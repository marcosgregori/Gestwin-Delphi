// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : F:\Desktop\Source\Documentacion\SII\01.07.2018\SuministroFactEmitidas.wsdl
//  >Import : F:\Desktop\Source\Documentacion\SII\01.07.2018\SuministroFactEmitidas.wsdl>0
//  >Import : F:\Desktop\Source\Documentacion\SII\01.07.2018\SuministroInformacion.xsd
//  >Import : F:\Desktop\Source\Documentacion\SII\01.07.2018\SuministroLR.xsd
//  >Import : F:\Desktop\Source\Documentacion\SII\01.07.2018\ConsultaLR.xsd
//  >Import : F:\Desktop\Source\Documentacion\SII\01.07.2018\RespuestaConsultaLR.xsd
//  >Import : F:\Desktop\Source\Documentacion\SII\01.07.2018\RespuestaSuministro.xsd
// Encoding : UTF-8
// Version  : 1.0
// (01/05/2018 11:52:29 - - $Rev: 90173 $)
// ************************************************************************ //

unit SuministroFactEmitidas;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  RegistroRespuestaConsultaInmueblesAdicionalesType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaCobrosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaPagosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaDetOperIntracomunitariasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaCobrosMetalicoType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaBienesType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaOperacionesSegurosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaAgenciasViajesType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  TipoDesglose         = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }
  TipoDesglose2        = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }
  RespuestaDetOperIntracomunitariaType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  TipoDesglose3        = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  TipoSinDesgloseType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  TipoConDesgloseType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DesgloseFacturaRecibidasType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  TipoSinDesglosePrestacionType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  SujetaType           = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  SujetaPrestacionType = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  NoExenta             = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  NoExenta2            = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  DatosInmuebleType    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  RespuestaComunBajaType = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaIMetalicoType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaCobrosMetalico = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBajaOComunitariasType = class;     { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaDetOperacionesIntracomunitarias = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBajaAgenciasViajesType = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaAgenciasViajes = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBajaFRecibidasType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaFacturasRecibidas = class;     { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBajaFEmitidasType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Lit][GblCplx] }
  RespuestaLRBajaFacturasEmitidas = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Lit][GblElm] }
  RespuestaLRBajaBienesInversionType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaBienesInversion = class;       { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBajaOperacionesSegurosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBajaOperacionesSeguros = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBajaFRecibidasPagosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaComunAltaType = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRIMetalicoType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRCobrosMetalico = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLROComunitariasType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRDetOperacionesIntracomunitarias = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRBienesInversionType = class;       { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRBienesInversion = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLROperacionesSegurosType = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLROperacionesSeguros = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRAgenciasViajesType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRAgenciasViajes = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  RespuestaLRFEmitidasType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Lit][GblCplx] }
  RespuestaLRFacturasEmitidas = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Lit][GblElm] }
  RespuestaLRFRecibidasType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaLRFacturasRecibidas = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblElm] }
  DatosPresentacionType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DatosPresentacion2Type = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDEmisorFactura      = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  RegistroSiiImputacion = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  PeriodoLiquidacion   = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion2  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion3  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion4  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion5  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion6  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion7  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion8  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[Cplx] }
  PeriodoLiquidacion9  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }
  PeriodoLiquidacion10 = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }
  RegistroSii          = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  PeriodoLiquidacion11 = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  ConsultaInformacion  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  RespuestaConsultaFacturaPagosType = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaFacturaCobrosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaInmueblesType = class;       { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaInmueblesAdicionalesType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaInmueblesAdicionales = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  SuministroInformacionBaja = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  SuministroInformacion = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  CabeceraConsultaSii  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  CabeceraSii          = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  CabeceraSiiBaja      = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  ConsultaInformacionCliente = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  CabeceraConsultaSiiCliente = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  PeriodoImputacion    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura2     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura3     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura4     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  PersonaFisicaJuridicaESType = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  PersonaFisicaJuridicaUnicaESType = class;     { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  ContraparteConsultaType = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  PersonaFisicaJuridicaType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDEmisorFactura5     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura6     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura7     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura8     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDEmisorFactura9     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  OperacionIntracomunitariaType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDEmisorFactura10    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  IDFacturaImputacionType = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaARType      = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaExpedidaType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  ClavePaginacionClienteType = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaExpedidaBCType = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaConsulta2Type = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaRecibidaNombreBCType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaConsulta1Type = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  ClavePaginacionBienType = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaRecibidaType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  ClavePaginacionProveedorType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  IDFacturaComunitariaType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  FacturaType          = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DetalleIVAEmitidaType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  FacturaRecibidaType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DetalleExentaType    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DetalleIVAEmitidaPrestacionType = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  NoSujetaType         = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DetalleIVARecibidaType = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  FacturaExpedidaType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DesgloseRectificacionType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DetalleIVARecibida2Type = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DatosPagoCobroType   = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  BienDeInversionType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  RespuestaCobrosMetalicoType = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  FacturaRespuestaType = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  FacturaRespuestaInformadaProveedorType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  FacturaRespuestaInformadaClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  FacturaRespuestaExpedidaType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  FacturaRespuestaRecibidaType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  IDOtroType           = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  RangoFechaPresentacionType = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  LRConsultaBienesInversionType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRConsultaDetOperIntracomunitariasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  ConsultaLRFactInformadasAgrupadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Lit][GblCplx] }
  LRConsultaEmitidasType = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Lit][GblCplx] }
  ConsultaLRFactInformadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Lit][GblCplx] }
  LRConsultaCobrosMetalicoType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  ConsultaPagosType    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  ConsultaInmueblesAdicionalesType = class;     { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  ConsultaCobrosType   = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRConsultaAgenciasViajesType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRConsultaLROperacionesSegurosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  ClavePaginacion      = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Cplx] }
  LRFiltroInmueblesAdicionalesType = class;     { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRConsultaRecibidasType = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroCobrosType   = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroPagosType    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaPagosType = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaPagos = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaCobrosType = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaCobros = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  ClavePaginacion2     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Cplx] }
  ConsultaLRFacturasRecibidas = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  RegistroRespuestaConsultaRecibidasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaEmitidasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRFacturasType = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRFacturasEmitidasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Lit][GblCplx] }
  RespuestaConsultaLRFacturasEmitidas = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Lit][GblElm] }
  RespuestaConsultaLRFacturasRecibidasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRFacturasRecibidas = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaLROperacionesSegurosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLROperacionesSeguros = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaLRAgenciasViajesType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRAgenciasViajes = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaLRDetOperIntracomunitariasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRDetOperIntracomunitarias = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaLRBienesInversionType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRBienesInversion = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaLRCobrosMetalicoType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRCobrosMetalico = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblElm] }
  RespuestaConsultaLRFacturasAgrupadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRFactInformadasAgrupadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Lit][GblCplx] }
  RespuestaConsultaLRFactInformadasAgrupadasCliente = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Lit][GblElm] }
  RespuestaConsultaLRFacturasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaConsultaLRFactInformadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Lit][GblCplx] }
  RespuestaConsultaLRFactInformadasCliente = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Lit][GblElm] }
  RegistroRespuestaConsultaFactInformadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  ConsultaLRBienesInversion = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaLRDetOperIntracomunitarias = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaLRFactInformadasAgrupadasCliente = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Lit][GblElm] }
  ConsultaLRFacturasEmitidas = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Lit][GblElm] }
  ConsultaLRFactInformadasCliente = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Lit][GblElm] }
  ConsultaLRCobrosMetalico = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaPagos        = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaLROperacionesSeguros = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaInmueblesAdicionales = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaLRAgenciasViajes = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  ConsultaCobros       = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblElm] }
  LRBajaRecibidasType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRBienesInversionType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRFacturasRecibidasType = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRfacturasEmitidasType = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRBajaExpedidasType  = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRBajaBienesInversionType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRBajaCobrosMetalicoType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRCobrosMetalicoType = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRAgenciasViajesType = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRBajaAgenciasViajesType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  RegistroRespuestaConsultaFactInformadasAgrupadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RangoFechaType       = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  DatosDescuadreContraparteType = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  LROperacionesSegurosType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  ClavePaginacion3     = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[Cplx] }
  RespuestaOperacionesSegurosType = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RegistroDuplicadoType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblCplx] }
  RespuestaComunitariaBajaType = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaAgenciasViajesBajaType = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaMetalicoBajaType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaExpedidaBajaType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaBienBajaType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaRecibidaBajaType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaOperacionesSegurosBajaType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  EstadoFactura2Type   = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  RespuestaAgenciasViajesType = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaMetalicoType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaOperacionesSegurosType2 = class;     { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaExpedidaType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaRecibidaType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaBienType    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaComunitariaType = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  RespuestaRecibidaPagoType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblCplx] }
  LRFiltroAgenciasViajesType = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroDetOperIntracomunitariasType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroBienInversionType = class;            { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroOperacionesSegurosType = class;       { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroCobrosMetalicoType = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  EstadoFacturaImputacionType = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  EstadoFacturaType    = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblCplx] }
  LRBajaRegistroLROperacionesSegurosType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  SuministroLRDetOperacionIntracomunitaria = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  BajaLRDetOperacionIntracomunitaria = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  BajaLROperacionesSeguros = class;             { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  BajaLRCobrosMetalico = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  SuministroLROperacionesSeguros = class;       { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  LRFiltroEmitidasType = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroFactInformadasAgrupadasProveedorType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroRecibidasType = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroFactInformadasProveedorType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroFactInformadasClienteType = class;    { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  LRFiltroFactInformadasAgrupadasClienteType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd"[GblCplx] }
  BajaLRFacturasEmitidas = class;               { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[Lit][GblElm] }
  SuministroLRFacturasRecibidas = class;        { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  SuministroLRFacturasEmitidas = class;         { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[Lit][GblElm] }
  LROperacionIntracomunitariaType = class;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  LRBajaOperacionIntracomunitariaType = class;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblCplx] }
  BajaLRFacturasRecibidas = class;              { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  BajaLRAgenciasViajes = class;                 { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  SuministroLRCobrosMetalico = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  SuministroLRAgenciasViajes = class;           { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  SuministroLRBienesInversion = class;          { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }
  BajaLRBienesInversion = class;                { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblElm] }

  {$SCOPEDENUMS ON}
  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblSmpl] }
  EstadoEnvioType = (Correcto, ParcialmenteCorrecto, Incorrecto);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblSmpl] }
  EstadoRegistroSIIType = (Correcta, AceptadaConErrores, Anulada);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblSmpl] }
  IndicadorPaginacionType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblSmpl] }
  ResultadoConsultaType = (ConDatos, SinDatos);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblSmpl] }
  FacturaARType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  CountryMiembroType = (
      DE, 
      AT, 
      BE, 
      BG, 
      CZ, 
      CY, 
      HR, 
      DK, 
      SK, 
      SI, 
      EE, 
      FI, 
      FR, 
      GR, 
      HU, 
      IE, 
      IT, 
      LV, 
      LT, 
      LU, 
      MT, 
      NL, 
      PL, 
      PT, 
      GB, 
      RO, 
      SE
  );

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Smpl] }
  ClaveDeclarado = (D, R);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Smpl] }
  TipoOperacion = (A, B);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  MedioPagoType = (_01, _02, _03, _04, _05);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblSmpl] }
  EstadoRegistroType = (Correcto, AceptadoConErrores, Incorrecto);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  CompletaSinDestinatarioType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  VariosDestinatariosType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  CuponType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  IdOperacionesTrascendenciaTributariaType = (
      _01, 
      _02, 
      _03, 
      _04, 
      _05, 
      _06, 
      _07, 
      _08, 
      _09, 
      _10, 
      _11, 
      _12, 
      _13, 
      _14, 
      _15, 
      _16
  );

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  SimplificadaCualificadaType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  EmitidaPorTercerosType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  MacrodatoType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TipoOperacionSujetaNoExentaType = (S1, S2, S3);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  CausaExencionType = (E1, E2, E3, E4, E5, E6);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  SituacionInmuebleType = (_1, _2, _3, _4);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  PersonaFisicaJuridicaIDTypeType = (_02, _03, _04, _05, _06, _07);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  CountryType2 = (
      AF, 
      AL, 
      DE, 
      AD, 
      AO, 
      AI, 
      AQ, 
      AG, 
      SA, 
      DZ, 
      AR, 
      AM, 
      AW, 
      AU, 
      AT, 
      AZ, 
      BS, 
      BH, 
      BD, 
      BB, 
      BE, 
      BZ, 
      BJ, 
      BM, 
      BY, 
      BO, 
      BA, 
      BW, 
      BV, 
      BR, 
      BN, 
      BG, 
      BF, 
      BI, 
      BT, 
      CV, 
      KY, 
      KH, 
      CM, 
      CA, 
      CF, 
      CC, 
      CO, 
      KM, 
      CG, 
      CD, 
      CK, 
      KP, 
      KR, 
      CI, 
      CR, 
      HR, 
      CU, 
      TD, 
      CZ, 
      CL, 
      CN, 
      CY, 
      CW, 
      DK, 
      DM, 
      DO_, 
      EC, 
      EG, 
      AE, 
      ER, 
      SK, 
      SI, 
      ES, 
      US, 
      EE, 
      ET, 
      FO, 
      PH, 
      FI, 
      FJ, 
      FR, 
      GA, 
      GM, 
      GE, 
      GS, 
      GH, 
      GI, 
      GD, 
      GR, 
      GL, 
      GU, 
      GT, 
      GG, 
      GN, 
      GQ, 
      GW, 
      GY, 
      HT, 
      HM, 
      HN, 
      HK, 
      HU, 
      IN_, 
      ID, 
      IR, 
      IQ, 
      IE, 
      IM, 
      IS_, 
      IL, 
      IT, 
      JM, 
      JP, 
      JE, 
      JO, 
      KZ, 
      KE, 
      KG, 
      KI, 
      KW, 
      LA, 
      LS, 
      LV, 
      LB, 
      LR, 
      LY, 
      LI, 
      LT, 
      LU, 
      XG, 
      MO, 
      MK, 
      MG, 
      MY, 
      MW, 
      MV, 
      ML, 
      MT, 
      FK, 
      MP, 
      MA, 
      MH, 
      MU, 
      MR, 
      YT, 
      UM, 
      MX, 
      FM, 
      MD, 
      MC, 
      MN, 
      ME, 
      MS, 
      MZ, 
      MM, 
      NA, 
      NR, 
      CX, 
      NP, 
      NI, 
      NE, 
      NG, 
      NU, 
      NF, 
      NO, 
      NC, 
      NZ, 
      IO, 
      OM, 
      NL, 
      BQ, 
      PK, 
      PW, 
      PA, 
      PG, 
      PY, 
      PE, 
      PN, 
      PF, 
      PL, 
      PT, 
      PR, 
      QA, 
      GB, 
      RW, 
      RO, 
      RU, 
      SB, 
      SV, 
      WS, 
      AS_, 
      KN, 
      SM, 
      SX, 
      PM, 
      VC, 
      SH, 
      LC, 
      ST, 
      SN, 
      RS, 
      SC, 
      SL, 
      SG, 
      SY, 
      SO, 
      LK, 
      SZ, 
      ZA, 
      SD, 
      SS, 
      SE, 
      CH, 
      SR, 
      TH, 
      TW, 
      TZ, 
      TJ, 
      PS, 
      TF, 
      TL, 
      TG, 
      TK, 
      TO_, 
      TT, 
      TN, 
      TC, 
      TM, 
      TR, 
      TV, 
      UA, 
      UG, 
      UY, 
      UZ, 
      VU, 
      VA, 
      VE, 
      VN, 
      VG, 
      VI, 
      WF, 
      YE, 
      DJ, 
      ZM, 
      ZW, 
      QU, 
      XB, 
      XU, 
      XN
  );

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TipoPeriodoType = (
      _01, 
      _02, 
      _03, 
      _04, 
      _05, 
      _06, 
      _07, 
      _08, 
      _09, 
      _10, 
      _11, 
      _12, 
      _0A, 
      _1T, 
      _2T, 
      _3T, 
      _4T
  );

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  ClaveTipoComunicacionType = (A0, A1, A4, A5, A6);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  VersionSiiType = (_1_1);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  ClaveTipoFacturaType = (
      F1, 
      F2, 
      R1, 
      R2, 
      R3, 
      R4, 
      R5, 
      F3, 
      F4, 
      F5, 
      F6, 
      LC
  );

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  ClaveTipoRectificativaType = (S, I, _);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  RegPrevioGGEEoREDEMEoCompetenciaType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  EstadoRegistroSIIType2 = (Correcta, AceptadaConErrores, Anulada);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  ClaveOperacionType = (A, B);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  EstadoCuadreImputacionType = (_3, _4, _5);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  FacturaModificadaType = (S, N);

  { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  EstadoCuadreType = (_1, _2, _3, _4, _5);

  {$SCOPEDENUMS OFF}



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaInmueblesAdicionalesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaInmueblesAdicionalesType = class(TRemotable)
  private
    FDatosInmueblesAdicionales: DatosInmuebleType;
    FDatosPresentacion: DatosPresentacion2Type;
  public
    destructor Destroy; override;
  published
    property DatosInmueblesAdicionales: DatosInmuebleType       read FDatosInmueblesAdicionales write FDatosInmueblesAdicionales;
    property DatosPresentacion:         DatosPresentacion2Type  read FDatosPresentacion write FDatosPresentacion;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaCobrosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaCobrosType = class(TRemotable)
  private
    FDatosCobro: DatosPagoCobroType;
    FDatosPresentacion: DatosPresentacion2Type;
  public
    destructor Destroy; override;
  published
    property DatosCobro:        DatosPagoCobroType      read FDatosCobro write FDatosCobro;
    property DatosPresentacion: DatosPresentacion2Type  read FDatosPresentacion write FDatosPresentacion;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaPagosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaPagosType = class(TRemotable)
  private
    FDatosPago: DatosPagoCobroType;
    FDatosPresentacion: DatosPresentacion2Type;
  public
    destructor Destroy; override;
  published
    property DatosPago:         DatosPagoCobroType      read FDatosPago write FDatosPago;
    property DatosPresentacion: DatosPresentacion2Type  read FDatosPresentacion write FDatosPresentacion;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaDetOperIntracomunitariasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaDetOperIntracomunitariasType = class(TRemotable)
  private
    FIDFactura: IDFacturaComunitariaType;
    FDatosDetOperIntracomunitarias: RespuestaDetOperIntracomunitariaType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoFactura: EstadoFactura2Type;
  public
    destructor Destroy; override;
  published
    property IDFactura:                     IDFacturaComunitariaType              read FIDFactura write FIDFactura;
    property DatosDetOperIntracomunitarias: RespuestaDetOperIntracomunitariaType  read FDatosDetOperIntracomunitarias write FDatosDetOperIntracomunitarias;
    property DatosPresentacion:             DatosPresentacion2Type                read FDatosPresentacion write FDatosPresentacion;
    property EstadoFactura:                 EstadoFactura2Type                    read FEstadoFactura write FEstadoFactura;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaCobrosMetalicoType = class(TRemotable)
  private
    FDatosCobroMetalico: RespuestaCobrosMetalicoType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoCobroMetalico: EstadoFactura2Type;
  public
    destructor Destroy; override;
  published
    property DatosCobroMetalico:  RespuestaCobrosMetalicoType  read FDatosCobroMetalico write FDatosCobroMetalico;
    property DatosPresentacion:   DatosPresentacion2Type       read FDatosPresentacion write FDatosPresentacion;
    property EstadoCobroMetalico: EstadoFactura2Type           read FEstadoCobroMetalico write FEstadoCobroMetalico;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaBienesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaBienesType = class(TRemotable)
  private
    FIDFactura: IDFacturaComunitariaType;
    FDatosBienInversion: BienDeInversionType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoFactura: EstadoFactura2Type;
  public
    destructor Destroy; override;
  published
    property IDFactura:          IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property DatosBienInversion: BienDeInversionType       read FDatosBienInversion write FDatosBienInversion;
    property DatosPresentacion:  DatosPresentacion2Type    read FDatosPresentacion write FDatosPresentacion;
    property EstadoFactura:      EstadoFactura2Type        read FEstadoFactura write FEstadoFactura;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaOperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaOperacionesSegurosType = class(TRemotable)
  private
    FDatosOperacionesSeguros: RespuestaOperacionesSegurosType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoOperacionesSeguros: EstadoFactura2Type;
  public
    destructor Destroy; override;
  published
    property DatosOperacionesSeguros:  RespuestaOperacionesSegurosType  read FDatosOperacionesSeguros write FDatosOperacionesSeguros;
    property DatosPresentacion:        DatosPresentacion2Type           read FDatosPresentacion write FDatosPresentacion;
    property EstadoOperacionesSeguros: EstadoFactura2Type               read FEstadoOperacionesSeguros write FEstadoOperacionesSeguros;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaAgenciasViajesType = class(TRemotable)
  private
    FDatosAgenciasViajes: RespuestaCobrosMetalicoType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoAgenciasViajes: EstadoFactura2Type;
  public
    destructor Destroy; override;
  published
    property DatosAgenciasViajes:  RespuestaCobrosMetalicoType  read FDatosAgenciasViajes write FDatosAgenciasViajes;
    property DatosPresentacion:    DatosPresentacion2Type       read FDatosPresentacion write FDatosPresentacion;
    property EstadoAgenciasViajes: EstadoFactura2Type           read FEstadoAgenciasViajes write FEstadoAgenciasViajes;
  end;

  FacturasRectificadas = array of IDFacturaARType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }
  DatosInmueble = array of DatosInmuebleType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }


  // ************************************************************************ //
  // XML       : TipoDesglose, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  TipoDesglose = class(TRemotable)
  private
    FDesgloseFactura: TipoSinDesgloseType;
    FDesgloseFactura_Specified: boolean;
    FDesgloseTipoOperacion: TipoConDesgloseType;
    FDesgloseTipoOperacion_Specified: boolean;
    procedure SetDesgloseFactura(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
    function  DesgloseFactura_Specified(Index: Integer): boolean;
    procedure SetDesgloseTipoOperacion(Index: Integer; const ATipoConDesgloseType: TipoConDesgloseType);
    function  DesgloseTipoOperacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DesgloseFactura:       TipoSinDesgloseType  Index (IS_OPTN) read FDesgloseFactura write SetDesgloseFactura stored DesgloseFactura_Specified;
    property DesgloseTipoOperacion: TipoConDesgloseType  Index (IS_OPTN) read FDesgloseTipoOperacion write SetDesgloseTipoOperacion stored DesgloseTipoOperacion_Specified;
  end;

  FacturasAgrupadas = array of IDFacturaARType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }
  DatosInmueble2 = array of DatosInmuebleType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[Cplx] }


  // ************************************************************************ //
  // XML       : TipoDesglose, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  TipoDesglose2 = class(TRemotable)
  private
    FDesgloseFactura: TipoSinDesgloseType;
    FDesgloseFactura_Specified: boolean;
    FDesgloseTipoOperacion: TipoConDesgloseType;
    FDesgloseTipoOperacion_Specified: boolean;
    procedure SetDesgloseFactura(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
    function  DesgloseFactura_Specified(Index: Integer): boolean;
    procedure SetDesgloseTipoOperacion(Index: Integer; const ATipoConDesgloseType: TipoConDesgloseType);
    function  DesgloseTipoOperacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DesgloseFactura:       TipoSinDesgloseType  Index (IS_OPTN) read FDesgloseFactura write SetDesgloseFactura stored DesgloseFactura_Specified;
    property DesgloseTipoOperacion: TipoConDesgloseType  Index (IS_OPTN) read FDesgloseTipoOperacion write SetDesgloseTipoOperacion stored DesgloseTipoOperacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaDetOperIntracomunitariaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaDetOperIntracomunitariaType = class(TRemotable)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FDetOperIntracomunitarias: OperacionIntracomunitariaType;
  public
    destructor Destroy; override;
  published
    property Contraparte:              PersonaFisicaJuridicaType      read FContraparte write FContraparte;
    property DetOperIntracomunitarias: OperacionIntracomunitariaType  read FDetOperIntracomunitarias write FDetOperIntracomunitarias;
  end;

  Array_Of_RegistroRespuestaConsultaRecibidasType = array of RegistroRespuestaConsultaRecibidasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaFactInformadasClienteType = array of RegistroRespuestaConsultaFactInformadasClienteType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaEmitidasType = array of RegistroRespuestaConsultaEmitidasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType = array of RegistroRespuestaConsultaDetOperIntracomunitariasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType = array of RegistroRespuestaConsultaFactInformadasAgrupadasClienteType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaBienesType = array of RegistroRespuestaConsultaBienesType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_LRBajaCobrosMetalicoType = array of LRBajaCobrosMetalicoType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LROperacionesSegurosType = array of LROperacionesSegurosType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRBajaRegistroLROperacionesSegurosType = array of LRBajaRegistroLROperacionesSegurosType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRBajaAgenciasViajesType = array of LRBajaAgenciasViajesType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRCobrosMetalicoType = array of LRCobrosMetalicoType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LROperacionIntracomunitariaType = array of LROperacionIntracomunitariaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRBajaOperacionIntracomunitariaType = array of LRBajaOperacionIntracomunitariaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_RespuestaAgenciasViajesType = array of RespuestaAgenciasViajesType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaOperacionesSegurosType = array of RespuestaOperacionesSegurosType2;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaExpedidaBajaType = array of RespuestaExpedidaBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaBienType = array of RespuestaBienType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaComunitariaType = array of RespuestaComunitariaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaMetalicoType = array of RespuestaMetalicoType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaMetalicoBajaType = array of RespuestaMetalicoBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaAgenciasViajesBajaType = array of RespuestaAgenciasViajesBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaOperacionesSegurosBajaType = array of RespuestaOperacionesSegurosBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaRecibidaBajaType = array of RespuestaRecibidaBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaBienBajaType = array of RespuestaBienBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaComunitariaBajaType = array of RespuestaComunitariaBajaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaRecibidaPagoType = array of RespuestaRecibidaPagoType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaCobrosMetalicoType = array of RegistroRespuestaConsultaCobrosMetalicoType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaAgenciasViajesType = array of RegistroRespuestaConsultaAgenciasViajesType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaPagosType = array of RegistroRespuestaConsultaPagosType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RespuestaExpedidaType = array of RespuestaExpedidaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RespuestaRecibidaType = array of RespuestaRecibidaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaOperacionesSegurosType = array of RegistroRespuestaConsultaOperacionesSegurosType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaCobrosType = array of RegistroRespuestaConsultaCobrosType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType = array of RegistroRespuestaConsultaInmueblesAdicionalesType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblUbnd] }
  Array_Of_LRBajaExpedidasType = array of LRBajaExpedidasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRFacturasRecibidasType = array of LRFacturasRecibidasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRBajaRecibidasType = array of LRBajaRecibidasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRfacturasEmitidasType = array of LRfacturasEmitidasType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRBienesInversionType = array of LRBienesInversionType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRBajaBienesInversionType = array of LRBajaBienesInversionType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }
  Array_Of_LRAgenciasViajesType = array of LRAgenciasViajesType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"[GblUbnd] }


  // ************************************************************************ //
  // XML       : TipoDesglose, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  TipoDesglose3 = class(TRemotable)
  private
    FDesgloseFactura: TipoSinDesgloseType;
    FDesgloseFactura_Specified: boolean;
    FDesgloseTipoOperacion: TipoConDesgloseType;
    FDesgloseTipoOperacion_Specified: boolean;
    procedure SetDesgloseFactura(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
    function  DesgloseFactura_Specified(Index: Integer): boolean;
    procedure SetDesgloseTipoOperacion(Index: Integer; const ATipoConDesgloseType: TipoConDesgloseType);
    function  DesgloseTipoOperacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DesgloseFactura:       TipoSinDesgloseType  Index (IS_OPTN) read FDesgloseFactura write SetDesgloseFactura stored DesgloseFactura_Specified;
    property DesgloseTipoOperacion: TipoConDesgloseType  Index (IS_OPTN) read FDesgloseTipoOperacion write SetDesgloseTipoOperacion stored DesgloseTipoOperacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : TipoSinDesgloseType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  TipoSinDesgloseType = class(TRemotable)
  private
    FSujeta: SujetaType;
    FSujeta_Specified: boolean;
    FNoSujeta: NoSujetaType;
    FNoSujeta_Specified: boolean;
    procedure SetSujeta(Index: Integer; const ASujetaType: SujetaType);
    function  Sujeta_Specified(Index: Integer): boolean;
    procedure SetNoSujeta(Index: Integer; const ANoSujetaType: NoSujetaType);
    function  NoSujeta_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Sujeta:   SujetaType    Index (IS_OPTN) read FSujeta write SetSujeta stored Sujeta_Specified;
    property NoSujeta: NoSujetaType  Index (IS_OPTN) read FNoSujeta write SetNoSujeta stored NoSujeta_Specified;
  end;

  DesgloseIVA = array of DetalleIVARecibidaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  InversionSujetoPasivo = array of DetalleIVARecibida2Type;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }


  // ************************************************************************ //
  // XML       : TipoConDesgloseType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  TipoConDesgloseType = class(TRemotable)
  private
    FPrestacionServicios: TipoSinDesglosePrestacionType;
    FPrestacionServicios_Specified: boolean;
    FEntrega: TipoSinDesgloseType;
    FEntrega_Specified: boolean;
    procedure SetPrestacionServicios(Index: Integer; const ATipoSinDesglosePrestacionType: TipoSinDesglosePrestacionType);
    function  PrestacionServicios_Specified(Index: Integer): boolean;
    procedure SetEntrega(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
    function  Entrega_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PrestacionServicios: TipoSinDesglosePrestacionType  Index (IS_OPTN) read FPrestacionServicios write SetPrestacionServicios stored PrestacionServicios_Specified;
    property Entrega:             TipoSinDesgloseType            Index (IS_OPTN) read FEntrega write SetEntrega stored Entrega_Specified;
  end;



  // ************************************************************************ //
  // XML       : DesgloseFacturaRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DesgloseFacturaRecibidasType = class(TRemotable)
  private
    FInversionSujetoPasivo: InversionSujetoPasivo;
    FInversionSujetoPasivo_Specified: boolean;
    FDesgloseIVA: DesgloseIVA;
    FDesgloseIVA_Specified: boolean;
    procedure SetInversionSujetoPasivo(Index: Integer; const AInversionSujetoPasivo: InversionSujetoPasivo);
    function  InversionSujetoPasivo_Specified(Index: Integer): boolean;
    procedure SetDesgloseIVA(Index: Integer; const ADesgloseIVA: DesgloseIVA);
    function  DesgloseIVA_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property InversionSujetoPasivo: InversionSujetoPasivo  Index (IS_OPTN) read FInversionSujetoPasivo write SetInversionSujetoPasivo stored InversionSujetoPasivo_Specified;
    property DesgloseIVA:           DesgloseIVA            Index (IS_OPTN) read FDesgloseIVA write SetDesgloseIVA stored DesgloseIVA_Specified;
  end;

  FacturasAgrupadas2 = array of IDFacturaARType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  FacturasRectificadas2 = array of IDFacturaARType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  DatosInmueble3 = array of DatosInmuebleType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  Exenta     = array of DetalleExentaType;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }


  // ************************************************************************ //
  // XML       : TipoSinDesglosePrestacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  TipoSinDesglosePrestacionType = class(TRemotable)
  private
    FSujeta: SujetaPrestacionType;
    FSujeta_Specified: boolean;
    FNoSujeta: NoSujetaType;
    FNoSujeta_Specified: boolean;
    procedure SetSujeta(Index: Integer; const ASujetaPrestacionType: SujetaPrestacionType);
    function  Sujeta_Specified(Index: Integer): boolean;
    procedure SetNoSujeta(Index: Integer; const ANoSujetaType: NoSujetaType);
    function  NoSujeta_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Sujeta:   SujetaPrestacionType  Index (IS_OPTN) read FSujeta write SetSujeta stored Sujeta_Specified;
    property NoSujeta: NoSujetaType          Index (IS_OPTN) read FNoSujeta write SetNoSujeta stored NoSujeta_Specified;
  end;



  // ************************************************************************ //
  // XML       : SujetaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  SujetaType = class(TRemotable)
  private
    FExenta: Exenta;
    FExenta_Specified: boolean;
    FNoExenta: NoExenta2;
    FNoExenta_Specified: boolean;
    procedure SetExenta(Index: Integer; const AExenta: Exenta);
    function  Exenta_Specified(Index: Integer): boolean;
    procedure SetNoExenta(Index: Integer; const ANoExenta2: NoExenta2);
    function  NoExenta_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Exenta:   Exenta     Index (IS_OPTN) read FExenta write SetExenta stored Exenta_Specified;
    property NoExenta: NoExenta2  Index (IS_OPTN) read FNoExenta write SetNoExenta stored NoExenta_Specified;
  end;

  DesgloseIVA2 = array of DetalleIVAEmitidaPrestacionType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }
  Exenta2    = array of DetalleExentaType;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }


  // ************************************************************************ //
  // XML       : SujetaPrestacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  SujetaPrestacionType = class(TRemotable)
  private
    FExenta: Exenta2;
    FExenta_Specified: boolean;
    FNoExenta: NoExenta;
    FNoExenta_Specified: boolean;
    procedure SetExenta(Index: Integer; const AExenta2: Exenta2);
    function  Exenta_Specified(Index: Integer): boolean;
    procedure SetNoExenta(Index: Integer; const ANoExenta: NoExenta);
    function  NoExenta_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Exenta:   Exenta2   Index (IS_OPTN) read FExenta write SetExenta stored Exenta_Specified;
    property NoExenta: NoExenta  Index (IS_OPTN) read FNoExenta write SetNoExenta stored NoExenta_Specified;
  end;



  // ************************************************************************ //
  // XML       : NoExenta, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  NoExenta = class(TRemotable)
  private
    FTipoNoExenta: TipoOperacionSujetaNoExentaType;
    FDesgloseIVA: DesgloseIVA2;
  public
    destructor Destroy; override;
  published
    property TipoNoExenta: TipoOperacionSujetaNoExentaType  read FTipoNoExenta write FTipoNoExenta;
    property DesgloseIVA:  DesgloseIVA2                     read FDesgloseIVA write FDesgloseIVA;
  end;

  DesgloseIVA3 = array of DetalleIVAEmitidaType;   { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Cplx] }


  // ************************************************************************ //
  // XML       : NoExenta, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  NoExenta2 = class(TRemotable)
  private
    FTipoNoExenta: TipoOperacionSujetaNoExentaType;
    FDesgloseIVA: DesgloseIVA3;
  public
    destructor Destroy; override;
  published
    property TipoNoExenta: TipoOperacionSujetaNoExentaType  read FTipoNoExenta write FTipoNoExenta;
    property DesgloseIVA:  DesgloseIVA3                     read FDesgloseIVA write FDesgloseIVA;
  end;

  ReferenciaCatastralType =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TextMax20Type   =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : DatosInmuebleType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DatosInmuebleType = class(TRemotable)
  private
    FSituacionInmueble: SituacionInmuebleType;
    FReferenciaCatastral: ReferenciaCatastralType;
    FReferenciaCatastral_Specified: boolean;
    procedure SetReferenciaCatastral(Index: Integer; const AReferenciaCatastralType: ReferenciaCatastralType);
    function  ReferenciaCatastral_Specified(Index: Integer): boolean;
  published
    property SituacionInmueble:   SituacionInmuebleType    read FSituacionInmueble write FSituacionInmueble;
    property ReferenciaCatastral: ReferenciaCatastralType  Index (IS_OPTN) read FReferenciaCatastral write SetReferenciaCatastral stored ReferenciaCatastral_Specified;
  end;

  TextMax500Type  =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TextMax34Type   =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  PlazoOperacion  =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[Smpl] }
  TextMax40Type   =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TextMax150Type  =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : RespuestaComunBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaComunBajaType = class(TRemotable)
  private
    FCSV: string;
    FCSV_Specified: boolean;
    FDatosPresentacion: DatosPresentacionType;
    FDatosPresentacion_Specified: boolean;
    FCabecera: CabeceraSiiBaja;
    FEstadoEnvio: EstadoEnvioType;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetDatosPresentacion(Index: Integer; const ADatosPresentacionType: DatosPresentacionType);
    function  DatosPresentacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property CSV:               string                 Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property DatosPresentacion: DatosPresentacionType  Index (IS_OPTN) read FDatosPresentacion write SetDatosPresentacion stored DatosPresentacion_Specified;
    property Cabecera:          CabeceraSiiBaja        read FCabecera write FCabecera;
    property EstadoEnvio:       EstadoEnvioType        read FEstadoEnvio write FEstadoEnvio;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaIMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaIMetalicoType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaMetalicoBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaMetalicoBajaType: Array_Of_RespuestaMetalicoBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaMetalicoBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaCobrosMetalico, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaCobrosMetalico = class(RespuestaLRBajaIMetalicoType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaOComunitariasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaOComunitariasType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaComunitariaBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaComunitariaBajaType: Array_Of_RespuestaComunitariaBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaComunitariaBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaDetOperacionesIntracomunitarias, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaDetOperacionesIntracomunitarias = class(RespuestaLRBajaOComunitariasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaAgenciasViajesType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaAgenciasViajesBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaAgenciasViajesBajaType: Array_Of_RespuestaAgenciasViajesBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaAgenciasViajesBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaAgenciasViajes, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaAgenciasViajes = class(RespuestaLRBajaAgenciasViajesType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaFRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaFRecibidasType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaRecibidaBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaRecibidaBajaType: Array_Of_RespuestaRecibidaBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaRecibidaBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaFacturasRecibidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaFacturasRecibidas = class(RespuestaLRBajaFRecibidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaFEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaLRBajaFEmitidasType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaExpedidaBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaExpedidaBajaType: Array_Of_RespuestaExpedidaBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaExpedidaBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaFacturasEmitidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaLRBajaFacturasEmitidas = class(RespuestaLRBajaFEmitidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaBienesInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaBienesInversionType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaBienBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaBienBajaType: Array_Of_RespuestaBienBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaBienBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaBienesInversion, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaBienesInversion = class(RespuestaLRBajaBienesInversionType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaOperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaOperacionesSegurosType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaOperacionesSegurosBajaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaOperacionesSegurosBajaType: Array_Of_RespuestaOperacionesSegurosBajaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaOperacionesSegurosBajaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaOperacionesSeguros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaOperacionesSeguros = class(RespuestaLRBajaOperacionesSegurosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBajaFRecibidasPagosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBajaFRecibidasPagosType = class(RespuestaComunBajaType)
  private
    FRespuestaLinea: Array_Of_RespuestaRecibidaPagoType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaRecibidaPagoType: Array_Of_RespuestaRecibidaPagoType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaRecibidaPagoType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaComunAltaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaComunAltaType = class(TRemotable)
  private
    FCSV: string;
    FCSV_Specified: boolean;
    FDatosPresentacion: DatosPresentacionType;
    FDatosPresentacion_Specified: boolean;
    FCabecera: CabeceraSii;
    FEstadoEnvio: EstadoEnvioType;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetDatosPresentacion(Index: Integer; const ADatosPresentacionType: DatosPresentacionType);
    function  DatosPresentacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property CSV:               string                 Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property DatosPresentacion: DatosPresentacionType  Index (IS_OPTN) read FDatosPresentacion write SetDatosPresentacion stored DatosPresentacion_Specified;
    property Cabecera:          CabeceraSii            read FCabecera write FCabecera;
    property EstadoEnvio:       EstadoEnvioType        read FEstadoEnvio write FEstadoEnvio;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRIMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRIMetalicoType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaMetalicoType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaMetalicoType: Array_Of_RespuestaMetalicoType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaMetalicoType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRCobrosMetalico, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRCobrosMetalico = class(RespuestaLRIMetalicoType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLROComunitariasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLROComunitariasType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaComunitariaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaComunitariaType: Array_Of_RespuestaComunitariaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaComunitariaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRDetOperacionesIntracomunitarias, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRDetOperacionesIntracomunitarias = class(RespuestaLROComunitariasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBienesInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBienesInversionType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaBienType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaBienType: Array_Of_RespuestaBienType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaBienType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRBienesInversion, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRBienesInversion = class(RespuestaLRBienesInversionType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLROperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLROperacionesSegurosType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaOperacionesSegurosType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaOperacionesSegurosType: Array_Of_RespuestaOperacionesSegurosType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaOperacionesSegurosType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLROperacionesSeguros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLROperacionesSeguros = class(RespuestaLROperacionesSegurosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRAgenciasViajesType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaAgenciasViajesType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaAgenciasViajesType: Array_Of_RespuestaAgenciasViajesType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaAgenciasViajesType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRAgenciasViajes, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRAgenciasViajes = class(RespuestaLRAgenciasViajesType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRFEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaLRFEmitidasType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaExpedidaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaExpedidaType: Array_Of_RespuestaExpedidaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaExpedidaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRFacturasEmitidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaLRFacturasEmitidas = class(RespuestaLRFEmitidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRFRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRFRecibidasType = class(RespuestaComunAltaType)
  private
    FRespuestaLinea: Array_Of_RespuestaRecibidaType;
    FRespuestaLinea_Specified: boolean;
    procedure SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaRecibidaType: Array_Of_RespuestaRecibidaType);
    function  RespuestaLinea_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RespuestaLinea: Array_Of_RespuestaRecibidaType  Index (IS_OPTN or IS_UNBD) read FRespuestaLinea write SetRespuestaLinea stored RespuestaLinea_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaLRFacturasRecibidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaLRFacturasRecibidas = class(RespuestaLRFRecibidasType)
  private
  published
  end;

  Timestamp       =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  NIFType         =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : DatosPresentacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DatosPresentacionType = class(TRemotable)
  private
    FNIFPresentador: NIFType;
    FTimestampPresentacion: Timestamp;
  published
    property NIFPresentador:        NIFType    read FNIFPresentador write FNIFPresentador;
    property TimestampPresentacion: Timestamp  read FTimestampPresentacion write FTimestampPresentacion;
  end;



  // ************************************************************************ //
  // XML       : DatosPresentacion2Type, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DatosPresentacion2Type = class(TRemotable)
  private
    FNIFPresentador: NIFType;
    FTimestampPresentacion: Timestamp;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  published
    property NIFPresentador:        NIFType    read FNIFPresentador write FNIFPresentador;
    property TimestampPresentacion: Timestamp  read FTimestampPresentacion write FTimestampPresentacion;
    property CSV:                   string     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura = class(TRemotable)
  private
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NIF:    NIFType     Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro: IDOtroType  Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;



  // ************************************************************************ //
  // XML       : RegistroSiiImputacion, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  RegistroSiiImputacion = class(TRemotable)
  private
    FPeriodoImputacion: PeriodoImputacion;
  public
    destructor Destroy; override;
  published
    property PeriodoImputacion: PeriodoImputacion  read FPeriodoImputacion write FPeriodoImputacion;
  end;

  YearType        =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion2 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion3 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion4 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion5 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion6 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion7 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  PeriodoLiquidacion8 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  PeriodoLiquidacion9 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  PeriodoLiquidacion10 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : RegistroSii, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  RegistroSii = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion11;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion: PeriodoLiquidacion11  read FPeriodoLiquidacion write FPeriodoLiquidacion;
  end;



  // ************************************************************************ //
  // XML       : PeriodoLiquidacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  PeriodoLiquidacion11 = class(TRemotable)
  private
    FEjercicio: YearType;
    FPeriodo: TipoPeriodoType;
  published
    property Ejercicio: YearType         read FEjercicio write FEjercicio;
    property Periodo:   TipoPeriodoType  read FPeriodo write FPeriodo;
  end;



  // ************************************************************************ //
  // XML       : ConsultaInformacion, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  ConsultaInformacion = class(TRemotable)
  private
    FCabecera: CabeceraConsultaSii;
  public
    destructor Destroy; override;
  published
    property Cabecera: CabeceraConsultaSii  read FCabecera write FCabecera;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaFacturaPagosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaFacturaPagosType = class(ConsultaInformacion)
  private
    FIDFactura: IDFacturaRecibidaNombreBCType;
    FIndicadorPaginacion: IndicadorPaginacionType;
    FResultadoConsulta: ResultadoConsultaType;
  public
    destructor Destroy; override;
  published
    property IDFactura:           IDFacturaRecibidaNombreBCType  read FIDFactura write FIDFactura;
    property IndicadorPaginacion: IndicadorPaginacionType        read FIndicadorPaginacion write FIndicadorPaginacion;
    property ResultadoConsulta:   ResultadoConsultaType          read FResultadoConsulta write FResultadoConsulta;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaFacturaCobrosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaFacturaCobrosType = class(ConsultaInformacion)
  private
    FIDFactura: IDFacturaExpedidaBCType;
    FIndicadorPaginacion: IndicadorPaginacionType;
    FResultadoConsulta: ResultadoConsultaType;
  public
    destructor Destroy; override;
  published
    property IDFactura:           IDFacturaExpedidaBCType  read FIDFactura write FIDFactura;
    property IndicadorPaginacion: IndicadorPaginacionType  read FIndicadorPaginacion write FIndicadorPaginacion;
    property ResultadoConsulta:   ResultadoConsultaType    read FResultadoConsulta write FResultadoConsulta;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaInmueblesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaInmueblesType = class(ConsultaInformacion)
  private
    FIDFactura: IDFacturaExpedidaBCType;
    FResultadoConsulta: ResultadoConsultaType;
  public
    destructor Destroy; override;
  published
    property IDFactura:         IDFacturaExpedidaBCType  read FIDFactura write FIDFactura;
    property ResultadoConsulta: ResultadoConsultaType    read FResultadoConsulta write FResultadoConsulta;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaInmueblesAdicionalesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaInmueblesAdicionalesType = class(RespuestaConsultaInmueblesType)
  private
    FRegistroRespuestaConsultaInmueblesAdicionales: Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType;
    FRegistroRespuestaConsultaInmueblesAdicionales_Specified: boolean;
    procedure SetRegistroRespuestaConsultaInmueblesAdicionales(Index: Integer; const AArray_Of_RegistroRespuestaConsultaInmueblesAdicionalesType: Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType);
    function  RegistroRespuestaConsultaInmueblesAdicionales_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaInmueblesAdicionales: Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaInmueblesAdicionales write SetRegistroRespuestaConsultaInmueblesAdicionales stored RegistroRespuestaConsultaInmueblesAdicionales_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaInmueblesAdicionales, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaInmueblesAdicionales = class(RespuestaConsultaInmueblesAdicionalesType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : SuministroInformacionBaja, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  SuministroInformacionBaja = class(TRemotable)
  private
    FCabecera: CabeceraSiiBaja;
  public
    destructor Destroy; override;
  published
    property Cabecera: CabeceraSiiBaja  read FCabecera write FCabecera;
  end;



  // ************************************************************************ //
  // XML       : SuministroInformacion, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  SuministroInformacion = class(TRemotable)
  private
    FCabecera: CabeceraSii;
  public
    destructor Destroy; override;
  published
    property Cabecera: CabeceraSii  read FCabecera write FCabecera;
  end;



  // ************************************************************************ //
  // XML       : CabeceraConsultaSii, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  CabeceraConsultaSii = class(TRemotable)
  private
    FIDVersionSii: VersionSiiType;
    FTitular: PersonaFisicaJuridicaUnicaESType;
  public
    destructor Destroy; override;
  published
    property IDVersionSii: VersionSiiType                    read FIDVersionSii write FIDVersionSii;
    property Titular:      PersonaFisicaJuridicaUnicaESType  read FTitular write FTitular;
  end;



  // ************************************************************************ //
  // XML       : CabeceraSii, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  CabeceraSii = class(TRemotable)
  private
    FIDVersionSii: VersionSiiType;
    FTitular: PersonaFisicaJuridicaESType;
    FTipoComunicacion: ClaveTipoComunicacionType;
  public
    destructor Destroy; override;
  published
    property IDVersionSii:     VersionSiiType               read FIDVersionSii write FIDVersionSii;
    property Titular:          PersonaFisicaJuridicaESType  read FTitular write FTitular;
    property TipoComunicacion: ClaveTipoComunicacionType    read FTipoComunicacion write FTipoComunicacion;
  end;



  // ************************************************************************ //
  // XML       : CabeceraSiiBaja, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  CabeceraSiiBaja = class(TRemotable)
  private
    FIDVersionSii: VersionSiiType;
    FTitular: PersonaFisicaJuridicaESType;
  public
    destructor Destroy; override;
  published
    property IDVersionSii: VersionSiiType               read FIDVersionSii write FIDVersionSii;
    property Titular:      PersonaFisicaJuridicaESType  read FTitular write FTitular;
  end;



  // ************************************************************************ //
  // XML       : ConsultaInformacionCliente, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  ConsultaInformacionCliente = class(TRemotable)
  private
    FCabecera: CabeceraConsultaSiiCliente;
  public
    destructor Destroy; override;
  published
    property Cabecera: CabeceraConsultaSiiCliente  read FCabecera write FCabecera;
  end;



  // ************************************************************************ //
  // XML       : CabeceraConsultaSiiCliente, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  CabeceraConsultaSiiCliente = class(TRemotable)
  private
    FIDVersionSii: VersionSiiType;
    FTitularLRFE: PersonaFisicaJuridicaUnicaESType;
  public
    destructor Destroy; override;
  published
    property IDVersionSii: VersionSiiType                    read FIDVersionSii write FIDVersionSii;
    property TitularLRFE:  PersonaFisicaJuridicaUnicaESType  read FTitularLRFE write FTitularLRFE;
  end;



  // ************************************************************************ //
  // XML       : PeriodoImputacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  PeriodoImputacion = class(TRemotable)
  private
    FEjercicioImputacion: YearType;
    FPeriodoImputacion: TipoPeriodoType;
  published
    property EjercicioImputacion: YearType         read FEjercicioImputacion write FEjercicioImputacion;
    property PeriodoImputacion:   TipoPeriodoType  read FPeriodoImputacion write FPeriodoImputacion;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura2 = class(TRemotable)
  private
    FNIF: NIFType;
  published
    property NIF: NIFType  read FNIF write FNIF;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura3 = class(TRemotable)
  private
    FNIF: NIFType;
  published
    property NIF: NIFType  read FNIF write FNIF;
  end;

  fecha           =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TextMax15Type   =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }
  TextMax120Type  =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura4 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         read FNIF write FNIF;
  end;



  // ************************************************************************ //
  // XML       : PersonaFisicaJuridicaESType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  PersonaFisicaJuridicaESType = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIFRepresentante: NIFType;
    FNIFRepresentante_Specified: boolean;
    FNIF: NIFType;
    procedure SetNIFRepresentante(Index: Integer; const ANIFType: NIFType);
    function  NIFRepresentante_Specified(Index: Integer): boolean;
  published
    property NombreRazon:      TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIFRepresentante: NIFType         Index (IS_OPTN) read FNIFRepresentante write SetNIFRepresentante stored NIFRepresentante_Specified;
    property NIF:              NIFType         read FNIF write FNIF;
  end;



  // ************************************************************************ //
  // XML       : PersonaFisicaJuridicaUnicaESType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  PersonaFisicaJuridicaUnicaESType = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         read FNIF write FNIF;
  end;



  // ************************************************************************ //
  // XML       : ContraparteConsultaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  ContraparteConsultaType = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro:      IDOtroType      Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;



  // ************************************************************************ //
  // XML       : PersonaFisicaJuridicaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  PersonaFisicaJuridicaType = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIFRepresentante: NIFType;
    FNIFRepresentante_Specified: boolean;
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIFRepresentante(Index: Integer; const ANIFType: NIFType);
    function  NIFRepresentante_Specified(Index: Integer): boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NombreRazon:      TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIFRepresentante: NIFType         Index (IS_OPTN) read FNIFRepresentante write SetNIFRepresentante stored NIFRepresentante_Specified;
    property NIF:              NIFType         Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro:           IDOtroType      Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura5 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro:      IDOtroType      Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura6 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro:      IDOtroType      Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura7 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro:      IDOtroType      Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura8 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         read FNIF write FNIF;
  end;



  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura9 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
    FNIF_Specified: boolean;
    FIDOtro: IDOtroType;
    FIDOtro_Specified: boolean;
    procedure SetNIF(Index: Integer; const ANIFType: NIFType);
    function  NIF_Specified(Index: Integer): boolean;
    procedure SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
    function  IDOtro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         Index (IS_OPTN) read FNIF write SetNIF stored NIF_Specified;
    property IDOtro:      IDOtroType      Index (IS_OPTN) read FIDOtro write SetIDOtro stored IDOtro_Specified;
  end;

  TextMax60Type   =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : OperacionIntracomunitariaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  OperacionIntracomunitariaType = class(TRemotable)
  private
    FTipoOperacion: TipoOperacion;
    FClaveDeclarado: ClaveDeclarado;
    FEstadoMiembro: CountryMiembroType;
    FPlazoOperacion: PlazoOperacion;
    FPlazoOperacion_Specified: boolean;
    FDescripcionBienes: TextMax40Type;
    FDireccionOperador: TextMax120Type;
    FFacturasODocumentacion: TextMax150Type;
    FFacturasODocumentacion_Specified: boolean;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FNumRegistroAcuerdoFacturacion: TextMax15Type;
    FNumRegistroAcuerdoFacturacion_Specified: boolean;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    FRegPrevioGGEEoREDEMEoCompetencia: RegPrevioGGEEoREDEMEoCompetenciaType;
    FRegPrevioGGEEoREDEMEoCompetencia_Specified: boolean;
    procedure SetPlazoOperacion(Index: Integer; const APlazoOperacion: PlazoOperacion);
    function  PlazoOperacion_Specified(Index: Integer): boolean;
    procedure SetFacturasODocumentacion(Index: Integer; const ATextMax150Type: TextMax150Type);
    function  FacturasODocumentacion_Specified(Index: Integer): boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
    function  NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
    procedure SetRegPrevioGGEEoREDEMEoCompetencia(Index: Integer; const ARegPrevioGGEEoREDEMEoCompetenciaType: RegPrevioGGEEoREDEMEoCompetenciaType);
    function  RegPrevioGGEEoREDEMEoCompetencia_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property TipoOperacion:                    TipoOperacion                         read FTipoOperacion write FTipoOperacion;
    property ClaveDeclarado:                   ClaveDeclarado                        read FClaveDeclarado write FClaveDeclarado;
    property EstadoMiembro:                    CountryMiembroType                    read FEstadoMiembro write FEstadoMiembro;
    property PlazoOperacion:                   PlazoOperacion                        Index (IS_OPTN) read FPlazoOperacion write SetPlazoOperacion stored PlazoOperacion_Specified;
    property DescripcionBienes:                TextMax40Type                         read FDescripcionBienes write FDescripcionBienes;
    property DireccionOperador:                TextMax120Type                        read FDireccionOperador write FDireccionOperador;
    property FacturasODocumentacion:           TextMax150Type                        Index (IS_OPTN) read FFacturasODocumentacion write SetFacturasODocumentacion stored FacturasODocumentacion_Specified;
    property RefExterna:                       TextMax60Type                         Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property NumRegistroAcuerdoFacturacion:    TextMax15Type                         Index (IS_OPTN) read FNumRegistroAcuerdoFacturacion write SetNumRegistroAcuerdoFacturacion stored NumRegistroAcuerdoFacturacion_Specified;
    property EntidadSucedida:                  PersonaFisicaJuridicaUnicaESType      Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
    property RegPrevioGGEEoREDEMEoCompetencia: RegPrevioGGEEoREDEMEoCompetenciaType  Index (IS_OPTN) read FRegPrevioGGEEoREDEMEoCompetencia write SetRegPrevioGGEEoREDEMEoCompetencia stored RegPrevioGGEEoREDEMEoCompetencia_Specified;
  end;

  Tipo2_2Type     =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : IDEmisorFactura, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDEmisorFactura10 = class(TRemotable)
  private
    FNombreRazon: TextMax120Type;
    FNIF: NIFType;
  published
    property NombreRazon: TextMax120Type  read FNombreRazon write FNombreRazon;
    property NIF:         NIFType         read FNIF write FNIF;
  end;

  TextoIDFacturaType =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : IDFacturaImputacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaImputacionType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura10;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisorResumenFin: TextoIDFacturaType;
    FNumSerieFacturaEmisorResumenFin_Specified: boolean;
    FFechaExpedicionFacturaEmisor: fecha;
    procedure SetNumSerieFacturaEmisorResumenFin(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisorResumenFin_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:                 IDEmisorFactura10   read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:           TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property NumSerieFacturaEmisorResumenFin: TextoIDFacturaType  Index (IS_OPTN) read FNumSerieFacturaEmisorResumenFin write SetNumSerieFacturaEmisorResumenFin stored NumSerieFacturaEmisorResumenFin_Specified;
    property FechaExpedicionFacturaEmisor:    fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaARType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaARType = class(TRemotable)
  private
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
  published
    property NumSerieFacturaEmisor:        TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaExpedidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaExpedidaType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura3;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisorResumenFin: TextoIDFacturaType;
    FNumSerieFacturaEmisorResumenFin_Specified: boolean;
    FFechaExpedicionFacturaEmisor: fecha;
    procedure SetNumSerieFacturaEmisorResumenFin(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisorResumenFin_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:                 IDEmisorFactura3    read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:           TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property NumSerieFacturaEmisorResumenFin: TextoIDFacturaType  Index (IS_OPTN) read FNumSerieFacturaEmisorResumenFin write SetNumSerieFacturaEmisorResumenFin stored NumSerieFacturaEmisorResumenFin_Specified;
    property FechaExpedicionFacturaEmisor:    fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : ClavePaginacionClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  ClavePaginacionClienteType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura4;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
    FCliente: PersonaFisicaJuridicaUnicaESType;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura4                  read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:        TextoIDFacturaType                read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha                             read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
    property Cliente:                      PersonaFisicaJuridicaUnicaESType  read FCliente write FCliente;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaExpedidaBCType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaExpedidaBCType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura2;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura2    read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:        TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaConsulta2Type, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaConsulta2Type = class(TRemotable)
  private
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisor_Specified: boolean;
    FFechaExpedicionFacturaEmisor: fecha;
    FFechaExpedicionFacturaEmisor_Specified: boolean;
    procedure SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
    procedure SetFechaExpedicionFacturaEmisor(Index: Integer; const Afecha: fecha);
    function  FechaExpedicionFacturaEmisor_Specified(Index: Integer): boolean;
  published
    property NumSerieFacturaEmisor:        TextoIDFacturaType  Index (IS_OPTN) read FNumSerieFacturaEmisor write SetNumSerieFacturaEmisor stored NumSerieFacturaEmisor_Specified;
    property FechaExpedicionFacturaEmisor: fecha               Index (IS_OPTN) read FFechaExpedicionFacturaEmisor write SetFechaExpedicionFacturaEmisor stored FechaExpedicionFacturaEmisor_Specified;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaRecibidaNombreBCType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaRecibidaNombreBCType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura5;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura5    read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:        TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaConsulta1Type, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaConsulta1Type = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura7;
    FIDEmisorFactura_Specified: boolean;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisor_Specified: boolean;
    FFechaExpedicionFacturaEmisor: fecha;
    FFechaExpedicionFacturaEmisor_Specified: boolean;
    procedure SetIDEmisorFactura(Index: Integer; const AIDEmisorFactura7: IDEmisorFactura7);
    function  IDEmisorFactura_Specified(Index: Integer): boolean;
    procedure SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
    procedure SetFechaExpedicionFacturaEmisor(Index: Integer; const Afecha: fecha);
    function  FechaExpedicionFacturaEmisor_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura7    Index (IS_OPTN) read FIDEmisorFactura write SetIDEmisorFactura stored IDEmisorFactura_Specified;
    property NumSerieFacturaEmisor:        TextoIDFacturaType  Index (IS_OPTN) read FNumSerieFacturaEmisor write SetNumSerieFacturaEmisor stored NumSerieFacturaEmisor_Specified;
    property FechaExpedicionFacturaEmisor: fecha               Index (IS_OPTN) read FFechaExpedicionFacturaEmisor write SetFechaExpedicionFacturaEmisor stored FechaExpedicionFacturaEmisor_Specified;
  end;



  // ************************************************************************ //
  // XML       : ClavePaginacionBienType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  ClavePaginacionBienType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura6;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
    FIdentificacionBien: TextMax40Type;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura6    read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:        TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
    property IdentificacionBien:           TextMax40Type       read FIdentificacionBien write FIdentificacionBien;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaRecibidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaRecibidaType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisorResumenFin: TextoIDFacturaType;
    FNumSerieFacturaEmisorResumenFin_Specified: boolean;
    FFechaExpedicionFacturaEmisor: fecha;
    procedure SetNumSerieFacturaEmisorResumenFin(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisorResumenFin_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:                 IDEmisorFactura     read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:           TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property NumSerieFacturaEmisorResumenFin: TextoIDFacturaType  Index (IS_OPTN) read FNumSerieFacturaEmisorResumenFin write SetNumSerieFacturaEmisorResumenFin stored NumSerieFacturaEmisorResumenFin_Specified;
    property FechaExpedicionFacturaEmisor:    fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : ClavePaginacionProveedorType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  ClavePaginacionProveedorType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura8;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura8    read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:        TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;



  // ************************************************************************ //
  // XML       : IDFacturaComunitariaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDFacturaComunitariaType = class(TRemotable)
  private
    FIDEmisorFactura: IDEmisorFactura9;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FFechaExpedicionFacturaEmisor: fecha;
  public
    destructor Destroy; override;
  published
    property IDEmisorFactura:              IDEmisorFactura9    read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFacturaEmisor:        TextoIDFacturaType  read FNumSerieFacturaEmisor write FNumSerieFacturaEmisor;
    property FechaExpedicionFacturaEmisor: fecha               read FFechaExpedicionFacturaEmisor write FFechaExpedicionFacturaEmisor;
  end;

  ImporteSgn12_2Type =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : FacturaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  FacturaType = class(TRemotable)
  private
    FTipoFactura: ClaveTipoFacturaType;
    FTipoRectificativa: ClaveTipoRectificativaType;
    FTipoRectificativa_Specified: boolean;
    FFacturasAgrupadas: FacturasAgrupadas2;
    FFacturasAgrupadas_Specified: boolean;
    FFacturasRectificadas: FacturasRectificadas2;
    FFacturasRectificadas_Specified: boolean;
    FImporteRectificacion: DesgloseRectificacionType;
    FImporteRectificacion_Specified: boolean;
    FFechaOperacion: fecha;
    FFechaOperacion_Specified: boolean;
    FClaveRegimenEspecialOTrascendencia: IdOperacionesTrascendenciaTributariaType;
    FClaveRegimenEspecialOTrascendenciaAdicional1: IdOperacionesTrascendenciaTributariaType;
    FClaveRegimenEspecialOTrascendenciaAdicional1_Specified: boolean;
    FClaveRegimenEspecialOTrascendenciaAdicional2: IdOperacionesTrascendenciaTributariaType;
    FClaveRegimenEspecialOTrascendenciaAdicional2_Specified: boolean;
    FNumRegistroAcuerdoFacturacion: TextMax15Type;
    FNumRegistroAcuerdoFacturacion_Specified: boolean;
    FImporteTotal: ImporteSgn12_2Type;
    FImporteTotal_Specified: boolean;
    FBaseImponibleACoste: ImporteSgn12_2Type;
    FBaseImponibleACoste_Specified: boolean;
    FDescripcionOperacion: TextMax500Type;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FFacturaSimplificadaArticulos7_2_7_3: SimplificadaCualificadaType;
    FFacturaSimplificadaArticulos7_2_7_3_Specified: boolean;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    FRegPrevioGGEEoREDEMEoCompetencia: RegPrevioGGEEoREDEMEoCompetenciaType;
    FRegPrevioGGEEoREDEMEoCompetencia_Specified: boolean;
    FMacrodato: MacrodatoType;
    FMacrodato_Specified: boolean;
    procedure SetTipoRectificativa(Index: Integer; const AClaveTipoRectificativaType: ClaveTipoRectificativaType);
    function  TipoRectificativa_Specified(Index: Integer): boolean;
    procedure SetFacturasAgrupadas(Index: Integer; const AFacturasAgrupadas2: FacturasAgrupadas2);
    function  FacturasAgrupadas_Specified(Index: Integer): boolean;
    procedure SetFacturasRectificadas(Index: Integer; const AFacturasRectificadas2: FacturasRectificadas2);
    function  FacturasRectificadas_Specified(Index: Integer): boolean;
    procedure SetImporteRectificacion(Index: Integer; const ADesgloseRectificacionType: DesgloseRectificacionType);
    function  ImporteRectificacion_Specified(Index: Integer): boolean;
    procedure SetFechaOperacion(Index: Integer; const Afecha: fecha);
    function  FechaOperacion_Specified(Index: Integer): boolean;
    procedure SetClaveRegimenEspecialOTrascendenciaAdicional1(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
    function  ClaveRegimenEspecialOTrascendenciaAdicional1_Specified(Index: Integer): boolean;
    procedure SetClaveRegimenEspecialOTrascendenciaAdicional2(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
    function  ClaveRegimenEspecialOTrascendenciaAdicional2_Specified(Index: Integer): boolean;
    procedure SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
    function  NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
    procedure SetImporteTotal(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTotal_Specified(Index: Integer): boolean;
    procedure SetBaseImponibleACoste(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  BaseImponibleACoste_Specified(Index: Integer): boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetFacturaSimplificadaArticulos7_2_7_3(Index: Integer; const ASimplificadaCualificadaType: SimplificadaCualificadaType);
    function  FacturaSimplificadaArticulos7_2_7_3_Specified(Index: Integer): boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
    procedure SetRegPrevioGGEEoREDEMEoCompetencia(Index: Integer; const ARegPrevioGGEEoREDEMEoCompetenciaType: RegPrevioGGEEoREDEMEoCompetenciaType);
    function  RegPrevioGGEEoREDEMEoCompetencia_Specified(Index: Integer): boolean;
    procedure SetMacrodato(Index: Integer; const AMacrodatoType: MacrodatoType);
    function  Macrodato_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property TipoFactura:                                  ClaveTipoFacturaType                      read FTipoFactura write FTipoFactura;
    property TipoRectificativa:                            ClaveTipoRectificativaType                Index (IS_OPTN) read FTipoRectificativa write SetTipoRectificativa stored TipoRectificativa_Specified;
    property FacturasAgrupadas:                            FacturasAgrupadas2                        Index (IS_OPTN) read FFacturasAgrupadas write SetFacturasAgrupadas stored FacturasAgrupadas_Specified;
    property FacturasRectificadas:                         FacturasRectificadas2                     Index (IS_OPTN) read FFacturasRectificadas write SetFacturasRectificadas stored FacturasRectificadas_Specified;
    property ImporteRectificacion:                         DesgloseRectificacionType                 Index (IS_OPTN) read FImporteRectificacion write SetImporteRectificacion stored ImporteRectificacion_Specified;
    property FechaOperacion:                               fecha                                     Index (IS_OPTN) read FFechaOperacion write SetFechaOperacion stored FechaOperacion_Specified;
    property ClaveRegimenEspecialOTrascendencia:           IdOperacionesTrascendenciaTributariaType  read FClaveRegimenEspecialOTrascendencia write FClaveRegimenEspecialOTrascendencia;
    property ClaveRegimenEspecialOTrascendenciaAdicional1: IdOperacionesTrascendenciaTributariaType  Index (IS_OPTN) read FClaveRegimenEspecialOTrascendenciaAdicional1 write SetClaveRegimenEspecialOTrascendenciaAdicional1 stored ClaveRegimenEspecialOTrascendenciaAdicional1_Specified;
    property ClaveRegimenEspecialOTrascendenciaAdicional2: IdOperacionesTrascendenciaTributariaType  Index (IS_OPTN) read FClaveRegimenEspecialOTrascendenciaAdicional2 write SetClaveRegimenEspecialOTrascendenciaAdicional2 stored ClaveRegimenEspecialOTrascendenciaAdicional2_Specified;
    property NumRegistroAcuerdoFacturacion:                TextMax15Type                             Index (IS_OPTN) read FNumRegistroAcuerdoFacturacion write SetNumRegistroAcuerdoFacturacion stored NumRegistroAcuerdoFacturacion_Specified;
    property ImporteTotal:                                 ImporteSgn12_2Type                        Index (IS_OPTN) read FImporteTotal write SetImporteTotal stored ImporteTotal_Specified;
    property BaseImponibleACoste:                          ImporteSgn12_2Type                        Index (IS_OPTN) read FBaseImponibleACoste write SetBaseImponibleACoste stored BaseImponibleACoste_Specified;
    property DescripcionOperacion:                         TextMax500Type                            read FDescripcionOperacion write FDescripcionOperacion;
    property RefExterna:                                   TextMax60Type                             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property FacturaSimplificadaArticulos7_2_7_3:          SimplificadaCualificadaType               Index (IS_OPTN) read FFacturaSimplificadaArticulos7_2_7_3 write SetFacturaSimplificadaArticulos7_2_7_3 stored FacturaSimplificadaArticulos7_2_7_3_Specified;
    property EntidadSucedida:                              PersonaFisicaJuridicaUnicaESType          Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
    property RegPrevioGGEEoREDEMEoCompetencia:             RegPrevioGGEEoREDEMEoCompetenciaType      Index (IS_OPTN) read FRegPrevioGGEEoREDEMEoCompetencia write SetRegPrevioGGEEoREDEMEoCompetencia stored RegPrevioGGEEoREDEMEoCompetencia_Specified;
    property Macrodato:                                    MacrodatoType                             Index (IS_OPTN) read FMacrodato write SetMacrodato stored Macrodato_Specified;
  end;



  // ************************************************************************ //
  // XML       : DetalleIVAEmitidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DetalleIVAEmitidaType = class(TRemotable)
  private
    FTipoImpositivo: Tipo2_2Type;
    FTipoImpositivo_Specified: boolean;
    FBaseImponible: ImporteSgn12_2Type;
    FCuotaRepercutida: ImporteSgn12_2Type;
    FCuotaRepercutida_Specified: boolean;
    FTipoRecargoEquivalencia: Tipo2_2Type;
    FTipoRecargoEquivalencia_Specified: boolean;
    FCuotaRecargoEquivalencia: ImporteSgn12_2Type;
    FCuotaRecargoEquivalencia_Specified: boolean;
    procedure SetTipoImpositivo(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  TipoImpositivo_Specified(Index: Integer): boolean;
    procedure SetCuotaRepercutida(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaRepercutida_Specified(Index: Integer): boolean;
    procedure SetTipoRecargoEquivalencia(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  TipoRecargoEquivalencia_Specified(Index: Integer): boolean;
    procedure SetCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
  published
    property TipoImpositivo:           Tipo2_2Type         Index (IS_OPTN) read FTipoImpositivo write SetTipoImpositivo stored TipoImpositivo_Specified;
    property BaseImponible:            ImporteSgn12_2Type  read FBaseImponible write FBaseImponible;
    property CuotaRepercutida:         ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaRepercutida write SetCuotaRepercutida stored CuotaRepercutida_Specified;
    property TipoRecargoEquivalencia:  Tipo2_2Type         Index (IS_OPTN) read FTipoRecargoEquivalencia write SetTipoRecargoEquivalencia stored TipoRecargoEquivalencia_Specified;
    property CuotaRecargoEquivalencia: ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaRecargoEquivalencia write SetCuotaRecargoEquivalencia stored CuotaRecargoEquivalencia_Specified;
  end;



  // ************************************************************************ //
  // XML       : FacturaRecibidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  FacturaRecibidaType = class(FacturaType)
  private
    FDesgloseFactura: DesgloseFacturaRecibidasType;
    FContraparte: PersonaFisicaJuridicaType;
    FFechaRegContable: fecha;
    FCuotaDeducible: ImporteSgn12_2Type;
  public
    destructor Destroy; override;
  published
    property DesgloseFactura:  DesgloseFacturaRecibidasType  read FDesgloseFactura write FDesgloseFactura;
    property Contraparte:      PersonaFisicaJuridicaType     read FContraparte write FContraparte;
    property FechaRegContable: fecha                         read FFechaRegContable write FFechaRegContable;
    property CuotaDeducible:   ImporteSgn12_2Type            read FCuotaDeducible write FCuotaDeducible;
  end;



  // ************************************************************************ //
  // XML       : DetalleExentaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DetalleExentaType = class(TRemotable)
  private
    FCausaExencion: CausaExencionType;
    FCausaExencion_Specified: boolean;
    FBaseImponible: ImporteSgn12_2Type;
    procedure SetCausaExencion(Index: Integer; const ACausaExencionType: CausaExencionType);
    function  CausaExencion_Specified(Index: Integer): boolean;
  published
    property CausaExencion: CausaExencionType   Index (IS_OPTN) read FCausaExencion write SetCausaExencion stored CausaExencion_Specified;
    property BaseImponible: ImporteSgn12_2Type  read FBaseImponible write FBaseImponible;
  end;



  // ************************************************************************ //
  // XML       : DetalleIVAEmitidaPrestacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DetalleIVAEmitidaPrestacionType = class(TRemotable)
  private
    FTipoImpositivo: Tipo2_2Type;
    FTipoImpositivo_Specified: boolean;
    FBaseImponible: ImporteSgn12_2Type;
    FCuotaRepercutida: ImporteSgn12_2Type;
    FCuotaRepercutida_Specified: boolean;
    procedure SetTipoImpositivo(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  TipoImpositivo_Specified(Index: Integer): boolean;
    procedure SetCuotaRepercutida(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaRepercutida_Specified(Index: Integer): boolean;
  published
    property TipoImpositivo:   Tipo2_2Type         Index (IS_OPTN) read FTipoImpositivo write SetTipoImpositivo stored TipoImpositivo_Specified;
    property BaseImponible:    ImporteSgn12_2Type  read FBaseImponible write FBaseImponible;
    property CuotaRepercutida: ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaRepercutida write SetCuotaRepercutida stored CuotaRepercutida_Specified;
  end;



  // ************************************************************************ //
  // XML       : NoSujetaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  NoSujetaType = class(TRemotable)
  private
    FImportePorArticulos7_14_Otros: ImporteSgn12_2Type;
    FImportePorArticulos7_14_Otros_Specified: boolean;
    FImporteTAIReglasLocalizacion: ImporteSgn12_2Type;
    FImporteTAIReglasLocalizacion_Specified: boolean;
    procedure SetImportePorArticulos7_14_Otros(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImportePorArticulos7_14_Otros_Specified(Index: Integer): boolean;
    procedure SetImporteTAIReglasLocalizacion(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTAIReglasLocalizacion_Specified(Index: Integer): boolean;
  published
    property ImportePorArticulos7_14_Otros: ImporteSgn12_2Type  Index (IS_OPTN) read FImportePorArticulos7_14_Otros write SetImportePorArticulos7_14_Otros stored ImportePorArticulos7_14_Otros_Specified;
    property ImporteTAIReglasLocalizacion:  ImporteSgn12_2Type  Index (IS_OPTN) read FImporteTAIReglasLocalizacion write SetImporteTAIReglasLocalizacion stored ImporteTAIReglasLocalizacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : DetalleIVARecibidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DetalleIVARecibidaType = class(TRemotable)
  private
    FTipoImpositivo: Tipo2_2Type;
    FTipoImpositivo_Specified: boolean;
    FBaseImponible: ImporteSgn12_2Type;
    FCuotaSoportada: ImporteSgn12_2Type;
    FCuotaSoportada_Specified: boolean;
    FTipoRecargoEquivalencia: Tipo2_2Type;
    FTipoRecargoEquivalencia_Specified: boolean;
    FCuotaRecargoEquivalencia: ImporteSgn12_2Type;
    FCuotaRecargoEquivalencia_Specified: boolean;
    FPorcentCompensacionREAGYP: Tipo2_2Type;
    FPorcentCompensacionREAGYP_Specified: boolean;
    FImporteCompensacionREAGYP: ImporteSgn12_2Type;
    FImporteCompensacionREAGYP_Specified: boolean;
    procedure SetTipoImpositivo(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  TipoImpositivo_Specified(Index: Integer): boolean;
    procedure SetCuotaSoportada(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaSoportada_Specified(Index: Integer): boolean;
    procedure SetTipoRecargoEquivalencia(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  TipoRecargoEquivalencia_Specified(Index: Integer): boolean;
    procedure SetCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
    procedure SetPorcentCompensacionREAGYP(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  PorcentCompensacionREAGYP_Specified(Index: Integer): boolean;
    procedure SetImporteCompensacionREAGYP(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteCompensacionREAGYP_Specified(Index: Integer): boolean;
  published
    property TipoImpositivo:            Tipo2_2Type         Index (IS_OPTN) read FTipoImpositivo write SetTipoImpositivo stored TipoImpositivo_Specified;
    property BaseImponible:             ImporteSgn12_2Type  read FBaseImponible write FBaseImponible;
    property CuotaSoportada:            ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaSoportada write SetCuotaSoportada stored CuotaSoportada_Specified;
    property TipoRecargoEquivalencia:   Tipo2_2Type         Index (IS_OPTN) read FTipoRecargoEquivalencia write SetTipoRecargoEquivalencia stored TipoRecargoEquivalencia_Specified;
    property CuotaRecargoEquivalencia:  ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaRecargoEquivalencia write SetCuotaRecargoEquivalencia stored CuotaRecargoEquivalencia_Specified;
    property PorcentCompensacionREAGYP: Tipo2_2Type         Index (IS_OPTN) read FPorcentCompensacionREAGYP write SetPorcentCompensacionREAGYP stored PorcentCompensacionREAGYP_Specified;
    property ImporteCompensacionREAGYP: ImporteSgn12_2Type  Index (IS_OPTN) read FImporteCompensacionREAGYP write SetImporteCompensacionREAGYP stored ImporteCompensacionREAGYP_Specified;
  end;



  // ************************************************************************ //
  // XML       : FacturaExpedidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  FacturaExpedidaType = class(FacturaType)
  private
    FDatosInmueble: DatosInmueble3;
    FDatosInmueble_Specified: boolean;
    FImporteTransmisionInmueblesSujetoAIVA: ImporteSgn12_2Type;
    FImporteTransmisionInmueblesSujetoAIVA_Specified: boolean;
    FEmitidaPorTercerosODestinatario: EmitidaPorTercerosType;
    FEmitidaPorTercerosODestinatario_Specified: boolean;
    FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas: EmitidaPorTercerosType;
    FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified: boolean;
    FVariosDestinatarios: VariosDestinatariosType;
    FVariosDestinatarios_Specified: boolean;
    FCupon: CuponType;
    FCupon_Specified: boolean;
    FFacturaSinIdentifDestinatarioAritculo6_1_d: CompletaSinDestinatarioType;
    FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified: boolean;
    FContraparte: PersonaFisicaJuridicaType;
    FContraparte_Specified: boolean;
    FTipoDesglose: TipoDesglose3;
    procedure SetDatosInmueble(Index: Integer; const ADatosInmueble3: DatosInmueble3);
    function  DatosInmueble_Specified(Index: Integer): boolean;
    procedure SetImporteTransmisionInmueblesSujetoAIVA(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTransmisionInmueblesSujetoAIVA_Specified(Index: Integer): boolean;
    procedure SetEmitidaPorTercerosODestinatario(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
    function  EmitidaPorTercerosODestinatario_Specified(Index: Integer): boolean;
    procedure SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
    function  FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified(Index: Integer): boolean;
    procedure SetVariosDestinatarios(Index: Integer; const AVariosDestinatariosType: VariosDestinatariosType);
    function  VariosDestinatarios_Specified(Index: Integer): boolean;
    procedure SetCupon(Index: Integer; const ACuponType: CuponType);
    function  Cupon_Specified(Index: Integer): boolean;
    procedure SetFacturaSinIdentifDestinatarioAritculo6_1_d(Index: Integer; const ACompletaSinDestinatarioType: CompletaSinDestinatarioType);
    function  FacturaSinIdentifDestinatarioAritculo6_1_d_Specified(Index: Integer): boolean;
    procedure SetContraparte(Index: Integer; const APersonaFisicaJuridicaType: PersonaFisicaJuridicaType);
    function  Contraparte_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DatosInmueble:                                                    DatosInmueble3               Index (IS_OPTN) read FDatosInmueble write SetDatosInmueble stored DatosInmueble_Specified;
    property ImporteTransmisionInmueblesSujetoAIVA:                            ImporteSgn12_2Type           Index (IS_OPTN) read FImporteTransmisionInmueblesSujetoAIVA write SetImporteTransmisionInmueblesSujetoAIVA stored ImporteTransmisionInmueblesSujetoAIVA_Specified;
    property EmitidaPorTercerosODestinatario:                                  EmitidaPorTercerosType       Index (IS_OPTN) read FEmitidaPorTercerosODestinatario write SetEmitidaPorTercerosODestinatario stored EmitidaPorTercerosODestinatario_Specified;
    property FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas: EmitidaPorTercerosType       Index (IS_OPTN) read FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas write SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas stored FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified;
    property VariosDestinatarios:                                              VariosDestinatariosType      Index (IS_OPTN) read FVariosDestinatarios write SetVariosDestinatarios stored VariosDestinatarios_Specified;
    property Cupon:                                                            CuponType                    Index (IS_OPTN) read FCupon write SetCupon stored Cupon_Specified;
    property FacturaSinIdentifDestinatarioAritculo6_1_d:                       CompletaSinDestinatarioType  Index (IS_OPTN) read FFacturaSinIdentifDestinatarioAritculo6_1_d write SetFacturaSinIdentifDestinatarioAritculo6_1_d stored FacturaSinIdentifDestinatarioAritculo6_1_d_Specified;
    property Contraparte:                                                      PersonaFisicaJuridicaType    Index (IS_OPTN) read FContraparte write SetContraparte stored Contraparte_Specified;
    property TipoDesglose:                                                     TipoDesglose3                read FTipoDesglose write FTipoDesglose;
  end;



  // ************************************************************************ //
  // XML       : DesgloseRectificacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DesgloseRectificacionType = class(TRemotable)
  private
    FBaseRectificada: ImporteSgn12_2Type;
    FCuotaRectificada: ImporteSgn12_2Type;
    FCuotaRecargoRectificado: ImporteSgn12_2Type;
    FCuotaRecargoRectificado_Specified: boolean;
    procedure SetCuotaRecargoRectificado(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaRecargoRectificado_Specified(Index: Integer): boolean;
  published
    property BaseRectificada:         ImporteSgn12_2Type  read FBaseRectificada write FBaseRectificada;
    property CuotaRectificada:        ImporteSgn12_2Type  read FCuotaRectificada write FCuotaRectificada;
    property CuotaRecargoRectificado: ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaRecargoRectificado write SetCuotaRecargoRectificado stored CuotaRecargoRectificado_Specified;
  end;



  // ************************************************************************ //
  // XML       : DetalleIVARecibida2Type, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DetalleIVARecibida2Type = class(TRemotable)
  private
    FTipoImpositivo: Tipo2_2Type;
    FBaseImponible: ImporteSgn12_2Type;
    FCuotaSoportada: ImporteSgn12_2Type;
    FTipoRecargoEquivalencia: Tipo2_2Type;
    FTipoRecargoEquivalencia_Specified: boolean;
    FCuotaRecargoEquivalencia: ImporteSgn12_2Type;
    FCuotaRecargoEquivalencia_Specified: boolean;
    procedure SetTipoRecargoEquivalencia(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
    function  TipoRecargoEquivalencia_Specified(Index: Integer): boolean;
    procedure SetCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  CuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
  published
    property TipoImpositivo:           Tipo2_2Type         read FTipoImpositivo write FTipoImpositivo;
    property BaseImponible:            ImporteSgn12_2Type  read FBaseImponible write FBaseImponible;
    property CuotaSoportada:           ImporteSgn12_2Type  read FCuotaSoportada write FCuotaSoportada;
    property TipoRecargoEquivalencia:  Tipo2_2Type         Index (IS_OPTN) read FTipoRecargoEquivalencia write SetTipoRecargoEquivalencia stored TipoRecargoEquivalencia_Specified;
    property CuotaRecargoEquivalencia: ImporteSgn12_2Type  Index (IS_OPTN) read FCuotaRecargoEquivalencia write SetCuotaRecargoEquivalencia stored CuotaRecargoEquivalencia_Specified;
  end;



  // ************************************************************************ //
  // XML       : DatosPagoCobroType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  DatosPagoCobroType = class(TRemotable)
  private
    FFecha: fecha;
    FImporte: ImporteSgn12_2Type;
    FMedio: MedioPagoType;
    FCuenta_O_Medio: TextMax34Type;
    FCuenta_O_Medio_Specified: boolean;
    procedure SetCuenta_O_Medio(Index: Integer; const ATextMax34Type: TextMax34Type);
    function  Cuenta_O_Medio_Specified(Index: Integer): boolean;
  published
    property Fecha:          fecha               read FFecha write FFecha;
    property Importe:        ImporteSgn12_2Type  read FImporte write FImporte;
    property Medio:          MedioPagoType       read FMedio write FMedio;
    property Cuenta_O_Medio: TextMax34Type       Index (IS_OPTN) read FCuenta_O_Medio write SetCuenta_O_Medio stored Cuenta_O_Medio_Specified;
  end;



  // ************************************************************************ //
  // XML       : BienDeInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  BienDeInversionType = class(TRemotable)
  private
    FIdentificacionBien: TextMax40Type;
    FFechaInicioUtilizacion: fecha;
    FProrrataAnualDefinitiva: Tipo2_2Type;
    FRegularizacionAnualDeduccion: ImporteSgn12_2Type;
    FRegularizacionAnualDeduccion_Specified: boolean;
    FIdentificacionEntrega: TextMax40Type;
    FIdentificacionEntrega_Specified: boolean;
    FRegularizacionDeduccionEfectuada: ImporteSgn12_2Type;
    FRegularizacionDeduccionEfectuada_Specified: boolean;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FNumRegistroAcuerdoFacturacion: TextMax15Type;
    FNumRegistroAcuerdoFacturacion_Specified: boolean;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    procedure SetRegularizacionAnualDeduccion(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  RegularizacionAnualDeduccion_Specified(Index: Integer): boolean;
    procedure SetIdentificacionEntrega(Index: Integer; const ATextMax40Type: TextMax40Type);
    function  IdentificacionEntrega_Specified(Index: Integer): boolean;
    procedure SetRegularizacionDeduccionEfectuada(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  RegularizacionDeduccionEfectuada_Specified(Index: Integer): boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
    function  NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IdentificacionBien:               TextMax40Type                     read FIdentificacionBien write FIdentificacionBien;
    property FechaInicioUtilizacion:           fecha                             read FFechaInicioUtilizacion write FFechaInicioUtilizacion;
    property ProrrataAnualDefinitiva:          Tipo2_2Type                       read FProrrataAnualDefinitiva write FProrrataAnualDefinitiva;
    property RegularizacionAnualDeduccion:     ImporteSgn12_2Type                Index (IS_OPTN) read FRegularizacionAnualDeduccion write SetRegularizacionAnualDeduccion stored RegularizacionAnualDeduccion_Specified;
    property IdentificacionEntrega:            TextMax40Type                     Index (IS_OPTN) read FIdentificacionEntrega write SetIdentificacionEntrega stored IdentificacionEntrega_Specified;
    property RegularizacionDeduccionEfectuada: ImporteSgn12_2Type                Index (IS_OPTN) read FRegularizacionDeduccionEfectuada write SetRegularizacionDeduccionEfectuada stored RegularizacionDeduccionEfectuada_Specified;
    property RefExterna:                       TextMax60Type                     Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property NumRegistroAcuerdoFacturacion:    TextMax15Type                     Index (IS_OPTN) read FNumRegistroAcuerdoFacturacion write SetNumRegistroAcuerdoFacturacion stored NumRegistroAcuerdoFacturacion_Specified;
    property EntidadSucedida:                  PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaCobrosMetalicoType = class(TRemotable)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FImporteTotal: ImporteSgn12_2Type;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:     PersonaFisicaJuridicaType         read FContraparte write FContraparte;
    property ImporteTotal:    ImporteSgn12_2Type                read FImporteTotal write FImporteTotal;
    property EntidadSucedida: PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
  end;



  // ************************************************************************ //
  // XML       : FacturaRespuestaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  FacturaRespuestaType = class(TRemotable)
  private
    FTipoFactura: ClaveTipoFacturaType;
    FTipoRectificativa: ClaveTipoRectificativaType;
    FTipoRectificativa_Specified: boolean;
    FFacturasAgrupadas: FacturasAgrupadas;
    FFacturasAgrupadas_Specified: boolean;
    FFacturasRectificadas: FacturasRectificadas;
    FFacturasRectificadas_Specified: boolean;
    FImporteRectificacion: DesgloseRectificacionType;
    FImporteRectificacion_Specified: boolean;
    FFechaOperacion: fecha;
    FFechaOperacion_Specified: boolean;
    FClaveRegimenEspecialOTrascendencia: IdOperacionesTrascendenciaTributariaType;
    FClaveRegimenEspecialOTrascendenciaAdicional1: IdOperacionesTrascendenciaTributariaType;
    FClaveRegimenEspecialOTrascendenciaAdicional1_Specified: boolean;
    FClaveRegimenEspecialOTrascendenciaAdicional2: IdOperacionesTrascendenciaTributariaType;
    FClaveRegimenEspecialOTrascendenciaAdicional2_Specified: boolean;
    FNumRegistroAcuerdoFacturacion: TextMax15Type;
    FNumRegistroAcuerdoFacturacion_Specified: boolean;
    FImporteTotal: ImporteSgn12_2Type;
    FImporteTotal_Specified: boolean;
    FBaseImponibleACoste: ImporteSgn12_2Type;
    FBaseImponibleACoste_Specified: boolean;
    FDescripcionOperacion: TextMax500Type;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FFacturaSimplificadaArticulos7_2_7_3: SimplificadaCualificadaType;
    FFacturaSimplificadaArticulos7_2_7_3_Specified: boolean;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    FRegPrevioGGEEoREDEMEoCompetencia: RegPrevioGGEEoREDEMEoCompetenciaType;
    FRegPrevioGGEEoREDEMEoCompetencia_Specified: boolean;
    FMacrodato: MacrodatoType;
    FMacrodato_Specified: boolean;
    procedure SetTipoRectificativa(Index: Integer; const AClaveTipoRectificativaType: ClaveTipoRectificativaType);
    function  TipoRectificativa_Specified(Index: Integer): boolean;
    procedure SetFacturasAgrupadas(Index: Integer; const AFacturasAgrupadas: FacturasAgrupadas);
    function  FacturasAgrupadas_Specified(Index: Integer): boolean;
    procedure SetFacturasRectificadas(Index: Integer; const AFacturasRectificadas: FacturasRectificadas);
    function  FacturasRectificadas_Specified(Index: Integer): boolean;
    procedure SetImporteRectificacion(Index: Integer; const ADesgloseRectificacionType: DesgloseRectificacionType);
    function  ImporteRectificacion_Specified(Index: Integer): boolean;
    procedure SetFechaOperacion(Index: Integer; const Afecha: fecha);
    function  FechaOperacion_Specified(Index: Integer): boolean;
    procedure SetClaveRegimenEspecialOTrascendenciaAdicional1(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
    function  ClaveRegimenEspecialOTrascendenciaAdicional1_Specified(Index: Integer): boolean;
    procedure SetClaveRegimenEspecialOTrascendenciaAdicional2(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
    function  ClaveRegimenEspecialOTrascendenciaAdicional2_Specified(Index: Integer): boolean;
    procedure SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
    function  NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
    procedure SetImporteTotal(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTotal_Specified(Index: Integer): boolean;
    procedure SetBaseImponibleACoste(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  BaseImponibleACoste_Specified(Index: Integer): boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetFacturaSimplificadaArticulos7_2_7_3(Index: Integer; const ASimplificadaCualificadaType: SimplificadaCualificadaType);
    function  FacturaSimplificadaArticulos7_2_7_3_Specified(Index: Integer): boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
    procedure SetRegPrevioGGEEoREDEMEoCompetencia(Index: Integer; const ARegPrevioGGEEoREDEMEoCompetenciaType: RegPrevioGGEEoREDEMEoCompetenciaType);
    function  RegPrevioGGEEoREDEMEoCompetencia_Specified(Index: Integer): boolean;
    procedure SetMacrodato(Index: Integer; const AMacrodatoType: MacrodatoType);
    function  Macrodato_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property TipoFactura:                                  ClaveTipoFacturaType                      read FTipoFactura write FTipoFactura;
    property TipoRectificativa:                            ClaveTipoRectificativaType                Index (IS_OPTN) read FTipoRectificativa write SetTipoRectificativa stored TipoRectificativa_Specified;
    property FacturasAgrupadas:                            FacturasAgrupadas                         Index (IS_OPTN) read FFacturasAgrupadas write SetFacturasAgrupadas stored FacturasAgrupadas_Specified;
    property FacturasRectificadas:                         FacturasRectificadas                      Index (IS_OPTN) read FFacturasRectificadas write SetFacturasRectificadas stored FacturasRectificadas_Specified;
    property ImporteRectificacion:                         DesgloseRectificacionType                 Index (IS_OPTN) read FImporteRectificacion write SetImporteRectificacion stored ImporteRectificacion_Specified;
    property FechaOperacion:                               fecha                                     Index (IS_OPTN) read FFechaOperacion write SetFechaOperacion stored FechaOperacion_Specified;
    property ClaveRegimenEspecialOTrascendencia:           IdOperacionesTrascendenciaTributariaType  read FClaveRegimenEspecialOTrascendencia write FClaveRegimenEspecialOTrascendencia;
    property ClaveRegimenEspecialOTrascendenciaAdicional1: IdOperacionesTrascendenciaTributariaType  Index (IS_OPTN) read FClaveRegimenEspecialOTrascendenciaAdicional1 write SetClaveRegimenEspecialOTrascendenciaAdicional1 stored ClaveRegimenEspecialOTrascendenciaAdicional1_Specified;
    property ClaveRegimenEspecialOTrascendenciaAdicional2: IdOperacionesTrascendenciaTributariaType  Index (IS_OPTN) read FClaveRegimenEspecialOTrascendenciaAdicional2 write SetClaveRegimenEspecialOTrascendenciaAdicional2 stored ClaveRegimenEspecialOTrascendenciaAdicional2_Specified;
    property NumRegistroAcuerdoFacturacion:                TextMax15Type                             Index (IS_OPTN) read FNumRegistroAcuerdoFacturacion write SetNumRegistroAcuerdoFacturacion stored NumRegistroAcuerdoFacturacion_Specified;
    property ImporteTotal:                                 ImporteSgn12_2Type                        Index (IS_OPTN) read FImporteTotal write SetImporteTotal stored ImporteTotal_Specified;
    property BaseImponibleACoste:                          ImporteSgn12_2Type                        Index (IS_OPTN) read FBaseImponibleACoste write SetBaseImponibleACoste stored BaseImponibleACoste_Specified;
    property DescripcionOperacion:                         TextMax500Type                            read FDescripcionOperacion write FDescripcionOperacion;
    property RefExterna:                                   TextMax60Type                             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property FacturaSimplificadaArticulos7_2_7_3:          SimplificadaCualificadaType               Index (IS_OPTN) read FFacturaSimplificadaArticulos7_2_7_3 write SetFacturaSimplificadaArticulos7_2_7_3 stored FacturaSimplificadaArticulos7_2_7_3_Specified;
    property EntidadSucedida:                              PersonaFisicaJuridicaUnicaESType          Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
    property RegPrevioGGEEoREDEMEoCompetencia:             RegPrevioGGEEoREDEMEoCompetenciaType      Index (IS_OPTN) read FRegPrevioGGEEoREDEMEoCompetencia write SetRegPrevioGGEEoREDEMEoCompetencia stored RegPrevioGGEEoREDEMEoCompetencia_Specified;
    property Macrodato:                                    MacrodatoType                             Index (IS_OPTN) read FMacrodato write SetMacrodato stored Macrodato_Specified;
  end;



  // ************************************************************************ //
  // XML       : FacturaRespuestaInformadaProveedorType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  FacturaRespuestaInformadaProveedorType = class(FacturaRespuestaType)
  private
    FDatosInmueble: DatosInmueble2;
    FDatosInmueble_Specified: boolean;
    FImporteTransmisionInmueblesSujetoAIVA: ImporteSgn12_2Type;
    FImporteTransmisionInmueblesSujetoAIVA_Specified: boolean;
    FEmitidaPorTercerosODestinatario: EmitidaPorTercerosType;
    FEmitidaPorTercerosODestinatario_Specified: boolean;
    FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas: EmitidaPorTercerosType;
    FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified: boolean;
    FVariosDestinatarios: VariosDestinatariosType;
    FVariosDestinatarios_Specified: boolean;
    FCupon: CuponType;
    FCupon_Specified: boolean;
    FFacturaSinIdentifDestinatarioAritculo6_1_d: CompletaSinDestinatarioType;
    FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified: boolean;
    FTipoDesglose: TipoDesglose2;
    FCobros: FacturaARType;
    procedure SetDatosInmueble(Index: Integer; const ADatosInmueble2: DatosInmueble2);
    function  DatosInmueble_Specified(Index: Integer): boolean;
    procedure SetImporteTransmisionInmueblesSujetoAIVA(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTransmisionInmueblesSujetoAIVA_Specified(Index: Integer): boolean;
    procedure SetEmitidaPorTercerosODestinatario(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
    function  EmitidaPorTercerosODestinatario_Specified(Index: Integer): boolean;
    procedure SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
    function  FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified(Index: Integer): boolean;
    procedure SetVariosDestinatarios(Index: Integer; const AVariosDestinatariosType: VariosDestinatariosType);
    function  VariosDestinatarios_Specified(Index: Integer): boolean;
    procedure SetCupon(Index: Integer; const ACuponType: CuponType);
    function  Cupon_Specified(Index: Integer): boolean;
    procedure SetFacturaSinIdentifDestinatarioAritculo6_1_d(Index: Integer; const ACompletaSinDestinatarioType: CompletaSinDestinatarioType);
    function  FacturaSinIdentifDestinatarioAritculo6_1_d_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DatosInmueble:                                                    DatosInmueble2               Index (IS_OPTN) read FDatosInmueble write SetDatosInmueble stored DatosInmueble_Specified;
    property ImporteTransmisionInmueblesSujetoAIVA:                            ImporteSgn12_2Type           Index (IS_OPTN) read FImporteTransmisionInmueblesSujetoAIVA write SetImporteTransmisionInmueblesSujetoAIVA stored ImporteTransmisionInmueblesSujetoAIVA_Specified;
    property EmitidaPorTercerosODestinatario:                                  EmitidaPorTercerosType       Index (IS_OPTN) read FEmitidaPorTercerosODestinatario write SetEmitidaPorTercerosODestinatario stored EmitidaPorTercerosODestinatario_Specified;
    property FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas: EmitidaPorTercerosType       Index (IS_OPTN) read FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas write SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas stored FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified;
    property VariosDestinatarios:                                              VariosDestinatariosType      Index (IS_OPTN) read FVariosDestinatarios write SetVariosDestinatarios stored VariosDestinatarios_Specified;
    property Cupon:                                                            CuponType                    Index (IS_OPTN) read FCupon write SetCupon stored Cupon_Specified;
    property FacturaSinIdentifDestinatarioAritculo6_1_d:                       CompletaSinDestinatarioType  Index (IS_OPTN) read FFacturaSinIdentifDestinatarioAritculo6_1_d write SetFacturaSinIdentifDestinatarioAritculo6_1_d stored FacturaSinIdentifDestinatarioAritculo6_1_d_Specified;
    property TipoDesglose:                                                     TipoDesglose2                read FTipoDesglose write FTipoDesglose;
    property Cobros:                                                           FacturaARType                read FCobros write FCobros;
  end;



  // ************************************************************************ //
  // XML       : FacturaRespuestaInformadaClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  FacturaRespuestaInformadaClienteType = class(FacturaRespuestaType)
  private
    FDesgloseFactura: DesgloseFacturaRecibidasType;
    FFechaRegContable: fecha;
    FPagos: FacturaARType;
  public
    destructor Destroy; override;
  published
    property DesgloseFactura:  DesgloseFacturaRecibidasType  read FDesgloseFactura write FDesgloseFactura;
    property FechaRegContable: fecha                         read FFechaRegContable write FFechaRegContable;
    property Pagos:            FacturaARType                 read FPagos write FPagos;
  end;



  // ************************************************************************ //
  // XML       : FacturaRespuestaExpedidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  FacturaRespuestaExpedidaType = class(FacturaRespuestaType)
  private
    FDatosInmueble: DatosInmueble;
    FDatosInmueble_Specified: boolean;
    FImporteTransmisionInmueblesSujetoAIVA: ImporteSgn12_2Type;
    FImporteTransmisionInmueblesSujetoAIVA_Specified: boolean;
    FEmitidaPorTercerosODestinatario: EmitidaPorTercerosType;
    FEmitidaPorTercerosODestinatario_Specified: boolean;
    FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas: EmitidaPorTercerosType;
    FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified: boolean;
    FVariosDestinatarios: VariosDestinatariosType;
    FVariosDestinatarios_Specified: boolean;
    FCupon: CuponType;
    FCupon_Specified: boolean;
    FFacturaSinIdentifDestinatarioAritculo6_1_d: CompletaSinDestinatarioType;
    FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified: boolean;
    FContraparte: PersonaFisicaJuridicaType;
    FContraparte_Specified: boolean;
    FTipoDesglose: TipoDesglose;
    FCobros: FacturaARType;
    procedure SetDatosInmueble(Index: Integer; const ADatosInmueble: DatosInmueble);
    function  DatosInmueble_Specified(Index: Integer): boolean;
    procedure SetImporteTransmisionInmueblesSujetoAIVA(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTransmisionInmueblesSujetoAIVA_Specified(Index: Integer): boolean;
    procedure SetEmitidaPorTercerosODestinatario(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
    function  EmitidaPorTercerosODestinatario_Specified(Index: Integer): boolean;
    procedure SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
    function  FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified(Index: Integer): boolean;
    procedure SetVariosDestinatarios(Index: Integer; const AVariosDestinatariosType: VariosDestinatariosType);
    function  VariosDestinatarios_Specified(Index: Integer): boolean;
    procedure SetCupon(Index: Integer; const ACuponType: CuponType);
    function  Cupon_Specified(Index: Integer): boolean;
    procedure SetFacturaSinIdentifDestinatarioAritculo6_1_d(Index: Integer; const ACompletaSinDestinatarioType: CompletaSinDestinatarioType);
    function  FacturaSinIdentifDestinatarioAritculo6_1_d_Specified(Index: Integer): boolean;
    procedure SetContraparte(Index: Integer; const APersonaFisicaJuridicaType: PersonaFisicaJuridicaType);
    function  Contraparte_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DatosInmueble:                                                    DatosInmueble                Index (IS_OPTN) read FDatosInmueble write SetDatosInmueble stored DatosInmueble_Specified;
    property ImporteTransmisionInmueblesSujetoAIVA:                            ImporteSgn12_2Type           Index (IS_OPTN) read FImporteTransmisionInmueblesSujetoAIVA write SetImporteTransmisionInmueblesSujetoAIVA stored ImporteTransmisionInmueblesSujetoAIVA_Specified;
    property EmitidaPorTercerosODestinatario:                                  EmitidaPorTercerosType       Index (IS_OPTN) read FEmitidaPorTercerosODestinatario write SetEmitidaPorTercerosODestinatario stored EmitidaPorTercerosODestinatario_Specified;
    property FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas: EmitidaPorTercerosType       Index (IS_OPTN) read FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas write SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas stored FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified;
    property VariosDestinatarios:                                              VariosDestinatariosType      Index (IS_OPTN) read FVariosDestinatarios write SetVariosDestinatarios stored VariosDestinatarios_Specified;
    property Cupon:                                                            CuponType                    Index (IS_OPTN) read FCupon write SetCupon stored Cupon_Specified;
    property FacturaSinIdentifDestinatarioAritculo6_1_d:                       CompletaSinDestinatarioType  Index (IS_OPTN) read FFacturaSinIdentifDestinatarioAritculo6_1_d write SetFacturaSinIdentifDestinatarioAritculo6_1_d stored FacturaSinIdentifDestinatarioAritculo6_1_d_Specified;
    property Contraparte:                                                      PersonaFisicaJuridicaType    Index (IS_OPTN) read FContraparte write SetContraparte stored Contraparte_Specified;
    property TipoDesglose:                                                     TipoDesglose                 read FTipoDesglose write FTipoDesglose;
    property Cobros:                                                           FacturaARType                read FCobros write FCobros;
  end;



  // ************************************************************************ //
  // XML       : FacturaRespuestaRecibidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  FacturaRespuestaRecibidaType = class(FacturaRespuestaType)
  private
    FDesgloseFactura: DesgloseFacturaRecibidasType;
    FContraparte: PersonaFisicaJuridicaType;
    FFechaRegContable: fecha;
    FCuotaDeducible: ImporteSgn12_2Type;
    FPagos: FacturaARType;
  public
    destructor Destroy; override;
  published
    property DesgloseFactura:  DesgloseFacturaRecibidasType  read FDesgloseFactura write FDesgloseFactura;
    property Contraparte:      PersonaFisicaJuridicaType     read FContraparte write FContraparte;
    property FechaRegContable: fecha                         read FFechaRegContable write FFechaRegContable;
    property CuotaDeducible:   ImporteSgn12_2Type            read FCuotaDeducible write FCuotaDeducible;
    property Pagos:            FacturaARType                 read FPagos write FPagos;
  end;



  // ************************************************************************ //
  // XML       : IDOtroType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  IDOtroType = class(TRemotable)
  private
    FCodigoPais: CountryType2;
    FCodigoPais_Specified: boolean;
    FIDType: PersonaFisicaJuridicaIDTypeType;
    FID: TextMax20Type;
    procedure SetCodigoPais(Index: Integer; const ACountryType2: CountryType2);
    function  CodigoPais_Specified(Index: Integer): boolean;
  published
    property CodigoPais: CountryType2                     Index (IS_OPTN) read FCodigoPais write SetCodigoPais stored CodigoPais_Specified;
    property IDType:     PersonaFisicaJuridicaIDTypeType  read FIDType write FIDType;
    property ID:         TextMax20Type                    read FID write FID;
  end;



  // ************************************************************************ //
  // XML       : RangoFechaPresentacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  RangoFechaPresentacionType = class(TRemotable)
  private
    FDesde: fecha;
    FDesde_Specified: boolean;
    FHasta: fecha;
    FHasta_Specified: boolean;
    procedure SetDesde(Index: Integer; const Afecha: fecha);
    function  Desde_Specified(Index: Integer): boolean;
    procedure SetHasta(Index: Integer; const Afecha: fecha);
    function  Hasta_Specified(Index: Integer): boolean;
  published
    property Desde: fecha  Index (IS_OPTN) read FDesde write SetDesde stored Desde_Specified;
    property Hasta: fecha  Index (IS_OPTN) read FHasta write SetHasta stored Hasta_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaBienesInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRConsultaBienesInversionType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroBienInversionType;
  public
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroBienInversionType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaDetOperIntracomunitariasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRConsultaDetOperIntracomunitariasType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroDetOperIntracomunitariasType;
  public
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroDetOperIntracomunitariasType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRFactInformadasAgrupadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ConsultaLRFactInformadasAgrupadasClienteType = class(ConsultaInformacionCliente)
  private
    FFiltroConsulta: LRFiltroFactInformadasAgrupadasClienteType;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroFactInformadasAgrupadasClienteType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  LRConsultaEmitidasType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroEmitidasType;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroEmitidasType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRFactInformadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ConsultaLRFactInformadasClienteType = class(ConsultaInformacionCliente)
  private
    FFiltroConsulta: LRFiltroFactInformadasClienteType;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroFactInformadasClienteType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRConsultaCobrosMetalicoType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroCobrosMetalicoType;
  public
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroCobrosMetalicoType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : ConsultaPagosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaPagosType = class(ConsultaInformacion)
  private
    FFiltroConsultaPagos: LRFiltroPagosType;
  public
    destructor Destroy; override;
  published
    property FiltroConsultaPagos: LRFiltroPagosType  read FFiltroConsultaPagos write FFiltroConsultaPagos;
  end;



  // ************************************************************************ //
  // XML       : ConsultaInmueblesAdicionalesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaInmueblesAdicionalesType = class(ConsultaInformacion)
  private
    FFiltroConsultaInmueblesAdicionales: LRFiltroInmueblesAdicionalesType;
  public
    destructor Destroy; override;
  published
    property FiltroConsultaInmueblesAdicionales: LRFiltroInmueblesAdicionalesType  read FFiltroConsultaInmueblesAdicionales write FFiltroConsultaInmueblesAdicionales;
  end;



  // ************************************************************************ //
  // XML       : ConsultaCobrosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaCobrosType = class(ConsultaInformacion)
  private
    FFiltroConsultaCobros: LRFiltroCobrosType;
  public
    destructor Destroy; override;
  published
    property FiltroConsultaCobros: LRFiltroCobrosType  read FFiltroConsultaCobros write FFiltroConsultaCobros;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRConsultaAgenciasViajesType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroAgenciasViajesType;
  public
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroAgenciasViajesType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaLROperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRConsultaLROperacionesSegurosType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroOperacionesSegurosType;
  public
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroOperacionesSegurosType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : ClavePaginacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ClavePaginacion = class(TRemotable)
  private
    FContraparte: PersonaFisicaJuridicaType;
  public
    destructor Destroy; override;
  published
    property Contraparte: PersonaFisicaJuridicaType  read FContraparte write FContraparte;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroInmueblesAdicionalesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroInmueblesAdicionalesType = class(TRemotable)
  private
    FIDFactura: IDFacturaExpedidaBCType;
  public
    destructor Destroy; override;
  published
    property IDFactura: IDFacturaExpedidaBCType  read FIDFactura write FIDFactura;
  end;



  // ************************************************************************ //
  // XML       : LRConsultaRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRConsultaRecibidasType = class(ConsultaInformacion)
  private
    FFiltroConsulta: LRFiltroRecibidasType;
  public
    destructor Destroy; override;
  published
    property FiltroConsulta: LRFiltroRecibidasType  read FFiltroConsulta write FFiltroConsulta;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroCobrosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroCobrosType = class(TRemotable)
  private
    FIDFactura: IDFacturaExpedidaBCType;
    FClavePaginacion: Double;
    FClavePaginacion_Specified: boolean;
    procedure SetClavePaginacion(Index: Integer; const ADouble: Double);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:       IDFacturaExpedidaBCType  read FIDFactura write FIDFactura;
    property ClavePaginacion: Double                   Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroPagosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroPagosType = class(TRemotable)
  private
    FIDFactura: IDFacturaRecibidaNombreBCType;
    FClavePaginacion: Double;
    FClavePaginacion_Specified: boolean;
    procedure SetClavePaginacion(Index: Integer; const ADouble: Double);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:       IDFacturaRecibidaNombreBCType  read FIDFactura write FIDFactura;
    property ClavePaginacion: Double                         Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaPagosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaPagosType = class(RespuestaConsultaFacturaPagosType)
  private
    FRegistroRespuestaConsultaPagos: Array_Of_RegistroRespuestaConsultaPagosType;
    FRegistroRespuestaConsultaPagos_Specified: boolean;
    FClavePaginacion: Double;
    FClavePaginacion_Specified: boolean;
    procedure SetRegistroRespuestaConsultaPagos(Index: Integer; const AArray_Of_RegistroRespuestaConsultaPagosType: Array_Of_RegistroRespuestaConsultaPagosType);
    function  RegistroRespuestaConsultaPagos_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const ADouble: Double);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaPagos: Array_Of_RegistroRespuestaConsultaPagosType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaPagos write SetRegistroRespuestaConsultaPagos stored RegistroRespuestaConsultaPagos_Specified;
    property ClavePaginacion:                Double                                       Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaPagos, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaPagos = class(RespuestaConsultaPagosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaCobrosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaCobrosType = class(RespuestaConsultaFacturaCobrosType)
  private
    FRegistroRespuestaConsultaCobros: Array_Of_RegistroRespuestaConsultaCobrosType;
    FRegistroRespuestaConsultaCobros_Specified: boolean;
    FClavePaginacion: Double;
    FClavePaginacion_Specified: boolean;
    procedure SetRegistroRespuestaConsultaCobros(Index: Integer; const AArray_Of_RegistroRespuestaConsultaCobrosType: Array_Of_RegistroRespuestaConsultaCobrosType);
    function  RegistroRespuestaConsultaCobros_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const ADouble: Double);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaCobros: Array_Of_RegistroRespuestaConsultaCobrosType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaCobros write SetRegistroRespuestaConsultaCobros stored RegistroRespuestaConsultaCobros_Specified;
    property ClavePaginacion:                 Double                                        Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaCobros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaCobros = class(RespuestaConsultaCobrosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ClavePaginacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ClavePaginacion2 = class(TRemotable)
  private
    FContraparte: PersonaFisicaJuridicaType;
  public
    destructor Destroy; override;
  published
    property Contraparte: PersonaFisicaJuridicaType  read FContraparte write FContraparte;
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRFacturasRecibidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaLRFacturasRecibidas = class(LRConsultaRecibidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaRecibidasType = class(TRemotable)
  private
    FIDFactura: IDFacturaRecibidaType;
    FDatosFacturaRecibida: FacturaRespuestaRecibidaType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoFactura: EstadoFacturaType;
    FDatosDescuadreContraparte: DatosDescuadreContraparteType;
    FDatosDescuadreContraparte_Specified: boolean;
    procedure SetDatosDescuadreContraparte(Index: Integer; const ADatosDescuadreContraparteType: DatosDescuadreContraparteType);
    function  DatosDescuadreContraparte_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                 IDFacturaRecibidaType          read FIDFactura write FIDFactura;
    property DatosFacturaRecibida:      FacturaRespuestaRecibidaType   read FDatosFacturaRecibida write FDatosFacturaRecibida;
    property DatosPresentacion:         DatosPresentacion2Type         read FDatosPresentacion write FDatosPresentacion;
    property EstadoFactura:             EstadoFacturaType              read FEstadoFactura write FEstadoFactura;
    property DatosDescuadreContraparte: DatosDescuadreContraparteType  Index (IS_OPTN) read FDatosDescuadreContraparte write SetDatosDescuadreContraparte stored DatosDescuadreContraparte_Specified;
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaEmitidasType = class(TRemotable)
  private
    FIDFactura: IDFacturaExpedidaType;
    FDatosFacturaEmitida: FacturaRespuestaExpedidaType;
    FDatosPresentacion: DatosPresentacion2Type;
    FEstadoFactura: EstadoFacturaType;
    FDatosDescuadreContraparte: DatosDescuadreContraparteType;
    FDatosDescuadreContraparte_Specified: boolean;
    procedure SetDatosDescuadreContraparte(Index: Integer; const ADatosDescuadreContraparteType: DatosDescuadreContraparteType);
    function  DatosDescuadreContraparte_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                 IDFacturaExpedidaType          read FIDFactura write FIDFactura;
    property DatosFacturaEmitida:       FacturaRespuestaExpedidaType   read FDatosFacturaEmitida write FDatosFacturaEmitida;
    property DatosPresentacion:         DatosPresentacion2Type         read FDatosPresentacion write FDatosPresentacion;
    property EstadoFactura:             EstadoFacturaType              read FEstadoFactura write FEstadoFactura;
    property DatosDescuadreContraparte: DatosDescuadreContraparteType  Index (IS_OPTN) read FDatosDescuadreContraparte write SetDatosDescuadreContraparte stored DatosDescuadreContraparte_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRFacturasType = class(ConsultaInformacion)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion10;
    FIndicadorPaginacion: IndicadorPaginacionType;
    FResultadoConsulta: ResultadoConsultaType;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:  PeriodoLiquidacion10     read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property IndicadorPaginacion: IndicadorPaginacionType  read FIndicadorPaginacion write FIndicadorPaginacion;
    property ResultadoConsulta:   ResultadoConsultaType    read FResultadoConsulta write FResultadoConsulta;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaConsultaLRFacturasEmitidasType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLRFacturasEmitidas: Array_Of_RegistroRespuestaConsultaEmitidasType;
    FRegistroRespuestaConsultaLRFacturasEmitidas_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRFacturasEmitidas(Index: Integer; const AArray_Of_RegistroRespuestaConsultaEmitidasType: Array_Of_RegistroRespuestaConsultaEmitidasType);
    function  RegistroRespuestaConsultaLRFacturasEmitidas_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRFacturasEmitidas: Array_Of_RegistroRespuestaConsultaEmitidasType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRFacturasEmitidas write SetRegistroRespuestaConsultaLRFacturasEmitidas stored RegistroRespuestaConsultaLRFacturasEmitidas_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasEmitidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaConsultaLRFacturasEmitidas = class(RespuestaConsultaLRFacturasEmitidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRFacturasRecibidasType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLRFacturasRecibidas: Array_Of_RegistroRespuestaConsultaRecibidasType;
    FRegistroRespuestaConsultaLRFacturasRecibidas_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRFacturasRecibidas(Index: Integer; const AArray_Of_RegistroRespuestaConsultaRecibidasType: Array_Of_RegistroRespuestaConsultaRecibidasType);
    function  RegistroRespuestaConsultaLRFacturasRecibidas_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRFacturasRecibidas: Array_Of_RegistroRespuestaConsultaRecibidasType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRFacturasRecibidas write SetRegistroRespuestaConsultaLRFacturasRecibidas stored RegistroRespuestaConsultaLRFacturasRecibidas_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasRecibidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRFacturasRecibidas = class(RespuestaConsultaLRFacturasRecibidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLROperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLROperacionesSegurosType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLROperacionesSeguros: Array_Of_RegistroRespuestaConsultaOperacionesSegurosType;
    FRegistroRespuestaConsultaLROperacionesSeguros_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLROperacionesSeguros(Index: Integer; const AArray_Of_RegistroRespuestaConsultaOperacionesSegurosType: Array_Of_RegistroRespuestaConsultaOperacionesSegurosType);
    function  RegistroRespuestaConsultaLROperacionesSeguros_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLROperacionesSeguros: Array_Of_RegistroRespuestaConsultaOperacionesSegurosType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLROperacionesSeguros write SetRegistroRespuestaConsultaLROperacionesSeguros stored RegistroRespuestaConsultaLROperacionesSeguros_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLROperacionesSeguros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLROperacionesSeguros = class(RespuestaConsultaLROperacionesSegurosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRAgenciasViajesType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLRAgenciasViajes: Array_Of_RegistroRespuestaConsultaAgenciasViajesType;
    FRegistroRespuestaConsultaLRAgenciasViajes_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRAgenciasViajes(Index: Integer; const AArray_Of_RegistroRespuestaConsultaAgenciasViajesType: Array_Of_RegistroRespuestaConsultaAgenciasViajesType);
    function  RegistroRespuestaConsultaLRAgenciasViajes_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRAgenciasViajes: Array_Of_RegistroRespuestaConsultaAgenciasViajesType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRAgenciasViajes write SetRegistroRespuestaConsultaLRAgenciasViajes stored RegistroRespuestaConsultaLRAgenciasViajes_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRAgenciasViajes, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRAgenciasViajes = class(RespuestaConsultaLRAgenciasViajesType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRDetOperIntracomunitariasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRDetOperIntracomunitariasType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLRDetOperIntracomunitarias: Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType;
    FRegistroRespuestaConsultaLRDetOperIntracomunitarias_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRDetOperIntracomunitarias(Index: Integer; const AArray_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType: Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType);
    function  RegistroRespuestaConsultaLRDetOperIntracomunitarias_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRDetOperIntracomunitarias: Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRDetOperIntracomunitarias write SetRegistroRespuestaConsultaLRDetOperIntracomunitarias stored RegistroRespuestaConsultaLRDetOperIntracomunitarias_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRDetOperIntracomunitarias, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRDetOperIntracomunitarias = class(RespuestaConsultaLRDetOperIntracomunitariasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRBienesInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRBienesInversionType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLRBienesInversion: Array_Of_RegistroRespuestaConsultaBienesType;
    FRegistroRespuestaConsultaLRBienesInversion_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRBienesInversion(Index: Integer; const AArray_Of_RegistroRespuestaConsultaBienesType: Array_Of_RegistroRespuestaConsultaBienesType);
    function  RegistroRespuestaConsultaLRBienesInversion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRBienesInversion: Array_Of_RegistroRespuestaConsultaBienesType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRBienesInversion write SetRegistroRespuestaConsultaLRBienesInversion stored RegistroRespuestaConsultaLRBienesInversion_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRBienesInversion, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRBienesInversion = class(RespuestaConsultaLRBienesInversionType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRCobrosMetalicoType = class(RespuestaConsultaLRFacturasType)
  private
    FRegistroRespuestaConsultaLRCobrosMetalico: Array_Of_RegistroRespuestaConsultaCobrosMetalicoType;
    FRegistroRespuestaConsultaLRCobrosMetalico_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRCobrosMetalico(Index: Integer; const AArray_Of_RegistroRespuestaConsultaCobrosMetalicoType: Array_Of_RegistroRespuestaConsultaCobrosMetalicoType);
    function  RegistroRespuestaConsultaLRCobrosMetalico_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRCobrosMetalico: Array_Of_RegistroRespuestaConsultaCobrosMetalicoType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRCobrosMetalico write SetRegistroRespuestaConsultaLRCobrosMetalico stored RegistroRespuestaConsultaLRCobrosMetalico_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRCobrosMetalico, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRCobrosMetalico = class(RespuestaConsultaLRCobrosMetalicoType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasAgrupadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRFacturasAgrupadasClienteType = class(ConsultaInformacionCliente)
  private
    FResultadoConsulta: ResultadoConsultaType;
  published
    property ResultadoConsulta: ResultadoConsultaType  read FResultadoConsulta write FResultadoConsulta;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFactInformadasAgrupadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaConsultaLRFactInformadasAgrupadasClienteType = class(RespuestaConsultaLRFacturasAgrupadasClienteType)
  private
    FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente: Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType;
    FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente(Index: Integer; const AArray_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType: Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType);
    function  RegistroRespuestaConsultaLRFactInformadasAgrupadasCliente_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRFactInformadasAgrupadasCliente: Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente write SetRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente stored RegistroRespuestaConsultaLRFactInformadasAgrupadasCliente_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFactInformadasAgrupadasCliente, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaConsultaLRFactInformadasAgrupadasCliente = class(RespuestaConsultaLRFactInformadasAgrupadasClienteType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFacturasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaConsultaLRFacturasClienteType = class(ConsultaInformacionCliente)
  private
    FIndicadorPaginacion: IndicadorPaginacionType;
    FResultadoConsulta: ResultadoConsultaType;
  published
    property IndicadorPaginacion: IndicadorPaginacionType  read FIndicadorPaginacion write FIndicadorPaginacion;
    property ResultadoConsulta:   ResultadoConsultaType    read FResultadoConsulta write FResultadoConsulta;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFactInformadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaConsultaLRFactInformadasClienteType = class(RespuestaConsultaLRFacturasClienteType)
  private
    FRegistroRespuestaConsultaLRFactInformadasCliente: Array_Of_RegistroRespuestaConsultaFactInformadasClienteType;
    FRegistroRespuestaConsultaLRFactInformadasCliente_Specified: boolean;
    procedure SetRegistroRespuestaConsultaLRFactInformadasCliente(Index: Integer; const AArray_Of_RegistroRespuestaConsultaFactInformadasClienteType: Array_Of_RegistroRespuestaConsultaFactInformadasClienteType);
    function  RegistroRespuestaConsultaLRFactInformadasCliente_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RegistroRespuestaConsultaLRFactInformadasCliente: Array_Of_RegistroRespuestaConsultaFactInformadasClienteType  Index (IS_OPTN or IS_UNBD) read FRegistroRespuestaConsultaLRFactInformadasCliente write SetRegistroRespuestaConsultaLRFactInformadasCliente stored RegistroRespuestaConsultaLRFactInformadasCliente_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaConsultaLRFactInformadasCliente, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaConsultaLRFactInformadasCliente = class(RespuestaConsultaLRFactInformadasClienteType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaFactInformadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaFactInformadasClienteType = class(TRemotable)
  private
    FIDFactura: IDFacturaImputacionType;
    FPeriodoLiquidacion: PeriodoLiquidacion9;
    FDatosFacturaInformadaCliente: FacturaRespuestaInformadaClienteType;
    FCliente: PersonaFisicaJuridicaUnicaESType;
    FEstadoFactura: EstadoFacturaImputacionType;
  public
    destructor Destroy; override;
  published
    property IDFactura:                    IDFacturaImputacionType               read FIDFactura write FIDFactura;
    property PeriodoLiquidacion:           PeriodoLiquidacion9                   read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property DatosFacturaInformadaCliente: FacturaRespuestaInformadaClienteType  read FDatosFacturaInformadaCliente write FDatosFacturaInformadaCliente;
    property Cliente:                      PersonaFisicaJuridicaUnicaESType      read FCliente write FCliente;
    property EstadoFactura:                EstadoFacturaImputacionType           read FEstadoFactura write FEstadoFactura;
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRBienesInversion, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaLRBienesInversion = class(LRConsultaBienesInversionType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRDetOperIntracomunitarias, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaLRDetOperIntracomunitarias = class(LRConsultaDetOperIntracomunitariasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRFactInformadasAgrupadasCliente, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  ConsultaLRFactInformadasAgrupadasCliente = class(ConsultaLRFactInformadasAgrupadasClienteType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRFacturasEmitidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  ConsultaLRFacturasEmitidas = class(LRConsultaEmitidasType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRFactInformadasCliente, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // Info      : Wrapper
  // ************************************************************************ //
  ConsultaLRFactInformadasCliente = class(ConsultaLRFactInformadasClienteType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRCobrosMetalico, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaLRCobrosMetalico = class(LRConsultaCobrosMetalicoType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaPagos, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaPagos = class(ConsultaPagosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLROperacionesSeguros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaLROperacionesSeguros = class(LRConsultaLROperacionesSegurosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaInmueblesAdicionales, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaInmueblesAdicionales = class(ConsultaInmueblesAdicionalesType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaLRAgenciasViajes, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaLRAgenciasViajes = class(LRConsultaAgenciasViajesType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConsultaCobros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ConsultaCobros = class(ConsultaCobrosType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : LRBajaRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaRecibidasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaRecibidaNombreBCType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:  IDFacturaRecibidaNombreBCType  read FIDFactura write FIDFactura;
    property RefExterna: TextMax60Type                  Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRBienesInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBienesInversionType = class(RegistroSii)
  private
    FIDFactura: IDFacturaComunitariaType;
    FBienesInversion: BienDeInversionType;
  public
    destructor Destroy; override;
  published
    property IDFactura:       IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property BienesInversion: BienDeInversionType       read FBienesInversion write FBienesInversion;
  end;



  // ************************************************************************ //
  // XML       : LRFacturasRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRFacturasRecibidasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaRecibidaType;
    FFacturaRecibida: FacturaRecibidaType;
  public
    destructor Destroy; override;
  published
    property IDFactura:       IDFacturaRecibidaType  read FIDFactura write FIDFactura;
    property FacturaRecibida: FacturaRecibidaType    read FFacturaRecibida write FFacturaRecibida;
  end;



  // ************************************************************************ //
  // XML       : LRfacturasEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRfacturasEmitidasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaExpedidaType;
    FFacturaExpedida: FacturaExpedidaType;
  public
    destructor Destroy; override;
  published
    property IDFactura:       IDFacturaExpedidaType  read FIDFactura write FIDFactura;
    property FacturaExpedida: FacturaExpedidaType    read FFacturaExpedida write FFacturaExpedida;
  end;



  // ************************************************************************ //
  // XML       : LRBajaExpedidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaExpedidasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaExpedidaBCType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:  IDFacturaExpedidaBCType  read FIDFactura write FIDFactura;
    property RefExterna: TextMax60Type            Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRBajaBienesInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaBienesInversionType = class(RegistroSii)
  private
    FIDFactura: IDFacturaComunitariaType;
    FIdentificacionBien: TextMax40Type;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:          IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property IdentificacionBien: TextMax40Type             read FIdentificacionBien write FIdentificacionBien;
    property RefExterna:         TextMax60Type             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRBajaCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaCobrosMetalicoType = class(RegistroSii)
  private
    FContraparte: PersonaFisicaJuridicaType;
  public
    destructor Destroy; override;
  published
    property Contraparte: PersonaFisicaJuridicaType  read FContraparte write FContraparte;
  end;



  // ************************************************************************ //
  // XML       : LRCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRCobrosMetalicoType = class(RegistroSii)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FImporteTotal: ImporteSgn12_2Type;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:     PersonaFisicaJuridicaType         read FContraparte write FContraparte;
    property ImporteTotal:    ImporteSgn12_2Type                read FImporteTotal write FImporteTotal;
    property EntidadSucedida: PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRAgenciasViajesType = class(RegistroSii)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FImporteTotal: ImporteSgn12_2Type;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:     PersonaFisicaJuridicaType         read FContraparte write FContraparte;
    property ImporteTotal:    ImporteSgn12_2Type                read FImporteTotal write FImporteTotal;
    property EntidadSucedida: PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRBajaAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaAgenciasViajesType = class(RegistroSii)
  private
    FContraparte: PersonaFisicaJuridicaType;
  public
    destructor Destroy; override;
  published
    property Contraparte: PersonaFisicaJuridicaType  read FContraparte write FContraparte;
  end;

  Tipo10Type      =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : RegistroRespuestaConsultaFactInformadasAgrupadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RegistroRespuestaConsultaFactInformadasAgrupadasClienteType = class(TRemotable)
  private
    FCliente: PersonaFisicaJuridicaUnicaESType;
    FNumeroFacturas: Tipo10Type;
  public
    destructor Destroy; override;
  published
    property Cliente:        PersonaFisicaJuridicaUnicaESType  read FCliente write FCliente;
    property NumeroFacturas: Tipo10Type                        read FNumeroFacturas write FNumeroFacturas;
  end;



  // ************************************************************************ //
  // XML       : RangoFechaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  RangoFechaType = class(TRemotable)
  private
    FDesde: fecha;
    FDesde_Specified: boolean;
    FHasta: fecha;
    FHasta_Specified: boolean;
    procedure SetDesde(Index: Integer; const Afecha: fecha);
    function  Desde_Specified(Index: Integer): boolean;
    procedure SetHasta(Index: Integer; const Afecha: fecha);
    function  Hasta_Specified(Index: Integer): boolean;
  published
    property Desde: fecha  Index (IS_OPTN) read FDesde write SetDesde stored Desde_Specified;
    property Hasta: fecha  Index (IS_OPTN) read FHasta write SetHasta stored Hasta_Specified;
  end;

  ImporteSgn14_2Type =  type string;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : DatosDescuadreContraparteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  DatosDescuadreContraparteType = class(TRemotable)
  private
    FSumBaseImponibleISP: ImporteSgn14_2Type;
    FSumBaseImponibleISP_Specified: boolean;
    FSumBaseImponible: ImporteSgn14_2Type;
    FSumBaseImponible_Specified: boolean;
    FSumCuota: ImporteSgn14_2Type;
    FSumCuota_Specified: boolean;
    FSumCuotaRecargoEquivalencia: ImporteSgn14_2Type;
    FSumCuotaRecargoEquivalencia_Specified: boolean;
    FImporteTotal: ImporteSgn12_2Type;
    FImporteTotal_Specified: boolean;
    procedure SetSumBaseImponibleISP(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
    function  SumBaseImponibleISP_Specified(Index: Integer): boolean;
    procedure SetSumBaseImponible(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
    function  SumBaseImponible_Specified(Index: Integer): boolean;
    procedure SetSumCuota(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
    function  SumCuota_Specified(Index: Integer): boolean;
    procedure SetSumCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
    function  SumCuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
    procedure SetImporteTotal(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
    function  ImporteTotal_Specified(Index: Integer): boolean;
  published
    property SumBaseImponibleISP:         ImporteSgn14_2Type  Index (IS_OPTN) read FSumBaseImponibleISP write SetSumBaseImponibleISP stored SumBaseImponibleISP_Specified;
    property SumBaseImponible:            ImporteSgn14_2Type  Index (IS_OPTN) read FSumBaseImponible write SetSumBaseImponible stored SumBaseImponible_Specified;
    property SumCuota:                    ImporteSgn14_2Type  Index (IS_OPTN) read FSumCuota write SetSumCuota stored SumCuota_Specified;
    property SumCuotaRecargoEquivalencia: ImporteSgn14_2Type  Index (IS_OPTN) read FSumCuotaRecargoEquivalencia write SetSumCuotaRecargoEquivalencia stored SumCuotaRecargoEquivalencia_Specified;
    property ImporteTotal:                ImporteSgn12_2Type  Index (IS_OPTN) read FImporteTotal write SetImporteTotal stored ImporteTotal_Specified;
  end;



  // ************************************************************************ //
  // XML       : LROperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LROperacionesSegurosType = class(RegistroSii)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FClaveOperacion: ClaveOperacionType;
    FImporteTotal: ImporteSgn12_2Type;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:     PersonaFisicaJuridicaType         read FContraparte write FContraparte;
    property ClaveOperacion:  ClaveOperacionType                read FClaveOperacion write FClaveOperacion;
    property ImporteTotal:    ImporteSgn12_2Type                read FImporteTotal write FImporteTotal;
    property EntidadSucedida: PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
  end;



  // ************************************************************************ //
  // XML       : ClavePaginacion, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  ClavePaginacion3 = class(TRemotable)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FClaveOperacion: ClaveOperacionType;
  public
    destructor Destroy; override;
  published
    property Contraparte:    PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property ClaveOperacion: ClaveOperacionType         read FClaveOperacion write FClaveOperacion;
  end;



  // ************************************************************************ //
  // XML       : RespuestaOperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  RespuestaOperacionesSegurosType = class(TRemotable)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FClaveOperacion: ClaveOperacionType;
    FImporteTotal: ImporteSgn12_2Type;
    FEntidadSucedida: PersonaFisicaJuridicaUnicaESType;
    FEntidadSucedida_Specified: boolean;
    procedure SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  EntidadSucedida_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:     PersonaFisicaJuridicaType         read FContraparte write FContraparte;
    property ClaveOperacion:  ClaveOperacionType                read FClaveOperacion write FClaveOperacion;
    property ImporteTotal:    ImporteSgn12_2Type                read FImporteTotal write FImporteTotal;
    property EntidadSucedida: PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FEntidadSucedida write SetEntidadSucedida stored EntidadSucedida_Specified;
  end;

  ErrorDetalleType =  type Int64;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : RegistroDuplicadoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd
  // ************************************************************************ //
  RegistroDuplicadoType = class(TRemotable)
  private
    FEstadoRegistro: EstadoRegistroSIIType2;
    FCodigoErrorRegistro: ErrorDetalleType;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType: ErrorDetalleType);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
  published
    property EstadoRegistro:           EstadoRegistroSIIType2  read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType        Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type          Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
  end;

  ErrorDetalleType2 =  type Int64;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : RespuestaComunitariaBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaComunitariaBajaType = class(TRemotable)
  private
    FIDFactura: IDFacturaComunitariaType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property RefExterna:               TextMax60Type             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType        read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2         Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type            Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                    Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaAgenciasViajesBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaAgenciasViajesBajaType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion6;
    FContraparte: PersonaFisicaJuridicaType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion6        read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property Contraparte:              PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property EstadoRegistro:           EstadoRegistroType         read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2          Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type             Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaMetalicoBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaMetalicoBajaType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion7;
    FContraparte: PersonaFisicaJuridicaType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion7        read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property Contraparte:              PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property EstadoRegistro:           EstadoRegistroType         read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2          Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type             Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaExpedidaBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaExpedidaBajaType = class(TRemotable)
  private
    FIDFactura: IDFacturaExpedidaType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaExpedidaType  read FIDFactura write FIDFactura;
    property RefExterna:               TextMax60Type          Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType     read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2      Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type         Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                 Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaBienBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaBienBajaType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion5;
    FIDFactura: IDFacturaComunitariaType;
    FIdentificacionBien: TextMax40Type;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion5       read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property IDFactura:                IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property IdentificacionBien:       TextMax40Type             read FIdentificacionBien write FIdentificacionBien;
    property RefExterna:               TextMax60Type             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType        read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2         Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type            Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                    Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaRecibidaBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaRecibidaBajaType = class(TRemotable)
  private
    FIDFactura: IDFacturaRecibidaNombreBCType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaRecibidaNombreBCType  read FIDFactura write FIDFactura;
    property RefExterna:               TextMax60Type                  Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType             read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2              Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type                 Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                         Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaOperacionesSegurosBajaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaOperacionesSegurosBajaType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion;
    FContraparte: PersonaFisicaJuridicaType;
    FClaveOperacion: ClaveOperacionType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion         read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property Contraparte:              PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property ClaveOperacion:           ClaveOperacionType         read FClaveOperacion write FClaveOperacion;
    property EstadoRegistro:           EstadoRegistroType         read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2          Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type             Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
  end;

  ErrorDetalleType3 =  type Int64;      { "https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd"[GblSmpl] }


  // ************************************************************************ //
  // XML       : EstadoFactura2Type, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  EstadoFactura2Type = class(TRemotable)
  private
    FTimestampUltimaModificacion: Timestamp;
    FEstadoRegistro: EstadoRegistroSIIType;
    FCodigoErrorRegistro: ErrorDetalleType3;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType3: ErrorDetalleType3);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
  published
    property TimestampUltimaModificacion: Timestamp              read FTimestampUltimaModificacion write FTimestampUltimaModificacion;
    property EstadoRegistro:              EstadoRegistroSIIType  read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:         ErrorDetalleType3      Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro:    TextMax500Type         Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaAgenciasViajesType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion3;
    FContraparte: PersonaFisicaJuridicaType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion3        read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property Contraparte:              PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property EstadoRegistro:           EstadoRegistroType         read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2          Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type             Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType      Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaMetalicoType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion4;
    FContraparte: PersonaFisicaJuridicaType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion4        read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property Contraparte:              PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property EstadoRegistro:           EstadoRegistroType         read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2          Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type             Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType      Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaOperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaOperacionesSegurosType2 = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion2;
    FContraparte: PersonaFisicaJuridicaType;
    FClaveOperacion: ClaveOperacionType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion2        read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property Contraparte:              PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property ClaveOperacion:           ClaveOperacionType         read FClaveOperacion write FClaveOperacion;
    property EstadoRegistro:           EstadoRegistroType         read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2          Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type             Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                     Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType      Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaExpedidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaExpedidaType = class(TRemotable)
  private
    FIDFactura: IDFacturaExpedidaType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaExpedidaType  read FIDFactura write FIDFactura;
    property RefExterna:               TextMax60Type          Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType     read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2      Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type         Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                 Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType  Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaRecibidaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaRecibidaType = class(TRemotable)
  private
    FIDFactura: IDFacturaRecibidaType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaRecibidaType  read FIDFactura write FIDFactura;
    property RefExterna:               TextMax60Type          Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType     read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2      Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type         Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                 Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType  Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaBienType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaBienType = class(TRemotable)
  private
    FPeriodoLiquidacion: PeriodoLiquidacion8;
    FIDFactura: IDFacturaComunitariaType;
    FIdentificacionBien: TextMax40Type;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PeriodoLiquidacion:       PeriodoLiquidacion8       read FPeriodoLiquidacion write FPeriodoLiquidacion;
    property IDFactura:                IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property IdentificacionBien:       TextMax40Type             read FIdentificacionBien write FIdentificacionBien;
    property RefExterna:               TextMax60Type             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType        read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2         Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type            Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                    Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType     Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaComunitariaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaComunitariaType = class(TRemotable)
  private
    FIDFactura: IDFacturaComunitariaType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    FCSV: string;
    FCSV_Specified: boolean;
    FRegistroDuplicado: RegistroDuplicadoType;
    FRegistroDuplicado_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetCSV(Index: Integer; const Astring: string);
    function  CSV_Specified(Index: Integer): boolean;
    procedure SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
    function  RegistroDuplicado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property RefExterna:               TextMax60Type             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
    property EstadoRegistro:           EstadoRegistroType        read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2         Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type            Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
    property CSV:                      string                    Index (IS_OPTN) read FCSV write SetCSV stored CSV_Specified;
    property RegistroDuplicado:        RegistroDuplicadoType     Index (IS_OPTN) read FRegistroDuplicado write SetRegistroDuplicado stored RegistroDuplicado_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaRecibidaPagoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd
  // ************************************************************************ //
  RespuestaRecibidaPagoType = class(TRemotable)
  private
    FIDFactura: IDFacturaRecibidaNombreBCType;
    FEstadoRegistro: EstadoRegistroType;
    FCodigoErrorRegistro: ErrorDetalleType2;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:                IDFacturaRecibidaNombreBCType  read FIDFactura write FIDFactura;
    property EstadoRegistro:           EstadoRegistroType             read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:      ErrorDetalleType2              Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro: TextMax500Type                 Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroAgenciasViajesType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroAgenciasViajesType = class(RegistroSii)
  private
    FContraparte: ContraparteConsultaType;
    FContraparte_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FRegistroModificado: FacturaModificadaType;
    FRegistroModificado_Specified: boolean;
    FClavePaginacion: ClavePaginacion2;
    FClavePaginacion_Specified: boolean;
    procedure SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
    function  Contraparte_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetRegistroModificado(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  RegistroModificado_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AClavePaginacion2: ClavePaginacion2);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:        ContraparteConsultaType     Index (IS_OPTN) read FContraparte write SetContraparte stored Contraparte_Specified;
    property FechaPresentacion:  RangoFechaPresentacionType  Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property RegistroModificado: FacturaModificadaType       Index (IS_OPTN) read FRegistroModificado write SetRegistroModificado stored RegistroModificado_Specified;
    property ClavePaginacion:    ClavePaginacion2            Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroDetOperIntracomunitariasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroDetOperIntracomunitariasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaConsulta1Type;
    FIDFactura_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FFacturaModificada: FacturaModificadaType;
    FFacturaModificada_Specified: boolean;
    FClavePaginacion: IDFacturaComunitariaType;
    FClavePaginacion_Specified: boolean;
    procedure SetIDFactura(Index: Integer; const AIDFacturaConsulta1Type: IDFacturaConsulta1Type);
    function  IDFactura_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  FacturaModificada_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AIDFacturaComunitariaType: IDFacturaComunitariaType);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:         IDFacturaConsulta1Type      Index (IS_OPTN) read FIDFactura write SetIDFactura stored IDFactura_Specified;
    property FechaPresentacion: RangoFechaPresentacionType  Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property FacturaModificada: FacturaModificadaType       Index (IS_OPTN) read FFacturaModificada write SetFacturaModificada stored FacturaModificada_Specified;
    property ClavePaginacion:   IDFacturaComunitariaType    Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroBienInversionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroBienInversionType = class(RegistroSii)
  private
    FIDFactura: IDFacturaConsulta1Type;
    FIDFactura_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FFacturaModificada: FacturaModificadaType;
    FFacturaModificada_Specified: boolean;
    FIdentificacionBien: TextMax40Type;
    FIdentificacionBien_Specified: boolean;
    FClavePaginacion: ClavePaginacionBienType;
    FClavePaginacion_Specified: boolean;
    procedure SetIDFactura(Index: Integer; const AIDFacturaConsulta1Type: IDFacturaConsulta1Type);
    function  IDFactura_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  FacturaModificada_Specified(Index: Integer): boolean;
    procedure SetIdentificacionBien(Index: Integer; const ATextMax40Type: TextMax40Type);
    function  IdentificacionBien_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AClavePaginacionBienType: ClavePaginacionBienType);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:          IDFacturaConsulta1Type      Index (IS_OPTN) read FIDFactura write SetIDFactura stored IDFactura_Specified;
    property FechaPresentacion:  RangoFechaPresentacionType  Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property FacturaModificada:  FacturaModificadaType       Index (IS_OPTN) read FFacturaModificada write SetFacturaModificada stored FacturaModificada_Specified;
    property IdentificacionBien: TextMax40Type               Index (IS_OPTN) read FIdentificacionBien write SetIdentificacionBien stored IdentificacionBien_Specified;
    property ClavePaginacion:    ClavePaginacionBienType     Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroOperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroOperacionesSegurosType = class(RegistroSii)
  private
    FContraparte: ContraparteConsultaType;
    FContraparte_Specified: boolean;
    FClaveOperacion: ClaveOperacionType;
    FClaveOperacion_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FOperacionModificada: FacturaModificadaType;
    FOperacionModificada_Specified: boolean;
    FClavePaginacion: ClavePaginacion3;
    FClavePaginacion_Specified: boolean;
    procedure SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
    function  Contraparte_Specified(Index: Integer): boolean;
    procedure SetClaveOperacion(Index: Integer; const AClaveOperacionType: ClaveOperacionType);
    function  ClaveOperacion_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetOperacionModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  OperacionModificada_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AClavePaginacion3: ClavePaginacion3);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:         ContraparteConsultaType     Index (IS_OPTN) read FContraparte write SetContraparte stored Contraparte_Specified;
    property ClaveOperacion:      ClaveOperacionType          Index (IS_OPTN) read FClaveOperacion write SetClaveOperacion stored ClaveOperacion_Specified;
    property FechaPresentacion:   RangoFechaPresentacionType  Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property OperacionModificada: FacturaModificadaType       Index (IS_OPTN) read FOperacionModificada write SetOperacionModificada stored OperacionModificada_Specified;
    property ClavePaginacion:     ClavePaginacion3            Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroCobrosMetalicoType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroCobrosMetalicoType = class(RegistroSii)
  private
    FContraparte: ContraparteConsultaType;
    FContraparte_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FCobroModificado: FacturaModificadaType;
    FCobroModificado_Specified: boolean;
    FClavePaginacion: ClavePaginacion;
    FClavePaginacion_Specified: boolean;
    procedure SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
    function  Contraparte_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetCobroModificado(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  CobroModificado_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AClavePaginacion: ClavePaginacion);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Contraparte:       ContraparteConsultaType     Index (IS_OPTN) read FContraparte write SetContraparte stored Contraparte_Specified;
    property FechaPresentacion: RangoFechaPresentacionType  Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property CobroModificado:   FacturaModificadaType       Index (IS_OPTN) read FCobroModificado write SetCobroModificado stored CobroModificado_Specified;
    property ClavePaginacion:   ClavePaginacion             Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : EstadoFacturaImputacionType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  EstadoFacturaImputacionType = class(TRemotable)
  private
    FEstadoCuadre: EstadoCuadreType;
    FEstadoCuadre_Specified: boolean;
    FTimestampEstadoCuadre: Timestamp;
    FTimestampEstadoCuadre_Specified: boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetTimestampEstadoCuadre(Index: Integer; const ATimestamp: Timestamp);
    function  TimestampEstadoCuadre_Specified(Index: Integer): boolean;
  published
    property EstadoCuadre:          EstadoCuadreType  Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
    property TimestampEstadoCuadre: Timestamp         Index (IS_OPTN) read FTimestampEstadoCuadre write SetTimestampEstadoCuadre stored TimestampEstadoCuadre_Specified;
  end;



  // ************************************************************************ //
  // XML       : EstadoFacturaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd
  // ************************************************************************ //
  EstadoFacturaType = class(TRemotable)
  private
    FEstadoCuadre: EstadoCuadreType;
    FEstadoCuadre_Specified: boolean;
    FTimestampEstadoCuadre: Timestamp;
    FTimestampEstadoCuadre_Specified: boolean;
    FTimestampUltimaModificacion: Timestamp;
    FEstadoRegistro: EstadoRegistroSIIType;
    FCodigoErrorRegistro: ErrorDetalleType3;
    FCodigoErrorRegistro_Specified: boolean;
    FDescripcionErrorRegistro: TextMax500Type;
    FDescripcionErrorRegistro_Specified: boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetTimestampEstadoCuadre(Index: Integer; const ATimestamp: Timestamp);
    function  TimestampEstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType3: ErrorDetalleType3);
    function  CodigoErrorRegistro_Specified(Index: Integer): boolean;
    procedure SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
    function  DescripcionErrorRegistro_Specified(Index: Integer): boolean;
  published
    property EstadoCuadre:                EstadoCuadreType       Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
    property TimestampEstadoCuadre:       Timestamp              Index (IS_OPTN) read FTimestampEstadoCuadre write SetTimestampEstadoCuadre stored TimestampEstadoCuadre_Specified;
    property TimestampUltimaModificacion: Timestamp              read FTimestampUltimaModificacion write FTimestampUltimaModificacion;
    property EstadoRegistro:              EstadoRegistroSIIType  read FEstadoRegistro write FEstadoRegistro;
    property CodigoErrorRegistro:         ErrorDetalleType3      Index (IS_OPTN) read FCodigoErrorRegistro write SetCodigoErrorRegistro stored CodigoErrorRegistro_Specified;
    property DescripcionErrorRegistro:    TextMax500Type         Index (IS_OPTN) read FDescripcionErrorRegistro write SetDescripcionErrorRegistro stored DescripcionErrorRegistro_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRBajaRegistroLROperacionesSegurosType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaRegistroLROperacionesSegurosType = class(RegistroSii)
  private
    FContraparte: PersonaFisicaJuridicaType;
    FClaveOperacion: ClaveOperacionType;
  public
    destructor Destroy; override;
  published
    property Contraparte:    PersonaFisicaJuridicaType  read FContraparte write FContraparte;
    property ClaveOperacion: ClaveOperacionType         read FClaveOperacion write FClaveOperacion;
  end;



  // ************************************************************************ //
  // XML       : SuministroLRDetOperacionIntracomunitaria, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  SuministroLRDetOperacionIntracomunitaria = class(SuministroInformacion)
  private
    FRegistroLRDetOperacionIntracomunitaria: Array_Of_LROperacionIntracomunitariaType;
  public
    destructor Destroy; override;
  published
    property RegistroLRDetOperacionIntracomunitaria: Array_Of_LROperacionIntracomunitariaType  Index (IS_UNBD) read FRegistroLRDetOperacionIntracomunitaria write FRegistroLRDetOperacionIntracomunitaria;
  end;



  // ************************************************************************ //
  // XML       : BajaLRDetOperacionIntracomunitaria, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  BajaLRDetOperacionIntracomunitaria = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaDetOperacionIntracomunitaria: Array_Of_LRBajaOperacionIntracomunitariaType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBajaDetOperacionIntracomunitaria: Array_Of_LRBajaOperacionIntracomunitariaType  Index (IS_UNBD) read FRegistroLRBajaDetOperacionIntracomunitaria write FRegistroLRBajaDetOperacionIntracomunitaria;
  end;



  // ************************************************************************ //
  // XML       : BajaLROperacionesSeguros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  BajaLROperacionesSeguros = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaOperacionesSeguros: Array_Of_LRBajaRegistroLROperacionesSegurosType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBajaOperacionesSeguros: Array_Of_LRBajaRegistroLROperacionesSegurosType  Index (IS_UNBD) read FRegistroLRBajaOperacionesSeguros write FRegistroLRBajaOperacionesSeguros;
  end;



  // ************************************************************************ //
  // XML       : BajaLRCobrosMetalico, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  BajaLRCobrosMetalico = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaCobrosMetalico: Array_Of_LRBajaCobrosMetalicoType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBajaCobrosMetalico: Array_Of_LRBajaCobrosMetalicoType  Index (IS_UNBD) read FRegistroLRBajaCobrosMetalico write FRegistroLRBajaCobrosMetalico;
  end;



  // ************************************************************************ //
  // XML       : SuministroLROperacionesSeguros, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  SuministroLROperacionesSeguros = class(SuministroInformacion)
  private
    FRegistroLROperacionesSeguros: Array_Of_LROperacionesSegurosType;
  public
    destructor Destroy; override;
  published
    property RegistroLROperacionesSeguros: Array_Of_LROperacionesSegurosType  Index (IS_UNBD) read FRegistroLROperacionesSeguros write FRegistroLROperacionesSeguros;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroEmitidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroEmitidasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaConsulta2Type;
    FIDFactura_Specified: boolean;
    FContraparte: ContraparteConsultaType;
    FContraparte_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FFechaCuadre: RangoFechaPresentacionType;
    FFechaCuadre_Specified: boolean;
    FFacturaModificada: FacturaModificadaType;
    FFacturaModificada_Specified: boolean;
    FEstadoCuadre: EstadoCuadreType;
    FEstadoCuadre_Specified: boolean;
    FClavePaginacion: IDFacturaExpedidaBCType;
    FClavePaginacion_Specified: boolean;
    procedure SetIDFactura(Index: Integer; const AIDFacturaConsulta2Type: IDFacturaConsulta2Type);
    function  IDFactura_Specified(Index: Integer): boolean;
    procedure SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
    function  Contraparte_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetFechaCuadre(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaCuadre_Specified(Index: Integer): boolean;
    procedure SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  FacturaModificada_Specified(Index: Integer): boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AIDFacturaExpedidaBCType: IDFacturaExpedidaBCType);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:         IDFacturaConsulta2Type      Index (IS_OPTN) read FIDFactura write SetIDFactura stored IDFactura_Specified;
    property Contraparte:       ContraparteConsultaType     Index (IS_OPTN) read FContraparte write SetContraparte stored Contraparte_Specified;
    property FechaPresentacion: RangoFechaPresentacionType  Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property FechaCuadre:       RangoFechaPresentacionType  Index (IS_OPTN) read FFechaCuadre write SetFechaCuadre stored FechaCuadre_Specified;
    property FacturaModificada: FacturaModificadaType       Index (IS_OPTN) read FFacturaModificada write SetFacturaModificada stored FacturaModificada_Specified;
    property EstadoCuadre:      EstadoCuadreType            Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
    property ClavePaginacion:   IDFacturaExpedidaBCType     Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroFactInformadasAgrupadasProveedorType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroFactInformadasAgrupadasProveedorType = class(RegistroSiiImputacion)
  private
    FProveedor: PersonaFisicaJuridicaUnicaESType;
    FProveedor_Specified: boolean;
    FEstadoCuadre: EstadoCuadreImputacionType;
    FEstadoCuadre_Specified: boolean;
    procedure SetProveedor(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  Proveedor_Specified(Index: Integer): boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Proveedor:    PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FProveedor write SetProveedor stored Proveedor_Specified;
    property EstadoCuadre: EstadoCuadreImputacionType        Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroRecibidasType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroRecibidasType = class(RegistroSii)
  private
    FIDFactura: IDFacturaConsulta1Type;
    FIDFactura_Specified: boolean;
    FFechaPresentacion: RangoFechaPresentacionType;
    FFechaPresentacion_Specified: boolean;
    FFechaCuadre: RangoFechaPresentacionType;
    FFechaCuadre_Specified: boolean;
    FFacturaModificada: FacturaModificadaType;
    FFacturaModificada_Specified: boolean;
    FEstadoCuadre: EstadoCuadreType;
    FEstadoCuadre_Specified: boolean;
    FClavePaginacion: IDFacturaRecibidaNombreBCType;
    FClavePaginacion_Specified: boolean;
    procedure SetIDFactura(Index: Integer; const AIDFacturaConsulta1Type: IDFacturaConsulta1Type);
    function  IDFactura_Specified(Index: Integer): boolean;
    procedure SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaPresentacion_Specified(Index: Integer): boolean;
    procedure SetFechaCuadre(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
    function  FechaCuadre_Specified(Index: Integer): boolean;
    procedure SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
    function  FacturaModificada_Specified(Index: Integer): boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AIDFacturaRecibidaNombreBCType: IDFacturaRecibidaNombreBCType);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:         IDFacturaConsulta1Type         Index (IS_OPTN) read FIDFactura write SetIDFactura stored IDFactura_Specified;
    property FechaPresentacion: RangoFechaPresentacionType     Index (IS_OPTN) read FFechaPresentacion write SetFechaPresentacion stored FechaPresentacion_Specified;
    property FechaCuadre:       RangoFechaPresentacionType     Index (IS_OPTN) read FFechaCuadre write SetFechaCuadre stored FechaCuadre_Specified;
    property FacturaModificada: FacturaModificadaType          Index (IS_OPTN) read FFacturaModificada write SetFacturaModificada stored FacturaModificada_Specified;
    property EstadoCuadre:      EstadoCuadreType               Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
    property ClavePaginacion:   IDFacturaRecibidaNombreBCType  Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroFactInformadasProveedorType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroFactInformadasProveedorType = class(RegistroSiiImputacion)
  private
    FProveedor: PersonaFisicaJuridicaUnicaESType;
    FProveedor_Specified: boolean;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisor_Specified: boolean;
    FEstadoCuadre: EstadoCuadreImputacionType;
    FEstadoCuadre_Specified: boolean;
    FFechaExpedicion: RangoFechaType;
    FFechaExpedicion_Specified: boolean;
    FFechaOperacion: RangoFechaType;
    FFechaOperacion_Specified: boolean;
    FClavePaginacion: ClavePaginacionProveedorType;
    FClavePaginacion_Specified: boolean;
    procedure SetProveedor(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  Proveedor_Specified(Index: Integer): boolean;
    procedure SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetFechaExpedicion(Index: Integer; const ARangoFechaType: RangoFechaType);
    function  FechaExpedicion_Specified(Index: Integer): boolean;
    procedure SetFechaOperacion(Index: Integer; const ARangoFechaType: RangoFechaType);
    function  FechaOperacion_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AClavePaginacionProveedorType: ClavePaginacionProveedorType);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Proveedor:             PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FProveedor write SetProveedor stored Proveedor_Specified;
    property NumSerieFacturaEmisor: TextoIDFacturaType                Index (IS_OPTN) read FNumSerieFacturaEmisor write SetNumSerieFacturaEmisor stored NumSerieFacturaEmisor_Specified;
    property EstadoCuadre:          EstadoCuadreImputacionType        Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
    property FechaExpedicion:       RangoFechaType                    Index (IS_OPTN) read FFechaExpedicion write SetFechaExpedicion stored FechaExpedicion_Specified;
    property FechaOperacion:        RangoFechaType                    Index (IS_OPTN) read FFechaOperacion write SetFechaOperacion stored FechaOperacion_Specified;
    property ClavePaginacion:       ClavePaginacionProveedorType      Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroFactInformadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroFactInformadasClienteType = class(RegistroSiiImputacion)
  private
    FCliente: PersonaFisicaJuridicaUnicaESType;
    FCliente_Specified: boolean;
    FNumSerieFacturaEmisor: TextoIDFacturaType;
    FNumSerieFacturaEmisor_Specified: boolean;
    FEstadoCuadre: EstadoCuadreImputacionType;
    FEstadoCuadre_Specified: boolean;
    FFechaExpedicion: RangoFechaType;
    FFechaExpedicion_Specified: boolean;
    FFechaOperacion: RangoFechaType;
    FFechaOperacion_Specified: boolean;
    FClavePaginacion: ClavePaginacionClienteType;
    FClavePaginacion_Specified: boolean;
    procedure SetCliente(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  Cliente_Specified(Index: Integer): boolean;
    procedure SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
    function  NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
    procedure SetFechaExpedicion(Index: Integer; const ARangoFechaType: RangoFechaType);
    function  FechaExpedicion_Specified(Index: Integer): boolean;
    procedure SetFechaOperacion(Index: Integer; const ARangoFechaType: RangoFechaType);
    function  FechaOperacion_Specified(Index: Integer): boolean;
    procedure SetClavePaginacion(Index: Integer; const AClavePaginacionClienteType: ClavePaginacionClienteType);
    function  ClavePaginacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Cliente:               PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FCliente write SetCliente stored Cliente_Specified;
    property NumSerieFacturaEmisor: TextoIDFacturaType                Index (IS_OPTN) read FNumSerieFacturaEmisor write SetNumSerieFacturaEmisor stored NumSerieFacturaEmisor_Specified;
    property EstadoCuadre:          EstadoCuadreImputacionType        Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
    property FechaExpedicion:       RangoFechaType                    Index (IS_OPTN) read FFechaExpedicion write SetFechaExpedicion stored FechaExpedicion_Specified;
    property FechaOperacion:        RangoFechaType                    Index (IS_OPTN) read FFechaOperacion write SetFechaOperacion stored FechaOperacion_Specified;
    property ClavePaginacion:       ClavePaginacionClienteType        Index (IS_OPTN) read FClavePaginacion write SetClavePaginacion stored ClavePaginacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : LRFiltroFactInformadasAgrupadasClienteType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd
  // ************************************************************************ //
  LRFiltroFactInformadasAgrupadasClienteType = class(RegistroSiiImputacion)
  private
    FCliente: PersonaFisicaJuridicaUnicaESType;
    FCliente_Specified: boolean;
    FEstadoCuadre: EstadoCuadreImputacionType;
    FEstadoCuadre_Specified: boolean;
    procedure SetCliente(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
    function  Cliente_Specified(Index: Integer): boolean;
    procedure SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
    function  EstadoCuadre_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Cliente:      PersonaFisicaJuridicaUnicaESType  Index (IS_OPTN) read FCliente write SetCliente stored Cliente_Specified;
    property EstadoCuadre: EstadoCuadreImputacionType        Index (IS_OPTN) read FEstadoCuadre write SetEstadoCuadre stored EstadoCuadre_Specified;
  end;



  // ************************************************************************ //
  // XML       : BajaLRFacturasEmitidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  BajaLRFacturasEmitidas = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaExpedidas: Array_Of_LRBajaExpedidasType;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RegistroLRBajaExpedidas: Array_Of_LRBajaExpedidasType  Index (IS_UNBD) read FRegistroLRBajaExpedidas write FRegistroLRBajaExpedidas;
  end;



  // ************************************************************************ //
  // XML       : SuministroLRFacturasRecibidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  SuministroLRFacturasRecibidas = class(SuministroInformacion)
  private
    FRegistroLRFacturasRecibidas: Array_Of_LRFacturasRecibidasType;
  public
    destructor Destroy; override;
  published
    property RegistroLRFacturasRecibidas: Array_Of_LRFacturasRecibidasType  Index (IS_UNBD) read FRegistroLRFacturasRecibidas write FRegistroLRFacturasRecibidas;
  end;



  // ************************************************************************ //
  // XML       : SuministroLRFacturasEmitidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SuministroLRFacturasEmitidas = class(SuministroInformacion)
  private
    FRegistroLRFacturasEmitidas: Array_Of_LRfacturasEmitidasType;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property RegistroLRFacturasEmitidas: Array_Of_LRfacturasEmitidasType  Index (IS_UNBD) read FRegistroLRFacturasEmitidas write FRegistroLRFacturasEmitidas;
  end;



  // ************************************************************************ //
  // XML       : LROperacionIntracomunitariaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LROperacionIntracomunitariaType = class(RegistroSii)
  private
    FIDFactura: IDFacturaComunitariaType;
    FContraparte: PersonaFisicaJuridicaType;
    FOperacionIntracomunitaria: OperacionIntracomunitariaType;
  public
    destructor Destroy; override;
  published
    property IDFactura:                 IDFacturaComunitariaType       read FIDFactura write FIDFactura;
    property Contraparte:               PersonaFisicaJuridicaType      read FContraparte write FContraparte;
    property OperacionIntracomunitaria: OperacionIntracomunitariaType  read FOperacionIntracomunitaria write FOperacionIntracomunitaria;
  end;



  // ************************************************************************ //
  // XML       : LRBajaOperacionIntracomunitariaType, global, <complexType>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  LRBajaOperacionIntracomunitariaType = class(RegistroSii)
  private
    FIDFactura: IDFacturaComunitariaType;
    FRefExterna: TextMax60Type;
    FRefExterna_Specified: boolean;
    procedure SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
    function  RefExterna_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property IDFactura:  IDFacturaComunitariaType  read FIDFactura write FIDFactura;
    property RefExterna: TextMax60Type             Index (IS_OPTN) read FRefExterna write SetRefExterna stored RefExterna_Specified;
  end;



  // ************************************************************************ //
  // XML       : BajaLRFacturasRecibidas, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  BajaLRFacturasRecibidas = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaRecibidas: Array_Of_LRBajaRecibidasType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBajaRecibidas: Array_Of_LRBajaRecibidasType  Index (IS_UNBD) read FRegistroLRBajaRecibidas write FRegistroLRBajaRecibidas;
  end;



  // ************************************************************************ //
  // XML       : BajaLRAgenciasViajes, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  BajaLRAgenciasViajes = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaAgenciasViajes: Array_Of_LRBajaAgenciasViajesType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBajaAgenciasViajes: Array_Of_LRBajaAgenciasViajesType  Index (IS_UNBD) read FRegistroLRBajaAgenciasViajes write FRegistroLRBajaAgenciasViajes;
  end;



  // ************************************************************************ //
  // XML       : SuministroLRCobrosMetalico, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  SuministroLRCobrosMetalico = class(SuministroInformacion)
  private
    FRegistroLRCobrosMetalico: Array_Of_LRCobrosMetalicoType;
  public
    destructor Destroy; override;
  published
    property RegistroLRCobrosMetalico: Array_Of_LRCobrosMetalicoType  Index (IS_UNBD) read FRegistroLRCobrosMetalico write FRegistroLRCobrosMetalico;
  end;



  // ************************************************************************ //
  // XML       : SuministroLRAgenciasViajes, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  SuministroLRAgenciasViajes = class(SuministroInformacion)
  private
    FRegistroLRAgenciasViajes: Array_Of_LRAgenciasViajesType;
  public
    destructor Destroy; override;
  published
    property RegistroLRAgenciasViajes: Array_Of_LRAgenciasViajesType  Index (IS_UNBD) read FRegistroLRAgenciasViajes write FRegistroLRAgenciasViajes;
  end;



  // ************************************************************************ //
  // XML       : SuministroLRBienesInversion, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  SuministroLRBienesInversion = class(SuministroInformacion)
  private
    FRegistroLRBienesInversion: Array_Of_LRBienesInversionType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBienesInversion: Array_Of_LRBienesInversionType  Index (IS_UNBD) read FRegistroLRBienesInversion write FRegistroLRBienesInversion;
  end;



  // ************************************************************************ //
  // XML       : BajaLRBienesInversion, global, <element>
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd
  // ************************************************************************ //
  BajaLRBienesInversion = class(SuministroInformacionBaja)
  private
    FRegistroLRBajaBienesInversion: Array_Of_LRBajaBienesInversionType;
  public
    destructor Destroy; override;
  published
    property RegistroLRBajaBienesInversion: Array_Of_LRBajaBienesInversionType  Index (IS_UNBD) read FRegistroLRBajaBienesInversion write FRegistroLRBajaBienesInversion;
  end;


  // ************************************************************************ //
  // Namespace : https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroFactEmitidas.wsdl
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : siiBinding
  // service   : siiService
  // port      : SuministroFactEmitidas
  // URL       : https://www1.agenciatributaria.gob.es/wlpl/SSII-FACT/ws/fe/SiiFactFEV1SOAP
  // ************************************************************************ //
  siiSOAP = interface(IInvokable)
  ['{1E877A56-F627-1434-7788-1955A279ED58}']
    function  SuministroLRFacturasEmitidas(const SuministroLRFacturasEmitidas: SuministroLRFacturasEmitidas): RespuestaLRFacturasEmitidas; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  AnulacionLRFacturasEmitidas(const AnulacionLRFacturasEmitidas: BajaLRFacturasEmitidas): RespuestaLRBajaFacturasEmitidas; stdcall;
    function  ConsultaLRFacturasEmitidas(const ConsultaLRFacturasEmitidas: ConsultaLRFacturasEmitidas): RespuestaConsultaLRFacturasEmitidas; stdcall;
    function  ConsultaLRFactInformadasCliente(const ConsultaLRFactInformadasCliente: ConsultaLRFactInformadasCliente): RespuestaConsultaLRFactInformadasCliente; stdcall;
    function  ConsultaLRFactInformadasAgrupadasCliente(const ConsultaLRFactInformadasAgrupadasCliente: ConsultaLRFactInformadasAgrupadasCliente): RespuestaConsultaLRFactInformadasAgrupadasCliente; stdcall;
  end;

function GetsiiSOAP(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): siiSOAP;


implementation
  uses System.SysUtils;

function GetsiiSOAP(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): siiSOAP;
const
  defWSDL = 'F:\Desktop\Source\Documentacion\SII\01.07.2018\SuministroFactEmitidas.wsdl';
  defURL  = 'https://www1.agenciatributaria.gob.es/wlpl/SSII-FACT/ws/fe/SiiFactFEV1SOAP';
  defSvc  = 'siiService';
  defPrt  = 'SuministroFactEmitidas';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as siiSOAP);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor RegistroRespuestaConsultaInmueblesAdicionalesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosInmueblesAdicionales);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaCobrosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosCobro);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaPagosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosPago);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaDetOperIntracomunitariasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FDatosDetOperIntracomunitarias);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoFactura);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaCobrosMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosCobroMetalico);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoCobroMetalico);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaBienesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FDatosBienInversion);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoFactura);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaOperacionesSegurosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosOperacionesSeguros);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoOperacionesSeguros);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaAgenciasViajesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosAgenciasViajes);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoAgenciasViajes);
  inherited Destroy;
end;

destructor TipoDesglose.Destroy;
begin
  System.SysUtils.FreeAndNil(FDesgloseFactura);
  System.SysUtils.FreeAndNil(FDesgloseTipoOperacion);
  inherited Destroy;
end;

procedure TipoDesglose.SetDesgloseFactura(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
begin
  FDesgloseFactura := ATipoSinDesgloseType;
  FDesgloseFactura_Specified := True;
end;

function TipoDesglose.DesgloseFactura_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseFactura_Specified;
end;

procedure TipoDesglose.SetDesgloseTipoOperacion(Index: Integer; const ATipoConDesgloseType: TipoConDesgloseType);
begin
  FDesgloseTipoOperacion := ATipoConDesgloseType;
  FDesgloseTipoOperacion_Specified := True;
end;

function TipoDesglose.DesgloseTipoOperacion_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseTipoOperacion_Specified;
end;

destructor TipoDesglose2.Destroy;
begin
  System.SysUtils.FreeAndNil(FDesgloseFactura);
  System.SysUtils.FreeAndNil(FDesgloseTipoOperacion);
  inherited Destroy;
end;

procedure TipoDesglose2.SetDesgloseFactura(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
begin
  FDesgloseFactura := ATipoSinDesgloseType;
  FDesgloseFactura_Specified := True;
end;

function TipoDesglose2.DesgloseFactura_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseFactura_Specified;
end;

procedure TipoDesglose2.SetDesgloseTipoOperacion(Index: Integer; const ATipoConDesgloseType: TipoConDesgloseType);
begin
  FDesgloseTipoOperacion := ATipoConDesgloseType;
  FDesgloseTipoOperacion_Specified := True;
end;

function TipoDesglose2.DesgloseTipoOperacion_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseTipoOperacion_Specified;
end;

destructor RespuestaDetOperIntracomunitariaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FDetOperIntracomunitarias);
  inherited Destroy;
end;

destructor TipoDesglose3.Destroy;
begin
  System.SysUtils.FreeAndNil(FDesgloseFactura);
  System.SysUtils.FreeAndNil(FDesgloseTipoOperacion);
  inherited Destroy;
end;

procedure TipoDesglose3.SetDesgloseFactura(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
begin
  FDesgloseFactura := ATipoSinDesgloseType;
  FDesgloseFactura_Specified := True;
end;

function TipoDesglose3.DesgloseFactura_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseFactura_Specified;
end;

procedure TipoDesglose3.SetDesgloseTipoOperacion(Index: Integer; const ATipoConDesgloseType: TipoConDesgloseType);
begin
  FDesgloseTipoOperacion := ATipoConDesgloseType;
  FDesgloseTipoOperacion_Specified := True;
end;

function TipoDesglose3.DesgloseTipoOperacion_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseTipoOperacion_Specified;
end;

destructor TipoSinDesgloseType.Destroy;
begin
  System.SysUtils.FreeAndNil(FSujeta);
  System.SysUtils.FreeAndNil(FNoSujeta);
  inherited Destroy;
end;

procedure TipoSinDesgloseType.SetSujeta(Index: Integer; const ASujetaType: SujetaType);
begin
  FSujeta := ASujetaType;
  FSujeta_Specified := True;
end;

function TipoSinDesgloseType.Sujeta_Specified(Index: Integer): boolean;
begin
  Result := FSujeta_Specified;
end;

procedure TipoSinDesgloseType.SetNoSujeta(Index: Integer; const ANoSujetaType: NoSujetaType);
begin
  FNoSujeta := ANoSujetaType;
  FNoSujeta_Specified := True;
end;

function TipoSinDesgloseType.NoSujeta_Specified(Index: Integer): boolean;
begin
  Result := FNoSujeta_Specified;
end;

destructor TipoConDesgloseType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPrestacionServicios);
  System.SysUtils.FreeAndNil(FEntrega);
  inherited Destroy;
end;

procedure TipoConDesgloseType.SetPrestacionServicios(Index: Integer; const ATipoSinDesglosePrestacionType: TipoSinDesglosePrestacionType);
begin
  FPrestacionServicios := ATipoSinDesglosePrestacionType;
  FPrestacionServicios_Specified := True;
end;

function TipoConDesgloseType.PrestacionServicios_Specified(Index: Integer): boolean;
begin
  Result := FPrestacionServicios_Specified;
end;

procedure TipoConDesgloseType.SetEntrega(Index: Integer; const ATipoSinDesgloseType: TipoSinDesgloseType);
begin
  FEntrega := ATipoSinDesgloseType;
  FEntrega_Specified := True;
end;

function TipoConDesgloseType.Entrega_Specified(Index: Integer): boolean;
begin
  Result := FEntrega_Specified;
end;

destructor DesgloseFacturaRecibidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FInversionSujetoPasivo)-1 do
    System.SysUtils.FreeAndNil(FInversionSujetoPasivo[I]);
  System.SetLength(FInversionSujetoPasivo, 0);
  for I := 0 to System.Length(FDesgloseIVA)-1 do
    System.SysUtils.FreeAndNil(FDesgloseIVA[I]);
  System.SetLength(FDesgloseIVA, 0);
  inherited Destroy;
end;

procedure DesgloseFacturaRecibidasType.SetInversionSujetoPasivo(Index: Integer; const AInversionSujetoPasivo: InversionSujetoPasivo);
begin
  FInversionSujetoPasivo := AInversionSujetoPasivo;
  FInversionSujetoPasivo_Specified := True;
end;

function DesgloseFacturaRecibidasType.InversionSujetoPasivo_Specified(Index: Integer): boolean;
begin
  Result := FInversionSujetoPasivo_Specified;
end;

procedure DesgloseFacturaRecibidasType.SetDesgloseIVA(Index: Integer; const ADesgloseIVA: DesgloseIVA);
begin
  FDesgloseIVA := ADesgloseIVA;
  FDesgloseIVA_Specified := True;
end;

function DesgloseFacturaRecibidasType.DesgloseIVA_Specified(Index: Integer): boolean;
begin
  Result := FDesgloseIVA_Specified;
end;

destructor TipoSinDesglosePrestacionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FSujeta);
  System.SysUtils.FreeAndNil(FNoSujeta);
  inherited Destroy;
end;

procedure TipoSinDesglosePrestacionType.SetSujeta(Index: Integer; const ASujetaPrestacionType: SujetaPrestacionType);
begin
  FSujeta := ASujetaPrestacionType;
  FSujeta_Specified := True;
end;

function TipoSinDesglosePrestacionType.Sujeta_Specified(Index: Integer): boolean;
begin
  Result := FSujeta_Specified;
end;

procedure TipoSinDesglosePrestacionType.SetNoSujeta(Index: Integer; const ANoSujetaType: NoSujetaType);
begin
  FNoSujeta := ANoSujetaType;
  FNoSujeta_Specified := True;
end;

function TipoSinDesglosePrestacionType.NoSujeta_Specified(Index: Integer): boolean;
begin
  Result := FNoSujeta_Specified;
end;

destructor SujetaType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FExenta)-1 do
    System.SysUtils.FreeAndNil(FExenta[I]);
  System.SetLength(FExenta, 0);
  System.SysUtils.FreeAndNil(FNoExenta);
  inherited Destroy;
end;

procedure SujetaType.SetExenta(Index: Integer; const AExenta: Exenta);
begin
  FExenta := AExenta;
  FExenta_Specified := True;
end;

function SujetaType.Exenta_Specified(Index: Integer): boolean;
begin
  Result := FExenta_Specified;
end;

procedure SujetaType.SetNoExenta(Index: Integer; const ANoExenta2: NoExenta2);
begin
  FNoExenta := ANoExenta2;
  FNoExenta_Specified := True;
end;

function SujetaType.NoExenta_Specified(Index: Integer): boolean;
begin
  Result := FNoExenta_Specified;
end;

destructor SujetaPrestacionType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FExenta)-1 do
    System.SysUtils.FreeAndNil(FExenta[I]);
  System.SetLength(FExenta, 0);
  System.SysUtils.FreeAndNil(FNoExenta);
  inherited Destroy;
end;

procedure SujetaPrestacionType.SetExenta(Index: Integer; const AExenta2: Exenta2);
begin
  FExenta := AExenta2;
  FExenta_Specified := True;
end;

function SujetaPrestacionType.Exenta_Specified(Index: Integer): boolean;
begin
  Result := FExenta_Specified;
end;

procedure SujetaPrestacionType.SetNoExenta(Index: Integer; const ANoExenta: NoExenta);
begin
  FNoExenta := ANoExenta;
  FNoExenta_Specified := True;
end;

function SujetaPrestacionType.NoExenta_Specified(Index: Integer): boolean;
begin
  Result := FNoExenta_Specified;
end;

destructor NoExenta.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FDesgloseIVA)-1 do
    System.SysUtils.FreeAndNil(FDesgloseIVA[I]);
  System.SetLength(FDesgloseIVA, 0);
  inherited Destroy;
end;

destructor NoExenta2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FDesgloseIVA)-1 do
    System.SysUtils.FreeAndNil(FDesgloseIVA[I]);
  System.SetLength(FDesgloseIVA, 0);
  inherited Destroy;
end;

procedure DatosInmuebleType.SetReferenciaCatastral(Index: Integer; const AReferenciaCatastralType: ReferenciaCatastralType);
begin
  FReferenciaCatastral := AReferenciaCatastralType;
  FReferenciaCatastral_Specified := True;
end;

function DatosInmuebleType.ReferenciaCatastral_Specified(Index: Integer): boolean;
begin
  Result := FReferenciaCatastral_Specified;
end;

destructor RespuestaComunBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FCabecera);
  inherited Destroy;
end;

procedure RespuestaComunBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaComunBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaComunBajaType.SetDatosPresentacion(Index: Integer; const ADatosPresentacionType: DatosPresentacionType);
begin
  FDatosPresentacion := ADatosPresentacionType;
  FDatosPresentacion_Specified := True;
end;

function RespuestaComunBajaType.DatosPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FDatosPresentacion_Specified;
end;

destructor RespuestaLRBajaIMetalicoType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaIMetalicoType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaMetalicoBajaType: Array_Of_RespuestaMetalicoBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaMetalicoBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaIMetalicoType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBajaOComunitariasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaOComunitariasType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaComunitariaBajaType: Array_Of_RespuestaComunitariaBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaComunitariaBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaOComunitariasType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBajaAgenciasViajesType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaAgenciasViajesType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaAgenciasViajesBajaType: Array_Of_RespuestaAgenciasViajesBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaAgenciasViajesBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaAgenciasViajesType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBajaFRecibidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaFRecibidasType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaRecibidaBajaType: Array_Of_RespuestaRecibidaBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaRecibidaBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaFRecibidasType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

constructor RespuestaLRBajaFEmitidasType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaLRBajaFEmitidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaFEmitidasType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaExpedidaBajaType: Array_Of_RespuestaExpedidaBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaExpedidaBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaFEmitidasType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBajaBienesInversionType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaBienesInversionType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaBienBajaType: Array_Of_RespuestaBienBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaBienBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaBienesInversionType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBajaOperacionesSegurosType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaOperacionesSegurosType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaOperacionesSegurosBajaType: Array_Of_RespuestaOperacionesSegurosBajaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaOperacionesSegurosBajaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaOperacionesSegurosType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBajaFRecibidasPagosType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBajaFRecibidasPagosType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaRecibidaPagoType: Array_Of_RespuestaRecibidaPagoType);
begin
  FRespuestaLinea := AArray_Of_RespuestaRecibidaPagoType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBajaFRecibidasPagosType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaComunAltaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FCabecera);
  inherited Destroy;
end;

procedure RespuestaComunAltaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaComunAltaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaComunAltaType.SetDatosPresentacion(Index: Integer; const ADatosPresentacionType: DatosPresentacionType);
begin
  FDatosPresentacion := ADatosPresentacionType;
  FDatosPresentacion_Specified := True;
end;

function RespuestaComunAltaType.DatosPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FDatosPresentacion_Specified;
end;

destructor RespuestaLRIMetalicoType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRIMetalicoType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaMetalicoType: Array_Of_RespuestaMetalicoType);
begin
  FRespuestaLinea := AArray_Of_RespuestaMetalicoType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRIMetalicoType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLROComunitariasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLROComunitariasType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaComunitariaType: Array_Of_RespuestaComunitariaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaComunitariaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLROComunitariasType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRBienesInversionType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRBienesInversionType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaBienType: Array_Of_RespuestaBienType);
begin
  FRespuestaLinea := AArray_Of_RespuestaBienType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRBienesInversionType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLROperacionesSegurosType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLROperacionesSegurosType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaOperacionesSegurosType: Array_Of_RespuestaOperacionesSegurosType);
begin
  FRespuestaLinea := AArray_Of_RespuestaOperacionesSegurosType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLROperacionesSegurosType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRAgenciasViajesType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRAgenciasViajesType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaAgenciasViajesType: Array_Of_RespuestaAgenciasViajesType);
begin
  FRespuestaLinea := AArray_Of_RespuestaAgenciasViajesType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRAgenciasViajesType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

constructor RespuestaLRFEmitidasType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaLRFEmitidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRFEmitidasType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaExpedidaType: Array_Of_RespuestaExpedidaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaExpedidaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRFEmitidasType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

destructor RespuestaLRFRecibidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRespuestaLinea)-1 do
    System.SysUtils.FreeAndNil(FRespuestaLinea[I]);
  System.SetLength(FRespuestaLinea, 0);
  inherited Destroy;
end;

procedure RespuestaLRFRecibidasType.SetRespuestaLinea(Index: Integer; const AArray_Of_RespuestaRecibidaType: Array_Of_RespuestaRecibidaType);
begin
  FRespuestaLinea := AArray_Of_RespuestaRecibidaType;
  FRespuestaLinea_Specified := True;
end;

function RespuestaLRFRecibidasType.RespuestaLinea_Specified(Index: Integer): boolean;
begin
  Result := FRespuestaLinea_Specified;
end;

procedure DatosPresentacion2Type.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function DatosPresentacion2Type.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor IDEmisorFactura.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure IDEmisorFactura.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function IDEmisorFactura.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure IDEmisorFactura.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function IDEmisorFactura.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor RegistroSiiImputacion.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoImputacion);
  inherited Destroy;
end;

destructor RegistroSii.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  inherited Destroy;
end;

destructor ConsultaInformacion.Destroy;
begin
  System.SysUtils.FreeAndNil(FCabecera);
  inherited Destroy;
end;

destructor RespuestaConsultaFacturaPagosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

destructor RespuestaConsultaFacturaCobrosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

destructor RespuestaConsultaInmueblesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

destructor RespuestaConsultaInmueblesAdicionalesType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaInmueblesAdicionales)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaInmueblesAdicionales[I]);
  System.SetLength(FRegistroRespuestaConsultaInmueblesAdicionales, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaInmueblesAdicionalesType.SetRegistroRespuestaConsultaInmueblesAdicionales(Index: Integer; const AArray_Of_RegistroRespuestaConsultaInmueblesAdicionalesType: Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType);
begin
  FRegistroRespuestaConsultaInmueblesAdicionales := AArray_Of_RegistroRespuestaConsultaInmueblesAdicionalesType;
  FRegistroRespuestaConsultaInmueblesAdicionales_Specified := True;
end;

function RespuestaConsultaInmueblesAdicionalesType.RegistroRespuestaConsultaInmueblesAdicionales_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaInmueblesAdicionales_Specified;
end;

destructor SuministroInformacionBaja.Destroy;
begin
  System.SysUtils.FreeAndNil(FCabecera);
  inherited Destroy;
end;

destructor SuministroInformacion.Destroy;
begin
  System.SysUtils.FreeAndNil(FCabecera);
  inherited Destroy;
end;

destructor CabeceraConsultaSii.Destroy;
begin
  System.SysUtils.FreeAndNil(FTitular);
  inherited Destroy;
end;

destructor CabeceraSii.Destroy;
begin
  System.SysUtils.FreeAndNil(FTitular);
  inherited Destroy;
end;

destructor CabeceraSiiBaja.Destroy;
begin
  System.SysUtils.FreeAndNil(FTitular);
  inherited Destroy;
end;

destructor ConsultaInformacionCliente.Destroy;
begin
  System.SysUtils.FreeAndNil(FCabecera);
  inherited Destroy;
end;

destructor CabeceraConsultaSiiCliente.Destroy;
begin
  System.SysUtils.FreeAndNil(FTitularLRFE);
  inherited Destroy;
end;

procedure PersonaFisicaJuridicaESType.SetNIFRepresentante(Index: Integer; const ANIFType: NIFType);
begin
  FNIFRepresentante := ANIFType;
  FNIFRepresentante_Specified := True;
end;

function PersonaFisicaJuridicaESType.NIFRepresentante_Specified(Index: Integer): boolean;
begin
  Result := FNIFRepresentante_Specified;
end;

destructor ContraparteConsultaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure ContraparteConsultaType.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function ContraparteConsultaType.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure ContraparteConsultaType.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function ContraparteConsultaType.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor PersonaFisicaJuridicaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure PersonaFisicaJuridicaType.SetNIFRepresentante(Index: Integer; const ANIFType: NIFType);
begin
  FNIFRepresentante := ANIFType;
  FNIFRepresentante_Specified := True;
end;

function PersonaFisicaJuridicaType.NIFRepresentante_Specified(Index: Integer): boolean;
begin
  Result := FNIFRepresentante_Specified;
end;

procedure PersonaFisicaJuridicaType.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function PersonaFisicaJuridicaType.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure PersonaFisicaJuridicaType.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function PersonaFisicaJuridicaType.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor IDEmisorFactura5.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure IDEmisorFactura5.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function IDEmisorFactura5.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure IDEmisorFactura5.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function IDEmisorFactura5.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor IDEmisorFactura6.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure IDEmisorFactura6.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function IDEmisorFactura6.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure IDEmisorFactura6.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function IDEmisorFactura6.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor IDEmisorFactura7.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure IDEmisorFactura7.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function IDEmisorFactura7.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure IDEmisorFactura7.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function IDEmisorFactura7.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor IDEmisorFactura9.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDOtro);
  inherited Destroy;
end;

procedure IDEmisorFactura9.SetNIF(Index: Integer; const ANIFType: NIFType);
begin
  FNIF := ANIFType;
  FNIF_Specified := True;
end;

function IDEmisorFactura9.NIF_Specified(Index: Integer): boolean;
begin
  Result := FNIF_Specified;
end;

procedure IDEmisorFactura9.SetIDOtro(Index: Integer; const AIDOtroType: IDOtroType);
begin
  FIDOtro := AIDOtroType;
  FIDOtro_Specified := True;
end;

function IDEmisorFactura9.IDOtro_Specified(Index: Integer): boolean;
begin
  Result := FIDOtro_Specified;
end;

destructor OperacionIntracomunitariaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure OperacionIntracomunitariaType.SetPlazoOperacion(Index: Integer; const APlazoOperacion: PlazoOperacion);
begin
  FPlazoOperacion := APlazoOperacion;
  FPlazoOperacion_Specified := True;
end;

function OperacionIntracomunitariaType.PlazoOperacion_Specified(Index: Integer): boolean;
begin
  Result := FPlazoOperacion_Specified;
end;

procedure OperacionIntracomunitariaType.SetFacturasODocumentacion(Index: Integer; const ATextMax150Type: TextMax150Type);
begin
  FFacturasODocumentacion := ATextMax150Type;
  FFacturasODocumentacion_Specified := True;
end;

function OperacionIntracomunitariaType.FacturasODocumentacion_Specified(Index: Integer): boolean;
begin
  Result := FFacturasODocumentacion_Specified;
end;

procedure OperacionIntracomunitariaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function OperacionIntracomunitariaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure OperacionIntracomunitariaType.SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
begin
  FNumRegistroAcuerdoFacturacion := ATextMax15Type;
  FNumRegistroAcuerdoFacturacion_Specified := True;
end;

function OperacionIntracomunitariaType.NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
begin
  Result := FNumRegistroAcuerdoFacturacion_Specified;
end;

procedure OperacionIntracomunitariaType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function OperacionIntracomunitariaType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

procedure OperacionIntracomunitariaType.SetRegPrevioGGEEoREDEMEoCompetencia(Index: Integer; const ARegPrevioGGEEoREDEMEoCompetenciaType: RegPrevioGGEEoREDEMEoCompetenciaType);
begin
  FRegPrevioGGEEoREDEMEoCompetencia := ARegPrevioGGEEoREDEMEoCompetenciaType;
  FRegPrevioGGEEoREDEMEoCompetencia_Specified := True;
end;

function OperacionIntracomunitariaType.RegPrevioGGEEoREDEMEoCompetencia_Specified(Index: Integer): boolean;
begin
  Result := FRegPrevioGGEEoREDEMEoCompetencia_Specified;
end;

destructor IDFacturaImputacionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

procedure IDFacturaImputacionType.SetNumSerieFacturaEmisorResumenFin(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisorResumenFin := ATextoIDFacturaType;
  FNumSerieFacturaEmisorResumenFin_Specified := True;
end;

function IDFacturaImputacionType.NumSerieFacturaEmisorResumenFin_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisorResumenFin_Specified;
end;

destructor IDFacturaExpedidaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

procedure IDFacturaExpedidaType.SetNumSerieFacturaEmisorResumenFin(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisorResumenFin := ATextoIDFacturaType;
  FNumSerieFacturaEmisorResumenFin_Specified := True;
end;

function IDFacturaExpedidaType.NumSerieFacturaEmisorResumenFin_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisorResumenFin_Specified;
end;

destructor ClavePaginacionClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  System.SysUtils.FreeAndNil(FCliente);
  inherited Destroy;
end;

destructor IDFacturaExpedidaBCType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

procedure IDFacturaConsulta2Type.SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisor := ATextoIDFacturaType;
  FNumSerieFacturaEmisor_Specified := True;
end;

function IDFacturaConsulta2Type.NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisor_Specified;
end;

procedure IDFacturaConsulta2Type.SetFechaExpedicionFacturaEmisor(Index: Integer; const Afecha: fecha);
begin
  FFechaExpedicionFacturaEmisor := Afecha;
  FFechaExpedicionFacturaEmisor_Specified := True;
end;

function IDFacturaConsulta2Type.FechaExpedicionFacturaEmisor_Specified(Index: Integer): boolean;
begin
  Result := FFechaExpedicionFacturaEmisor_Specified;
end;

destructor IDFacturaRecibidaNombreBCType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

destructor IDFacturaConsulta1Type.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

procedure IDFacturaConsulta1Type.SetIDEmisorFactura(Index: Integer; const AIDEmisorFactura7: IDEmisorFactura7);
begin
  FIDEmisorFactura := AIDEmisorFactura7;
  FIDEmisorFactura_Specified := True;
end;

function IDFacturaConsulta1Type.IDEmisorFactura_Specified(Index: Integer): boolean;
begin
  Result := FIDEmisorFactura_Specified;
end;

procedure IDFacturaConsulta1Type.SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisor := ATextoIDFacturaType;
  FNumSerieFacturaEmisor_Specified := True;
end;

function IDFacturaConsulta1Type.NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisor_Specified;
end;

procedure IDFacturaConsulta1Type.SetFechaExpedicionFacturaEmisor(Index: Integer; const Afecha: fecha);
begin
  FFechaExpedicionFacturaEmisor := Afecha;
  FFechaExpedicionFacturaEmisor_Specified := True;
end;

function IDFacturaConsulta1Type.FechaExpedicionFacturaEmisor_Specified(Index: Integer): boolean;
begin
  Result := FFechaExpedicionFacturaEmisor_Specified;
end;

destructor ClavePaginacionBienType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

destructor IDFacturaRecibidaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

procedure IDFacturaRecibidaType.SetNumSerieFacturaEmisorResumenFin(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisorResumenFin := ATextoIDFacturaType;
  FNumSerieFacturaEmisorResumenFin_Specified := True;
end;

function IDFacturaRecibidaType.NumSerieFacturaEmisorResumenFin_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisorResumenFin_Specified;
end;

destructor ClavePaginacionProveedorType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

destructor IDFacturaComunitariaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDEmisorFactura);
  inherited Destroy;
end;

destructor FacturaType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FFacturasAgrupadas)-1 do
    System.SysUtils.FreeAndNil(FFacturasAgrupadas[I]);
  System.SetLength(FFacturasAgrupadas, 0);
  for I := 0 to System.Length(FFacturasRectificadas)-1 do
    System.SysUtils.FreeAndNil(FFacturasRectificadas[I]);
  System.SetLength(FFacturasRectificadas, 0);
  System.SysUtils.FreeAndNil(FImporteRectificacion);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure FacturaType.SetTipoRectificativa(Index: Integer; const AClaveTipoRectificativaType: ClaveTipoRectificativaType);
begin
  FTipoRectificativa := AClaveTipoRectificativaType;
  FTipoRectificativa_Specified := True;
end;

function FacturaType.TipoRectificativa_Specified(Index: Integer): boolean;
begin
  Result := FTipoRectificativa_Specified;
end;

procedure FacturaType.SetFacturasAgrupadas(Index: Integer; const AFacturasAgrupadas2: FacturasAgrupadas2);
begin
  FFacturasAgrupadas := AFacturasAgrupadas2;
  FFacturasAgrupadas_Specified := True;
end;

function FacturaType.FacturasAgrupadas_Specified(Index: Integer): boolean;
begin
  Result := FFacturasAgrupadas_Specified;
end;

procedure FacturaType.SetFacturasRectificadas(Index: Integer; const AFacturasRectificadas2: FacturasRectificadas2);
begin
  FFacturasRectificadas := AFacturasRectificadas2;
  FFacturasRectificadas_Specified := True;
end;

function FacturaType.FacturasRectificadas_Specified(Index: Integer): boolean;
begin
  Result := FFacturasRectificadas_Specified;
end;

procedure FacturaType.SetImporteRectificacion(Index: Integer; const ADesgloseRectificacionType: DesgloseRectificacionType);
begin
  FImporteRectificacion := ADesgloseRectificacionType;
  FImporteRectificacion_Specified := True;
end;

function FacturaType.ImporteRectificacion_Specified(Index: Integer): boolean;
begin
  Result := FImporteRectificacion_Specified;
end;

procedure FacturaType.SetFechaOperacion(Index: Integer; const Afecha: fecha);
begin
  FFechaOperacion := Afecha;
  FFechaOperacion_Specified := True;
end;

function FacturaType.FechaOperacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaOperacion_Specified;
end;

procedure FacturaType.SetClaveRegimenEspecialOTrascendenciaAdicional1(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
begin
  FClaveRegimenEspecialOTrascendenciaAdicional1 := AIdOperacionesTrascendenciaTributariaType;
  FClaveRegimenEspecialOTrascendenciaAdicional1_Specified := True;
end;

function FacturaType.ClaveRegimenEspecialOTrascendenciaAdicional1_Specified(Index: Integer): boolean;
begin
  Result := FClaveRegimenEspecialOTrascendenciaAdicional1_Specified;
end;

procedure FacturaType.SetClaveRegimenEspecialOTrascendenciaAdicional2(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
begin
  FClaveRegimenEspecialOTrascendenciaAdicional2 := AIdOperacionesTrascendenciaTributariaType;
  FClaveRegimenEspecialOTrascendenciaAdicional2_Specified := True;
end;

function FacturaType.ClaveRegimenEspecialOTrascendenciaAdicional2_Specified(Index: Integer): boolean;
begin
  Result := FClaveRegimenEspecialOTrascendenciaAdicional2_Specified;
end;

procedure FacturaType.SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
begin
  FNumRegistroAcuerdoFacturacion := ATextMax15Type;
  FNumRegistroAcuerdoFacturacion_Specified := True;
end;

function FacturaType.NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
begin
  Result := FNumRegistroAcuerdoFacturacion_Specified;
end;

procedure FacturaType.SetImporteTotal(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTotal := AImporteSgn12_2Type;
  FImporteTotal_Specified := True;
end;

function FacturaType.ImporteTotal_Specified(Index: Integer): boolean;
begin
  Result := FImporteTotal_Specified;
end;

procedure FacturaType.SetBaseImponibleACoste(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FBaseImponibleACoste := AImporteSgn12_2Type;
  FBaseImponibleACoste_Specified := True;
end;

function FacturaType.BaseImponibleACoste_Specified(Index: Integer): boolean;
begin
  Result := FBaseImponibleACoste_Specified;
end;

procedure FacturaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function FacturaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure FacturaType.SetFacturaSimplificadaArticulos7_2_7_3(Index: Integer; const ASimplificadaCualificadaType: SimplificadaCualificadaType);
begin
  FFacturaSimplificadaArticulos7_2_7_3 := ASimplificadaCualificadaType;
  FFacturaSimplificadaArticulos7_2_7_3_Specified := True;
end;

function FacturaType.FacturaSimplificadaArticulos7_2_7_3_Specified(Index: Integer): boolean;
begin
  Result := FFacturaSimplificadaArticulos7_2_7_3_Specified;
end;

procedure FacturaType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function FacturaType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

procedure FacturaType.SetRegPrevioGGEEoREDEMEoCompetencia(Index: Integer; const ARegPrevioGGEEoREDEMEoCompetenciaType: RegPrevioGGEEoREDEMEoCompetenciaType);
begin
  FRegPrevioGGEEoREDEMEoCompetencia := ARegPrevioGGEEoREDEMEoCompetenciaType;
  FRegPrevioGGEEoREDEMEoCompetencia_Specified := True;
end;

function FacturaType.RegPrevioGGEEoREDEMEoCompetencia_Specified(Index: Integer): boolean;
begin
  Result := FRegPrevioGGEEoREDEMEoCompetencia_Specified;
end;

procedure FacturaType.SetMacrodato(Index: Integer; const AMacrodatoType: MacrodatoType);
begin
  FMacrodato := AMacrodatoType;
  FMacrodato_Specified := True;
end;

function FacturaType.Macrodato_Specified(Index: Integer): boolean;
begin
  Result := FMacrodato_Specified;
end;

procedure DetalleIVAEmitidaType.SetTipoImpositivo(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FTipoImpositivo := ATipo2_2Type;
  FTipoImpositivo_Specified := True;
end;

function DetalleIVAEmitidaType.TipoImpositivo_Specified(Index: Integer): boolean;
begin
  Result := FTipoImpositivo_Specified;
end;

procedure DetalleIVAEmitidaType.SetCuotaRepercutida(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaRepercutida := AImporteSgn12_2Type;
  FCuotaRepercutida_Specified := True;
end;

function DetalleIVAEmitidaType.CuotaRepercutida_Specified(Index: Integer): boolean;
begin
  Result := FCuotaRepercutida_Specified;
end;

procedure DetalleIVAEmitidaType.SetTipoRecargoEquivalencia(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FTipoRecargoEquivalencia := ATipo2_2Type;
  FTipoRecargoEquivalencia_Specified := True;
end;

function DetalleIVAEmitidaType.TipoRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FTipoRecargoEquivalencia_Specified;
end;

procedure DetalleIVAEmitidaType.SetCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaRecargoEquivalencia := AImporteSgn12_2Type;
  FCuotaRecargoEquivalencia_Specified := True;
end;

function DetalleIVAEmitidaType.CuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FCuotaRecargoEquivalencia_Specified;
end;

destructor FacturaRecibidaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDesgloseFactura);
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

procedure DetalleExentaType.SetCausaExencion(Index: Integer; const ACausaExencionType: CausaExencionType);
begin
  FCausaExencion := ACausaExencionType;
  FCausaExencion_Specified := True;
end;

function DetalleExentaType.CausaExencion_Specified(Index: Integer): boolean;
begin
  Result := FCausaExencion_Specified;
end;

procedure DetalleIVAEmitidaPrestacionType.SetTipoImpositivo(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FTipoImpositivo := ATipo2_2Type;
  FTipoImpositivo_Specified := True;
end;

function DetalleIVAEmitidaPrestacionType.TipoImpositivo_Specified(Index: Integer): boolean;
begin
  Result := FTipoImpositivo_Specified;
end;

procedure DetalleIVAEmitidaPrestacionType.SetCuotaRepercutida(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaRepercutida := AImporteSgn12_2Type;
  FCuotaRepercutida_Specified := True;
end;

function DetalleIVAEmitidaPrestacionType.CuotaRepercutida_Specified(Index: Integer): boolean;
begin
  Result := FCuotaRepercutida_Specified;
end;

procedure NoSujetaType.SetImportePorArticulos7_14_Otros(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImportePorArticulos7_14_Otros := AImporteSgn12_2Type;
  FImportePorArticulos7_14_Otros_Specified := True;
end;

function NoSujetaType.ImportePorArticulos7_14_Otros_Specified(Index: Integer): boolean;
begin
  Result := FImportePorArticulos7_14_Otros_Specified;
end;

procedure NoSujetaType.SetImporteTAIReglasLocalizacion(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTAIReglasLocalizacion := AImporteSgn12_2Type;
  FImporteTAIReglasLocalizacion_Specified := True;
end;

function NoSujetaType.ImporteTAIReglasLocalizacion_Specified(Index: Integer): boolean;
begin
  Result := FImporteTAIReglasLocalizacion_Specified;
end;

procedure DetalleIVARecibidaType.SetTipoImpositivo(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FTipoImpositivo := ATipo2_2Type;
  FTipoImpositivo_Specified := True;
end;

function DetalleIVARecibidaType.TipoImpositivo_Specified(Index: Integer): boolean;
begin
  Result := FTipoImpositivo_Specified;
end;

procedure DetalleIVARecibidaType.SetCuotaSoportada(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaSoportada := AImporteSgn12_2Type;
  FCuotaSoportada_Specified := True;
end;

function DetalleIVARecibidaType.CuotaSoportada_Specified(Index: Integer): boolean;
begin
  Result := FCuotaSoportada_Specified;
end;

procedure DetalleIVARecibidaType.SetTipoRecargoEquivalencia(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FTipoRecargoEquivalencia := ATipo2_2Type;
  FTipoRecargoEquivalencia_Specified := True;
end;

function DetalleIVARecibidaType.TipoRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FTipoRecargoEquivalencia_Specified;
end;

procedure DetalleIVARecibidaType.SetCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaRecargoEquivalencia := AImporteSgn12_2Type;
  FCuotaRecargoEquivalencia_Specified := True;
end;

function DetalleIVARecibidaType.CuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FCuotaRecargoEquivalencia_Specified;
end;

procedure DetalleIVARecibidaType.SetPorcentCompensacionREAGYP(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FPorcentCompensacionREAGYP := ATipo2_2Type;
  FPorcentCompensacionREAGYP_Specified := True;
end;

function DetalleIVARecibidaType.PorcentCompensacionREAGYP_Specified(Index: Integer): boolean;
begin
  Result := FPorcentCompensacionREAGYP_Specified;
end;

procedure DetalleIVARecibidaType.SetImporteCompensacionREAGYP(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteCompensacionREAGYP := AImporteSgn12_2Type;
  FImporteCompensacionREAGYP_Specified := True;
end;

function DetalleIVARecibidaType.ImporteCompensacionREAGYP_Specified(Index: Integer): boolean;
begin
  Result := FImporteCompensacionREAGYP_Specified;
end;

destructor FacturaExpedidaType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FDatosInmueble)-1 do
    System.SysUtils.FreeAndNil(FDatosInmueble[I]);
  System.SetLength(FDatosInmueble, 0);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FTipoDesglose);
  inherited Destroy;
end;

procedure FacturaExpedidaType.SetDatosInmueble(Index: Integer; const ADatosInmueble3: DatosInmueble3);
begin
  FDatosInmueble := ADatosInmueble3;
  FDatosInmueble_Specified := True;
end;

function FacturaExpedidaType.DatosInmueble_Specified(Index: Integer): boolean;
begin
  Result := FDatosInmueble_Specified;
end;

procedure FacturaExpedidaType.SetImporteTransmisionInmueblesSujetoAIVA(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTransmisionInmueblesSujetoAIVA := AImporteSgn12_2Type;
  FImporteTransmisionInmueblesSujetoAIVA_Specified := True;
end;

function FacturaExpedidaType.ImporteTransmisionInmueblesSujetoAIVA_Specified(Index: Integer): boolean;
begin
  Result := FImporteTransmisionInmueblesSujetoAIVA_Specified;
end;

procedure FacturaExpedidaType.SetEmitidaPorTercerosODestinatario(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
begin
  FEmitidaPorTercerosODestinatario := AEmitidaPorTercerosType;
  FEmitidaPorTercerosODestinatario_Specified := True;
end;

function FacturaExpedidaType.EmitidaPorTercerosODestinatario_Specified(Index: Integer): boolean;
begin
  Result := FEmitidaPorTercerosODestinatario_Specified;
end;

procedure FacturaExpedidaType.SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
begin
  FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas := AEmitidaPorTercerosType;
  FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified := True;
end;

function FacturaExpedidaType.FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified(Index: Integer): boolean;
begin
  Result := FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified;
end;

procedure FacturaExpedidaType.SetVariosDestinatarios(Index: Integer; const AVariosDestinatariosType: VariosDestinatariosType);
begin
  FVariosDestinatarios := AVariosDestinatariosType;
  FVariosDestinatarios_Specified := True;
end;

function FacturaExpedidaType.VariosDestinatarios_Specified(Index: Integer): boolean;
begin
  Result := FVariosDestinatarios_Specified;
end;

procedure FacturaExpedidaType.SetCupon(Index: Integer; const ACuponType: CuponType);
begin
  FCupon := ACuponType;
  FCupon_Specified := True;
end;

function FacturaExpedidaType.Cupon_Specified(Index: Integer): boolean;
begin
  Result := FCupon_Specified;
end;

procedure FacturaExpedidaType.SetFacturaSinIdentifDestinatarioAritculo6_1_d(Index: Integer; const ACompletaSinDestinatarioType: CompletaSinDestinatarioType);
begin
  FFacturaSinIdentifDestinatarioAritculo6_1_d := ACompletaSinDestinatarioType;
  FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified := True;
end;

function FacturaExpedidaType.FacturaSinIdentifDestinatarioAritculo6_1_d_Specified(Index: Integer): boolean;
begin
  Result := FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified;
end;

procedure FacturaExpedidaType.SetContraparte(Index: Integer; const APersonaFisicaJuridicaType: PersonaFisicaJuridicaType);
begin
  FContraparte := APersonaFisicaJuridicaType;
  FContraparte_Specified := True;
end;

function FacturaExpedidaType.Contraparte_Specified(Index: Integer): boolean;
begin
  Result := FContraparte_Specified;
end;

procedure DesgloseRectificacionType.SetCuotaRecargoRectificado(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaRecargoRectificado := AImporteSgn12_2Type;
  FCuotaRecargoRectificado_Specified := True;
end;

function DesgloseRectificacionType.CuotaRecargoRectificado_Specified(Index: Integer): boolean;
begin
  Result := FCuotaRecargoRectificado_Specified;
end;

procedure DetalleIVARecibida2Type.SetTipoRecargoEquivalencia(Index: Integer; const ATipo2_2Type: Tipo2_2Type);
begin
  FTipoRecargoEquivalencia := ATipo2_2Type;
  FTipoRecargoEquivalencia_Specified := True;
end;

function DetalleIVARecibida2Type.TipoRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FTipoRecargoEquivalencia_Specified;
end;

procedure DetalleIVARecibida2Type.SetCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FCuotaRecargoEquivalencia := AImporteSgn12_2Type;
  FCuotaRecargoEquivalencia_Specified := True;
end;

function DetalleIVARecibida2Type.CuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FCuotaRecargoEquivalencia_Specified;
end;

procedure DatosPagoCobroType.SetCuenta_O_Medio(Index: Integer; const ATextMax34Type: TextMax34Type);
begin
  FCuenta_O_Medio := ATextMax34Type;
  FCuenta_O_Medio_Specified := True;
end;

function DatosPagoCobroType.Cuenta_O_Medio_Specified(Index: Integer): boolean;
begin
  Result := FCuenta_O_Medio_Specified;
end;

destructor BienDeInversionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure BienDeInversionType.SetRegularizacionAnualDeduccion(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FRegularizacionAnualDeduccion := AImporteSgn12_2Type;
  FRegularizacionAnualDeduccion_Specified := True;
end;

function BienDeInversionType.RegularizacionAnualDeduccion_Specified(Index: Integer): boolean;
begin
  Result := FRegularizacionAnualDeduccion_Specified;
end;

procedure BienDeInversionType.SetIdentificacionEntrega(Index: Integer; const ATextMax40Type: TextMax40Type);
begin
  FIdentificacionEntrega := ATextMax40Type;
  FIdentificacionEntrega_Specified := True;
end;

function BienDeInversionType.IdentificacionEntrega_Specified(Index: Integer): boolean;
begin
  Result := FIdentificacionEntrega_Specified;
end;

procedure BienDeInversionType.SetRegularizacionDeduccionEfectuada(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FRegularizacionDeduccionEfectuada := AImporteSgn12_2Type;
  FRegularizacionDeduccionEfectuada_Specified := True;
end;

function BienDeInversionType.RegularizacionDeduccionEfectuada_Specified(Index: Integer): boolean;
begin
  Result := FRegularizacionDeduccionEfectuada_Specified;
end;

procedure BienDeInversionType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function BienDeInversionType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure BienDeInversionType.SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
begin
  FNumRegistroAcuerdoFacturacion := ATextMax15Type;
  FNumRegistroAcuerdoFacturacion_Specified := True;
end;

function BienDeInversionType.NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
begin
  Result := FNumRegistroAcuerdoFacturacion_Specified;
end;

procedure BienDeInversionType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function BienDeInversionType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

destructor RespuestaCobrosMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure RespuestaCobrosMetalicoType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function RespuestaCobrosMetalicoType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

destructor FacturaRespuestaType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FFacturasAgrupadas)-1 do
    System.SysUtils.FreeAndNil(FFacturasAgrupadas[I]);
  System.SetLength(FFacturasAgrupadas, 0);
  for I := 0 to System.Length(FFacturasRectificadas)-1 do
    System.SysUtils.FreeAndNil(FFacturasRectificadas[I]);
  System.SetLength(FFacturasRectificadas, 0);
  System.SysUtils.FreeAndNil(FImporteRectificacion);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure FacturaRespuestaType.SetTipoRectificativa(Index: Integer; const AClaveTipoRectificativaType: ClaveTipoRectificativaType);
begin
  FTipoRectificativa := AClaveTipoRectificativaType;
  FTipoRectificativa_Specified := True;
end;

function FacturaRespuestaType.TipoRectificativa_Specified(Index: Integer): boolean;
begin
  Result := FTipoRectificativa_Specified;
end;

procedure FacturaRespuestaType.SetFacturasAgrupadas(Index: Integer; const AFacturasAgrupadas: FacturasAgrupadas);
begin
  FFacturasAgrupadas := AFacturasAgrupadas;
  FFacturasAgrupadas_Specified := True;
end;

function FacturaRespuestaType.FacturasAgrupadas_Specified(Index: Integer): boolean;
begin
  Result := FFacturasAgrupadas_Specified;
end;

procedure FacturaRespuestaType.SetFacturasRectificadas(Index: Integer; const AFacturasRectificadas: FacturasRectificadas);
begin
  FFacturasRectificadas := AFacturasRectificadas;
  FFacturasRectificadas_Specified := True;
end;

function FacturaRespuestaType.FacturasRectificadas_Specified(Index: Integer): boolean;
begin
  Result := FFacturasRectificadas_Specified;
end;

procedure FacturaRespuestaType.SetImporteRectificacion(Index: Integer; const ADesgloseRectificacionType: DesgloseRectificacionType);
begin
  FImporteRectificacion := ADesgloseRectificacionType;
  FImporteRectificacion_Specified := True;
end;

function FacturaRespuestaType.ImporteRectificacion_Specified(Index: Integer): boolean;
begin
  Result := FImporteRectificacion_Specified;
end;

procedure FacturaRespuestaType.SetFechaOperacion(Index: Integer; const Afecha: fecha);
begin
  FFechaOperacion := Afecha;
  FFechaOperacion_Specified := True;
end;

function FacturaRespuestaType.FechaOperacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaOperacion_Specified;
end;

procedure FacturaRespuestaType.SetClaveRegimenEspecialOTrascendenciaAdicional1(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
begin
  FClaveRegimenEspecialOTrascendenciaAdicional1 := AIdOperacionesTrascendenciaTributariaType;
  FClaveRegimenEspecialOTrascendenciaAdicional1_Specified := True;
end;

function FacturaRespuestaType.ClaveRegimenEspecialOTrascendenciaAdicional1_Specified(Index: Integer): boolean;
begin
  Result := FClaveRegimenEspecialOTrascendenciaAdicional1_Specified;
end;

procedure FacturaRespuestaType.SetClaveRegimenEspecialOTrascendenciaAdicional2(Index: Integer; const AIdOperacionesTrascendenciaTributariaType: IdOperacionesTrascendenciaTributariaType);
begin
  FClaveRegimenEspecialOTrascendenciaAdicional2 := AIdOperacionesTrascendenciaTributariaType;
  FClaveRegimenEspecialOTrascendenciaAdicional2_Specified := True;
end;

function FacturaRespuestaType.ClaveRegimenEspecialOTrascendenciaAdicional2_Specified(Index: Integer): boolean;
begin
  Result := FClaveRegimenEspecialOTrascendenciaAdicional2_Specified;
end;

procedure FacturaRespuestaType.SetNumRegistroAcuerdoFacturacion(Index: Integer; const ATextMax15Type: TextMax15Type);
begin
  FNumRegistroAcuerdoFacturacion := ATextMax15Type;
  FNumRegistroAcuerdoFacturacion_Specified := True;
end;

function FacturaRespuestaType.NumRegistroAcuerdoFacturacion_Specified(Index: Integer): boolean;
begin
  Result := FNumRegistroAcuerdoFacturacion_Specified;
end;

procedure FacturaRespuestaType.SetImporteTotal(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTotal := AImporteSgn12_2Type;
  FImporteTotal_Specified := True;
end;

function FacturaRespuestaType.ImporteTotal_Specified(Index: Integer): boolean;
begin
  Result := FImporteTotal_Specified;
end;

procedure FacturaRespuestaType.SetBaseImponibleACoste(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FBaseImponibleACoste := AImporteSgn12_2Type;
  FBaseImponibleACoste_Specified := True;
end;

function FacturaRespuestaType.BaseImponibleACoste_Specified(Index: Integer): boolean;
begin
  Result := FBaseImponibleACoste_Specified;
end;

procedure FacturaRespuestaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function FacturaRespuestaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure FacturaRespuestaType.SetFacturaSimplificadaArticulos7_2_7_3(Index: Integer; const ASimplificadaCualificadaType: SimplificadaCualificadaType);
begin
  FFacturaSimplificadaArticulos7_2_7_3 := ASimplificadaCualificadaType;
  FFacturaSimplificadaArticulos7_2_7_3_Specified := True;
end;

function FacturaRespuestaType.FacturaSimplificadaArticulos7_2_7_3_Specified(Index: Integer): boolean;
begin
  Result := FFacturaSimplificadaArticulos7_2_7_3_Specified;
end;

procedure FacturaRespuestaType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function FacturaRespuestaType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

procedure FacturaRespuestaType.SetRegPrevioGGEEoREDEMEoCompetencia(Index: Integer; const ARegPrevioGGEEoREDEMEoCompetenciaType: RegPrevioGGEEoREDEMEoCompetenciaType);
begin
  FRegPrevioGGEEoREDEMEoCompetencia := ARegPrevioGGEEoREDEMEoCompetenciaType;
  FRegPrevioGGEEoREDEMEoCompetencia_Specified := True;
end;

function FacturaRespuestaType.RegPrevioGGEEoREDEMEoCompetencia_Specified(Index: Integer): boolean;
begin
  Result := FRegPrevioGGEEoREDEMEoCompetencia_Specified;
end;

procedure FacturaRespuestaType.SetMacrodato(Index: Integer; const AMacrodatoType: MacrodatoType);
begin
  FMacrodato := AMacrodatoType;
  FMacrodato_Specified := True;
end;

function FacturaRespuestaType.Macrodato_Specified(Index: Integer): boolean;
begin
  Result := FMacrodato_Specified;
end;

destructor FacturaRespuestaInformadaProveedorType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FDatosInmueble)-1 do
    System.SysUtils.FreeAndNil(FDatosInmueble[I]);
  System.SetLength(FDatosInmueble, 0);
  System.SysUtils.FreeAndNil(FTipoDesglose);
  inherited Destroy;
end;

procedure FacturaRespuestaInformadaProveedorType.SetDatosInmueble(Index: Integer; const ADatosInmueble2: DatosInmueble2);
begin
  FDatosInmueble := ADatosInmueble2;
  FDatosInmueble_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.DatosInmueble_Specified(Index: Integer): boolean;
begin
  Result := FDatosInmueble_Specified;
end;

procedure FacturaRespuestaInformadaProveedorType.SetImporteTransmisionInmueblesSujetoAIVA(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTransmisionInmueblesSujetoAIVA := AImporteSgn12_2Type;
  FImporteTransmisionInmueblesSujetoAIVA_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.ImporteTransmisionInmueblesSujetoAIVA_Specified(Index: Integer): boolean;
begin
  Result := FImporteTransmisionInmueblesSujetoAIVA_Specified;
end;

procedure FacturaRespuestaInformadaProveedorType.SetEmitidaPorTercerosODestinatario(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
begin
  FEmitidaPorTercerosODestinatario := AEmitidaPorTercerosType;
  FEmitidaPorTercerosODestinatario_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.EmitidaPorTercerosODestinatario_Specified(Index: Integer): boolean;
begin
  Result := FEmitidaPorTercerosODestinatario_Specified;
end;

procedure FacturaRespuestaInformadaProveedorType.SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
begin
  FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas := AEmitidaPorTercerosType;
  FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified(Index: Integer): boolean;
begin
  Result := FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified;
end;

procedure FacturaRespuestaInformadaProveedorType.SetVariosDestinatarios(Index: Integer; const AVariosDestinatariosType: VariosDestinatariosType);
begin
  FVariosDestinatarios := AVariosDestinatariosType;
  FVariosDestinatarios_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.VariosDestinatarios_Specified(Index: Integer): boolean;
begin
  Result := FVariosDestinatarios_Specified;
end;

procedure FacturaRespuestaInformadaProveedorType.SetCupon(Index: Integer; const ACuponType: CuponType);
begin
  FCupon := ACuponType;
  FCupon_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.Cupon_Specified(Index: Integer): boolean;
begin
  Result := FCupon_Specified;
end;

procedure FacturaRespuestaInformadaProveedorType.SetFacturaSinIdentifDestinatarioAritculo6_1_d(Index: Integer; const ACompletaSinDestinatarioType: CompletaSinDestinatarioType);
begin
  FFacturaSinIdentifDestinatarioAritculo6_1_d := ACompletaSinDestinatarioType;
  FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified := True;
end;

function FacturaRespuestaInformadaProveedorType.FacturaSinIdentifDestinatarioAritculo6_1_d_Specified(Index: Integer): boolean;
begin
  Result := FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified;
end;

destructor FacturaRespuestaInformadaClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDesgloseFactura);
  inherited Destroy;
end;

destructor FacturaRespuestaExpedidaType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FDatosInmueble)-1 do
    System.SysUtils.FreeAndNil(FDatosInmueble[I]);
  System.SetLength(FDatosInmueble, 0);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FTipoDesglose);
  inherited Destroy;
end;

procedure FacturaRespuestaExpedidaType.SetDatosInmueble(Index: Integer; const ADatosInmueble: DatosInmueble);
begin
  FDatosInmueble := ADatosInmueble;
  FDatosInmueble_Specified := True;
end;

function FacturaRespuestaExpedidaType.DatosInmueble_Specified(Index: Integer): boolean;
begin
  Result := FDatosInmueble_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetImporteTransmisionInmueblesSujetoAIVA(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTransmisionInmueblesSujetoAIVA := AImporteSgn12_2Type;
  FImporteTransmisionInmueblesSujetoAIVA_Specified := True;
end;

function FacturaRespuestaExpedidaType.ImporteTransmisionInmueblesSujetoAIVA_Specified(Index: Integer): boolean;
begin
  Result := FImporteTransmisionInmueblesSujetoAIVA_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetEmitidaPorTercerosODestinatario(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
begin
  FEmitidaPorTercerosODestinatario := AEmitidaPorTercerosType;
  FEmitidaPorTercerosODestinatario_Specified := True;
end;

function FacturaRespuestaExpedidaType.EmitidaPorTercerosODestinatario_Specified(Index: Integer): boolean;
begin
  Result := FEmitidaPorTercerosODestinatario_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas(Index: Integer; const AEmitidaPorTercerosType: EmitidaPorTercerosType);
begin
  FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas := AEmitidaPorTercerosType;
  FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified := True;
end;

function FacturaRespuestaExpedidaType.FacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified(Index: Integer): boolean;
begin
  Result := FFacturacionDispAdicionalTerceraYsextayDelMercadoOrganizadoDelGas_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetVariosDestinatarios(Index: Integer; const AVariosDestinatariosType: VariosDestinatariosType);
begin
  FVariosDestinatarios := AVariosDestinatariosType;
  FVariosDestinatarios_Specified := True;
end;

function FacturaRespuestaExpedidaType.VariosDestinatarios_Specified(Index: Integer): boolean;
begin
  Result := FVariosDestinatarios_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetCupon(Index: Integer; const ACuponType: CuponType);
begin
  FCupon := ACuponType;
  FCupon_Specified := True;
end;

function FacturaRespuestaExpedidaType.Cupon_Specified(Index: Integer): boolean;
begin
  Result := FCupon_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetFacturaSinIdentifDestinatarioAritculo6_1_d(Index: Integer; const ACompletaSinDestinatarioType: CompletaSinDestinatarioType);
begin
  FFacturaSinIdentifDestinatarioAritculo6_1_d := ACompletaSinDestinatarioType;
  FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified := True;
end;

function FacturaRespuestaExpedidaType.FacturaSinIdentifDestinatarioAritculo6_1_d_Specified(Index: Integer): boolean;
begin
  Result := FFacturaSinIdentifDestinatarioAritculo6_1_d_Specified;
end;

procedure FacturaRespuestaExpedidaType.SetContraparte(Index: Integer; const APersonaFisicaJuridicaType: PersonaFisicaJuridicaType);
begin
  FContraparte := APersonaFisicaJuridicaType;
  FContraparte_Specified := True;
end;

function FacturaRespuestaExpedidaType.Contraparte_Specified(Index: Integer): boolean;
begin
  Result := FContraparte_Specified;
end;

destructor FacturaRespuestaRecibidaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FDesgloseFactura);
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

procedure IDOtroType.SetCodigoPais(Index: Integer; const ACountryType2: CountryType2);
begin
  FCodigoPais := ACountryType2;
  FCodigoPais_Specified := True;
end;

function IDOtroType.CodigoPais_Specified(Index: Integer): boolean;
begin
  Result := FCodigoPais_Specified;
end;

procedure RangoFechaPresentacionType.SetDesde(Index: Integer; const Afecha: fecha);
begin
  FDesde := Afecha;
  FDesde_Specified := True;
end;

function RangoFechaPresentacionType.Desde_Specified(Index: Integer): boolean;
begin
  Result := FDesde_Specified;
end;

procedure RangoFechaPresentacionType.SetHasta(Index: Integer; const Afecha: fecha);
begin
  FHasta := Afecha;
  FHasta_Specified := True;
end;

function RangoFechaPresentacionType.Hasta_Specified(Index: Integer): boolean;
begin
  Result := FHasta_Specified;
end;

destructor LRConsultaBienesInversionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

destructor LRConsultaDetOperIntracomunitariasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

constructor ConsultaLRFactInformadasAgrupadasClienteType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ConsultaLRFactInformadasAgrupadasClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

constructor LRConsultaEmitidasType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor LRConsultaEmitidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

constructor ConsultaLRFactInformadasClienteType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ConsultaLRFactInformadasClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

destructor LRConsultaCobrosMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

destructor ConsultaPagosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsultaPagos);
  inherited Destroy;
end;

destructor ConsultaInmueblesAdicionalesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsultaInmueblesAdicionales);
  inherited Destroy;
end;

destructor ConsultaCobrosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsultaCobros);
  inherited Destroy;
end;

destructor LRConsultaAgenciasViajesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

destructor LRConsultaLROperacionesSegurosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

destructor ClavePaginacion.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

destructor LRFiltroInmueblesAdicionalesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

destructor LRConsultaRecibidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FFiltroConsulta);
  inherited Destroy;
end;

destructor LRFiltroCobrosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure LRFiltroCobrosType.SetClavePaginacion(Index: Integer; const ADouble: Double);
begin
  FClavePaginacion := ADouble;
  FClavePaginacion_Specified := True;
end;

function LRFiltroCobrosType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroPagosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure LRFiltroPagosType.SetClavePaginacion(Index: Integer; const ADouble: Double);
begin
  FClavePaginacion := ADouble;
  FClavePaginacion_Specified := True;
end;

function LRFiltroPagosType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor RespuestaConsultaPagosType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaPagos)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaPagos[I]);
  System.SetLength(FRegistroRespuestaConsultaPagos, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaPagosType.SetRegistroRespuestaConsultaPagos(Index: Integer; const AArray_Of_RegistroRespuestaConsultaPagosType: Array_Of_RegistroRespuestaConsultaPagosType);
begin
  FRegistroRespuestaConsultaPagos := AArray_Of_RegistroRespuestaConsultaPagosType;
  FRegistroRespuestaConsultaPagos_Specified := True;
end;

function RespuestaConsultaPagosType.RegistroRespuestaConsultaPagos_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaPagos_Specified;
end;

procedure RespuestaConsultaPagosType.SetClavePaginacion(Index: Integer; const ADouble: Double);
begin
  FClavePaginacion := ADouble;
  FClavePaginacion_Specified := True;
end;

function RespuestaConsultaPagosType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor RespuestaConsultaCobrosType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaCobros)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaCobros[I]);
  System.SetLength(FRegistroRespuestaConsultaCobros, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaCobrosType.SetRegistroRespuestaConsultaCobros(Index: Integer; const AArray_Of_RegistroRespuestaConsultaCobrosType: Array_Of_RegistroRespuestaConsultaCobrosType);
begin
  FRegistroRespuestaConsultaCobros := AArray_Of_RegistroRespuestaConsultaCobrosType;
  FRegistroRespuestaConsultaCobros_Specified := True;
end;

function RespuestaConsultaCobrosType.RegistroRespuestaConsultaCobros_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaCobros_Specified;
end;

procedure RespuestaConsultaCobrosType.SetClavePaginacion(Index: Integer; const ADouble: Double);
begin
  FClavePaginacion := ADouble;
  FClavePaginacion_Specified := True;
end;

function RespuestaConsultaCobrosType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor ClavePaginacion2.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaRecibidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FDatosFacturaRecibida);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoFactura);
  System.SysUtils.FreeAndNil(FDatosDescuadreContraparte);
  inherited Destroy;
end;

procedure RegistroRespuestaConsultaRecibidasType.SetDatosDescuadreContraparte(Index: Integer; const ADatosDescuadreContraparteType: DatosDescuadreContraparteType);
begin
  FDatosDescuadreContraparte := ADatosDescuadreContraparteType;
  FDatosDescuadreContraparte_Specified := True;
end;

function RegistroRespuestaConsultaRecibidasType.DatosDescuadreContraparte_Specified(Index: Integer): boolean;
begin
  Result := FDatosDescuadreContraparte_Specified;
end;

destructor RegistroRespuestaConsultaEmitidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FDatosFacturaEmitida);
  System.SysUtils.FreeAndNil(FDatosPresentacion);
  System.SysUtils.FreeAndNil(FEstadoFactura);
  System.SysUtils.FreeAndNil(FDatosDescuadreContraparte);
  inherited Destroy;
end;

procedure RegistroRespuestaConsultaEmitidasType.SetDatosDescuadreContraparte(Index: Integer; const ADatosDescuadreContraparteType: DatosDescuadreContraparteType);
begin
  FDatosDescuadreContraparte := ADatosDescuadreContraparteType;
  FDatosDescuadreContraparte_Specified := True;
end;

function RegistroRespuestaConsultaEmitidasType.DatosDescuadreContraparte_Specified(Index: Integer): boolean;
begin
  Result := FDatosDescuadreContraparte_Specified;
end;

destructor RespuestaConsultaLRFacturasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  inherited Destroy;
end;

constructor RespuestaConsultaLRFacturasEmitidasType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaConsultaLRFacturasEmitidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRFacturasEmitidas)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRFacturasEmitidas[I]);
  System.SetLength(FRegistroRespuestaConsultaLRFacturasEmitidas, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRFacturasEmitidasType.SetRegistroRespuestaConsultaLRFacturasEmitidas(Index: Integer; const AArray_Of_RegistroRespuestaConsultaEmitidasType: Array_Of_RegistroRespuestaConsultaEmitidasType);
begin
  FRegistroRespuestaConsultaLRFacturasEmitidas := AArray_Of_RegistroRespuestaConsultaEmitidasType;
  FRegistroRespuestaConsultaLRFacturasEmitidas_Specified := True;
end;

function RespuestaConsultaLRFacturasEmitidasType.RegistroRespuestaConsultaLRFacturasEmitidas_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRFacturasEmitidas_Specified;
end;

destructor RespuestaConsultaLRFacturasRecibidasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRFacturasRecibidas)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRFacturasRecibidas[I]);
  System.SetLength(FRegistroRespuestaConsultaLRFacturasRecibidas, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRFacturasRecibidasType.SetRegistroRespuestaConsultaLRFacturasRecibidas(Index: Integer; const AArray_Of_RegistroRespuestaConsultaRecibidasType: Array_Of_RegistroRespuestaConsultaRecibidasType);
begin
  FRegistroRespuestaConsultaLRFacturasRecibidas := AArray_Of_RegistroRespuestaConsultaRecibidasType;
  FRegistroRespuestaConsultaLRFacturasRecibidas_Specified := True;
end;

function RespuestaConsultaLRFacturasRecibidasType.RegistroRespuestaConsultaLRFacturasRecibidas_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRFacturasRecibidas_Specified;
end;

destructor RespuestaConsultaLROperacionesSegurosType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLROperacionesSeguros)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLROperacionesSeguros[I]);
  System.SetLength(FRegistroRespuestaConsultaLROperacionesSeguros, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLROperacionesSegurosType.SetRegistroRespuestaConsultaLROperacionesSeguros(Index: Integer; const AArray_Of_RegistroRespuestaConsultaOperacionesSegurosType: Array_Of_RegistroRespuestaConsultaOperacionesSegurosType);
begin
  FRegistroRespuestaConsultaLROperacionesSeguros := AArray_Of_RegistroRespuestaConsultaOperacionesSegurosType;
  FRegistroRespuestaConsultaLROperacionesSeguros_Specified := True;
end;

function RespuestaConsultaLROperacionesSegurosType.RegistroRespuestaConsultaLROperacionesSeguros_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLROperacionesSeguros_Specified;
end;

destructor RespuestaConsultaLRAgenciasViajesType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRAgenciasViajes)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRAgenciasViajes[I]);
  System.SetLength(FRegistroRespuestaConsultaLRAgenciasViajes, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRAgenciasViajesType.SetRegistroRespuestaConsultaLRAgenciasViajes(Index: Integer; const AArray_Of_RegistroRespuestaConsultaAgenciasViajesType: Array_Of_RegistroRespuestaConsultaAgenciasViajesType);
begin
  FRegistroRespuestaConsultaLRAgenciasViajes := AArray_Of_RegistroRespuestaConsultaAgenciasViajesType;
  FRegistroRespuestaConsultaLRAgenciasViajes_Specified := True;
end;

function RespuestaConsultaLRAgenciasViajesType.RegistroRespuestaConsultaLRAgenciasViajes_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRAgenciasViajes_Specified;
end;

destructor RespuestaConsultaLRDetOperIntracomunitariasType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRDetOperIntracomunitarias)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRDetOperIntracomunitarias[I]);
  System.SetLength(FRegistroRespuestaConsultaLRDetOperIntracomunitarias, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRDetOperIntracomunitariasType.SetRegistroRespuestaConsultaLRDetOperIntracomunitarias(Index: Integer; const AArray_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType: Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType);
begin
  FRegistroRespuestaConsultaLRDetOperIntracomunitarias := AArray_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType;
  FRegistroRespuestaConsultaLRDetOperIntracomunitarias_Specified := True;
end;

function RespuestaConsultaLRDetOperIntracomunitariasType.RegistroRespuestaConsultaLRDetOperIntracomunitarias_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRDetOperIntracomunitarias_Specified;
end;

destructor RespuestaConsultaLRBienesInversionType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRBienesInversion)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRBienesInversion[I]);
  System.SetLength(FRegistroRespuestaConsultaLRBienesInversion, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRBienesInversionType.SetRegistroRespuestaConsultaLRBienesInversion(Index: Integer; const AArray_Of_RegistroRespuestaConsultaBienesType: Array_Of_RegistroRespuestaConsultaBienesType);
begin
  FRegistroRespuestaConsultaLRBienesInversion := AArray_Of_RegistroRespuestaConsultaBienesType;
  FRegistroRespuestaConsultaLRBienesInversion_Specified := True;
end;

function RespuestaConsultaLRBienesInversionType.RegistroRespuestaConsultaLRBienesInversion_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRBienesInversion_Specified;
end;

destructor RespuestaConsultaLRCobrosMetalicoType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRCobrosMetalico)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRCobrosMetalico[I]);
  System.SetLength(FRegistroRespuestaConsultaLRCobrosMetalico, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRCobrosMetalicoType.SetRegistroRespuestaConsultaLRCobrosMetalico(Index: Integer; const AArray_Of_RegistroRespuestaConsultaCobrosMetalicoType: Array_Of_RegistroRespuestaConsultaCobrosMetalicoType);
begin
  FRegistroRespuestaConsultaLRCobrosMetalico := AArray_Of_RegistroRespuestaConsultaCobrosMetalicoType;
  FRegistroRespuestaConsultaLRCobrosMetalico_Specified := True;
end;

function RespuestaConsultaLRCobrosMetalicoType.RegistroRespuestaConsultaLRCobrosMetalico_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRCobrosMetalico_Specified;
end;

constructor RespuestaConsultaLRFactInformadasAgrupadasClienteType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaConsultaLRFactInformadasAgrupadasClienteType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente[I]);
  System.SetLength(FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRFactInformadasAgrupadasClienteType.SetRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente(Index: Integer; const AArray_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType: Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType);
begin
  FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente := AArray_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType;
  FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente_Specified := True;
end;

function RespuestaConsultaLRFactInformadasAgrupadasClienteType.RegistroRespuestaConsultaLRFactInformadasAgrupadasCliente_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRFactInformadasAgrupadasCliente_Specified;
end;

constructor RespuestaConsultaLRFactInformadasClienteType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaConsultaLRFactInformadasClienteType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroRespuestaConsultaLRFactInformadasCliente)-1 do
    System.SysUtils.FreeAndNil(FRegistroRespuestaConsultaLRFactInformadasCliente[I]);
  System.SetLength(FRegistroRespuestaConsultaLRFactInformadasCliente, 0);
  inherited Destroy;
end;

procedure RespuestaConsultaLRFactInformadasClienteType.SetRegistroRespuestaConsultaLRFactInformadasCliente(Index: Integer; const AArray_Of_RegistroRespuestaConsultaFactInformadasClienteType: Array_Of_RegistroRespuestaConsultaFactInformadasClienteType);
begin
  FRegistroRespuestaConsultaLRFactInformadasCliente := AArray_Of_RegistroRespuestaConsultaFactInformadasClienteType;
  FRegistroRespuestaConsultaLRFactInformadasCliente_Specified := True;
end;

function RespuestaConsultaLRFactInformadasClienteType.RegistroRespuestaConsultaLRFactInformadasCliente_Specified(Index: Integer): boolean;
begin
  Result := FRegistroRespuestaConsultaLRFactInformadasCliente_Specified;
end;

destructor RegistroRespuestaConsultaFactInformadasClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FDatosFacturaInformadaCliente);
  System.SysUtils.FreeAndNil(FCliente);
  System.SysUtils.FreeAndNil(FEstadoFactura);
  inherited Destroy;
end;

destructor LRBajaRecibidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure LRBajaRecibidasType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function LRBajaRecibidasType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

destructor LRBienesInversionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FBienesInversion);
  inherited Destroy;
end;

destructor LRFacturasRecibidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FFacturaRecibida);
  inherited Destroy;
end;

destructor LRfacturasEmitidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FFacturaExpedida);
  inherited Destroy;
end;

destructor LRBajaExpedidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure LRBajaExpedidasType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function LRBajaExpedidasType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

destructor LRBajaBienesInversionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure LRBajaBienesInversionType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function LRBajaBienesInversionType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

destructor LRBajaCobrosMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

destructor LRCobrosMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure LRCobrosMetalicoType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function LRCobrosMetalicoType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

destructor LRAgenciasViajesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure LRAgenciasViajesType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function LRAgenciasViajesType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

destructor LRBajaAgenciasViajesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

destructor RegistroRespuestaConsultaFactInformadasAgrupadasClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FCliente);
  inherited Destroy;
end;

procedure RangoFechaType.SetDesde(Index: Integer; const Afecha: fecha);
begin
  FDesde := Afecha;
  FDesde_Specified := True;
end;

function RangoFechaType.Desde_Specified(Index: Integer): boolean;
begin
  Result := FDesde_Specified;
end;

procedure RangoFechaType.SetHasta(Index: Integer; const Afecha: fecha);
begin
  FHasta := Afecha;
  FHasta_Specified := True;
end;

function RangoFechaType.Hasta_Specified(Index: Integer): boolean;
begin
  Result := FHasta_Specified;
end;

procedure DatosDescuadreContraparteType.SetSumBaseImponibleISP(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
begin
  FSumBaseImponibleISP := AImporteSgn14_2Type;
  FSumBaseImponibleISP_Specified := True;
end;

function DatosDescuadreContraparteType.SumBaseImponibleISP_Specified(Index: Integer): boolean;
begin
  Result := FSumBaseImponibleISP_Specified;
end;

procedure DatosDescuadreContraparteType.SetSumBaseImponible(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
begin
  FSumBaseImponible := AImporteSgn14_2Type;
  FSumBaseImponible_Specified := True;
end;

function DatosDescuadreContraparteType.SumBaseImponible_Specified(Index: Integer): boolean;
begin
  Result := FSumBaseImponible_Specified;
end;

procedure DatosDescuadreContraparteType.SetSumCuota(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
begin
  FSumCuota := AImporteSgn14_2Type;
  FSumCuota_Specified := True;
end;

function DatosDescuadreContraparteType.SumCuota_Specified(Index: Integer): boolean;
begin
  Result := FSumCuota_Specified;
end;

procedure DatosDescuadreContraparteType.SetSumCuotaRecargoEquivalencia(Index: Integer; const AImporteSgn14_2Type: ImporteSgn14_2Type);
begin
  FSumCuotaRecargoEquivalencia := AImporteSgn14_2Type;
  FSumCuotaRecargoEquivalencia_Specified := True;
end;

function DatosDescuadreContraparteType.SumCuotaRecargoEquivalencia_Specified(Index: Integer): boolean;
begin
  Result := FSumCuotaRecargoEquivalencia_Specified;
end;

procedure DatosDescuadreContraparteType.SetImporteTotal(Index: Integer; const AImporteSgn12_2Type: ImporteSgn12_2Type);
begin
  FImporteTotal := AImporteSgn12_2Type;
  FImporteTotal_Specified := True;
end;

function DatosDescuadreContraparteType.ImporteTotal_Specified(Index: Integer): boolean;
begin
  Result := FImporteTotal_Specified;
end;

destructor LROperacionesSegurosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure LROperacionesSegurosType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function LROperacionesSegurosType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

destructor ClavePaginacion3.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

destructor RespuestaOperacionesSegurosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FEntidadSucedida);
  inherited Destroy;
end;

procedure RespuestaOperacionesSegurosType.SetEntidadSucedida(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FEntidadSucedida := APersonaFisicaJuridicaUnicaESType;
  FEntidadSucedida_Specified := True;
end;

function RespuestaOperacionesSegurosType.EntidadSucedida_Specified(Index: Integer): boolean;
begin
  Result := FEntidadSucedida_Specified;
end;

procedure RegistroDuplicadoType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType: ErrorDetalleType);
begin
  FCodigoErrorRegistro := AErrorDetalleType;
  FCodigoErrorRegistro_Specified := True;
end;

function RegistroDuplicadoType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RegistroDuplicadoType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RegistroDuplicadoType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

destructor RespuestaComunitariaBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure RespuestaComunitariaBajaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaComunitariaBajaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaComunitariaBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaComunitariaBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaComunitariaBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaComunitariaBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaComunitariaBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaComunitariaBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor RespuestaAgenciasViajesBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

procedure RespuestaAgenciasViajesBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaAgenciasViajesBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaAgenciasViajesBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaAgenciasViajesBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaAgenciasViajesBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaAgenciasViajesBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor RespuestaMetalicoBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

procedure RespuestaMetalicoBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaMetalicoBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaMetalicoBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaMetalicoBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaMetalicoBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaMetalicoBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor RespuestaExpedidaBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure RespuestaExpedidaBajaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaExpedidaBajaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaExpedidaBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaExpedidaBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaExpedidaBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaExpedidaBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaExpedidaBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaExpedidaBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor RespuestaBienBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure RespuestaBienBajaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaBienBajaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaBienBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaBienBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaBienBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaBienBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaBienBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaBienBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor RespuestaRecibidaBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure RespuestaRecibidaBajaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaRecibidaBajaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaRecibidaBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaRecibidaBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaRecibidaBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaRecibidaBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaRecibidaBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaRecibidaBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

destructor RespuestaOperacionesSegurosBajaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

procedure RespuestaOperacionesSegurosBajaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaOperacionesSegurosBajaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaOperacionesSegurosBajaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaOperacionesSegurosBajaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaOperacionesSegurosBajaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaOperacionesSegurosBajaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure EstadoFactura2Type.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType3: ErrorDetalleType3);
begin
  FCodigoErrorRegistro := AErrorDetalleType3;
  FCodigoErrorRegistro_Specified := True;
end;

function EstadoFactura2Type.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure EstadoFactura2Type.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function EstadoFactura2Type.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

destructor RespuestaAgenciasViajesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaAgenciasViajesType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaAgenciasViajesType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaAgenciasViajesType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaAgenciasViajesType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaAgenciasViajesType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaAgenciasViajesType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaAgenciasViajesType.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaAgenciasViajesType.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaMetalicoType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaMetalicoType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaMetalicoType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaMetalicoType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaMetalicoType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaMetalicoType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaMetalicoType.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaMetalicoType.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaOperacionesSegurosType2.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaOperacionesSegurosType2.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaOperacionesSegurosType2.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaOperacionesSegurosType2.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaOperacionesSegurosType2.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaOperacionesSegurosType2.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaOperacionesSegurosType2.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaOperacionesSegurosType2.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaOperacionesSegurosType2.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaExpedidaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaExpedidaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaExpedidaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaExpedidaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaExpedidaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaExpedidaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaExpedidaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaExpedidaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaExpedidaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaExpedidaType.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaExpedidaType.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaRecibidaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaRecibidaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaRecibidaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaRecibidaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaRecibidaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaRecibidaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaRecibidaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaRecibidaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaRecibidaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaRecibidaType.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaRecibidaType.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaBienType.Destroy;
begin
  System.SysUtils.FreeAndNil(FPeriodoLiquidacion);
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaBienType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaBienType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaBienType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaBienType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaBienType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaBienType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaBienType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaBienType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaBienType.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaBienType.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaComunitariaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FRegistroDuplicado);
  inherited Destroy;
end;

procedure RespuestaComunitariaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function RespuestaComunitariaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

procedure RespuestaComunitariaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaComunitariaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaComunitariaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaComunitariaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

procedure RespuestaComunitariaType.SetCSV(Index: Integer; const Astring: string);
begin
  FCSV := Astring;
  FCSV_Specified := True;
end;

function RespuestaComunitariaType.CSV_Specified(Index: Integer): boolean;
begin
  Result := FCSV_Specified;
end;

procedure RespuestaComunitariaType.SetRegistroDuplicado(Index: Integer; const ARegistroDuplicadoType: RegistroDuplicadoType);
begin
  FRegistroDuplicado := ARegistroDuplicadoType;
  FRegistroDuplicado_Specified := True;
end;

function RespuestaComunitariaType.RegistroDuplicado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroDuplicado_Specified;
end;

destructor RespuestaRecibidaPagoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure RespuestaRecibidaPagoType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType2: ErrorDetalleType2);
begin
  FCodigoErrorRegistro := AErrorDetalleType2;
  FCodigoErrorRegistro_Specified := True;
end;

function RespuestaRecibidaPagoType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure RespuestaRecibidaPagoType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function RespuestaRecibidaPagoType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

destructor LRFiltroAgenciasViajesType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroAgenciasViajesType.SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
begin
  FContraparte := AContraparteConsultaType;
  FContraparte_Specified := True;
end;

function LRFiltroAgenciasViajesType.Contraparte_Specified(Index: Integer): boolean;
begin
  Result := FContraparte_Specified;
end;

procedure LRFiltroAgenciasViajesType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroAgenciasViajesType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroAgenciasViajesType.SetRegistroModificado(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FRegistroModificado := AFacturaModificadaType;
  FRegistroModificado_Specified := True;
end;

function LRFiltroAgenciasViajesType.RegistroModificado_Specified(Index: Integer): boolean;
begin
  Result := FRegistroModificado_Specified;
end;

procedure LRFiltroAgenciasViajesType.SetClavePaginacion(Index: Integer; const AClavePaginacion2: ClavePaginacion2);
begin
  FClavePaginacion := AClavePaginacion2;
  FClavePaginacion_Specified := True;
end;

function LRFiltroAgenciasViajesType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroDetOperIntracomunitariasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroDetOperIntracomunitariasType.SetIDFactura(Index: Integer; const AIDFacturaConsulta1Type: IDFacturaConsulta1Type);
begin
  FIDFactura := AIDFacturaConsulta1Type;
  FIDFactura_Specified := True;
end;

function LRFiltroDetOperIntracomunitariasType.IDFactura_Specified(Index: Integer): boolean;
begin
  Result := FIDFactura_Specified;
end;

procedure LRFiltroDetOperIntracomunitariasType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroDetOperIntracomunitariasType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroDetOperIntracomunitariasType.SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FFacturaModificada := AFacturaModificadaType;
  FFacturaModificada_Specified := True;
end;

function LRFiltroDetOperIntracomunitariasType.FacturaModificada_Specified(Index: Integer): boolean;
begin
  Result := FFacturaModificada_Specified;
end;

procedure LRFiltroDetOperIntracomunitariasType.SetClavePaginacion(Index: Integer; const AIDFacturaComunitariaType: IDFacturaComunitariaType);
begin
  FClavePaginacion := AIDFacturaComunitariaType;
  FClavePaginacion_Specified := True;
end;

function LRFiltroDetOperIntracomunitariasType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroBienInversionType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroBienInversionType.SetIDFactura(Index: Integer; const AIDFacturaConsulta1Type: IDFacturaConsulta1Type);
begin
  FIDFactura := AIDFacturaConsulta1Type;
  FIDFactura_Specified := True;
end;

function LRFiltroBienInversionType.IDFactura_Specified(Index: Integer): boolean;
begin
  Result := FIDFactura_Specified;
end;

procedure LRFiltroBienInversionType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroBienInversionType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroBienInversionType.SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FFacturaModificada := AFacturaModificadaType;
  FFacturaModificada_Specified := True;
end;

function LRFiltroBienInversionType.FacturaModificada_Specified(Index: Integer): boolean;
begin
  Result := FFacturaModificada_Specified;
end;

procedure LRFiltroBienInversionType.SetIdentificacionBien(Index: Integer; const ATextMax40Type: TextMax40Type);
begin
  FIdentificacionBien := ATextMax40Type;
  FIdentificacionBien_Specified := True;
end;

function LRFiltroBienInversionType.IdentificacionBien_Specified(Index: Integer): boolean;
begin
  Result := FIdentificacionBien_Specified;
end;

procedure LRFiltroBienInversionType.SetClavePaginacion(Index: Integer; const AClavePaginacionBienType: ClavePaginacionBienType);
begin
  FClavePaginacion := AClavePaginacionBienType;
  FClavePaginacion_Specified := True;
end;

function LRFiltroBienInversionType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroOperacionesSegurosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroOperacionesSegurosType.SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
begin
  FContraparte := AContraparteConsultaType;
  FContraparte_Specified := True;
end;

function LRFiltroOperacionesSegurosType.Contraparte_Specified(Index: Integer): boolean;
begin
  Result := FContraparte_Specified;
end;

procedure LRFiltroOperacionesSegurosType.SetClaveOperacion(Index: Integer; const AClaveOperacionType: ClaveOperacionType);
begin
  FClaveOperacion := AClaveOperacionType;
  FClaveOperacion_Specified := True;
end;

function LRFiltroOperacionesSegurosType.ClaveOperacion_Specified(Index: Integer): boolean;
begin
  Result := FClaveOperacion_Specified;
end;

procedure LRFiltroOperacionesSegurosType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroOperacionesSegurosType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroOperacionesSegurosType.SetOperacionModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FOperacionModificada := AFacturaModificadaType;
  FOperacionModificada_Specified := True;
end;

function LRFiltroOperacionesSegurosType.OperacionModificada_Specified(Index: Integer): boolean;
begin
  Result := FOperacionModificada_Specified;
end;

procedure LRFiltroOperacionesSegurosType.SetClavePaginacion(Index: Integer; const AClavePaginacion3: ClavePaginacion3);
begin
  FClavePaginacion := AClavePaginacion3;
  FClavePaginacion_Specified := True;
end;

function LRFiltroOperacionesSegurosType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroCobrosMetalicoType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroCobrosMetalicoType.SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
begin
  FContraparte := AContraparteConsultaType;
  FContraparte_Specified := True;
end;

function LRFiltroCobrosMetalicoType.Contraparte_Specified(Index: Integer): boolean;
begin
  Result := FContraparte_Specified;
end;

procedure LRFiltroCobrosMetalicoType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroCobrosMetalicoType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroCobrosMetalicoType.SetCobroModificado(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FCobroModificado := AFacturaModificadaType;
  FCobroModificado_Specified := True;
end;

function LRFiltroCobrosMetalicoType.CobroModificado_Specified(Index: Integer): boolean;
begin
  Result := FCobroModificado_Specified;
end;

procedure LRFiltroCobrosMetalicoType.SetClavePaginacion(Index: Integer; const AClavePaginacion: ClavePaginacion);
begin
  FClavePaginacion := AClavePaginacion;
  FClavePaginacion_Specified := True;
end;

function LRFiltroCobrosMetalicoType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

procedure EstadoFacturaImputacionType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
begin
  FEstadoCuadre := AEstadoCuadreType;
  FEstadoCuadre_Specified := True;
end;

function EstadoFacturaImputacionType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

procedure EstadoFacturaImputacionType.SetTimestampEstadoCuadre(Index: Integer; const ATimestamp: Timestamp);
begin
  FTimestampEstadoCuadre := ATimestamp;
  FTimestampEstadoCuadre_Specified := True;
end;

function EstadoFacturaImputacionType.TimestampEstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FTimestampEstadoCuadre_Specified;
end;

procedure EstadoFacturaType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
begin
  FEstadoCuadre := AEstadoCuadreType;
  FEstadoCuadre_Specified := True;
end;

function EstadoFacturaType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

procedure EstadoFacturaType.SetTimestampEstadoCuadre(Index: Integer; const ATimestamp: Timestamp);
begin
  FTimestampEstadoCuadre := ATimestamp;
  FTimestampEstadoCuadre_Specified := True;
end;

function EstadoFacturaType.TimestampEstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FTimestampEstadoCuadre_Specified;
end;

procedure EstadoFacturaType.SetCodigoErrorRegistro(Index: Integer; const AErrorDetalleType3: ErrorDetalleType3);
begin
  FCodigoErrorRegistro := AErrorDetalleType3;
  FCodigoErrorRegistro_Specified := True;
end;

function EstadoFacturaType.CodigoErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FCodigoErrorRegistro_Specified;
end;

procedure EstadoFacturaType.SetDescripcionErrorRegistro(Index: Integer; const ATextMax500Type: TextMax500Type);
begin
  FDescripcionErrorRegistro := ATextMax500Type;
  FDescripcionErrorRegistro_Specified := True;
end;

function EstadoFacturaType.DescripcionErrorRegistro_Specified(Index: Integer): boolean;
begin
  Result := FDescripcionErrorRegistro_Specified;
end;

destructor LRBajaRegistroLROperacionesSegurosType.Destroy;
begin
  System.SysUtils.FreeAndNil(FContraparte);
  inherited Destroy;
end;

destructor SuministroLRDetOperacionIntracomunitaria.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRDetOperacionIntracomunitaria)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRDetOperacionIntracomunitaria[I]);
  System.SetLength(FRegistroLRDetOperacionIntracomunitaria, 0);
  inherited Destroy;
end;

destructor BajaLRDetOperacionIntracomunitaria.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaDetOperacionIntracomunitaria)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaDetOperacionIntracomunitaria[I]);
  System.SetLength(FRegistroLRBajaDetOperacionIntracomunitaria, 0);
  inherited Destroy;
end;

destructor BajaLROperacionesSeguros.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaOperacionesSeguros)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaOperacionesSeguros[I]);
  System.SetLength(FRegistroLRBajaOperacionesSeguros, 0);
  inherited Destroy;
end;

destructor BajaLRCobrosMetalico.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaCobrosMetalico)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaCobrosMetalico[I]);
  System.SetLength(FRegistroLRBajaCobrosMetalico, 0);
  inherited Destroy;
end;

destructor SuministroLROperacionesSeguros.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLROperacionesSeguros)-1 do
    System.SysUtils.FreeAndNil(FRegistroLROperacionesSeguros[I]);
  System.SetLength(FRegistroLROperacionesSeguros, 0);
  inherited Destroy;
end;

destructor LRFiltroEmitidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FFechaCuadre);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroEmitidasType.SetIDFactura(Index: Integer; const AIDFacturaConsulta2Type: IDFacturaConsulta2Type);
begin
  FIDFactura := AIDFacturaConsulta2Type;
  FIDFactura_Specified := True;
end;

function LRFiltroEmitidasType.IDFactura_Specified(Index: Integer): boolean;
begin
  Result := FIDFactura_Specified;
end;

procedure LRFiltroEmitidasType.SetContraparte(Index: Integer; const AContraparteConsultaType: ContraparteConsultaType);
begin
  FContraparte := AContraparteConsultaType;
  FContraparte_Specified := True;
end;

function LRFiltroEmitidasType.Contraparte_Specified(Index: Integer): boolean;
begin
  Result := FContraparte_Specified;
end;

procedure LRFiltroEmitidasType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroEmitidasType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroEmitidasType.SetFechaCuadre(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaCuadre := ARangoFechaPresentacionType;
  FFechaCuadre_Specified := True;
end;

function LRFiltroEmitidasType.FechaCuadre_Specified(Index: Integer): boolean;
begin
  Result := FFechaCuadre_Specified;
end;

procedure LRFiltroEmitidasType.SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FFacturaModificada := AFacturaModificadaType;
  FFacturaModificada_Specified := True;
end;

function LRFiltroEmitidasType.FacturaModificada_Specified(Index: Integer): boolean;
begin
  Result := FFacturaModificada_Specified;
end;

procedure LRFiltroEmitidasType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
begin
  FEstadoCuadre := AEstadoCuadreType;
  FEstadoCuadre_Specified := True;
end;

function LRFiltroEmitidasType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

procedure LRFiltroEmitidasType.SetClavePaginacion(Index: Integer; const AIDFacturaExpedidaBCType: IDFacturaExpedidaBCType);
begin
  FClavePaginacion := AIDFacturaExpedidaBCType;
  FClavePaginacion_Specified := True;
end;

function LRFiltroEmitidasType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroFactInformadasAgrupadasProveedorType.Destroy;
begin
  System.SysUtils.FreeAndNil(FProveedor);
  inherited Destroy;
end;

procedure LRFiltroFactInformadasAgrupadasProveedorType.SetProveedor(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FProveedor := APersonaFisicaJuridicaUnicaESType;
  FProveedor_Specified := True;
end;

function LRFiltroFactInformadasAgrupadasProveedorType.Proveedor_Specified(Index: Integer): boolean;
begin
  Result := FProveedor_Specified;
end;

procedure LRFiltroFactInformadasAgrupadasProveedorType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
begin
  FEstadoCuadre := AEstadoCuadreImputacionType;
  FEstadoCuadre_Specified := True;
end;

function LRFiltroFactInformadasAgrupadasProveedorType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

destructor LRFiltroRecibidasType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FFechaPresentacion);
  System.SysUtils.FreeAndNil(FFechaCuadre);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroRecibidasType.SetIDFactura(Index: Integer; const AIDFacturaConsulta1Type: IDFacturaConsulta1Type);
begin
  FIDFactura := AIDFacturaConsulta1Type;
  FIDFactura_Specified := True;
end;

function LRFiltroRecibidasType.IDFactura_Specified(Index: Integer): boolean;
begin
  Result := FIDFactura_Specified;
end;

procedure LRFiltroRecibidasType.SetFechaPresentacion(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaPresentacion := ARangoFechaPresentacionType;
  FFechaPresentacion_Specified := True;
end;

function LRFiltroRecibidasType.FechaPresentacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaPresentacion_Specified;
end;

procedure LRFiltroRecibidasType.SetFechaCuadre(Index: Integer; const ARangoFechaPresentacionType: RangoFechaPresentacionType);
begin
  FFechaCuadre := ARangoFechaPresentacionType;
  FFechaCuadre_Specified := True;
end;

function LRFiltroRecibidasType.FechaCuadre_Specified(Index: Integer): boolean;
begin
  Result := FFechaCuadre_Specified;
end;

procedure LRFiltroRecibidasType.SetFacturaModificada(Index: Integer; const AFacturaModificadaType: FacturaModificadaType);
begin
  FFacturaModificada := AFacturaModificadaType;
  FFacturaModificada_Specified := True;
end;

function LRFiltroRecibidasType.FacturaModificada_Specified(Index: Integer): boolean;
begin
  Result := FFacturaModificada_Specified;
end;

procedure LRFiltroRecibidasType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreType: EstadoCuadreType);
begin
  FEstadoCuadre := AEstadoCuadreType;
  FEstadoCuadre_Specified := True;
end;

function LRFiltroRecibidasType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

procedure LRFiltroRecibidasType.SetClavePaginacion(Index: Integer; const AIDFacturaRecibidaNombreBCType: IDFacturaRecibidaNombreBCType);
begin
  FClavePaginacion := AIDFacturaRecibidaNombreBCType;
  FClavePaginacion_Specified := True;
end;

function LRFiltroRecibidasType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroFactInformadasProveedorType.Destroy;
begin
  System.SysUtils.FreeAndNil(FProveedor);
  System.SysUtils.FreeAndNil(FFechaExpedicion);
  System.SysUtils.FreeAndNil(FFechaOperacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroFactInformadasProveedorType.SetProveedor(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FProveedor := APersonaFisicaJuridicaUnicaESType;
  FProveedor_Specified := True;
end;

function LRFiltroFactInformadasProveedorType.Proveedor_Specified(Index: Integer): boolean;
begin
  Result := FProveedor_Specified;
end;

procedure LRFiltroFactInformadasProveedorType.SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisor := ATextoIDFacturaType;
  FNumSerieFacturaEmisor_Specified := True;
end;

function LRFiltroFactInformadasProveedorType.NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisor_Specified;
end;

procedure LRFiltroFactInformadasProveedorType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
begin
  FEstadoCuadre := AEstadoCuadreImputacionType;
  FEstadoCuadre_Specified := True;
end;

function LRFiltroFactInformadasProveedorType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

procedure LRFiltroFactInformadasProveedorType.SetFechaExpedicion(Index: Integer; const ARangoFechaType: RangoFechaType);
begin
  FFechaExpedicion := ARangoFechaType;
  FFechaExpedicion_Specified := True;
end;

function LRFiltroFactInformadasProveedorType.FechaExpedicion_Specified(Index: Integer): boolean;
begin
  Result := FFechaExpedicion_Specified;
end;

procedure LRFiltroFactInformadasProveedorType.SetFechaOperacion(Index: Integer; const ARangoFechaType: RangoFechaType);
begin
  FFechaOperacion := ARangoFechaType;
  FFechaOperacion_Specified := True;
end;

function LRFiltroFactInformadasProveedorType.FechaOperacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaOperacion_Specified;
end;

procedure LRFiltroFactInformadasProveedorType.SetClavePaginacion(Index: Integer; const AClavePaginacionProveedorType: ClavePaginacionProveedorType);
begin
  FClavePaginacion := AClavePaginacionProveedorType;
  FClavePaginacion_Specified := True;
end;

function LRFiltroFactInformadasProveedorType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroFactInformadasClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FCliente);
  System.SysUtils.FreeAndNil(FFechaExpedicion);
  System.SysUtils.FreeAndNil(FFechaOperacion);
  System.SysUtils.FreeAndNil(FClavePaginacion);
  inherited Destroy;
end;

procedure LRFiltroFactInformadasClienteType.SetCliente(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FCliente := APersonaFisicaJuridicaUnicaESType;
  FCliente_Specified := True;
end;

function LRFiltroFactInformadasClienteType.Cliente_Specified(Index: Integer): boolean;
begin
  Result := FCliente_Specified;
end;

procedure LRFiltroFactInformadasClienteType.SetNumSerieFacturaEmisor(Index: Integer; const ATextoIDFacturaType: TextoIDFacturaType);
begin
  FNumSerieFacturaEmisor := ATextoIDFacturaType;
  FNumSerieFacturaEmisor_Specified := True;
end;

function LRFiltroFactInformadasClienteType.NumSerieFacturaEmisor_Specified(Index: Integer): boolean;
begin
  Result := FNumSerieFacturaEmisor_Specified;
end;

procedure LRFiltroFactInformadasClienteType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
begin
  FEstadoCuadre := AEstadoCuadreImputacionType;
  FEstadoCuadre_Specified := True;
end;

function LRFiltroFactInformadasClienteType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

procedure LRFiltroFactInformadasClienteType.SetFechaExpedicion(Index: Integer; const ARangoFechaType: RangoFechaType);
begin
  FFechaExpedicion := ARangoFechaType;
  FFechaExpedicion_Specified := True;
end;

function LRFiltroFactInformadasClienteType.FechaExpedicion_Specified(Index: Integer): boolean;
begin
  Result := FFechaExpedicion_Specified;
end;

procedure LRFiltroFactInformadasClienteType.SetFechaOperacion(Index: Integer; const ARangoFechaType: RangoFechaType);
begin
  FFechaOperacion := ARangoFechaType;
  FFechaOperacion_Specified := True;
end;

function LRFiltroFactInformadasClienteType.FechaOperacion_Specified(Index: Integer): boolean;
begin
  Result := FFechaOperacion_Specified;
end;

procedure LRFiltroFactInformadasClienteType.SetClavePaginacion(Index: Integer; const AClavePaginacionClienteType: ClavePaginacionClienteType);
begin
  FClavePaginacion := AClavePaginacionClienteType;
  FClavePaginacion_Specified := True;
end;

function LRFiltroFactInformadasClienteType.ClavePaginacion_Specified(Index: Integer): boolean;
begin
  Result := FClavePaginacion_Specified;
end;

destructor LRFiltroFactInformadasAgrupadasClienteType.Destroy;
begin
  System.SysUtils.FreeAndNil(FCliente);
  inherited Destroy;
end;

procedure LRFiltroFactInformadasAgrupadasClienteType.SetCliente(Index: Integer; const APersonaFisicaJuridicaUnicaESType: PersonaFisicaJuridicaUnicaESType);
begin
  FCliente := APersonaFisicaJuridicaUnicaESType;
  FCliente_Specified := True;
end;

function LRFiltroFactInformadasAgrupadasClienteType.Cliente_Specified(Index: Integer): boolean;
begin
  Result := FCliente_Specified;
end;

procedure LRFiltroFactInformadasAgrupadasClienteType.SetEstadoCuadre(Index: Integer; const AEstadoCuadreImputacionType: EstadoCuadreImputacionType);
begin
  FEstadoCuadre := AEstadoCuadreImputacionType;
  FEstadoCuadre_Specified := True;
end;

function LRFiltroFactInformadasAgrupadasClienteType.EstadoCuadre_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCuadre_Specified;
end;

constructor BajaLRFacturasEmitidas.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor BajaLRFacturasEmitidas.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaExpedidas)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaExpedidas[I]);
  System.SetLength(FRegistroLRBajaExpedidas, 0);
  inherited Destroy;
end;

destructor SuministroLRFacturasRecibidas.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRFacturasRecibidas)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRFacturasRecibidas[I]);
  System.SetLength(FRegistroLRFacturasRecibidas, 0);
  inherited Destroy;
end;

constructor SuministroLRFacturasEmitidas.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor SuministroLRFacturasEmitidas.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRFacturasEmitidas)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRFacturasEmitidas[I]);
  System.SetLength(FRegistroLRFacturasEmitidas, 0);
  inherited Destroy;
end;

destructor LROperacionIntracomunitariaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  System.SysUtils.FreeAndNil(FContraparte);
  System.SysUtils.FreeAndNil(FOperacionIntracomunitaria);
  inherited Destroy;
end;

destructor LRBajaOperacionIntracomunitariaType.Destroy;
begin
  System.SysUtils.FreeAndNil(FIDFactura);
  inherited Destroy;
end;

procedure LRBajaOperacionIntracomunitariaType.SetRefExterna(Index: Integer; const ATextMax60Type: TextMax60Type);
begin
  FRefExterna := ATextMax60Type;
  FRefExterna_Specified := True;
end;

function LRBajaOperacionIntracomunitariaType.RefExterna_Specified(Index: Integer): boolean;
begin
  Result := FRefExterna_Specified;
end;

destructor BajaLRFacturasRecibidas.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaRecibidas)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaRecibidas[I]);
  System.SetLength(FRegistroLRBajaRecibidas, 0);
  inherited Destroy;
end;

destructor BajaLRAgenciasViajes.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaAgenciasViajes)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaAgenciasViajes[I]);
  System.SetLength(FRegistroLRBajaAgenciasViajes, 0);
  inherited Destroy;
end;

destructor SuministroLRCobrosMetalico.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRCobrosMetalico)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRCobrosMetalico[I]);
  System.SetLength(FRegistroLRCobrosMetalico, 0);
  inherited Destroy;
end;

destructor SuministroLRAgenciasViajes.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRAgenciasViajes)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRAgenciasViajes[I]);
  System.SetLength(FRegistroLRAgenciasViajes, 0);
  inherited Destroy;
end;

destructor SuministroLRBienesInversion.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBienesInversion)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBienesInversion[I]);
  System.SetLength(FRegistroLRBienesInversion, 0);
  inherited Destroy;
end;

destructor BajaLRBienesInversion.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRegistroLRBajaBienesInversion)-1 do
    System.SysUtils.FreeAndNil(FRegistroLRBajaBienesInversion[I]);
  System.SetLength(FRegistroLRBajaBienesInversion, 0);
  inherited Destroy;
end;

procedure RegisterTypeProc0;
begin
  RemClassRegistry.RegisterXSInfo(TypeInfo(EstadoEnvioType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'EstadoEnvioType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaInmueblesAdicionalesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaInmueblesAdicionalesType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaCobrosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaCobrosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EstadoRegistroSIIType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'EstadoRegistroSIIType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaPagosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaPagosType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaDetOperIntracomunitariasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaDetOperIntracomunitariasType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaCobrosMetalicoType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaBienesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaBienesType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaOperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaOperacionesSegurosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(IndicadorPaginacionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'IndicadorPaginacionType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ResultadoConsultaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'ResultadoConsultaType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaAgenciasViajesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FacturasRectificadas), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturasRectificadas');
  RemClassRegistry.RegisterXSInfo(TypeInfo(DatosInmueble), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'DatosInmueble');
  RemClassRegistry.RegisterXSClass(TipoDesglose, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'TipoDesglose');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FacturasAgrupadas), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturasAgrupadas');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FacturaARType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturaARType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(DatosInmueble2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'DatosInmueble2', 'DatosInmueble');
  RemClassRegistry.RegisterXSClass(TipoDesglose2, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'TipoDesglose2', 'TipoDesglose');
  RemClassRegistry.RegisterXSClass(RespuestaDetOperIntracomunitariaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaDetOperIntracomunitariaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaRecibidasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaRecibidasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaFactInformadasClienteType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaFactInformadasClienteType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaEmitidasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaEmitidasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaDetOperIntracomunitariasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaFactInformadasAgrupadasClienteType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaBienesType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaBienesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaCobrosMetalicoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaCobrosMetalicoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LROperacionesSegurosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LROperacionesSegurosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaRegistroLROperacionesSegurosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaRegistroLROperacionesSegurosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaAgenciasViajesType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaAgenciasViajesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRCobrosMetalicoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRCobrosMetalicoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LROperacionIntracomunitariaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LROperacionIntracomunitariaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaOperacionIntracomunitariaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaOperacionIntracomunitariaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaAgenciasViajesType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaAgenciasViajesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaOperacionesSegurosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaOperacionesSegurosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaExpedidaBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaExpedidaBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaBienType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaBienType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaComunitariaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaComunitariaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaMetalicoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaMetalicoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaMetalicoBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaMetalicoBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaAgenciasViajesBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaAgenciasViajesBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaOperacionesSegurosBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaOperacionesSegurosBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaRecibidaBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaRecibidaBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaBienBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaBienBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaComunitariaBajaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaComunitariaBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaRecibidaPagoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaRecibidaPagoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaCobrosMetalicoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaCobrosMetalicoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaAgenciasViajesType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaAgenciasViajesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CountryMiembroType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CountryMiembroType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ClaveDeclarado), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClaveDeclarado');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TipoOperacion), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoOperacion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaPagosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaPagosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaExpedidaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaExpedidaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RespuestaRecibidaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'Array_Of_RespuestaRecibidaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaOperacionesSegurosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaOperacionesSegurosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaCobrosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaCobrosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'Array_Of_RegistroRespuestaConsultaInmueblesAdicionalesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(MedioPagoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'MedioPagoType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MedioPagoType), '_01', '01');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MedioPagoType), '_02', '02');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MedioPagoType), '_03', '03');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MedioPagoType), '_04', '04');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MedioPagoType), '_05', '05');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EstadoRegistroType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'EstadoRegistroType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaExpedidasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaExpedidasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRFacturasRecibidasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRFacturasRecibidasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaRecibidasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaRecibidasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRfacturasEmitidasType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRfacturasEmitidasType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBienesInversionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBienesInversionType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRBajaBienesInversionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRBajaBienesInversionType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LRAgenciasViajesType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'Array_Of_LRAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(TipoDesglose3, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoDesglose3', 'TipoDesglose');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CompletaSinDestinatarioType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CompletaSinDestinatarioType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(VariosDestinatariosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'VariosDestinatariosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CuponType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CuponType');
  RemClassRegistry.RegisterXSClass(TipoSinDesgloseType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoSinDesgloseType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(DesgloseIVA), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DesgloseIVA');
  RemClassRegistry.RegisterXSInfo(TypeInfo(InversionSujetoPasivo), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'InversionSujetoPasivo');
  RemClassRegistry.RegisterXSClass(TipoConDesgloseType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoConDesgloseType');
  RemClassRegistry.RegisterXSClass(DesgloseFacturaRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DesgloseFacturaRecibidasType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(DesgloseFacturaRecibidasType), 'InversionSujetoPasivo', '[ArrayItemName="DetalleIVA"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(DesgloseFacturaRecibidasType), 'DesgloseIVA', '[ArrayItemName="DetalleIVA"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(IdOperacionesTrascendenciaTributariaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IdOperacionesTrascendenciaTributariaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_01', '01');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_02', '02');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_03', '03');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_04', '04');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_05', '05');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_06', '06');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_07', '07');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_08', '08');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_09', '09');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_10', '10');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_11', '11');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_12', '12');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_13', '13');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_14', '14');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_15', '15');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(IdOperacionesTrascendenciaTributariaType), '_16', '16');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FacturasAgrupadas2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'FacturasAgrupadas2', 'FacturasAgrupadas');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FacturasRectificadas2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'FacturasRectificadas2', 'FacturasRectificadas');
  RemClassRegistry.RegisterXSInfo(TypeInfo(SimplificadaCualificadaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'SimplificadaCualificadaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EmitidaPorTercerosType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'EmitidaPorTercerosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(DatosInmueble3), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DatosInmueble3', 'DatosInmueble');
  RemClassRegistry.RegisterXSInfo(TypeInfo(MacrodatoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'MacrodatoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Exenta), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'Exenta');
  RemClassRegistry.RegisterXSClass(TipoSinDesglosePrestacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoSinDesglosePrestacionType');
  RemClassRegistry.RegisterXSClass(SujetaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'SujetaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SujetaType), 'Exenta', '[ArrayItemName="DetalleExenta"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(DesgloseIVA2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DesgloseIVA2', 'DesgloseIVA');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Exenta2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'Exenta2', 'Exenta');
  RemClassRegistry.RegisterXSClass(SujetaPrestacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'SujetaPrestacionType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SujetaPrestacionType), 'Exenta', '[ArrayItemName="DetalleExenta"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TipoOperacionSujetaNoExentaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoOperacionSujetaNoExentaType');
  RemClassRegistry.RegisterXSClass(NoExenta, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'NoExenta');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(NoExenta), 'DesgloseIVA', '[ArrayItemName="DetalleIVA"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(DesgloseIVA3), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DesgloseIVA3', 'DesgloseIVA');
  RemClassRegistry.RegisterXSClass(NoExenta2, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'NoExenta2', 'NoExenta');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(NoExenta2), 'DesgloseIVA', '[ArrayItemName="DetalleIVA"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CausaExencionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CausaExencionType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(SituacionInmuebleType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'SituacionInmuebleType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SituacionInmuebleType), '_1', '1');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SituacionInmuebleType), '_2', '2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SituacionInmuebleType), '_3', '3');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SituacionInmuebleType), '_4', '4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PersonaFisicaJuridicaIDTypeType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PersonaFisicaJuridicaIDTypeType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonaFisicaJuridicaIDTypeType), '_02', '02');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonaFisicaJuridicaIDTypeType), '_03', '03');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonaFisicaJuridicaIDTypeType), '_04', '04');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonaFisicaJuridicaIDTypeType), '_05', '05');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonaFisicaJuridicaIDTypeType), '_06', '06');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonaFisicaJuridicaIDTypeType), '_07', '07');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CountryType2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CountryType2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CountryType2), 'DO_', 'DO');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CountryType2), 'IN_', 'IN');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CountryType2), 'IS_', 'IS');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CountryType2), 'AS_', 'AS');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CountryType2), 'TO_', 'TO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ReferenciaCatastralType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ReferenciaCatastralType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax20Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax20Type');
  RemClassRegistry.RegisterXSClass(DatosInmuebleType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DatosInmuebleType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax500Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax500Type');
end;

procedure RegisterTypeProc1;
begin
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax34Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax34Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PlazoOperacion), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PlazoOperacion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax40Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax40Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax150Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax150Type');
  RemClassRegistry.RegisterXSClass(RespuestaComunBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaComunBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaIMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaIMetalicoType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaCobrosMetalico, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaCobrosMetalico');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaOComunitariasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaOComunitariasType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaDetOperacionesIntracomunitarias, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaDetOperacionesIntracomunitarias');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaAgenciasViajes, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaAgenciasViajes');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaFRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaFRecibidasType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaFacturasRecibidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaFacturasRecibidas');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaFEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaFEmitidasType');
  RemClassRegistry.RegisterSerializeOptions(RespuestaLRBajaFEmitidasType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaFacturasEmitidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaFacturasEmitidas');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaBienesInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaBienesInversionType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaBienesInversion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaBienesInversion');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaOperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaOperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaOperacionesSeguros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaOperacionesSeguros');
  RemClassRegistry.RegisterXSClass(RespuestaLRBajaFRecibidasPagosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBajaFRecibidasPagosType');
  RemClassRegistry.RegisterXSClass(RespuestaComunAltaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaComunAltaType');
  RemClassRegistry.RegisterXSClass(RespuestaLRIMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRIMetalicoType');
  RemClassRegistry.RegisterXSClass(RespuestaLRCobrosMetalico, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRCobrosMetalico');
  RemClassRegistry.RegisterXSClass(RespuestaLROComunitariasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLROComunitariasType');
  RemClassRegistry.RegisterXSClass(RespuestaLRDetOperacionesIntracomunitarias, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRDetOperacionesIntracomunitarias');
  RemClassRegistry.RegisterXSClass(RespuestaLRBienesInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBienesInversionType');
  RemClassRegistry.RegisterXSClass(RespuestaLRBienesInversion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRBienesInversion');
  RemClassRegistry.RegisterXSClass(RespuestaLROperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLROperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(RespuestaLROperacionesSeguros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLROperacionesSeguros');
  RemClassRegistry.RegisterXSClass(RespuestaLRAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(RespuestaLRAgenciasViajes, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRAgenciasViajes');
  RemClassRegistry.RegisterXSClass(RespuestaLRFEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRFEmitidasType');
  RemClassRegistry.RegisterSerializeOptions(RespuestaLRFEmitidasType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RespuestaLRFacturasEmitidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRFacturasEmitidas');
  RemClassRegistry.RegisterXSClass(RespuestaLRFRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRFRecibidasType');
  RemClassRegistry.RegisterXSClass(RespuestaLRFacturasRecibidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaLRFacturasRecibidas');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Timestamp), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'Timestamp');
  RemClassRegistry.RegisterXSInfo(TypeInfo(NIFType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'NIFType');
  RemClassRegistry.RegisterXSClass(DatosPresentacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DatosPresentacionType');
  RemClassRegistry.RegisterXSClass(DatosPresentacion2Type, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DatosPresentacion2Type');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TipoPeriodoType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TipoPeriodoType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_01', '01');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_02', '02');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_03', '03');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_04', '04');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_05', '05');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_06', '06');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_07', '07');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_08', '08');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_09', '09');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_10', '10');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_11', '11');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_12', '12');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_0A', '0A');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_1T', '1T');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_2T', '2T');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_3T', '3T');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TipoPeriodoType), '_4T', '4T');
  RemClassRegistry.RegisterXSClass(RegistroSiiImputacion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'RegistroSiiImputacion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(YearType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'YearType');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion2, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion2', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion3, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion3', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion4, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion4', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion5, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion5', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion6, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion6', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion7, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion7', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion8, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'PeriodoLiquidacion8', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion9, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'PeriodoLiquidacion9', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion10, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'PeriodoLiquidacion10', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(RegistroSii, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'RegistroSii');
  RemClassRegistry.RegisterXSClass(PeriodoLiquidacion11, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PeriodoLiquidacion11', 'PeriodoLiquidacion');
  RemClassRegistry.RegisterXSClass(ConsultaInformacion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ConsultaInformacion');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaFacturaPagosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaFacturaPagosType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaFacturaCobrosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaFacturaCobrosType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaInmueblesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaInmueblesType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaInmueblesAdicionalesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaInmueblesAdicionalesType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaInmueblesAdicionales, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaInmueblesAdicionales');
  RemClassRegistry.RegisterXSClass(SuministroInformacionBaja, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'SuministroInformacionBaja');
  RemClassRegistry.RegisterXSClass(SuministroInformacion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'SuministroInformacion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ClaveTipoComunicacionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClaveTipoComunicacionType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(VersionSiiType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'VersionSiiType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(VersionSiiType), '_1_1', '1.1');
  RemClassRegistry.RegisterXSClass(CabeceraConsultaSii, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CabeceraConsultaSii');
  RemClassRegistry.RegisterXSClass(CabeceraSii, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CabeceraSii');
  RemClassRegistry.RegisterXSClass(CabeceraSiiBaja, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CabeceraSiiBaja');
  RemClassRegistry.RegisterXSClass(ConsultaInformacionCliente, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ConsultaInformacionCliente');
  RemClassRegistry.RegisterXSClass(CabeceraConsultaSiiCliente, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'CabeceraConsultaSiiCliente');
  RemClassRegistry.RegisterXSClass(PeriodoImputacion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PeriodoImputacion');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura2, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura2', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ClaveTipoFacturaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClaveTipoFacturaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ClaveTipoRectificativaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClaveTipoRectificativaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ClaveTipoRectificativaType), '_', ' ');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura3, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura3', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSInfo(TypeInfo(RegPrevioGGEEoREDEMEoCompetenciaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'RegPrevioGGEEoREDEMEoCompetenciaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fecha), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'fecha');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax15Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax15Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax120Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax120Type');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura4, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura4', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSClass(PersonaFisicaJuridicaESType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PersonaFisicaJuridicaESType');
  RemClassRegistry.RegisterXSClass(PersonaFisicaJuridicaUnicaESType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PersonaFisicaJuridicaUnicaESType');
  RemClassRegistry.RegisterXSClass(ContraparteConsultaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ContraparteConsultaType');
  RemClassRegistry.RegisterXSClass(PersonaFisicaJuridicaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'PersonaFisicaJuridicaType');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura5, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura5', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura6, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura6', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura7, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura7', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura8, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura8', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura9, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura9', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextMax60Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextMax60Type');
  RemClassRegistry.RegisterXSClass(OperacionIntracomunitariaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'OperacionIntracomunitariaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Tipo2_2Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'Tipo2_2Type', 'Tipo2.2Type');
  RemClassRegistry.RegisterXSClass(IDEmisorFactura10, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDEmisorFactura10', 'IDEmisorFactura');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TextoIDFacturaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'TextoIDFacturaType');
  RemClassRegistry.RegisterXSClass(IDFacturaImputacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaImputacionType');
  RemClassRegistry.RegisterXSClass(IDFacturaARType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaARType');
  RemClassRegistry.RegisterXSClass(IDFacturaExpedidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaExpedidaType');
  RemClassRegistry.RegisterXSClass(ClavePaginacionClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClavePaginacionClienteType');
  RemClassRegistry.RegisterXSClass(IDFacturaExpedidaBCType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaExpedidaBCType');
  RemClassRegistry.RegisterXSClass(IDFacturaConsulta2Type, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaConsulta2Type');
end;

procedure RegisterTypeProc2;
begin
  RemClassRegistry.RegisterXSClass(IDFacturaRecibidaNombreBCType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaRecibidaNombreBCType');
  RemClassRegistry.RegisterXSClass(IDFacturaConsulta1Type, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaConsulta1Type');
  RemClassRegistry.RegisterXSClass(ClavePaginacionBienType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClavePaginacionBienType');
  RemClassRegistry.RegisterXSClass(IDFacturaRecibidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaRecibidaType');
  RemClassRegistry.RegisterXSClass(ClavePaginacionProveedorType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClavePaginacionProveedorType');
  RemClassRegistry.RegisterXSClass(IDFacturaComunitariaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDFacturaComunitariaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ImporteSgn12_2Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ImporteSgn12_2Type', 'ImporteSgn12.2Type');
  RemClassRegistry.RegisterXSClass(FacturaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'FacturaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaType), 'FacturasAgrupadas', '[ArrayItemName="IDFacturaAgrupada"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaType), 'FacturasRectificadas', '[ArrayItemName="IDFacturaRectificada"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaType), 'FacturaSimplificadaArticulos7_2_7_3', '[ExtName="FacturaSimplificadaArticulos7.2_7.3"]');
  RemClassRegistry.RegisterXSClass(DetalleIVAEmitidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DetalleIVAEmitidaType');
  RemClassRegistry.RegisterXSClass(FacturaRecibidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'FacturaRecibidaType');
  RemClassRegistry.RegisterXSClass(DetalleExentaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DetalleExentaType');
  RemClassRegistry.RegisterXSClass(DetalleIVAEmitidaPrestacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DetalleIVAEmitidaPrestacionType');
  RemClassRegistry.RegisterXSClass(NoSujetaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'NoSujetaType');
  RemClassRegistry.RegisterXSClass(DetalleIVARecibidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DetalleIVARecibidaType');
  RemClassRegistry.RegisterXSClass(FacturaExpedidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'FacturaExpedidaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaExpedidaType), 'DatosInmueble', '[ArrayItemName="DetalleInmueble"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaExpedidaType), 'FacturaSinIdentifDestinatarioAritculo6_1_d', '[ExtName="FacturaSinIdentifDestinatarioAritculo6.1.d"]');
  RemClassRegistry.RegisterXSClass(DesgloseRectificacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DesgloseRectificacionType');
  RemClassRegistry.RegisterXSClass(DetalleIVARecibida2Type, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DetalleIVARecibida2Type');
  RemClassRegistry.RegisterXSClass(DatosPagoCobroType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'DatosPagoCobroType');
  RemClassRegistry.RegisterXSClass(BienDeInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'BienDeInversionType');
  RemClassRegistry.RegisterXSClass(RespuestaCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaCobrosMetalicoType');
  RemClassRegistry.RegisterXSClass(FacturaRespuestaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturaRespuestaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaType), 'FacturasAgrupadas', '[ArrayItemName="IDFacturaAgrupada"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaType), 'FacturasRectificadas', '[ArrayItemName="IDFacturaRectificada"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaType), 'FacturaSimplificadaArticulos7_2_7_3', '[ExtName="FacturaSimplificadaArticulos7.2_7.3"]');
  RemClassRegistry.RegisterXSClass(FacturaRespuestaInformadaProveedorType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturaRespuestaInformadaProveedorType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaInformadaProveedorType), 'DatosInmueble', '[ArrayItemName="DetalleInmueble"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaInformadaProveedorType), 'FacturaSinIdentifDestinatarioAritculo6_1_d', '[ExtName="FacturaSinIdentifDestinatarioAritculo6.1.d"]');
  RemClassRegistry.RegisterXSClass(FacturaRespuestaInformadaClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturaRespuestaInformadaClienteType');
  RemClassRegistry.RegisterXSClass(FacturaRespuestaExpedidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturaRespuestaExpedidaType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaExpedidaType), 'DatosInmueble', '[ArrayItemName="DetalleInmueble"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FacturaRespuestaExpedidaType), 'FacturaSinIdentifDestinatarioAritculo6_1_d', '[ExtName="FacturaSinIdentifDestinatarioAritculo6.1.d"]');
  RemClassRegistry.RegisterXSClass(FacturaRespuestaRecibidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'FacturaRespuestaRecibidaType');
  RemClassRegistry.RegisterXSClass(IDOtroType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'IDOtroType');
  RemClassRegistry.RegisterXSClass(RangoFechaPresentacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'RangoFechaPresentacionType');
  RemClassRegistry.RegisterXSClass(LRConsultaBienesInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaBienesInversionType');
  RemClassRegistry.RegisterXSClass(LRConsultaDetOperIntracomunitariasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaDetOperIntracomunitariasType');
  RemClassRegistry.RegisterXSClass(ConsultaLRFactInformadasAgrupadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRFactInformadasAgrupadasClienteType');
  RemClassRegistry.RegisterSerializeOptions(ConsultaLRFactInformadasAgrupadasClienteType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(LRConsultaEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaEmitidasType');
  RemClassRegistry.RegisterSerializeOptions(LRConsultaEmitidasType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ConsultaLRFactInformadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRFactInformadasClienteType');
  RemClassRegistry.RegisterSerializeOptions(ConsultaLRFactInformadasClienteType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(LRConsultaCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaCobrosMetalicoType');
  RemClassRegistry.RegisterXSClass(ConsultaPagosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaPagosType');
  RemClassRegistry.RegisterXSClass(ConsultaInmueblesAdicionalesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaInmueblesAdicionalesType');
  RemClassRegistry.RegisterXSClass(ConsultaCobrosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaCobrosType');
  RemClassRegistry.RegisterXSClass(LRConsultaAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(LRConsultaLROperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaLROperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(ClavePaginacion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ClavePaginacion');
  RemClassRegistry.RegisterXSClass(LRFiltroInmueblesAdicionalesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroInmueblesAdicionalesType');
  RemClassRegistry.RegisterXSClass(LRConsultaRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRConsultaRecibidasType');
  RemClassRegistry.RegisterXSClass(LRFiltroCobrosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroCobrosType');
  RemClassRegistry.RegisterXSClass(LRFiltroPagosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroPagosType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaPagosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaPagosType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaPagos, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaPagos');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaCobrosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaCobrosType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaCobros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaCobros');
  RemClassRegistry.RegisterXSClass(ClavePaginacion2, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ClavePaginacion2', 'ClavePaginacion');
  RemClassRegistry.RegisterXSClass(ConsultaLRFacturasRecibidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRFacturasRecibidas');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaRecibidasType');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaEmitidasType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasEmitidasType');
  RemClassRegistry.RegisterSerializeOptions(RespuestaConsultaLRFacturasEmitidasType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasEmitidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasEmitidas');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasRecibidasType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasRecibidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasRecibidas');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLROperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLROperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLROperacionesSeguros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLROperacionesSeguros');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRAgenciasViajes, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRAgenciasViajes');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRDetOperIntracomunitariasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRDetOperIntracomunitariasType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRDetOperIntracomunitarias, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRDetOperIntracomunitarias');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRBienesInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRBienesInversionType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRBienesInversion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRBienesInversion');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRCobrosMetalicoType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRCobrosMetalico, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRCobrosMetalico');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasAgrupadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasAgrupadasClienteType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFactInformadasAgrupadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFactInformadasAgrupadasClienteType');
  RemClassRegistry.RegisterSerializeOptions(RespuestaConsultaLRFactInformadasAgrupadasClienteType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFactInformadasAgrupadasCliente, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFactInformadasAgrupadasCliente');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFacturasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFacturasClienteType');
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFactInformadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFactInformadasClienteType');
  RemClassRegistry.RegisterSerializeOptions(RespuestaConsultaLRFactInformadasClienteType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RespuestaConsultaLRFactInformadasCliente, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaConsultaLRFactInformadasCliente');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaFactInformadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaFactInformadasClienteType');
  RemClassRegistry.RegisterXSClass(ConsultaLRBienesInversion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRBienesInversion');
  RemClassRegistry.RegisterXSClass(ConsultaLRDetOperIntracomunitarias, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRDetOperIntracomunitarias');
  RemClassRegistry.RegisterXSClass(ConsultaLRFactInformadasAgrupadasCliente, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRFactInformadasAgrupadasCliente');
  RemClassRegistry.RegisterXSClass(ConsultaLRFacturasEmitidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRFacturasEmitidas');
  RemClassRegistry.RegisterXSClass(ConsultaLRFactInformadasCliente, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRFactInformadasCliente');
  RemClassRegistry.RegisterXSClass(ConsultaLRCobrosMetalico, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRCobrosMetalico');
  RemClassRegistry.RegisterXSClass(ConsultaPagos, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaPagos');
  RemClassRegistry.RegisterXSClass(ConsultaLROperacionesSeguros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLROperacionesSeguros');
  RemClassRegistry.RegisterXSClass(ConsultaInmueblesAdicionales, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaInmueblesAdicionales');
  RemClassRegistry.RegisterXSClass(ConsultaLRAgenciasViajes, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaLRAgenciasViajes');
  RemClassRegistry.RegisterXSClass(ConsultaCobros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ConsultaCobros');
  RemClassRegistry.RegisterXSClass(LRBajaRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaRecibidasType');
  RemClassRegistry.RegisterXSClass(LRBienesInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBienesInversionType');
  RemClassRegistry.RegisterXSClass(LRFacturasRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRFacturasRecibidasType');
  RemClassRegistry.RegisterXSClass(LRfacturasEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRfacturasEmitidasType');
  RemClassRegistry.RegisterXSClass(LRBajaExpedidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaExpedidasType');
  RemClassRegistry.RegisterXSClass(LRBajaBienesInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaBienesInversionType');
  RemClassRegistry.RegisterXSClass(LRBajaCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaCobrosMetalicoType');
  RemClassRegistry.RegisterXSClass(LRCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRCobrosMetalicoType');
  RemClassRegistry.RegisterXSClass(LRAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(LRBajaAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaAgenciasViajesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Tipo10Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'Tipo10Type');
  RemClassRegistry.RegisterXSClass(RegistroRespuestaConsultaFactInformadasAgrupadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RegistroRespuestaConsultaFactInformadasAgrupadasClienteType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EstadoRegistroSIIType2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'EstadoRegistroSIIType2', 'EstadoRegistroSIIType');
  RemClassRegistry.RegisterXSClass(RangoFechaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'RangoFechaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ImporteSgn14_2Type), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ImporteSgn14_2Type', 'ImporteSgn14.2Type');
  RemClassRegistry.RegisterXSClass(DatosDescuadreContraparteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'DatosDescuadreContraparteType');
end;

procedure RegisterTypeProc3;
begin
  RemClassRegistry.RegisterXSInfo(TypeInfo(ClaveOperacionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ClaveOperacionType');
  RemClassRegistry.RegisterXSClass(LROperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LROperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(ClavePaginacion3, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'ClavePaginacion3', 'ClavePaginacion');
  RemClassRegistry.RegisterXSClass(RespuestaOperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'RespuestaOperacionesSegurosType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ErrorDetalleType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'ErrorDetalleType');
  RemClassRegistry.RegisterXSClass(RegistroDuplicadoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'RegistroDuplicadoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ErrorDetalleType2), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'ErrorDetalleType2', 'ErrorDetalleType');
  RemClassRegistry.RegisterXSClass(RespuestaComunitariaBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaComunitariaBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaAgenciasViajesBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaAgenciasViajesBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaMetalicoBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaMetalicoBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaExpedidaBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaExpedidaBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaBienBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaBienBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaRecibidaBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaRecibidaBajaType');
  RemClassRegistry.RegisterXSClass(RespuestaOperacionesSegurosBajaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaOperacionesSegurosBajaType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ErrorDetalleType3), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'ErrorDetalleType3', 'ErrorDetalleType');
  RemClassRegistry.RegisterXSClass(EstadoFactura2Type, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'EstadoFactura2Type');
  RemClassRegistry.RegisterXSClass(RespuestaAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(RespuestaMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaMetalicoType');
  RemClassRegistry.RegisterXSClass(RespuestaOperacionesSegurosType2, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaOperacionesSegurosType2', 'RespuestaOperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(RespuestaExpedidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaExpedidaType');
  RemClassRegistry.RegisterXSClass(RespuestaRecibidaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaRecibidaType');
  RemClassRegistry.RegisterXSClass(RespuestaBienType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaBienType');
  RemClassRegistry.RegisterXSClass(RespuestaComunitariaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaComunitariaType');
  RemClassRegistry.RegisterXSClass(RespuestaRecibidaPagoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaSuministro.xsd', 'RespuestaRecibidaPagoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EstadoCuadreImputacionType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'EstadoCuadreImputacionType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreImputacionType), '_3', '3');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreImputacionType), '_4', '4');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreImputacionType), '_5', '5');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FacturaModificadaType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'FacturaModificadaType');
  RemClassRegistry.RegisterXSClass(LRFiltroAgenciasViajesType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroAgenciasViajesType');
  RemClassRegistry.RegisterXSClass(LRFiltroDetOperIntracomunitariasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroDetOperIntracomunitariasType');
  RemClassRegistry.RegisterXSClass(LRFiltroBienInversionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroBienInversionType');
  RemClassRegistry.RegisterXSClass(LRFiltroOperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroOperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(LRFiltroCobrosMetalicoType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroCobrosMetalicoType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EstadoCuadreType), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd', 'EstadoCuadreType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreType), '_1', '1');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreType), '_2', '2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreType), '_3', '3');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreType), '_4', '4');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(EstadoCuadreType), '_5', '5');
  RemClassRegistry.RegisterXSClass(EstadoFacturaImputacionType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'EstadoFacturaImputacionType');
  RemClassRegistry.RegisterXSClass(EstadoFacturaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/RespuestaConsultaLR.xsd', 'EstadoFacturaType');
  RemClassRegistry.RegisterXSClass(LRBajaRegistroLROperacionesSegurosType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaRegistroLROperacionesSegurosType');
  RemClassRegistry.RegisterXSClass(SuministroLRDetOperacionIntracomunitaria, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLRDetOperacionIntracomunitaria');
  RemClassRegistry.RegisterXSClass(BajaLRDetOperacionIntracomunitaria, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLRDetOperacionIntracomunitaria');
  RemClassRegistry.RegisterXSClass(BajaLROperacionesSeguros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLROperacionesSeguros');
  RemClassRegistry.RegisterXSClass(BajaLRCobrosMetalico, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLRCobrosMetalico');
  RemClassRegistry.RegisterXSClass(SuministroLROperacionesSeguros, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLROperacionesSeguros');
  RemClassRegistry.RegisterXSClass(LRFiltroEmitidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroEmitidasType');
  RemClassRegistry.RegisterXSClass(LRFiltroFactInformadasAgrupadasProveedorType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroFactInformadasAgrupadasProveedorType');
  RemClassRegistry.RegisterXSClass(LRFiltroRecibidasType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroRecibidasType');
  RemClassRegistry.RegisterXSClass(LRFiltroFactInformadasProveedorType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroFactInformadasProveedorType');
  RemClassRegistry.RegisterXSClass(LRFiltroFactInformadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroFactInformadasClienteType');
  RemClassRegistry.RegisterXSClass(LRFiltroFactInformadasAgrupadasClienteType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/ConsultaLR.xsd', 'LRFiltroFactInformadasAgrupadasClienteType');
  RemClassRegistry.RegisterXSClass(BajaLRFacturasEmitidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLRFacturasEmitidas');
  RemClassRegistry.RegisterSerializeOptions(BajaLRFacturasEmitidas, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(SuministroLRFacturasRecibidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLRFacturasRecibidas');
  RemClassRegistry.RegisterXSClass(SuministroLRFacturasEmitidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLRFacturasEmitidas');
  RemClassRegistry.RegisterSerializeOptions(SuministroLRFacturasEmitidas, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(LROperacionIntracomunitariaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LROperacionIntracomunitariaType');
  RemClassRegistry.RegisterXSClass(LRBajaOperacionIntracomunitariaType, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'LRBajaOperacionIntracomunitariaType');
  RemClassRegistry.RegisterXSClass(BajaLRFacturasRecibidas, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLRFacturasRecibidas');
  RemClassRegistry.RegisterXSClass(BajaLRAgenciasViajes, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLRAgenciasViajes');
  RemClassRegistry.RegisterXSClass(SuministroLRCobrosMetalico, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLRCobrosMetalico');
  RemClassRegistry.RegisterXSClass(SuministroLRAgenciasViajes, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLRAgenciasViajes');
  RemClassRegistry.RegisterXSClass(SuministroLRBienesInversion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'SuministroLRBienesInversion');
  RemClassRegistry.RegisterXSClass(BajaLRBienesInversion, 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd', 'BajaLRBienesInversion');
end;

procedure RegisterTypeProc4;
begin
end;

initialization
  { siiSOAP }
  InvRegistry.RegisterInterface(TypeInfo(siiSOAP), 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroFactEmitidas.wsdl', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(siiSOAP), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(siiSOAP), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(siiSOAP), ioLiteral);
  RegisterTypeProc0;
  RegisterTypeProc1;
  RegisterTypeProc2;
  RegisterTypeProc3;

end.
