
unit PreventaServiceUnit;

{$I kbmMW.inc}

interface

uses
  SysUtils,
  Variants,
  Classes,
  TypInfo,
  Rtti,
  Generics.Defaults,
  Generics.Collections,

  kbmMWSecurity,
  kbmMWServer,
  kbmMWServiceUtils,
  kbmMWGlobal,
  kbmMemTable,
  kbmMWStreamFormat,
  kbmMWBinaryStreamFormat,
  Data.DB,
  kbmMWCustomConnectionPool,
  kbmMWCustomDataset,
  kbmMWNexusDB,
  kbmMWQueryService,
  kbmMWJSONStreamFormat,
  kbmMWJSON,
  kbmMWObjectNotation,
  kbmMWONStreamFormat,

  nxDB,
  DataManager;

type
  TPreventaService = class(TkbmMWQueryService)
    JONStreamFormat: TkbmMWJSONStreamFormat;
    MovimientosData: TnxeTable;
    MovimientosDataIdRegistro: TIntegerField;
    MovimientosDataIdLinea: TIntegerField;
    MovimientosDataTipoMovimiento: TSmallintField;
    MovimientosDataGrupoLinea: TSmallintField;
    MovimientosDataFechaMovimiento: TDateField;
    MovimientosDataCreado: TDateTimeField;
    MovimientosDataCodigoCliente: TStringField;
    MovimientosDataEntrega: TBCDField;
    MovimientosDataCodigoArticulo: TStringField;
    MovimientosDataCodigoClaseA: TStringField;
    MovimientosDataCodigoClaseB: TStringField;
    MovimientosDataCodigoClaseC: TStringField;
    MovimientosDataDescripcion: TStringField;
    MovimientosDataNroCajas: TBCDField;
    MovimientosDataCantidad: TBCDField;
    MovimientosDataPrecio: TFloatField;
    MovimientosDataRecargo: TBCDField;
    MovimientosDataDescuento: TBCDField;
    MovimientosDataAnotacion: TnxMemoField;
    MovimientosDataUUID: TStringField;
    MovimientosDataFechaEntrega: TDateField;
    MovimientosDataFirma: TMemoField;
    procedure kbmMWQueryServiceCreate(Sender: TObject);
    procedure kbmMWQueryServiceDestroy(Sender: TObject);
  private

   JSONStreamer :TkbmMWJSONStreamer;

   procedure ExtractArgs(const Args: array of Variant; var ClientID, CodigoEmpresa, CodigoEquipoMovil : String);
   function GetClientID(CodigoEquipoMovil: String): String;

  protected
    function ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant; override;

    function CierraSesion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

    function ObtenConfiguracion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenArticulos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenClases(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenClientes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenTarifasVentas(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenTarifasClase( ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;
    function ObtenRutas(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenConsumos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenDeudaClientes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

    function EnviaMovimientos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function EnviaLocalizaciones(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

  public
     { Public declarations }
     class function GetPrefServiceName:string; override;
     class function GetFlags:TkbmMWServiceFlags; override;
     class function GetVersion:string; override;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses kbmMWObject,
     kbmMWExceptions,

     nxsdTypes,
     nxdmServer,
     ScroogeXHTML,

     SBTypes,
     SBEncoding,

     DateUtils,
     LibUtils,

     BaseServerContainer,
     AppManager,
     MainData,

     EnterpriseData,
     BaseSessionData,
     SessionData,
     ServerContainer,

     Gim00Fields,
     Gim10Fields,
     Gim30Fields,

     Gsm00Dm,
     Gsm10Dm,
     Gsm30Dm,

     dmi_sal,
     dmi_mov,
     dmi_sto,

     dm_sal,

     dm_usr,
     dm_mov,
     dm_eqm,

     PreventaDataModule;

{$R *.dfm}

const  ServiceName = 'Preventa';

       RTFText = '{\rtf1\ansi\deff0\nouicompat{\fonttbl{\f0\fnil\fcharset0 [font];}{\f1\fnil [font];}}' +
                 '{\colortbl ;\red78\green78\blue78;}' +
                 '\viewkind4\uc1' +
                 '\pard\cf1\f0\fs[fontsize]\lang3082 [text]\f1\par}';


// Service definitions.
//---------------------

class function TPreventaService.GetPrefServiceName : string;
begin
     Result := ServiceName;
end;

function TPreventaService.GetClientID( CodigoEquipoMovil : String ) : String;
begin
     Result := GetPrefServiceName + CodigoEquipoMovil;
end;

class function TPreventaService.GetFlags:TkbmMWServiceFlags;
begin
     Result:=[mwsfListed];
end;

class function TPreventaService.GetVersion:string;
begin
     Result:='1.0';
end;

procedure TPreventaService.kbmMWQueryServiceCreate(Sender: TObject);
begin
     BoundTransport := ServerContainerModule.ServerTransport;
     TransportStreamFormat := ServerContainerModule.JSONStreamFormat;

     JSONStreamer := TkbmMWJSONStreamer.Create;
end;

procedure TPreventaService.kbmMWQueryServiceDestroy(Sender: TObject);
begin
     JSONStreamer.Free;
end;

function TPreventaService.ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
var
   AFunc:string;
begin
     AFunc:=UpperCase(Func);
     if AFunc='OBTENCONFIGURACION' then
        Result:=ObtenConfiguracion(ClientIdent,Args)
     else if AFunc='OBTENARTICULOS' then
        Result:=ObtenArticulos(ClientIdent,Args)
     else if AFunc='OBTENCLASES' then
        Result:=ObtenClases(ClientIdent,Args)
     else if AFunc='OBTENCLIENTES' then
        Result:=ObtenClientes(ClientIdent,Args)
     else if AFunc='OBTENTARIFASVENTAS' then
        Result:=ObtenTarifasVentas(ClientIdent,Args)
     else if AFunc='OBTENTARIFASCLASE' then
        Result:=ObtenTarifasClase(ClientIdent,Args)
     else if AFunc='OBTENRUTAS' then
        Result:=ObtenRutas(ClientIdent,Args)
     else if AFunc='OBTENCONSUMOS' then
        Result:=ObtenConsumos(ClientIdent,Args)
     else if AFunc='OBTENDEUDACLIENTES' then
        Result:=ObtenDeudaClientes(ClientIdent,Args)
     else if AFunc='ENVIAMOVIMIENTOS' then
        Result:=EnviaMovimientos(ClientIdent,Args)
     else if AFunc='ENVIALOCALIZACIONES' then
        Result:=EnviaLocalizaciones(ClientIdent,Args)
     else if AFunc='CIERRASESION' then
        Result:=CierraSesion(ClientIdent,Args)
     else
        Result:=inherited ProcessRequest(Func,ClientIdent,Args);
end;

procedure TPreventaService.ExtractArgs( const Args               : array of Variant;
                                        var   ClientID,
                                              CodigoEmpresa,
                                              CodigoEquipoMovil : String );
begin
     ClientID := Args[ 0 ];
     CodigoEmpresa := Args[ 1 ];
     CodigoEquipoMovil  := Args[ 2 ];
end;

function TPreventaService.CierraSesion(        ClientIdent : TkbmMWClientIdentity;
                                         const Args        : array of Variant ) : Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEquipoMovil,
      CodigoEmpresa : String;

begin
     ExtractArgs( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then SessionDataModule.Free;
     Result := VarNull;
end;

function TPreventaService.ObtenArticulos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa,
      CodigoEquipoMovil,
      TextoAnotacion,
      TextoAviso  : String;

begin
     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     Result := VarNull;

     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              DmPreventa.ArticuloTable.Open;

              With Dm30.ArticuloModule do
                begin

                DmArticuloTable.First;
                While not DmArticuloTable.Eof do
                  begin

                  If   not DmArticuloFields.Obsoleto.Value
                  then begin

                        DmPreventa.ArticuloTable.Append;

                        DmPreventa.ArticuloTableCodigo.Value := StrToJSONText( DmArticuloFields.Codigo.Value );
                        DmPreventa.ArticuloTableDescripcion.Value := StrToJSONText( DmArticuloFields.Descripcion.Value );
                        DmPreventa.ArticuloTableFamilia.Value := DmArticuloFields.Familia.Value;
                        DmPreventa.ArticuloTablePrecio_Venta.Value := DmArticuloFields.Precio_venta.Value;
                        DmPreventa.ArticuloTableDto_Venta.Value := DmArticuloFields.Dto_Venta.Value;
                        DmPreventa.ArticuloTableUnidadesPorCaja.Value := DmArticuloFields.UnidadesPorCaja.Value;
                        DmPreventa.ArticuloTableOferta.Value := DmArticuloFields.Oferta.Value;
                        DmPreventa.ArticuloTableOfertaPrecioVenta.Value := DmArticuloFields.OfertaPrecioVenta.Value;
                        DmPreventa.ArticuloTableOfertaDescuento.Value := DmArticuloFields.OfertaDescuento.Value;
                        DmPreventa.ArticuloTableOfertaFechaInicial.Value := DmArticuloFields.OfertaFechaInicial.Value;
                        DmPreventa.ArticuloTableOfertaFechaFinal.Value := DmArticuloFields.OfertaFechaFinal.Value;

                        TextoAnotacion := SessionDataModule.RTFToPlainText( DmArticuloFields.Anotacion.AsAnsiString );
                        TextoAnotacion := StringReplace( TextoAnotacion, '\r\f', #10#13, [ rfReplaceAll ] );
                        TextoAnotacion := StringReplace( TextoAnotacion, '\"', '"', [ rfReplaceAll ] );

                        DmPreventa.ArticuloTableAnotacion.AsString := TextoAnotacion;

                        DmPreventa.ArticuloTableMostrarAviso.Value := DmArticuloFields.MostrarAviso.Value;

                        TextoAviso := SessionDataModule.RTFToPlainText( DmArticuloFields.Aviso.AsAnsiString );
                        TextoAviso := StringReplace( TextoAviso, '\r\f', #10#13, [ rfReplaceAll ] );
                        TextoAviso := StringReplace( TextoAviso, '\"', '"', [ rfReplaceAll ] );

                        DmPreventa.ArticuloTableAviso.AsString := TextoAviso;

                        DmPreventa.ArticuloTable.Post;
                       end;

                  DmArticuloTable.Next;
                  end;

                end;

              Result := ReturnDataset(  DmPreventa.ArticuloTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
               DmPreventa.ArticuloTable.Close;
              end;
end;

function TPreventaService.ObtenClases(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa : String;
      CodigoEquipoMovil : String;

begin
     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     Result := VarNull;

     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              DmPreventa.ClaseTable.Open;

              With SessionDataModule.Dm30.ClaseModule do
                begin

                DmClaseTable.First;
                While not DmClaseTable.Eof do
                  begin

                   DmPreventa.ClaseTable.Append;

                   DmPreventa.ClaseTableNroClase.Value := DmClaseFields.NroClase.Value;
                   DmPreventa.ClaseTableCodigo.Value := DmClaseFields.Codigo.Value;
                   DmPreventa.ClaseTableDescripcion.Value := DmClaseFields.Descripcion.Value;

                   DmPreventa.ClaseTable.Post;

                  DmClaseTable.Next;
                  end;

                end;

              Result := ReturnDataset(  DmPreventa.ClaseTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
               DmPreventa.ClaseTable.Close;
              end;
end;

function TPreventaService.ObtenClientes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa,
      CodigoInicial,
      CodigoEquipoMovil : String;

      NroContacto,
      Index : SmallInt;
      RutaActual : String;

      Nombre,
      Fijo,
      Movil,
      Aviso : String;

begin
     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     CodigoInicial:= Args[ 2 ];
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              DmPreventa.ClienteTable.Open;

              With Dm30.PreventaModule do
                try

                  DmEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );
                  DmEquipoMovilTable.First;
                  While not DmEquipoMovilTable.Eof do
                    begin
                    DmRutasEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );  // CodigoEquipoMovil;NroOrden;CodigoRuta
                    DmRutasEquipoMovilTable.First;
                    While not DmRutasEquipoMovilTable.Eof do
                      begin
                      RutaActual := DmRutasEquipoMovilFields.CodigoRuta.Value;
                      If   RutaActual<>''
                      then If   DmRutaTable.FindKey( [ RutaActual ] )
                           then With DmLineaRutaTable do
                                  try
                                    SetRange( [ DmRutaFields.Codigo.Value, 1 ], [ DmRutaFields.Codigo.Value, MaxSmallInt ] );
                                    First;
                                    While not Eof do
                                      begin

                                      // Puede que esté el mismo cliente en más de una ruta

                                      If   not  DmPreventa.ClienteTable.FindKey( [ DmLineaRutaFields.CodigoCliente.Value ] )
                                      then If   DmClienteTable.FindKey( [ DmLineaRutaFields.CodigoCliente.Value ] )
                                           then If   not DmClienteFields.Obsoleto.Value
                                                then begin

                                                      DmPreventa.ClienteTable.Append;

                                                 DmPreventa.ClienteTableCodigo.Value := DmClienteFields.Codigo.Value;
                                                 DmPreventa.ClienteTableNombre.Value := StrToJSONText( DmClienteFields.Nombre.Value );
                                                 DmPreventa.ClienteTableDomicilio.Value := StrToJSONText( DmClienteFields.Domicilio.Value );
                                                 DmPreventa.ClienteTableLocalidad.Value := DmClienteFields.Localidad.Value;
                                                 DmPreventa.ClienteTableCodigoPais.Value := DmClienteFields.CodigoPais.Value;
                                                 DmPreventa.ClienteTableCodigoPostal.Value := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value;
                                                 DmPreventa.ClienteTableNIF.Value := DmClienteFields.NIF.Value;
                                                 DmPreventa.ClienteTableTelefono.Value := StrToJSONText( DmClienteFields.Telefono.Value );
                                                 DmPreventa.ClienteTableFax.Value := StrToJSONText( DmClienteFields.Fax.Value );
                                                 DmPreventa.ClienteTableEnvios_Nombre.Value := StrToJSONText( DmClienteFields.Envios_Nombre.Value );
                                                 DmPreventa.ClienteTableEnvios_Domicilio.Value := StrToJSONText( DmClienteFields.Envios_Domicilio.Value );
                                                 DmPreventa.ClienteTableEnvios_Localidad.Value := StrToJSONText( DmClienteFields.Envios_Localidad.Value );
                                                 DmPreventa.ClienteTableEnvios_CodigoPostal.Value := DmClienteFields.Envios_CodigoProv.Value + DmClienteFields.Envios_CodigoPostal.Value;
                                                 DmPreventa.ClienteTableAnotacion.Value := SessionDataModule.RTFToPlainText( DmClienteFields.Anotacion.AsAnsiString );
                                                 Aviso := DmClienteFields.Aviso.AsAnsiString;
                                                 DmPreventa.ClienteTableAviso.Value := SessionDataModule.RTFToPlainText( Aviso );
                                                 DmPreventa.ClienteTableMostrarAviso.Value := DmClienteFields.MostrarAviso.Value;

                                                // Tipo;Codigo;NroRegistro

                                                DmDireccionContactoTable.SetRange(  [ 0, DmClienteFields.Codigo.Value ] );
                                                try
                                                  DmDireccionContactoTable.First;
                                                  For NroContacto := 1 to 3 do
                                                    begin

                                                    If   DmDireccionContactoTable.Found
                                                    then begin
                                                         Nombre := DmDireccionContactoFields.Nombre.Value;
                                                         Fijo := DmDireccionContactoFields.Fijo.Value;
                                                         Movil := DmDireccionContactoFields.Movil.Value;
                                                         end
                                                    else begin
                                                         Nombre := '';
                                                         Fijo := '';
                                                         Movil := '';
                                                         end;

                                                    case NroContacto of
                                                      1 : begin
                                                           DmPreventa.ClienteTableContacto1_Nombre.Value := Nombre;
                                                           DmPreventa.ClienteTableContacto1_Fijo.Value := Fijo;
                                                           DmPreventa.ClienteTableContacto1_Movil.Value := Movil;
                                                          end;
                                                      2 : begin
                                                           DmPreventa.ClienteTableContacto2_Nombre.Value := Nombre;
                                                           DmPreventa.ClienteTableContacto2_Fijo.Value := Fijo;
                                                           DmPreventa.ClienteTableContacto2_Movil.Value := Movil;
                                                          end;
                                                      3 : begin
                                                           DmPreventa.ClienteTableContacto3_Nombre.Value := Nombre;
                                                           DmPreventa.ClienteTableContacto3_Fijo.Value := Fijo;
                                                           DmPreventa.ClienteTableContacto3_Movil.Value := Movil;
                                                          end;
                                                      end;

                                                    DmDireccionContactoTable.Next;
                                                    end;

                                                finally
                                                  DmDireccionContactoTable.CancelRange;
                                                  end;

                                                 DmPreventa.ClienteTableFactura_Tarifa.Value := DmClienteFields.Factura_Tarifa.Value;
                                                 DmPreventa.ClienteTableFactura_NoAplicarOfertas.Value := DmClienteFields.Factura_NoAplicarOfertas.Value;

                                                 DmPreventa.ClienteTable.Post;
                                                end;

                                      Next;
                                      end;

                                  finally
                                    CancelRange;
                                    end;

                      DmRutasEquipoMovilTable.Next;
                      end;

                    DmEquipoMovilTable.Next;
                    end;

                finally
                  DmEquipoMovilTable.CancelRange;
                  DmRutasEquipoMovilTable.CancelRange;
                  end;

              Result := ReturnDataset(  DmPreventa.ClienteTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
               DmPreventa.ClienteTable.Close;
              end;

end;

function TPreventaService.ObtenRutas(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa,
      CodigoInicial,
      CodigoEquipoMovil : String;

      NroOrden,
      Index : SmallInt;
      RutaActual : String;

begin

     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     CodigoInicial:= Args[ 2 ];
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              DmPreventa.RutaTable.Open;

              With SessionDataModule.Dm30.PreventaModule do
                try
                  DmEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );
                  DmEquipoMovilTable.First;
                  While not DmEquipoMovilTable.Eof do
                    begin
                    DmRutasEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );  // CodigoEquipoMovil;CodigoRuta
                    DmRutasEquipoMovilTable.First;
                    While not DmRutasEquipoMovilTable.Eof do
                      begin
                      RutaActual := DmRutasEquipoMovilFields.CodigoRuta.Value;
                      If   RutaActual<>''
                      then If   DmRutaTable.FindKey( [ RutaActual ] )
                           then With DmLineaRutaTable do
                                  begin

                                   DmPreventa.RutaTable.Append;

                                   DmPreventa.RutaTableCodigo.Value := DmRutaFields.Codigo.Value;
                                   DmPreventa.RutaTableNroOrden.Value := 0;
                                   DmPreventa.RutaTableClienteDescripcion.Value := DmRutaFields.Descripcion.Value;

                                   DmPreventa.RutaTable.Post;

                                  NroOrden := 1;

                                  try

                                    SetRange( [ DmRutaFields.Codigo.Value, 1 ], [ DmRutaFields.Codigo.Value, MaxSmallInt ] );

                                    First;
                                    While not Eof do
                                      begin

                                       DmPreventa.RutaTable.Append;

                                       DmPreventa.RutaTableCodigo.Value := DmLineaRutaFields.CodigoRuta.Value;
                                       DmPreventa.RutaTableNroOrden.Value := NroOrden;
                                       DmPreventa.RutaTableClienteDescripcion.Value := DmLineaRutaFields.CodigoCliente.Value;

                                       DmPreventa.RutaTable.Post;

                                      Inc( NroOrden );

                                      Next;
                                      end;

                                  finally
                                    CancelRange;
                                    end;

                                  end;

                      DmRutasEquipoMovilTable.Next;
                      end;

                    DmEquipoMovilTable.Next;
                    end;

                finally
                  DmEquipoMovilTable.CancelRange;
                  DmRutasEquipoMovilTable.CancelRange;
                  end;

              Result := ReturnDataset(  DmPreventa.RutaTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
               DmPreventa.RutaTable.Close;
              end;

end;

function TPreventaService.ObtenTarifasVentas( ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa : String;
      CodigoEquipoMovil : String;

begin
    ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
    Result := VarNull;
    SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
    If   Assigned( SessionDataModule )
    then begin
         Query := SessionDataModule.EnterpriseQuery;
         SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT * FROM TarifaVentas';
         SessionDataModule.EnterpriseQuery.Open;
         Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
         end;
end;

function TPreventaService.ObtenTarifasClase( ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa : String;
      CodigoEquipoMovil : String;

begin
    ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
    Result := VarNull;
    SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
    If   Assigned( SessionDataModule )
    then begin
         Query := SessionDataModule.EnterpriseQuery;
         SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT * FROM TarifaClase';
         SessionDataModule.EnterpriseQuery.Open;
         Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
         end;
end;

function TPreventaService.ObtenConfiguracion(       ClientIdent : TkbmMWClientIdentity;
                                              const Args        : array of Variant ) : Variant;

var  SessionDataModule : TSessionDataModule;
     ClientID,
     CodigoEmpresa,
     CodigoEquipoMovil : String;

begin

     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );

     Result := VarArrayCreate( [0, 2], varVariant);

     // Por defecto la modificación de precios y descuentos está habilitada.
     // Solo si el usuario decide limitarla, asignando un usuario al equipo móvil, se puede cambiar.

     Result[ 0 ] := Integer( 1 );
     Result[ 1 ] := Integer( 1 );

     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule.Dm30.PreventaModule do
            If   DmEquipoMovilTable.FindKey( [ CodigoEquipoMovil ] )
            then begin
                  If   SessionDataModule.UsuarioTable.FindKey( [ DmEquipoMovilFields.CodigoUsuario.Value ] )  // Si no está asignado simplemente no lo encuentra
                  then begin
                       Result[ 0 ] := VarToBooleanInt( SessionDataModule.UsuarioFields.AcCAPrecios.AsVariant );
                       Result[ 1 ] := VarToBooleanInt( SessionDataModule.UsuarioFields.AcCADescuentos.AsVariant );
                       end;
                  end;
end;

function TPreventaService.ObtenConsumos( ClientIdent : TkbmMWClientIdentity; const Args : array of Variant ) : Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa,
      CodigoEquipoMovil : String;

      NroOrden,
      Index : SmallInt;
      RutaActual : String;

begin

     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              DmPreventa.ConsumosTable.Open;

              With SessionDataModule.Dm30.PreventaModule do
                try
                  DmEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );
                  DmEquipoMovilTable.First;
                  While not DmEquipoMovilTable.Eof do
                    begin
                    DmRutasEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );  // CodigoEquipoMovil;CodigoRuta
                    DmRutasEquipoMovilTable.First;
                    While not DmRutasEquipoMovilTable.Eof do
                      begin
                      RutaActual := DmRutasEquipoMovilFields.CodigoRuta.Value;
                      If   RutaActual<>''
                      then If   DmRutaTable.FindKey( [ RutaActual ] )
                           then With DmLineaRutaTable do
                                  try
                                    SetRange( [ DmRutaFields.Codigo.Value, 1 ], [ DmRutaFields.Codigo.Value, MaxSmallInt ] );
                                    First;
                                    While not Eof do
                                      begin

                                      If   DmClienteTable.FindKey( [ DmLineaRutaFields.CodigoCliente.Value ] )
                                      then If   not DmPreventa.ConsumosTable.FindKey( [ DmLineaRutaFields.CodigoCliente.Value ] )  // Evitando duplicados
                                           then With DmConsumosClienteTable do
                                                  try

                                                    SetRange( [ DmLineaRutaFields.CodigoCliente.Value, 1 ], [ DmLineaRutaFields.CodigoCliente.Value, MaxSmallInt ] );
                                                    First;
                                                    NroOrden := 1;

                                                    while not Eof  do
                                                      begin

                                                      DmPreventa.ConsumosTable.Append;

                                                      DmPreventa.ConsumosTableCodigoCliente.Value := DmConsumosClienteFields.CodigoCliente.Value;
                                                      DmPreventa.ConsumosTableNroOrden.Value := NroOrden;
                                                      DmPreventa.ConsumosTableCodigoArticulo.Value := DmConsumosClienteFields.CodigoArticulo.Value;
                                                      DmPreventa.ConsumosTableCajas.Value := DmConsumosClienteFields.Cajas.Value;
                                                      DmPreventa.ConsumosTableCantidad.Value := DmConsumosClienteFields.Cantidad.Value;
                                                      DmPreventa.ConsumosTablePrecioActual.Value := DmConsumosClienteFields.PrecioActual.Value;
                                                      DmPreventa.ConsumosTableUltimoPrecio.Value := DmConsumosClienteFields.UltimoPrecio.Value;
                                                      DmPreventa.ConsumosTablePrecio.Value := DmConsumosClienteFields.Precio.Value;
                                                      DmPreventa.ConsumosTableRecargo.Value := DmConsumosClienteFields.Recargo.Value;
                                                      DmPreventa.ConsumosTableDescuentoActual.Value := DmConsumosClienteFields.DescuentoActual.Value;
                                                      DmPreventa.ConsumosTableUltimoDescuento.Value := DmConsumosClienteFields.UltimoDescuento.Value;
                                                      DmPreventa.ConsumosTableDescuento.Value := DmConsumosClienteFields.Descuento.Value;
                                                      DmPreventa.ConsumosTableFecha.Value := DmConsumosClienteFields.Fecha.Value;

                                                      DmPreventa.ConsumosTable.Post;

                                                      Inc( NroOrden );

                                                      Next;
                                                      end;

                                             finally
                                               CancelRange;
                                               end;

                                      Next;
                                      end;

                                  finally
                                    CancelRange;
                                    end;
                      DmRutasEquipoMovilTable.Next;
                      end;

                    DmEquipoMovilTable.Next;
                    end;

                finally
                  DmEquipoMovilTable.CancelRange;
                  DmRutasEquipoMovilTable.CancelRange;
                  end;

              Result := ReturnDataset(  DmPreventa.ConsumosTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
               DmPreventa.ConsumosTable.Close;
              end;

end;

function TPreventaService.ObtenDeudaClientes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID,
      CodigoEmpresa,
      CodigoInicial,
      CodigoEquipoMovil : String;

      Index : SmallInt;
      ImporteDeuda : Decimal;
      RutaActual : String;

begin

     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     CodigoInicial:= Args[ 2 ];

     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              SessionDataModule.Ejercicio := SessionDataModule.EjercicioFecha( Today );

              DmPreventa.DeudaClienteTable.Open;

              With SessionDataModule.Dm30.PreventaModule do
                try

                  DmEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );
                  DmEquipoMovilTable.First;
                  While not DmEquipoMovilTable.Eof do
                    begin
                    DmRutasEquipoMovilTable.SetRange( [ CodigoEquipoMovil ] );  // CodigoEquipoMovil;CodigoRuta
                    DmRutasEquipoMovilTable.First;
                    While not DmRutasEquipoMovilTable.Eof do
                      begin
                      RutaActual := DmRutasEquipoMovilFields.CodigoRuta.Value;
                      If   RutaActual<>''
                      then If   DmRutaTable.FindKey( [ RutaActual ] )
                           then With DmLineaRutaTable do
                                  try
                                    SetRange( [ DmRutaFields.Codigo.Value, 1 ], [ DmRutaFields.Codigo.Value, MaxSmallInt ] );
                                    First;
                                    While not Eof do
                                      begin

                                      // Puede que esté el mismo cliente en más de una ruta

                                      If   not  DmPreventa.DeudaClienteTable.FindKey( [ DmLineaRutaFields.CodigoCliente.Value ] )
                                      then If   DmClienteTable.FindKey( [ DmLineaRutaFields.CodigoCliente.Value ] )
                                           then With DmClienteFields do
                                                  begin

                                                  ImporteDeuda := SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( DmClienteFields.Subcuenta.Value, '', True, SessionDataModule.Ejercicio, 0, 12 ).Saldo;
                                                  If   ImporteDeuda>=1.0 // Cantidades inferiores no son significativas
                                                  then begin
                                                        DmPreventa.DeudaClienteTable.Append;

                                                        DmPreventa.DeudaClienteTableCodigoCliente.Value := DmClienteFields.Codigo.Value;
                                                        DmPreventa.DeudaClienteTableImporte.Value := ImporteDeuda;

                                                        DmPreventa.DeudaClienteTable.Post;
                                                       end;

                                                  end;

                                      Next;
                                      end;

                                  finally
                                    CancelRange;
                                    end;

                      DmRutasEquipoMovilTable.Next;
                      end;

                    DmEquipoMovilTable.Next;
                    end;

                finally
                  DmEquipoMovilTable.CancelRange;
                  DmRutasEquipoMovilTable.CancelRange;
                  end;

              Result := ReturnDataset(  DmPreventa.DeudaClienteTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
               DmPreventa.DeudaClienteTable.Close;
              end;

end;

function TPreventaService.EnviaMovimientos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

type TLineaRespuesta = record
       Id : LongInt;
       Existencias : Decimal;
       end;

var SessionDataModule : TSessionDataModule;
    IdMovimientoActual : LongInt;
    GrupoLineaActual : SmallInt;
    NroOperacionOrigenGrupo : LongInt;
    SaltarDocumentoActual,
    MovimientoDiferente,
    ExistenArticulosPrimerGrupo,
    GrupoLineaActivado : Boolean;
    I : SmallInt;
    NroLineaActual : SmallInt;
    CantidadLinea,
    Existencias : Decimal;
    ClientID,
    CodigoEmpresa,
    CodigoAlmacenUsuario,
    CodigoUsuarioMovil,
    Datos : String;
    ComprobarExistencias,
    ExistenciasInsuficientes : Boolean;
    CodigoEquipoMovil : String;
    JSONContent : String;
    JSONObjectData : TkbmMWONCustomObject;
    JSONObject : TkbmMWJSONObject;
    JSONArray : TkbmMWJSONArray;
    ActualizaDocumento : Boolean;
    ExistenciasArticulo : IExistenciasArticulo;
    LineasRespuesta : Array of TLineaRespuesta;

    MovimientoFields,
    SegundoMovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    UsuarioFields : TUsuarioFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    EquipoMovilFields : TEquipoMovilFields;
    TiposIVAFields : TTiposIVAFields;

    TextoFechaEntrega : String;
    Firma : ByteArray;
    FontName : String;
    FontSize  : SmallInt;

procedure CompletaVinculosCliente;
begin
     With SessionDataModule, Dm30.MovimientoModule, EmpresaFields do
       begin

       If   Cliente_GruposFac.Value
       then MovimientoFields.GrupoFacturacion.Value := ClienteFields.Factura_Agrupacion.Value;

       If   Ventas_PagosPedido.Value
       then MovimientoFields.CodigoFormaCobro.Value := ClienteFields.Cobro_FormaCobro.Value;

       MovimientoFields.CodigoVendedor.Value := Dm30.VendedorModule.VendedorPorDefecto( ClienteFields );

       If   MovimientoFields.CodigoVendedor.Value=''
       then If   EquipoMovilFields.CodigoVendedor.Value=''
            then MovimientoFields.CodigoVendedor.Value := ClienteFields.Vendedor.Value
            else MovimientoFields.CodigoVendedor.Value := EquipoMovilFields.CodigoVendedor.Value;

       end;
end;

procedure LogMessage( Msg : String );
begin
     dmServer.EventLog.WriteString( Msg );
end;

function GetRTFText( AnnotationText : String ) : String;
begin
     Result := StringReplace( RTFText, '[font]', FontName, [ rfReplaceAll ] );
     Result := StringReplace( Result, '[fontsize]', IntToStr( FontSize * 2 ), [ rfReplaceAll ] );
     Result := StringReplace( Result, '[text]', AnnotationText, [ rfReplaceAll ] );
end;

function GetIncrementedUUID( Value : String ) : String;
begin
     var GUUID := StringToGUID( MovimientosDataUUID.Value );
     GUUID.D1 := GUUID.D1 + 1;
     Result := GUUID.ToString;
end;

begin
     Result := False;
     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     Datos := Args[ 3 ];

     If   Length( Args )>4
     then ComprobarExistencias := Args[ 4 ]    // Lo sitúo al final para que sea compatible con versiones anteriores
     else ComprobarExistencias := False;

     ExistenciasInsuficientes := False;

     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule, Dm30 do
            try

              MovimientosData.Database := SessionDataModule.InMemoryDatabase;
              MovimientosData.Open;

              SessionDataModule.Dm00.GetAnnotationsFont( FontName, FontSize );

              MovimientoFields := EquipoMovilModule.DmMovimientoFields;
              LineaMovimientoFields := EquipoMovilModule.DmLineaMovimientoFields;

              UsuarioFields := TUsuarioFields.Create( nil );
              ClienteFields := TClienteFields.Create( nil );
              ArticuloFields := TArticuloFields.Create( nil );
              SerieFacturacionFields := TSerieFacturacionFields.Create( nil );
              EquipoMovilFields := TEquipoMovilFields.Create( nil );
              TiposIVAFields := TTiposIVAFields.Create( nil );
              SegundoMovimientoFields := TMovimientoFields.Create( nil );

              var TransactionTag := SessionDataModule.StartTransactionWith( [ MovimientoFields.Table, LineaMovimientoFields.Table ] );

              try

                EquipoMovilModule.Obten( CodigoEquipoMovil, EquipoMovilFields );

                CodigoAlmacenUsuario := '';
                GrupoLineaActivado := EmpresaFields.Articulo_CamposLibres.Value and ( EmpresaFields.Articulo_CampoLibre[ 9 ].Value<>'' ) and EmpresaFields.Articulo_CampoLib9Agrupacion.Value;

                SaltarDocumentoActual := False;

                //** 06.02.2024 Si el usuario no asignaba un código de usuario al equipo móvil, no se leía su registro. El primer error se producía al leer la serie por defecto.

                CodigoUsuarioMovil := EquipoMovilFields.CodigoUsuario.Value;
                If   CodigoUsuarioMovil=''
                then CodigoUsuarioMovil := '00';

                SessionDataModule.Dm00.UsuarioModule.Obten( CodigoUsuarioMovil, UsuarioFields );
                If   UsuarioFields.Ventas_AlmacenDefecto.Value<>''
                then CodigoAlmacenUsuario := UsuarioFields.Ventas_AlmacenDefecto.Value;

                // Serie := EquipoMovil.DmEquipoMovilFields.Serie.Value;       // Puede que en un futuro

                var TipoMovimiento := 0;
                var FechaMovimiento : TDate := 0;

                JSONObjectData := TkbmMWJSONObject( JSONStreamer.LoadFromUTF8String( TkbmMWPlatformMarshal.UTF8Encode( Datos ) ) );
                If   JSONObjectData is TkbmMWJSONArray
                then begin

                     JSONArray := JSONObjectData as TkbmMWJSONArray;

                     For I := 0 to JSONArray.Count - 1 do
                       begin

                       JSONObject := JSONArray.AsObject[ I ] as TkbmMWJSONObject;

                       MovimientosData.Append;

                       MovimientosDataIdRegistro.Value := JSONObject.AsInteger[ 'Id' ];
                       MovimientosDataIdLinea.Value := JSONObject.AsInteger[ 'IdLinea' ];
                       If   TipoMovimiento=0
                       then TipoMovimiento := JSONObject.AsInteger[ 'TipoMovimiento' ];
                       MovimientosDataUUID.Value := '{' + JSONObject.AsString[ 'UUID' ] + '}';
                       MovimientosDataFechaMovimiento.Value := LibUtils.StrToDate( JSONObject.AsString[ 'Fecha' ] );
                       If   FechaMovimiento=0
                       then FechaMovimiento := MovimientosDataFechaMovimiento.Value;  // Aunque esté repetido en todos los registro el ejercicio es siempre el mismo y es todo lo que necesito
                       MovimientosDataCreado.Value := LibUtils.StrToDateTime( JSONObject.AsString[ 'Creado' ] );

                       TextoFechaEntrega := JSONObject.AsString[ 'FechaEntrega' ];
                       If   ( TextoFechaEntrega='' ) or ( TipoMovimiento=tmVenta ) // Albaran
                       then MovimientosDataFechaEntrega.Value := MovimientosDataFechaMovimiento.Value
                       else MovimientosDataFechaEntrega.Value := LibUtils.StrToDate( TextoFechaEntrega );
                       
                       Firma :=  Base64DecodeArray( JSONObject.GetDefAsString( 'Firma' ) );   // Solo se incluye en el primer registro de la cabecera, para reducir el tamaño del fichero JSON
     	                 MovimientosDataFirma.AsVariant := Firma;
		
                       MovimientosDataCodigoCliente.Value := JSONObject.AsString[ 'CodigoCliente' ];
                       MovimientosDataEntrega.Value := JSONObject.AsDouble[ 'Entrega' ];
                       MovimientosDataCodigoArticulo.Value := JSONObject.AsString[ 'CodigoArticulo' ];
                       MovimientosDataCodigoClaseA.Value := JSONObject.AsString[ 'CodigoClaseA' ];
                       MovimientosDataCodigoClaseB.Value := JSONObject.AsString[ 'CodigoClaseB' ];
                       MovimientosDataCodigoClaseC.Value := JSONObject.AsString[ 'CodigoClaseC' ];
                       MovimientosDataDescripcion.Value := JSONObject.AsString[ 'Descripcion' ];
                       MovimientosDataNroCajas.Value := JSONObject.AsDouble[ 'NroCajas' ];
                       MovimientosDataCantidad.Value := JSONObject.AsDouble[ 'Cantidad' ];
                       MovimientosDataPrecio.Value := JSONObject.AsDouble[ 'Precio' ];
                       MovimientosDataRecargo.Value := JSONObject.GetDefAsDouble( 'Recargo' );
                       MovimientosDataDescuento.Value := JSONObject.AsDouble[ 'Descuento' ];
                       MovimientosDataAnotacion.Value := JSONObject.AsString[ 'Anotacion' ];

                       ArticuloModule.Obten( MovimientosDataCodigoArticulo.Value, ArticuloFields );

                       // De momento, fijo

                       If   GrupoLineaActivado and ArticuloFields.CampoLibre9.Value
                       then MovimientosDataGrupoLinea.Value := 1
                       else MovimientosDataGrupoLinea.Value := 0;

                       MovimientosData.Post;

                       end;  // For I := 0 to JSONArray.Count - 1 do

                     SessionDataModule.Ejercicio := SessionDataModule.EjercicioFecha( FechaMovimiento );

                     var Serie := Dm10.SerieFacturacionModule.ObtenSeriePorDefecto;

                     Dm10.SerieFacturacionModule.Obten( Serie, SerieFacturacionFields );

                     IdMovimientoActual := -1;
                     GrupoLineaActual := -1;

                     MovimientosData.First;  // IdRegistro;GrupoLinea;IdLinea

                     While not MovimientosData.Eof do
                       begin

                       If   not ( SaltarDocumentoActual and ( IdMovimientoActual=MovimientosDataIdRegistro.Value ) )
                       then begin

                            SaltarDocumentoActual := False;

                            If   ComprobarExistencias
                            then begin
                                 ExistenciasArticulo := Dm30.StockAlmacenModule.ObtenStock( MovimientosDataCodigoArticulo.Value,
                                                                                            False,
                                                                                            MovimientosDataCodigoClaseA.Value,
                                                                                            MovimientosDataCodigoClaseB.Value,
                                                                                            MovimientosDataCodigoClaseC.Value,
                                                                                            { TodosLosLotes } True, '',
                                                                                            { TodosLosAlmacenes } True,
                                                                                            '',
                                                                                            { TodasLasUbicaciones } True,
                                                                                            '',
                                                                                            { Obtencoste } False,
                                                                                            SessionDataModule.Ejercicio,
                                                                                            0,
                                                                                            12 );
                                 With ExistenciasArticulo.SumaExistencias do
                                   begin
                                   var ExistenciasVirtuales := Saldo + PendienteRecibir - PendienteServir;
                                   If   ExistenciasVirtuales<MovimientosDataCantidad.Value
                                   then begin
                                        ExistenciasInsuficientes := True;
                                        var LineaErronea : TLineaRespuesta;
                                        LineaErronea.Id := MovimientosDataIdLinea.Value;
                                        If   ExistenciasVirtuales>0.0
                                        then LineaErronea.Existencias := ExistenciasVirtuales
                                        else LineaErronea.Existencias := 0.0;
                                        LineasRespuesta := LineasRespuesta + [ LineaErronea ];
                                        end;
                                   end;

                                 end;

                            If   not ExistenciasInsuficientes  // Una vez se sabe que no hay existencias no vale la pena intentar crear nuevos registros
                            then begin

                                 If   ( IdMovimientoActual<>MovimientosDataIdRegistro.Value ) or   // Un nuevo movimiento
                                      ( GrupoLineaActual<>MovimientosDataGrupoLinea.Value )
                                 then begin

                                      MovimientoDiferente := IdMovimientoActual<>MovimientosDataIdRegistro.Value;
                                      If   MovimientoDiferente
                                      then ExistenArticulosPrimerGrupo := MovimientosDataGrupoLinea.Value=0;

                                      IdMovimientoActual := MovimientosDataIdRegistro.value;
                                      GrupoLineaActual := MovimientosDataGrupoLinea.Value;

                                      ActualizaDocumento := False;

                                      // Con la llamada a esta función se obtiene una referencia a un TMovimientoFields vinculado a un dataset válido

                                      If   MovimientoDiferente and
                                           Dm30.MovimientoModule.ObtenPorUUID( MovimientosDataUUID.Value, MovimientoFields )  // El movimiento ya existe
                                      then begin

                                           If   ( ( TipoMovimiento=tmPedidoVenta ) and ( MovimientoFields.Situacion.Value=epPendiente ) ) or // Es un pedido
                                                ( ( TipoMovimiento=tmVenta ) and ( not MovimientoFields.Facturado.Value ) )
                                           then begin

                                                Dm30.MovimientoModule.SuprimeMovimiento( MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, True );  // Preservando la cabecera

                                                // Aprovecho para suprimir el posible segundo documento

                                                If   GrupoLineaActivado
                                                then begin
                                                     var SegundoDocumentoUUID := GetIncrementedUUID( MovimientosDataUUID.Value );
                                                     If   Dm30.MovimientoModule.ObtenPorUUID( SegundoDocumentoUUID, SegundoMovimientoFields )
                                                     then Dm30.MovimientoModule.SuprimeMovimiento( SegundoMovimientoFields.Ejercicio.Value, SegundoMovimientoFields.NroOperacion.Value );
                                                     end;

                                                ActualizaDocumento := True;
                                                end;

                                           If   not ActualizaDocumento
                                           then begin
                                                SaltarDocumentoActual := True;
                                                Continue;
                                                end;

                                           end;

                                      If   ActualizaDocumento
                                      then MovimientoFields.Table.Edit
                                      else begin

                                           MovimientoFields.Table.Append;

                                           MovimientoFields.TipoMovimiento.Value := TipoMovimiento;

                                           If   not( ( TipoMovimiento=tmPedidoVenta ) and not EmpresaFields.Ventas_SeriesPedido.Value )
                                           then MovimientoFields.Serie.Value := Serie
                                           else MovimientoFields.Serie.Value := '';

                                           MovimientoFields.Ejercicio.Value := Ejercicio;
                                           MovimientoFields.NroOperacion.Value := MovimientoModule.ProximaOperacion;
                                           MovimientoFields.NroDocumento.Value := MovimientoModule.ProximoDocumento( MovimientoFields );

                                           // Genero un nuevo GUUID a partir del maestro para evitar usar otro índice en la tabla  (por ejemplo en NroOperacionOrigen o parecido)

                                           If   ( GrupoLineaActual=0 ) or not ExistenArticulosPrimerGrupo
                                           then MovimientoFields.UUID.AsString := MovimientosDataUUID.Value
                                           else MovimientoFields.UUID.AsString := GetIncrementedUUID( MovimientosDataUUID.Value );

                                           MovimientoFields.Origen.Value := omPreventa;
                                           MovimientoFields.NroDocumentoPropietario.Value := CodigoEquipoMovil;

                                           end;

                                      Dm10.ClienteModule.Obten( MovimientosDataCodigoCliente.Value, ClienteFields );

                                      CompletaVinculosCliente;

                                      MovimientoFields.Fecha.Value := MovimientosDataFechaMovimiento.Value;
                                      MovimientoFields.FechaAplicacion.Value := MovimientosDataFechaEntrega.Value;
                                      MovimientoFields.Propietario.Value := MovimientosDataCodigoCliente.Value;
                                      MovimientoFields.EntregaACuenta.Value := MovimientosDataEntrega.Value;
                                      MovimientoFields.Creado.Value := MovimientosDataCreado.Value;

                                      If   Length( MovimientosDataFirma.Value )>0
                                      then MovimientoFields.Firma.AsVariant := MovimientosDataFirma.AsVariant;

                                      MovimientoFields.Table.Post;

                                      MovimientoModule.RetiraDocumento( MovimientoFields, False );

                                      MovimientoModule.CompruebaPrimerNroPagina( MovimientoFields );

                                      NroLineaActual := 1;

                                      end;

                                 LineaMovimientoFields.Table.Append;

                                 LineaMovimientoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                                 LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                                 LineaMovimientoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                                 LineaMovimientoFields.NroPagina.Value := 0;
                                 LineaMovimientoFields.NroLinea.Value := NroLineaActual;
                                 LineaMovimientoFields.CodigoArticulo.Value := MovimientosDataCodigoArticulo.Value;
                                 LineaMovimientoFields.CodigoClaseA.Value := MovimientosDataCodigoClaseA.Value;
                                 LineaMovimientoFields.CodigoClaseB.Value := MovimientosDataCodigoClaseB.Value;
                                 LineaMovimientoFields.CodigoClaseC.Value := MovimientosDataCodigoClaseC.Value;
                                 LineaMovimientoFields.UIDArticulo.AsGuid := ArticuloModule.Identificador;
                                 LineaMovimientoFields.Descripcion.Value := MovimientosDataDescripcion.Value;

                                 LineaMovimientoFields.NroCajas.Value := MovimientosDataNroCajas.Value;
                                 If   MovimientoFields.TipoMovimiento.Value=tmVenta
                                 then LineaMovimientoFields.Cantidad.Value := -MovimientosDataCantidad.Value
                                 else LineaMovimientoFields.Cantidad.Value := MovimientosDataCantidad.Value;

                                 LineaMovimientoFields.CantidadAjustada.Value := MovimientosDataCantidad.Value;

                                 ArticuloModule.Obten( MovimientosDataCodigoArticulo.Value, ArticuloFields );

                                 If   CodigoAlmacenUsuario<>''
                                 then LineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacenUsuario
                                 else LineaMovimientoFields.CodigoAlmacen.Value := ArticuloFields.CodigoAlmacen.Value;

                                 LineaMovimientoFields.Ubicacion.Value := SessionDataModule.Dm30.AlmacenModule.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );
                                 LineaMovimientoFields.PuntoVerde.Value := ArticuloFields.PuntoVerde.Value;

                                 // Articulo.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value, DmLineaMovimientoFields, ClienteModule.DmClienteFields, DmArticuloFields );

                                 LineaMovimientoFields.Precio.Value := MovimientosDataPrecio.Value;
                                 LineaMovimientoFields.Recargo.Value := MovimientosDataRecargo.Value;
                                 LineaMovimientoFields.Descuento.Value := MovimientosDataDescuento.Value;

                                 FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, MovimientoFields.IVAIncluido.Value );

                                 If   MovimientosDataAnotacion.Value<>''
                                 then LineaMovimientoFields.Anotacion.Value := GetRTFText( MovimientosDataAnotacion.Value );

                                 StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields );

                                 LineaMovimientoFields.Table.Post;

                                 Inc( NroLineaActual );
                                 end;

                            end;

                       MovimientosData.Next;
                       end;

                    If   ExistenciasInsuficientes
                    then begin

                         // Construir la respuesta con las líneas que contienen existencias insuficientes

                         var ArrayHigh := Length( LineasRespuesta ) - 1;
                         Result := VarArrayCreate( [ 0, ArrayHigh ], varVariant );
                         For var Index := 0 to ArrayHigh do
                           begin

                           var LineaArray := VarArrayCreate( [ 0, 1 ], varVariant );
                           LineaArray[ 0 ] := LineasRespuesta[ Index ].Id;
                           LineaArray[ 1 ] := LineasRespuesta[ Index ].Existencias;

                           Result[ Index ] := LineaArray;

                           end;

                         TransactionTag.Rollback;
                         end
                    else begin
                         TransactionTag.Commit;
                         Result := True;
                         end;

                    end;

              except on E : Exception do
                begin
                TransactionTag.Rollback;
                LogException( E, Self );
                end;
              end;

            finally
              MovimientosData.Close;
              ClienteFields.Free;
              ArticuloFields.Free;
              SerieFacturacionFields.Free;
              EquipoMovilFields.Free;
              TiposIVAFields.Free;
              SegundoMovimientoFields.Free;

              MovimientoFields.Table.Cancel;
              LineaMovimientoFields.Table.Cancel;
              end;
end;

function TPreventaService.EnviaLocalizaciones(       ClientIdent : TkbmMWClientIdentity;
                                               const Args        : array of Variant ) : Variant;

var SessionDataModule : TSessionDataModule;
    I : SmallInt;
    ClientID,
    CodigoEmpresa,
    Datos : String;
    CodigoEquipoMovil : String;
    JSONObjectData : TkbmMWONCustomObject;
    JSONObject : TkbmMWJSONObject;
    JSONArray : TkbmMWJSONArray;

    // Registro

    Codigo : String;
    Latitud,
    Longitud : Double;

begin
     Result := False;
     ExtractArgs ( Args, ClientID, CodigoEmpresa, CodigoEquipoMovil );
     Datos := Args[ 3 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, CodigoEquipoMovil, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              JSONObjectData := TkbmMWJSONObject( JSONStreamer.LoadFromUTF8String( TkbmMWPlatformMarshal.UTF8Encode( Datos ) ) );
              If   JSONObjectData is TkbmMWJSONArray
              then begin

                   JSONArray := JSONObjectData as TkbmMWJSONArray;

                   For I := 0 to JSONArray.Count - 1 do
                     begin

                     JSONObject := JSONArray.AsObject[ I ] as TkbmMWJSONObject;

                     Codigo := JSONObject.AsString[ 'Codigo' ];
                     Latitud := JSONObject.AsDouble[ 'Latitud' ];
                     Longitud := JSONObject.AsDouble[ 'Longitud' ];

                     Dm10.ClienteModule.ActualizaLocalizacion( Codigo, Latitud, Longitud );
                     end;

                   end;

              Result := True;

            except
              end;

end;

end.


