{$ALIGN OFF} {$OPTIMIZATION OFF}

unit ParametrosFacturacionIntf;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     DB,
     SessionIntf;

const
     CLSID_ParametrosFacturacion : TGuid = '{6C0DAADB-460A-49DF-BABE-FAA19C2A8A50}';

type
  TTipoSeleccionAlbaranes = ( tsDocumento, tsFecha, tsRelacion );
  TTipoFicheroExportacion = ( tfePDF, tfePDFFirma, tfeCamerFactura, tfeFacturaE, tfeFacturaEFirma );

  IParametrosFacturacion = interface( InxInvokable )
    ['{5054B152-BA94-4FEB-8B0C-127B8124BA1C}']

    function LoadFromReader(aReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;

    function GetClassID: TnxGuid;
    function GetSerieFinal: String;
    function GetSerieInicial: String;
    function GetSeleccionPropietario : SmallInt;
    function GetPropietarioFinal: String;
    function GetPropietarioInicial: String;
    function GetCodigoPropietario: String;
    function GetSeleccionNroDocumento : SmallInt;
    function GetNroDocumentoFinal: LongInt;
    function GetNroDocumentoInicial: LongInt;
    function GetCopiaPropietario: Boolean;
    function GetCorrecto: Boolean;
    function GetDesglosarRegAuxilar: Boolean;
    function GetEjercicioFactura: SmallInt;
    function GetEnviarPorCorreo: Boolean;
    function GetExcluirCorreo: Boolean;
    function GetUnaFacturaPorAlbaran: Boolean;
    function GetExcluirEnviados: Boolean;
    function GetFechaFacturacion: TDateTime;
    function GetFechaFinal: TDateTime;
    function GetFechaInicial: TDateTime;
    function GetSeleccionFormaCobro: SmallInt;
    function GetFormaCobroFinal: String;
    function GetFormaCobroInicial: String;
    function GetFormato: SmallInt;
    function GetGenerarFichero: Boolean;
    function GetSeleccionGrupoPropietario: SmallInt;
    function GetGrupoPropietarioFinal: String;
    function GetGrupoPropietarioInicial: String;
    function GetImporteMinimo: Decimal;
    function GetImportePendiente: Decimal;
    function GetNroCopias: SmallInt;
    function GetNroDocumento: LongInt;
    function GetNroFacturaFinal: LongInt;
    function GetNroFacturaInicial: LongInt;
    function GetUnaSolaFactura : Boolean;
    function GetPrimerNroFactura: LongInt;
    function GetSeleccionRegAuxiliar: SmallInt;
    function GetRegAuxiliarFinal: String;
    function GetRegAuxiliarInicial: String;
    function GetSerie: String;
    function GetTipoFichero: TTipoFicheroExportacion;
    function GetTipoSeleccion: TTipoSeleccionAlbaranes;
    function GetSeleccionVendedor: SmallInt;
    function GetVendedorFinal: String;
    function GetVendedorInicial: String;
    procedure SetSerieFinal(const Value: String);
    procedure SetSerieInicial(const Value: String);
    procedure SetSeleccionPropietario(const Value: SmallInt);
    procedure SetPropietarioFinal(const Value: String);
    procedure SetPropietarioInicial(const Value: String);
    procedure SetSeleccionNroDocumento(const Value: SmallInt);
    procedure SetNroDocumentoFinal(const Value: LongInt);
    procedure SetNroDocumentoInicial(const Value: LongInt);
    procedure SetCodigoPropietario(const Value: String);
    procedure SetCopiaPropietario(const Value: Boolean);
    procedure SetCorrecto(const Value: Boolean);
    procedure SetDesglosarRegAuxilar(const Value: Boolean);
    procedure SetEjercicioFactura(const Value: SmallInt);
    procedure SetEnviarPorCorreo(const Value: Boolean);
    procedure SetExcluirCorreo(const Value: Boolean);
    procedure SetUnaFacturaPorAlbaran(const Value: Boolean);
    procedure SetExcluirEnviados(const Value: Boolean);
    procedure SetFechaFacturacion(const Value: TDateTime);
    procedure SetFechaFinal(const Value: TDateTime);
    procedure SetFechaInicial(const Value: TDateTime);
    procedure SetSeleccionFormaCobro(const Value: SmallInt);
    procedure SetFormaCobroFinal(const Value: String);
    procedure SetFormaCobroInicial(const Value: String);
    procedure SetFormato(const Value: SmallInt);
    procedure SetGenerarFichero(const Value: Boolean);
    procedure SetSeleccionGrupoPropietario(const Value: SmallInt);
    procedure SetGrupoPropietarioFinal(const Value: String);
    procedure SetGrupoPropietarioInicial(const Value: String);
    procedure SetImporteMinimo(const Value: Decimal);
    procedure SetImportePendiente(const Value: Decimal);
    procedure SetNroCopias(const Value: SmallInt);
    procedure SetNroDocumento(const Value: LongInt);
    procedure SetNroFacturaFinal(const Value: LongInt);
    procedure SetNroFacturaInicial(const Value: LongInt);
    procedure SetUnaSolaFactura(const Value: Boolean);
    procedure SetPrimerNroFactura(const Value: LongInt);
    procedure SetSeleccionRegAuxiliar(const Value: SmallInt);
    procedure SetRegAuxiliarFinal(const Value: String);
    procedure SetRegAuxiliarInicial(const Value: String);
    procedure SetSerie(const Value: String);
    procedure SetTipoFichero(const Value: TTipoFicheroExportacion);
    procedure SetTipoSeleccion(const Value: TTipoSeleccionAlbaranes);
    procedure SetSeleccionVendedor(const Value: SmallInt);
    procedure SetVendedorFinal(const Value: String);
    procedure SetVendedorInicial(const Value: String);

    property TipoSeleccion : TTipoSeleccionAlbaranes read GetTipoSeleccion write SetTipoSeleccion;
    property EjercicioFactura : SmallInt  read GetEjercicioFactura write SetEjercicioFactura;
    property Serie : String read GetSerie write SetSerie;
    property NroDocumento : LongInt read GetNroDocumento write SetNroDocumento;
    property FechaInicial : TDateTime read GetFechaInicial write SetFechaInicial;
    property FechaFinal : TDateTime read GetFechaFinal write SetFechaFinal;
    property FechaFacturacion : TDateTime read GetFechaFacturacion write SetFechaFacturacion;
    property UnaSolaFactura : Boolean read GetUnaSolaFactura write SetUnaSolaFactura;
    property PrimerNroFactura : LongInt read GetPrimerNroFactura write SetPrimerNroFactura;
    property ImportePendiente : Decimal read GetImportePendiente write SetImportePendiente;
    property ImporteMinimo : Decimal read GetImporteMinimo write SetImporteMinimo;
    property SerieInicial : String read GetSerieInicial write SetSerieInicial;
    property SerieFinal : String read GetSerieFinal write SetSerieFinal;
    property SeleccionPropietario : SmallInt read GetSeleccionPropietario write SetSeleccionPropietario;
    property PropietarioInicial : String read GetPropietarioInicial write SetPropietarioInicial;
    property PropietarioFinal : String read GetPropietarioFinal write SetPropietarioFinal;
    property SeleccionNroDocumento : SmallInt read GetSeleccionNroDocumento write SetSeleccionNroDocumento;
    property NroDocumentoInicial : LongInt read GetNroDocumentoInicial write SetNroDocumentoInicial;
    property NroDocumentoFinal : LongInt read GetNroDocumentoFinal write SetNroDocumentoFinal;
    property SeleccionGrupoPropietario : SmallInt read GetSeleccionGrupoPropietario write SetSeleccionGrupoPropietario;
    property GrupoPropietarioInicial : String read GetGrupoPropietarioInicial write SetGrupoPropietarioInicial;
    property GrupoPropietarioFinal : String read GetGrupoPropietarioFinal write SetGrupoPropietarioFinal;
    property SeleccionVendedor : SmallInt read GetSeleccionVendedor write SetSeleccionVendedor;
    property VendedorInicial : String read GetVendedorInicial write SetVendedorInicial;
    property VendedorFinal : String read GetVendedorFinal write SetVendedorFinal;
    property SeleccionFormaCobro : SmallInt read GetSeleccionFormaCobro write SetSeleccionFormaCobro;
    property FormaCobroInicial : String read GetFormaCobroInicial write SetFormaCobroInicial;
    property FormaCobroFinal : String read GetFormaCobroFinal write SetFormaCobroFinal;
    property CodigoPropietario : String read GetCodigoPropietario write SetCodigoPropietario;
    property SeleccionRegAuxiliar : SmallInt read GetSeleccionRegAuxiliar write SetSeleccionRegAuxiliar;
    property RegAuxiliarInicial : String read GetRegAuxiliarInicial write SetRegAuxiliarInicial;
    property RegAuxiliarFinal : String read GetRegAuxiliarFinal write SetRegAuxiliarFinal;
    property CopiaPropietario : Boolean read GetCopiaPropietario write SetCopiaPropietario;
    property Correcto : Boolean read GetCorrecto write SetCorrecto;
    property NroCopias : SmallInt read GetNroCopias write SetNroCopias;
    property NroFacturaInicial : LongInt read GetNroFacturaInicial write SetNroFacturaInicial;
    property NroFacturaFinal : LongInt read GetNroFacturaFinal write SetNroFacturaFinal;
    property DesglosarRegAuxilar : Boolean read GetDesglosarRegAuxilar write SetDesglosarRegAuxilar;
    property Formato : SmallInt read GetFormato write SetFormato;
    property GenerarFichero : Boolean read GetGenerarFichero write SetGenerarFichero;
    property TipoFichero : TTipoFicheroExportacion read GetTipoFichero write SetTipoFichero;
    property EnviarPorCorreo : Boolean read GetEnviarPorCorreo write SetEnviarPorCorreo;
    property ExcluirEnviados : Boolean read GetExcluirEnviados write SetExcluirEnviados;
    property ExcluirCorreo : Boolean read GetExcluirCorreo write SetExcluirCorreo;
    property UnaFacturaPorAlbaran : Boolean read GetUnaFacturaPorAlbaran write SetUnaFacturaPorAlbaran;
  end;

  TParametrosFacturacion = class( TnxClass, InxRemoteableClass, IParametrosFacturacion )
  private

    FTipoSeleccion : TTipoSeleccionAlbaranes;
    FEjercicioFactura : SmallInt;                  // Solo en el caso de impresión y selección por número de documento
    FSerie : String;
    FNroDocumento : LongInt;
    FFechaInicial,
    FFechaFinal,
    FFechaFacturacion : TDateTime;
    FUnaSolaFactura : Boolean;
    FPrimerNroFactura : LongInt;
    FImportePendiente,
    FImporteMinimo : Decimal;
    FSerieInicial,
    FSerieFinal : String;
    FSeleccionPropietario : SmallInt;
    FPropietarioInicial,
    FPropietarioFinal : String;
    FSeleccionNroDocumento : SmallInt;
    FNroDocumentoInicial,
    FNroDocumentoFinal : LongInt;
    FSeleccionGrupoPropietario : SmallInt;
    FGrupoPropietarioInicial,
    FGrupoPropietarioFinal : String;
    FSeleccionVendedor : SmallInt;
    FVendedorInicial,
    FVendedorFinal : String;
    FSeleccionFormaCobro : SmallInt;
    FFormaCobroInicial,
    FFormaCobroFinal : String;
    FCodigoPropietario : String;
    FSeleccionRegAuxiliar: SmallInt;
    FRegAuxiliarInicial,
    FRegAuxiliarFinal : String;
    FCopiaPropietario : Boolean;
    FNroCopias : SmallInt;
    FNroFacturaInicial,                             // Son el primer y último nº de las facturas a imprimir
    FNroFacturaFinal : LongInt;
    FDesglosarRegAuxilar : Boolean;
    FFormato : SmallInt;                            // El contenido del registro debe estar en informeExterno.dmInformeExternoRec
    FGenerarFichero : Boolean;
    FTipoFichero : TTipoFicheroExportacion;         // 0 = PDF, 1 = PDF con firma y 2 = Factura-e CSV
    FEnviarPorCorreo,
    FExcluirEnviados,
    FExcluirCorreo,
    FUnaFacturaPorAlbaran,
    FCorrecto : Boolean;                            // Si el proceso ha finalizado correctamente

    function LoadFromReader(aReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;

    function GetClassID: TnxGuid;
    function GetSerieFinal: String;
    function GetSerieInicial: String;
    function GetSeleccionPropietario : SmallInt;
    function GetPropietarioFinal: String;
    function GetPropietarioInicial: String;
    function GetCodigoPropietario: String;
    function GetSeleccionNroDocumento : SmallInt;
    function GetNroDocumentoFinal: LongInt;
    function GetNroDocumentoInicial: LongInt;
    function GetCopiaPropietario: Boolean;
    function GetCorrecto : Boolean;
    function GetDesglosarRegAuxilar: Boolean;
    function GetEjercicioFactura: SmallInt;
    function GetEnviarPorCorreo: Boolean;
    function GetExcluirCorreo: Boolean;
    function GetUnaFacturaPorAlbaran: Boolean;
    function GetExcluirEnviados: Boolean;
    function GetFechaFacturacion: TDateTime;
    function GetFechaFinal: TDateTime;
    function GetFechaInicial: TDateTime;
    function GetSeleccionFormaCobro: SmallInt;
    function GetFormaCobroFinal: String;
    function GetFormaCobroInicial: String;
    function GetFormato: SmallInt;
    function GetGenerarFichero: Boolean;
    function GetSeleccionGrupoPropietario: SmallInt;
    function GetGrupoPropietarioFinal: String;
    function GetGrupoPropietarioInicial: String;
    function GetImporteMinimo: Decimal;
    function GetImportePendiente: Decimal;
    function GetNroCopias: SmallInt;
    function GetNroDocumento: LongInt;
    function GetNroFacturaFinal: LongInt;
    function GetNroFacturaInicial: LongInt;
    function GetUnaSolaFactura : Boolean;
    function GetPrimerNroFactura: LongInt;
    function GetSeleccionRegAuxiliar: SmallInt;
    function GetRegAuxiliarFinal: String;
    function GetRegAuxiliarInicial: String;
    function GetSerie: String;
    function GetTipoFichero: TTipoFicheroExportacion;
    function GetTipoSeleccion: TTipoSeleccionAlbaranes;
    function GetSeleccionVendedor: SmallInt;
    function GetVendedorFinal: String;
    function GetVendedorInicial: String;
    procedure SetSerieFinal(const Value: String);
    procedure SetSerieInicial(const Value: String);
    procedure SetSeleccionPropietario(const Value: SmallInt);
    procedure SetPropietarioFinal(const Value: String);
    procedure SetPropietarioInicial(const Value: String);
    procedure SetSeleccionNroDocumento(const Value: SmallInt);
    procedure SetNroDocumentoFinal(const Value: LongInt);
    procedure SetNroDocumentoInicial(const Value: LongInt);
    procedure SetCodigoPropietario(const Value: String);
    procedure SetCopiaPropietario(const Value: Boolean);
    procedure SetCorrecto(const Value: Boolean);
    procedure SetDesglosarRegAuxilar(const Value: Boolean);
    procedure SetEjercicioFactura(const Value: SmallInt);
    procedure SetEnviarPorCorreo(const Value: Boolean);
    procedure SetExcluirCorreo(const Value: Boolean);
    procedure SetUnaFacturaPorAlbaran(const Value: Boolean);
    procedure SetExcluirEnviados(const Value: Boolean);
    procedure SetFechaFacturacion(const Value: TDateTime);
    procedure SetFechaFinal(const Value: TDateTime);
    procedure SetFechaInicial(const Value: TDateTime);
    procedure SetSeleccionFormaCobro(const Value: SmallInt);
    procedure SetFormaCobroFinal(const Value: String);
    procedure SetFormaCobroInicial(const Value: String);
    procedure SetFormato(const Value: SmallInt);
    procedure SetGenerarFichero(const Value: Boolean);
    procedure SetSeleccionGrupoPropietario(const Value: SmallInt);
    procedure SetGrupoPropietarioFinal(const Value: String);
    procedure SetGrupoPropietarioInicial(const Value: String);
    procedure SetImporteMinimo(const Value: Decimal);
    procedure SetImportePendiente(const Value: Decimal);
    procedure SetNroCopias(const Value: SmallInt);
    procedure SetNroDocumento(const Value: LongInt);
    procedure SetNroFacturaFinal(const Value: LongInt);
    procedure SetNroFacturaInicial(const Value: LongInt);
    procedure SetUnaSolaFactura(const Value: Boolean );
    procedure SetPrimerNroFactura(const Value: LongInt);
    procedure SetSeleccionRegAuxiliar(const Value: SmallInt);
    procedure SetRegAuxiliarFinal(const Value: String);
    procedure SetRegAuxiliarInicial(const Value: String);
    procedure SetSerie(const Value: String);
    procedure SetTipoFichero(const Value: TTipoFicheroExportacion);
    procedure SetTipoSeleccion(const Value: TTipoSeleccionAlbaranes);
    procedure SetSeleccionVendedor(const Value: SmallInt);
    procedure SetVendedorFinal(const Value: String);
    procedure SetVendedorInicial(const Value: String);

  public

    constructor Create;

    property TipoSeleccion : TTipoSeleccionAlbaranes read GetTipoSeleccion write SetTipoSeleccion;
    property EjercicioFactura : SmallInt  read GetEjercicioFactura write SetEjercicioFactura;
    property Serie : String read GetSerie write SetSerie;
    property NroDocumento : LongInt read GetNroDocumento write SetNroDocumento;
    property FechaInicial : TDateTime read GetFechaInicial write SetFechaInicial;
    property FechaFinal : TDateTime read GetFechaFinal write SetFechaFinal;
    property FechaFacturacion : TDateTime read GetFechaFacturacion write SetFechaFacturacion;
    property UnaSolaFactura : Boolean read GetUnaSolaFactura write SetUnaSolaFactura;
    property PrimerNroFactura : LongInt read GetPrimerNroFactura write SetPrimerNroFactura;
    property ImportePendiente : Decimal read GetImportePendiente write SetImportePendiente;
    property ImporteMinimo : Decimal read GetImporteMinimo write SetImporteMinimo;
    property SerieInicial : String read GetSerieInicial write SetSerieInicial;
    property SerieFinal : String read GetSerieFinal write SetSerieFinal;
    property SeleccionPropietario : SmallInt read GetSeleccionPropietario write SetSeleccionPropietario;
    property PropietarioInicial : String read GetPropietarioInicial write SetPropietarioInicial;
    property PropietarioFinal : String read GetPropietarioFinal write SetPropietarioFinal;
    property SeleccionNroDocumento : SmallInt read GetSeleccionNroDocumento write SetSeleccionNroDocumento;
    property NroDocumentoInicial : LongInt read GetNroDocumentoInicial write SetNroDocumentoInicial;
    property NroDocumentoFinal : LongInt read GetNroDocumentoFinal write SetNroDocumentoFinal;
    property SeleccionGrupoPropietario : SmallInt read GetSeleccionGrupoPropietario write SetSeleccionGrupoPropietario;
    property GrupoPropietarioInicial : String read GetGrupoPropietarioInicial write SetGrupoPropietarioInicial;
    property GrupoPropietarioFinal : String read GetGrupoPropietarioFinal write SetGrupoPropietarioFinal;
    property SeleccionVendedor : SmallInt read GetSeleccionVendedor write SetSeleccionVendedor;
    property VendedorInicial : String read GetVendedorInicial write SetVendedorInicial;
    property VendedorFinal : String read GetVendedorFinal write SetVendedorFinal;
    property SeleccionFormaCobro : SmallInt read GetSeleccionFormaCobro write SetSeleccionFormaCobro;
    property FormaCobroInicial : String read GetFormaCobroInicial write SetFormaCobroInicial;
    property FormaCobroFinal : String read GetFormaCobroFinal write SetFormaCobroFinal;
    property CodigoPropietario : String read GetCodigoPropietario write SetCodigoPropietario;
    property SeleccionRegAuxiliar : SmallInt read GetSeleccionRegAuxiliar write SetSeleccionRegAuxiliar;
    property RegAuxiliarInicial : String read GetRegAuxiliarInicial write SetRegAuxiliarInicial;
    property RegAuxiliarFinal : String read GetRegAuxiliarFinal write SetRegAuxiliarFinal;
    property CopiaPropietario : Boolean read GetCopiaPropietario write SetCopiaPropietario;
    property Correcto : Boolean read GetCorrecto write SetCorrecto;
    property NroCopias : SmallInt read GetNroCopias write SetNroCopias;
    property NroFacturaInicial : LongInt read GetNroFacturaInicial write SetNroFacturaInicial;
    property NroFacturaFinal : LongInt read GetNroFacturaFinal write SetNroFacturaFinal;
    property DesglosarRegAuxilar : Boolean read GetDesglosarRegAuxilar write SetDesglosarRegAuxilar;
    property Formato : SmallInt read GetFormato write SetFormato;
    property GenerarFichero : Boolean read GetGenerarFichero write SetGenerarFichero;
    property TipoFichero : TTipoFicheroExportacion read GetTipoFichero write SetTipoFichero;
    property EnviarPorCorreo : Boolean read GetEnviarPorCorreo write SetEnviarPorCorreo;
    property ExcluirEnviados : Boolean read GetExcluirEnviados write SetExcluirEnviados;
    property ExcluirCorreo : Boolean read GetExcluirCorreo write SetExcluirCorreo;
    property UnaFacturaPorAlbaran : Boolean read GetUnaFacturaPorAlbaran write SetUnaFacturaPorAlbaran;
  end;

implementation

uses  Variants;

{ TParametrosFacturacion }

function TParametrosFacturacion.GetClassID: TnxGuid;
begin
     Result := CLSID_ParametrosFacturacion;
end;

function TParametrosFacturacion.GetSerieFinal: String;
begin
     Result := FSerieFinal;
end;

function TParametrosFacturacion.GetSerieInicial: String;
begin
     Result := FSerieInicial;
end;

function TParametrosFacturacion.GetSeleccionPropietario : SmallInt;
begin
     Result := FSeleccionPropietario;
end;

function TParametrosFacturacion.GetPropietarioFinal: String;
begin
     Result := FPropietarioFinal;
end;

function TParametrosFacturacion.GetPropietarioInicial: String;
begin
     Result := FPropietarioInicial;
end;

function TParametrosFacturacion.GetSeleccionNroDocumento : SmallInt;
begin
     Result := FSeleccionNroDocumento;
end;

function TParametrosFacturacion.GetNroDocumentoFinal: LongInt;
begin
     Result := FNroDocumentoFinal;
end;

function TParametrosFacturacion.GetNroDocumentoInicial: LongInt;
begin
     Result := FNroDocumentoInicial;
end;

function TParametrosFacturacion.GetCodigoPropietario: String;
begin
     Result := FCodigoPropietario;
end;

function TParametrosFacturacion.GetCopiaPropietario: Boolean;
begin
     Result := FCopiaPropietario;
end;

function TParametrosFacturacion.GetCorrecto : Boolean;
begin
     Result := FCorrecto;
end;

function TParametrosFacturacion.GetDesglosarRegAuxilar: Boolean;
begin
     Result := FDesglosarRegAuxilar;
end;

function TParametrosFacturacion.GetEjercicioFactura: SmallInt;
begin
     Result := FEjercicioFactura;
end;

function TParametrosFacturacion.GetEnviarPorCorreo: Boolean;
begin
     Result := FEnviarPorCorreo;
end;

function TParametrosFacturacion.GetExcluirCorreo: Boolean;
begin
     Result := FExcluirCorreo;
end;

function TParametrosFacturacion.GetUnaFacturaPorAlbaran: Boolean;
begin
     Result := FUnaFacturaPorAlbaran;
end;

function TParametrosFacturacion.GetExcluirEnviados: Boolean;
begin
     Result := FExcluirEnviados;
end;

function TParametrosFacturacion.GetFechaFacturacion: TDateTime;
begin
     Result := FFechaFacturacion;
end;

function TParametrosFacturacion.GetFechaFinal: TDateTime;
begin
     Result := FFechaFinal;
end;

function TParametrosFacturacion.GetFechaInicial: TDateTime;
begin
     Result := FFechaInicial;
end;

function TParametrosFacturacion.GetSeleccionFormaCobro: SmallInt;
begin
     Result := FSeleccionFormaCobro;
end;

function TParametrosFacturacion.GetFormaCobroFinal: String;
begin
     Result := FFormaCobroFinal;
end;

function TParametrosFacturacion.GetFormaCobroInicial: String;
begin
     Result := FFormaCobroInicial;
end;

function TParametrosFacturacion.GetFormato: SmallInt;
begin
     Result := FFormato;
end;

function TParametrosFacturacion.GetGenerarFichero: Boolean;
begin
     Result := FGenerarFichero;
end;

function TParametrosFacturacion.GetGrupoPropietarioFinal: String;
begin
     Result := FGrupoPropietarioFinal;
end;

function TParametrosFacturacion.GetSeleccionGrupoPropietario: SmallInt;
begin
     Result := FSeleccionGrupoPropietario;
end;

function TParametrosFacturacion.GetGrupoPropietarioInicial: String;
begin
     Result := FGrupoPropietarioInicial;
end;

function TParametrosFacturacion.GetImporteMinimo: Decimal;
begin
     Result := FImporteMinimo;
end;

function TParametrosFacturacion.GetImportePendiente: Decimal;
begin
     Result := FImportePendiente;
end;

function TParametrosFacturacion.GetNroCopias: SmallInt;
begin
     Result := FNroCopias;
end;

function TParametrosFacturacion.GetNroDocumento: LongInt;
begin
     Result := FNroDocumento;
end;

function TParametrosFacturacion.GetNroFacturaFinal: LongInt;
begin
     Result := FNroFacturaFinal;
end;

function TParametrosFacturacion.GetNroFacturaInicial: LongInt;
begin
     Result := FNroFacturaInicial;
end;

function TParametrosFacturacion.GetUnaSolaFactura: Boolean;
begin
     Result := FUnaSolaFactura;
end;

function TParametrosFacturacion.GetPrimerNroFactura: LongInt;
begin
     Result := FPrimerNroFactura;
end;

function TParametrosFacturacion.GetSeleccionRegAuxiliar: SmallInt;
begin
     Result := FSeleccionRegAuxiliar;
end;

function TParametrosFacturacion.GetRegAuxiliarFinal: String;
begin
     Result := FRegAuxiliarFinal;
end;

function TParametrosFacturacion.GetRegAuxiliarInicial: String;
begin
     Result := FRegAuxiliarInicial;
end;

function TParametrosFacturacion.GetSerie: String;
begin
     Result := FSerie;
end;

function TParametrosFacturacion.GetTipoFichero: TTipoFicheroExportacion;
begin
     Result := FTipoFichero;
end;

function TParametrosFacturacion.GetTipoSeleccion: TTipoSeleccionAlbaranes;
begin
     Result := FTipoSeleccion;
end;

function TParametrosFacturacion.GetSeleccionVendedor: SmallInt;
begin
     Result := FSeleccionVendedor;
end;

function TParametrosFacturacion.GetVendedorFinal: String;
begin
     Result := FVendedorFinal;
end;

function TParametrosFacturacion.GetVendedorInicial: String;
begin
     Result := FVendedorInicial;
end;

constructor TParametrosFacturacion.Create;
begin
     inherited Create( @CLSID_ParametrosFacturacion, nil, nil, False);
end;

function TParametrosFacturacion.LoadFromReader( AReader : InxReader ) : HRESULT;
begin
     With AReader do
       begin
       FTipoSeleccion := TTipoSeleccionAlbaranes( ReadInteger );
       FEjercicioFactura := ReadInteger;
       FSerie := ReadString;
       FNroDocumento := ReadInteger;
       FFechaInicial := ReadDate;
       FFechaFinal := ReadDate;
       FFechaFacturacion := ReadDate;
       FUnaSolaFactura := ReadBoolean;
       FPrimerNroFactura := ReadInteger;
       FImportePendiente := ReadCurrency;
       FImporteMinimo := ReadCurrency;
       FSerieInicial := ReadString;
       FSerieFinal := ReadString;
       FSeleccionPropietario := ReadInteger;
       FPropietarioInicial := ReadString;
       FPropietarioFinal := ReadString;
       FSeleccionNroDocumento := ReadInteger;
       FNroDocumentoInicial := ReadInteger;
       FNroDocumentoFinal := ReadInteger;
       FSeleccionGrupoPropietario := ReadInteger;
       FGrupoPropietarioInicial := ReadString;
       FGrupoPropietarioFinal := ReadString;
       FSeleccionVendedor := ReadInteger;
       FVendedorInicial := ReadString;
       FVendedorFinal := ReadString;
       FSeleccionFormaCobro := ReadInteger;
       FFormaCobroInicial := ReadString;
       FFormaCobroFinal := ReadString;
       FCodigoPropietario := ReadString;
       FSeleccionRegAuxiliar := ReadInteger;
       FRegAuxiliarInicial := ReadString;
       FRegAuxiliarFinal := ReadString;
       FCopiaPropietario := ReadBoolean;
       FNroCopias := ReadInteger;
       FNroFacturaInicial := ReadInteger;
       FNroFacturaFinal := ReadInteger;
       FDesglosarRegAuxilar := ReadBoolean;
       FFormato := ReadInteger;
       FGenerarFichero := ReadBoolean;
       FTipoFichero := TTipoFicheroExportacion( ReadInteger );
       FEnviarPorCorreo := ReadBoolean;
       FExcluirEnviados := ReadBoolean;
       FExcluirCorreo := ReadBoolean;
       FUnaFacturaPorAlbaran := ReadBoolean;
       FCorrecto := ReadBoolean;
       end;
     Result := S_OK;
end;

function TParametrosFacturacion.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     With AWriter do
       begin
       WriteInteger( Ord( FTipoSeleccion ) );
       WriteInteger( FEjercicioFactura );
       WriteString( FSerie );
       WriteInteger( FNroDocumento );
       WriteDate( FFechaInicial );
       WriteDate( FFechaFinal );
       WriteDate( FFechaFacturacion );
       WriteBoolean( FUnaSolaFactura );
       WriteInteger( FPrimerNroFactura );
       WriteCurrency( FImportePendiente );
       WriteCurrency( FImporteMinimo );
       WriteString( FSerieInicial );
       WriteString( FSerieFinal );
       WriteInteger( FSeleccionPropietario );
       WriteString( FPropietarioInicial );
       WriteString( FPropietarioFinal );
       WriteInteger( FSeleccionNroDocumento );
       WriteInteger( FNroDocumentoInicial );
       WriteInteger( FNroDocumentoFinal );
       WriteInteger( FSeleccionGrupoPropietario );
       WriteString( FGrupoPropietarioInicial );
       WriteString( FGrupoPropietarioFinal );
       WriteInteger( FSeleccionVendedor );
       WriteString( FVendedorInicial );
       WriteString( FVendedorFinal );
       WriteInteger( FSeleccionFormaCobro );
       WriteString( FFormaCobroInicial );
       WriteString( FFormaCobroFinal );
       WriteString( FCodigoPropietario );
       WriteInteger( FSeleccionRegAuxiliar );
       WriteString( FRegAuxiliarInicial );
       WriteString( FRegAuxiliarFinal );
       WriteBoolean( FCopiaPropietario );
       WriteInteger( FNroCopias );
       WriteInteger( FNroFacturaInicial );
       WriteInteger( FNroFacturaFinal );
       WriteBoolean( FDesglosarRegAuxilar );
       WriteInteger( FFormato );
       WriteBoolean( FGenerarFichero );
       WriteInteger( Ord( FTipoFichero ) );
       WriteBoolean( FEnviarPorCorreo );
       WriteBoolean( FExcluirEnviados );
       WriteBoolean( FExcluirCorreo );
       WriteBoolean( FUnaFacturaPorAlbaran );
       WriteBoolean( FCorrecto );
       end;
     Result := S_OK;
end;

procedure TParametrosFacturacion.SetSerieFinal( const Value: String);
begin
     FSerieFinal := Value;
end;

procedure TParametrosFacturacion.SetSerieInicial(const Value: String);
begin
     FSerieInicial := Value;
end;

procedure TParametrosFacturacion.SetSeleccionPropietario( const Value: SmallInt);
begin
     FSeleccionPropietario := Value;
end;

procedure TParametrosFacturacion.SetPropietarioFinal( const Value: String);
begin
     FPropietarioFinal := Value;
end;

procedure TParametrosFacturacion.SetPropietarioInicial(const Value: String);
begin
     FPropietarioInicial := Value;
end;

procedure TParametrosFacturacion.SetSeleccionNroDocumento(const Value: SmallInt);
begin
     FSeleccionNroDocumento := Value;
end;

procedure TParametrosFacturacion.SetNroDocumentoFinal(const Value: Integer);
begin
     FNroDocumentoFinal := Value;
end;

procedure TParametrosFacturacion.SetNroDocumentoInicial(const Value: Integer);
begin
     FNroDocumentoInicial := Value;
end;

procedure TParametrosFacturacion.SetCodigoPropietario(const Value: String);
begin
     FCodigoPropietario := Value;
end;

procedure TParametrosFacturacion.SetCopiaPropietario(const Value: Boolean);
begin
     FCopiaPropietario := Value;
end;

procedure TParametrosFacturacion.SetCorrecto(const Value: Boolean);
begin
     FCorrecto := Value;
end;

procedure TParametrosFacturacion.SetDesglosarRegAuxilar(const Value: Boolean);
begin
     FDesglosarRegAuxilar := Value;
end;

procedure TParametrosFacturacion.SetEjercicioFactura(const Value: SmallInt);
begin
     FEjercicioFactura := Value;
end;

procedure TParametrosFacturacion.SetEnviarPorCorreo(const Value: Boolean);
begin
     FEnviarPorCorreo := Value;
end;

procedure TParametrosFacturacion.SetExcluirCorreo(const Value: Boolean);
begin
     FExcluirCorreo := Value;
end;

procedure TParametrosFacturacion.SetUnaFacturaPorAlbaran(const Value: Boolean);
begin
     FUnaFacturaPorAlbaran := Value;
end;

procedure TParametrosFacturacion.SetExcluirEnviados(const Value: Boolean);
begin
     FExcluirEnviados := Value;
end;

procedure TParametrosFacturacion.SetFechaFacturacion(const Value: TDateTime);
begin
     FFechaFacturacion := Value;
end;

procedure TParametrosFacturacion.SetFechaFinal(const Value: TDateTime);
begin
     FFechaFinal := Value;
end;

procedure TParametrosFacturacion.SetFechaInicial(const Value: TDateTime);
begin
     FFechaInicial := Value;
end;

procedure TParametrosFacturacion.SetSeleccionFormaCobro(const Value: SmallInt);
begin
     FSeleccionFormaCobro := Value;
end;

procedure TParametrosFacturacion.SetFormaCobroFinal(const Value: String);
begin
     FFormaCobroFinal := Value;
end;

procedure TParametrosFacturacion.SetFormaCobroInicial(const Value: String);
begin
     FFormaCobroInicial := Value;
end;

procedure TParametrosFacturacion.SetFormato(const Value: SmallInt);
begin
     FFormato := Value;
end;

procedure TParametrosFacturacion.SetGenerarFichero(const Value: Boolean);
begin
     FGenerarFichero := Value;
end;

procedure TParametrosFacturacion.SetGrupoPropietarioFinal(const Value: String);
begin
     FGrupoPropietarioFinal := Value;
end;

procedure TParametrosFacturacion.SetSeleccionGrupoPropietario(const Value: SmallInt);
begin
     FSeleccionGrupoPropietario := Value;
end;

procedure TParametrosFacturacion.SetGrupoPropietarioInicial(const Value: String);
begin
     FGrupoPropietarioInicial := Value;
end;

procedure TParametrosFacturacion.SetImporteMinimo(const Value: Decimal);
begin
     FImporteMinimo := Value;
end;

procedure TParametrosFacturacion.SetImportePendiente(const Value: Decimal);
begin
     FImportePendiente := Value;
end;

procedure TParametrosFacturacion.SetNroCopias(const Value: SmallInt);
begin
     FNroCopias := Value;
end;

procedure TParametrosFacturacion.SetNroDocumento(const Value: Integer);
begin
     FNroDocumento := Value;
end;

procedure TParametrosFacturacion.SetNroFacturaFinal(const Value: Integer);
begin
     FNroFacturaFinal := Value;
end;

procedure TParametrosFacturacion.SetNroFacturaInicial(const Value: Integer);
begin
     FNroFacturaInicial := Value;
end;

procedure TParametrosFacturacion.SetUnaSolaFactura( const Value: Boolean );
begin
     FUnaSolaFactura := Value;
end;

procedure TParametrosFacturacion.SetPrimerNroFactura( const Value: LongInt );
begin
     FPrimerNroFactura := Value;
end;

procedure TParametrosFacturacion.SetSeleccionRegAuxiliar(const Value: SmallInt);
begin
     FSeleccionRegAuxiliar := Value;
end;

procedure TParametrosFacturacion.SetRegAuxiliarFinal(const Value: String);
begin
     FRegAuxiliarFinal := Value;
end;

procedure TParametrosFacturacion.SetRegAuxiliarInicial(const Value: String);
begin
     FRegAuxiliarInicial := Value;
end;

procedure TParametrosFacturacion.SetSerie(const Value: String);
begin
     FSerie := Value;
end;

procedure TParametrosFacturacion.SetTipoFichero(const Value: TTipoFicheroExportacion);
begin
     FTipoFichero := Value;
end;

procedure TParametrosFacturacion.SetTipoSeleccion(const Value: TTipoSeleccionAlbaranes);
begin
     FTipoSeleccion := Value;
end;

procedure TParametrosFacturacion.SetSeleccionVendedor(const Value: SmallInt);
begin
     FSeleccionVendedor := Value;
end;

procedure TParametrosFacturacion.SetVendedorFinal(const Value: String);
begin
     FVendedorFinal := Value;
end;

procedure TParametrosFacturacion.SetVendedorInicial(const Value: String);
begin
     FVendedorInicial := Value;
end;

var ParametrosFacturacionControl : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IParametrosFacturacion ) );

     TnxClassFactory.RegisterClass( CLSID_ParametrosFacturacion, TParametrosFacturacion, ParametrosFacturacionControl );

end.


