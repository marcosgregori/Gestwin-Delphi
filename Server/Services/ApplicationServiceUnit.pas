
unit ApplicationServiceUnit;

{$I kbmMW.inc}

interface

uses
  SysUtils,
{$ifdef LEVEL6}
  Variants,
{$else}
  VCL.Forms,
{$endif}
  Classes,
  TypInfo,
  Rtti,
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
  kbmMWQueryService, kbmMWJSONStreamFormat;

type
  TApplicationService = class(TkbmMWQueryService)
    procedure kbmMWQueryServiceCreate(Sender: TObject);
  private

     { Private declarations }
  protected
    function ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant; override;

    function CierraSesion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

    function ObtenEmpresas(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenUsuarios(ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;
    function ObtenPaises(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenProvincias(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenCodigosPostales(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

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

     nxDB,

     DateUtils,
     LibUtils,

     AppManager,
     MainData,
     ServerContainer,
     BaseSessionData,
     SessionData,

     Gsm00Dm,

     dm_pai,
     dm_prv,
     dm_cop;


{$R *.dfm}

const ServiceName = 'Aplicacion';

// Service definitions.
//---------------------

class function TApplicationService.GetPrefServiceName:string;
begin
     Result := 'Aplicacion';
end;

class function TApplicationService.GetFlags:TkbmMWServiceFlags;
begin
     Result:=[mwsfListed];
end;

class function TApplicationService.GetVersion:string;
begin
     Result:='1.0';
end;

procedure TApplicationService.kbmMWQueryServiceCreate(Sender: TObject);
begin
     BoundTransport := ServerContainerModule.ServerTransport;
     TransportStreamFormat := ServerContainerModule.JSONStreamFormat;
end;

function TApplicationService.ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   AFunc : String;

begin
     AFunc:=UpperCase(Func);
     if AFunc='OBTENEMPRESAS' then
        Result:=ObtenEmpresas(ClientIdent,Args)
     else if AFunc='OBTENUSUARIOS' then
        Result:=ObtenUsuarios(ClientIdent,Args)
     else if AFunc='OBTENPAISES' then
        Result:=ObtenPaises(ClientIdent,Args)
     else if AFunc='OBTENPROVINCIAS' then
        Result:=ObtenProvincias(ClientIdent,Args)
     else if AFunc='OBTENCODIGOSPOSTALES' then
        Result:=ObtenCodigosPostales(ClientIdent,Args)
     else if AFunc='CIERRASESION' then
        Result:=CierraSesion(ClientIdent,Args)
     else Result := inherited ProcessRequest( Func, ClientIdent, Args );
end;


function TApplicationService.CierraSesion(        ClientIdent : TkbmMWClientIdentity;
                                           const Args        : array of Variant ) : Variant;

var   SessionDataModule : TSessionDataModule;
      ClientID : String;

begin
     ClientID := Args[ 0 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', '' );
     If   Assigned( SessionDataModule )
     then SessionDataModule.Free;
     Result := VarNull;
end;

function TApplicationService.ObtenEmpresas( ClientIdent : TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  ClientID : String;
     SessionDataModule : TSessionDataModule;
     NroAplicacion : SmallInt;
     SQLText : String;

begin
     Result := VarNull;
     ClientID := Args[ 0 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', '' );
     If   Assigned( SessionDataModule )
     then begin
          // NroAplicacion : 0 = Capturador, 1 = Preventa, 2 = TPV
          If   High( Args )=1
          then NroAplicacion := Args[ 1 ]
          else NroAplicacion := 0;
          SQLText := 'SELECT Codigo, Nombre, Compras_NrosSerie, Ventas_NrosSerie, Ventas_DecCantidad, Ventas_DecCajas, Ventas_DecPrecio, Ventas_DecRecargo, Ventas_Recargos, Ventas_NombreRecargos, Ventas_EditarBultosAlbaran, ' +
                     '       Compras_FechaCaducidad, Ventas_FechaCaducidad, ' +
                     '       Articulo_ExisteClase1, Articulo_ExisteClase2, Articulo_ExisteClase3, Articulo_NombreClase1, Articulo_NombreClase2, Articulo_NombreClase3, ' +
                     '       Articulo_Cajas, Articulo_TarifaClase, ' +
                     '       Cliente_DtosTarifas, Cliente_Referencias, Cliente_TarCodigo, ' +
                     '       Stock_MultiAlmacen, Stock_Ubicaciones, Stock_LotesProductos ' +
                     'FROM Empresa';
          If   NroAplicacion=1
          then StrAdd( SQLText, ' WHERE Ventas_PreAutoVenta<>0' );
          SessionDataModule.OpenGlobalFiles;  // Por si acaso. En los procesos de actualización de la base de datos, por ejemplo, se cierran.
          SessionDataModule.MainQuery.SQL.Text := SQLText;
          SessionDataModule.MainQuery.Open;
          Result := ReturnDataset( SessionDataModule.MainQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TApplicationService.ObtenUsuarios( ClientIdent : TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  SessionDataModule : TSessionDataModule;
     ClientID : String;
     SQLText : String;

begin
     Result := VarNull;
     ClientID := Args[ 0 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', '' );
     If   Assigned( SessionDataModule )
     then begin
          SQLText := 'SELECT Codigo AS Codigo, Nombre FROM Usuario';
          SessionDataModule.OpenGlobalFiles;
          SessionDataModule.MainQuery.SQL.Text := SQLText;
          SessionDataModule.MainQuery.Open;
          Result := ReturnDataset( SessionDataModule.MainQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TApplicationService.ObtenPaises(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  SessionDataModule : TSessionDataModule;
     ClientID : String;

begin
     Result := VarNull;
     ClientID := Args[ 0 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', '' );
     If   Assigned( SessionDataModule )
     then begin
          SessionDataModule.OpenGlobalFiles;
          SessionDataModule.MainQuery.SQL.Text := 'SELECT * FROM Pais';
          SessionDataModule.MainQuery.Open;
          Result := ReturnDataset( SessionDataModule.MainQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TApplicationService.ObtenProvincias(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  SessionDataModule : TSessionDataModule;
     ClientID : String;

begin
     Result := VarNull;
     ClientID := Args[ 0 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', '' );
     If   Assigned( SessionDataModule )
     then begin
          SessionDataModule.OpenGlobalFiles;
          SessionDataModule.MainQuery.SQL.Text := 'SELECT * FROM Provincia';
          SessionDataModule.MainQuery.Open;
          Result := ReturnDataset( SessionDataModule.MainQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TApplicationService.ObtenCodigosPostales(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  SessionDataModule : TSessionDataModule;
     ClientID : String;

begin
     Result := VarNull;
     ClientID := Args[ 0 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', '' );
     If   Assigned( SessionDataModule )
     then begin
          SessionDataModule.OpenGlobalFiles;
          SessionDataModule.MainQuery.SQL.Text := 'SELECT * FROM CodigoPostal';
          SessionDataModule.MainQuery.Open;
          Result := ReturnDataset( SessionDataModule.MainQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

end.

