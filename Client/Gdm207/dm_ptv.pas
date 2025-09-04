unit dm_ptv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb, cxEdit,

  dxTokenEdit,

  DataManager,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim207Fields,

  dmi_iva,
  dmi_sdt,

  clJSON;

type

  TParametrosTiendaVirtualModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    DmTarifaVentasFields : TTarifaVentasFields;

    FToken : String;

    function GetGrupoConIVAIncluido(Index: SmallInt): Boolean;
    function GetGrupoModeloImpositivo(Index: SmallInt): SmallInt;
    procedure SetGrupoConIVAIncluido(Index: SmallInt;const Value: Boolean);
    procedure SetGrupoModeloImpositivo(Index: SmallInt; const Value: SmallInt);
    function GetGrupoCodigoTarifa( Index : SmallInt ) : String;
    procedure SetGrupoCodigoTarifa( Index : SmallInt; Value : String );
    function GetGrupoSerie( Index : SmallInt ) : String;
    procedure SetGrupoSerie( Index : SmallInt; Value : String );
    function GetGrupoNombre(Index: SmallInt): String;
    procedure SetGrupoNombre(Index: SmallInt; const Value: String);
    function GetNombreUsuario: String;
    function GetPassword: String;

    procedure DoOnCheckStoreUser( UnNombreUsuario, UnPassword : String );

  protected

    FHost : String;                    // Dirección de la Web
    FMainWebSiteId : SmallInt;
    FLastAccess : TDateTime;
    FNombreCategoriaRaiz : String;
    FImagenesExternas : Boolean;
    FDirectorioImagenes,
    FFormatoImagenes : String;
    FNoPublicarArticulosSinImagen,
    FNoPublicarArticulosSinPrecio,
    FPublicarArticulosSinExistencias,
    FNoIncluirPendienteRecibir,
    FPreciosConDescuentoPrevio,
    FCamposLibresComoAtributos : Boolean;
    FAtributoPorcentajeDescuento,
    FNombreAtributo1 : String;
    FPreciosConIVAIncluido : Boolean;   // Los precios en la tienda son con IVA incluido
    FPublicarArticulosAlmacenSeleccionado : Boolean;
    FPublicarClasesComoConfiguraciones : Boolean;
    FUnidadesSonCajas : Boolean;

    FGrupoNombre : array[ 0..LastCustomerGroupIndex ] of String;
    FGrupoCodigoTarifa : array[ 0..LastCustomerGroupIndex ] of String;
    FGrupoModeloImpositivo : array[ 0..LastCustomerGroupIndex ] of SmallInt;
    FGrupoConIVAIncluido : array[ 0..LastCustomerGroupIndex ] of Boolean;
    FGrupoSerie : array[ 0..LastCustomerGroupIndex ] of String;

    FCodigoFormaCobro,
    FPlantillaCodigoCliente : String;
    FSeleccionAlmacen : SmallInt;
    FCodigoAlmacen : String;
    FArticulosPorGrupoCliente,
    FPreciosPorCliente : Boolean;

    FAplicarPreciosyDtos : Boolean;
    FEstadoPedidosADescargar,
    FEstadoPedidosEnviados : String;

  public

    procedure SuprimeRegistrosGruposClientes;

    function GetAuthorization( UnHost : String = ''; UnNombreUsuario : String = ''; UnPassword : String = '' ) : Boolean;
    function GetMainWebSiteId : SmallInt;
    function BaseURL( Func : String ) : String;

    property Host : String read FHost write FHost;
    property Token : String read FToken;
    property MainWebSiteId : SmallInt read FMainWebSiteId;
    property NombreUsuario : String read GetNombreUsuario;
    property Password : String read GetPassword;
    property NombreCategoriaRaiz : String read FNombreCategoriaRaiz write FNombreCategoriaRaiz;
    property ImagenesExternas : Boolean read FImagenesExternas write FImagenesExternas;
    property DirectorioImagenes : String read FDirectorioImagenes write FDirectorioImagenes;
    property FormatoImagenes : String read FFormatoImagenes write FFormatoImagenes;
    property NoPublicarArticulosSinImagen : Boolean read FNoPublicarArticulosSinImagen write FNoPublicarArticulosSinImagen;
    property NoPublicarArticulosSinPrecio : Boolean read FNoPublicarArticulosSinPrecio write FNoPublicarArticulosSinPrecio;
    property PublicarArticulosSinExistencias : Boolean read FPublicarArticulosSinExistencias write FPublicarArticulosSinExistencias;
    property NoIncluirPendienteRecibir : Boolean read FNoIncluirPendienteRecibir write FNoIncluirPendienteRecibir;
    property PreciosConDescuentoPrevio : Boolean read FPreciosConDescuentoPrevio write FPreciosConDescuentoPrevio;
    property AtributoPorcentajeDescuento : String read FAtributoPorcentajeDescuento write FAtributoPorcentajeDescuento;
    property CamposLibresComoAtributos : Boolean read FCamposLibresComoAtributos write FCamposLibresComoAtributos;
    property NombreAtributo1 : String read FNombreAtributo1 write FNombreAtributo1;
    property PreciosConIVAIncluido : Boolean read FPreciosConIVAIncluido write FPreciosConIVAIncluido;
    property PublicarArticulosAlmacenSeleccionado : Boolean read FPublicarArticulosAlmacenSeleccionado write FPublicarArticulosAlmacenSeleccionado;
    property PublicarClasesComoConfiguraciones : Boolean read FPublicarClasesComoConfiguraciones write FPublicarClasesComoConfiguraciones;
    property UnidadesSonCajas : Boolean read FUnidadesSonCajas write FUnidadesSonCajas;

    // Grupos de clientes

    property GrupoNombre[ Index : SmallInt ] : String read GetGrupoNombre write SetGrupoNombre;
    property GrupoCodigoTarifa[ Index : SmallInt ] : String read GetGrupoCodigoTarifa write SetGrupoCodigoTarifa;
    property GrupoModeloImpositivo[ Index : SmallInt ] : SmallInt read GetGrupoModeloImpositivo write SetGrupoModeloImpositivo;
    property GrupoConIVAIncluido[ Index : SmallInt ] : Boolean read GetGrupoConIVAIncluido write SetGrupoConIVAIncluido;
    property GrupoSerie[ Index : SmallInt ] : String read GetGrupoSerie write SetGrupoSerie;

    property CodigoFormaCobro : String read FCodigoFormaCobro write FCodigoFormaCobro;
    property PlantillaCodigoCliente : String read FPlantillaCodigoCliente write FPlantillaCodigoCliente;
    property SeleccionAlmacen : SmallInt read FSeleccionAlmacen write FSeleccionAlmacen;
    property CodigoAlmacen : String read FCodigoAlmacen write FCodigoAlmacen;
    property PreciosPorCliente : Boolean read FPreciosPorCliente write FPreciosPorCliente;
    property ArticulosPorGrupoCliente : Boolean read FArticulosPorGrupoCliente write FArticulosPorGrupoCliente;

    // Pedidos

    property AplicarPreciosyDtos : Boolean read FAplicarPreciosyDtos write FAplicarPreciosyDtos;
    property EstadoPedidosADescargar : String read FEstadoPedidosADescargar write FEstadoPedidosADescargar;
    property EstadoPedidosEnviados : String read FEstadoPedidosEnviados write FEstadoPedidosEnviados;

  end;

var ParametrosTiendaVirtualModule : TParametrosTiendaVirtualModule = nil;

function ParametrosTiendaVirtual : TParametrosTiendaVirtualModule;
procedure ActualizaParametrosTiendaVirtual;

implementation

uses LibUtils,
     DateUtils,

     EnterpriseDataAccess,
     AppManager,
     RestRpcData,

     Gdm00Dm,
     Gdm00Frm,
     Gdm30Frm,

     f_cnf207,

     dm_pga,
     dm_reg,

     a_usr,

     b_2fa,
     b_sdt207;

{$R *.dfm}

resourceString
     RsMsg1 = 'Se ha accedido correctamente a la tienda virtual.';
     RsMsg2 = 'No se ha podido acceder a la tienda virtual.';
     RsMsg3 = 'Revise la dirección, nombre de usuario y palabra de paso.';

function ParametrosTiendaVirtual : TParametrosTiendaVirtualModule;
begin
     CreateDataModule( TParametrosTiendaVirtualModule, ParametrosTiendaVirtualModule );
     Result := ParametrosTiendaVirtualModule;
end;

procedure ActualizaParametrosTiendaVirtual;

var  I : SmallInt;
     ValorIdTasa,
     ValorGrupoNombre : String;

begin
     ParametrosTiendaVirtual;
     If   Assigned( ParametrosTiendaVirtualModule )
     then begin

          Registro.ClavePadre := CodigoEmpresaActual + '.' + ncrParametrosTiendaVirtual;

          With ParametrosTiendaVirtual do
            begin

            Host := Registro.ObtenValorString( ncrHost );

            // Artículos

            NombreCategoriaRaiz := Registro.ObtenValorString( ncrNombreCategoriaRaiz );
            ImagenesExternas := StrToBoolDef( Registro.ObtenValorString( ncrImagenesExternas ), False );
            DirectorioImagenes := Registro.ObtenValorString( ncrDirectorioImagenes );
            FormatoImagenes := Registro.ObtenValorString( ncrFormatoImagenes );
            If   FormatoImagenes=''
            then FormatoImagenes := 'jpg';
            SeleccionAlmacen := StrToIntDef( Registro.ObtenValorString( ncrSeleccionAlmacen ), 0 );
            CodigoAlmacen := Registro.ObtenValorString( ncrCodigoAlmacen );
            NoPublicarArticulosSinImagen := StrToBoolDef( Registro.ObtenValorString( ncrNoPublicarArticulosSinImagen ), False );
            NoPublicarArticulosSinPrecio := StrToBoolDef( Registro.ObtenValorString( ncrNoPublicarArticulosSinPrecio ), False );
            PublicarArticulosSinExistencias := StrToBoolDef( Registro.ObtenValorString( ncrPublicarArticulosSinExistencias), False );
            NoIncluirPendienteRecibir := StrToBoolDef( Registro.ObtenValorString( ncrNoIncluirPendienteRecibir), False );
            PreciosConDescuentoPrevio := StrToBoolDef( Registro.ObtenValorString( ncrPreciosConDescuentoPrevio ), False );
            CamposLibresComoAtributos := StrToBoolDef( Registro.ObtenValorString( ncrCamposLibresComoAtributos ), False );
            NombreAtributo1 := Registro.ObtenValorString( ncrNombreAtributo1 );
            PreciosConIVAIncluido := StrToBoolDef( Registro.ObtenValorString( ncrPreciosConIVAIncluido ), False );
            PublicarArticulosAlmacenSeleccionado := StrToBoolDef( Registro.ObtenValorString( ncrPublicarArticulosAlmacenSeleccionado ), False );
            PublicarClasesComoConfiguraciones := StrToBoolDef( Registro.ObtenValorString( ncrPublicarClasesComoConfiguraciones ), False );
            UnidadesSonCajas := StrToBoolDef( Registro.ObtenValorString( ncrUnidadesSonCajas ), False );

            // Clientes

            For I := 0 to LastCustomerGroupIndex do
              begin
              ValorGrupoNombre := Registro.ObtenValorString( ncrGrupoNombre + IntToStr( I ) );
              If   ValorGrupoNombre<>''
              then begin
                   GrupoNombre[ I ] := ValorGrupoNombre;
                   GrupoCodigoTarifa[ I ] := Registro.ObtenValorString( ncrGrupoCodigoTarifa + IntToStr( I ) );
                   GrupoModeloImpositivo[ I ] := StrToIntDef( Registro.ObtenValorString( ncrGrupoModeloImpositivo + IntToStr( I ) ), micSinRe );
                   GrupoConIVAIncluido[ I ] := StrToBoolDef( Registro.ObtenValorString( ncrGrupoConIVAIncluido + IntToStr( I ) ), False );
                   GrupoSerie[ I ] := Registro.ObtenValorString( ncrGrupoSerie + IntToStr( I ) );
                   end
              else begin
                   GrupoNombre[ I ] := '';
                   GrupoModeloImpositivo[ I ] := micSinRE;
                   end;
              end;

            CodigoFormaCobro := Registro.ObtenValorString( ncrCodigoFormaCobro );
            PlantillaCodigoCliente := Registro.ObtenValorString( ncrPlantillaCodigoCliente );
            PreciosPorCliente := StrToBoolDef( Registro.ObtenValorString( ncrPreciosPorCliente ), False );
            ArticulosPorGrupoCliente := StrToBoolDef( Registro.ObtenValorString( ncrArticulosPorGrupoCliente ), False );

            // Pedidos

            AplicarPreciosyDtos := Registro.ObtenValorBool( ncrAplicarPreciosyDtos );
            EstadoPedidosADescargar := Registro.ObtenValorString( ncrEstadoPedidosADescargar );
            EstadoPedidosEnviados := Registro.ObtenValorString( ncrEstadoPedidosEnviados );

            end;

          end;
end;

procedure TParametrosTiendaVirtualModule.DataModuleCreate(Sender: TObject);
begin
     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moTiendaVirtual );
end;

procedure TParametrosTiendaVirtualModule.DataModuleDestroy(Sender: TObject);
begin
     ParametrosTiendaVirtualModule := nil;
end;

procedure TParametrosTiendaVirtualModule.DoOnCheckStoreUser( UnNombreUsuario, UnPassword : String );
begin
     If   GetAuthorization( ParametrosTiendaVirtual.Host, UnNombreUsuario, UnPassword )
     then ShowNotification( ntInformation, RsMsg1 )
     else ShowNotification( ntError, RsMsg2, RsMsg3 );
end;

function TParametrosTiendaVirtualModule.BaseURL( Func : String ) : String;
begin
     Result := FHost + '/index.php/rest/V1/' + Func;
end;

function TParametrosTiendaVirtualModule.GetAuthorization( UnHost           : String = '';
                                                          UnNombreUsuario  : String = '';
                                                          UnPassword       : String = '' ) : Boolean;

var  ResponseObject : TclJsonObject;
     HTTPResult : Integer;
     ErrorMessage : String;

procedure UpdateAccessParameters;
begin

     RestRpc.Host := UnHost;
     RestRpc.UserName := UnNombreUsuario;
     RestRpc.Password := UnPassword;

     FToken := RestRpc.ResponseText.DeQuotedString( '"' );
     RestRpc.Authorization := 'Bearer ' + FToken;

end;

begin
     Result := False;

     {
     If   MinutesBetween( Now, FLastAccess )<230  // Dejo un margen de 10 minutos. TODO: Por defecto son 4 horas, pero podría ser configurable
     then begin
          FMainWebSiteId := GetMainWebSiteId;
          If   FMainWebSiteId<>-1
          then begin
               Result := True;
               Exit;  // El token sigue siendo válido
               end;
          end;
     }

     var Parameters := TclJsonObject.Create;

     try

       FToken := '';

       If   UnHost=''
       then begin
            UnHost := Host;
            UnNombreUsuario := NombreUsuario;
            UnPassword := Password;
            end;

       Parameters.AddString( 'username', UnNombreUsuario );
       Parameters.AddString( 'password', UnPassword );

       try
         Result := RestRpc.Post( UnHost + '/index.php/rest/V1/integration/admin/token', Parameters );
         If   Result
         then UpdateAccessParameters
         else If   Assigned( RestRpc.ResponseJSON )
              then begin
                   ResponseObject := RestRpc.ResponseJSON as TclJsonObject;
                   ErrorMessage := ResponseObject.ValueByName( 'message' );
                   If   Pos( '2fa', ErrorMessage )<>-1
                   then If   SolicitaCodigoActivacion=mrOk
                        then begin
                             Parameters.AddString( 'otp', TBox2faForm.CodigoActivacion );
                             Result := RestRpc.Post( UnHost + '/index.php/rest/V1/tfa/provider/google/authenticate', Parameters );
                             If   Result
                             then UpdateAccessParameters;
                             end;
                   end;

         If   Result
         then begin
              FMainWebSiteId := GetMainWebSiteId;
              FLastAccess := Now;
              end;

       except on E : Exception do
         RestRPC.ErrorMessage := E.Message;
         end;

     finally
       Parameters.Free;
       end;
end;

function TParametrosTiendaVirtualModule.GetMainWebSiteId : SmallInt;

var  WebSites : TclJSONArray;
     Elemento : TclJsonObject;
     I : SmallInt;
     Id : Integer;
     Name : String;

begin
     Result := -1;
     try
       If   RestRpc.Get( BaseURL( 'store/websites' ) )
       then If   Assigned( RestRpc.ResponseJSONArray )
            then begin
                 WebSites := RestRpc.ResponseJSONArray;
                 If   WebSites.Count>0
                 then begin
                      For I := 0 to WebSites.Count- 1 do
                        begin
                        Elemento := WebSites.Objects[ I ];
                        Id := StrToInt( Elemento.ValueByName( 'id' ) );
                        Name := Elemento.ValueByName( 'name' );
                        If   Name='Main Website'
                        then begin
                             Result := Id;
                             Exit;
                             end;
                        end;
                      end;
                 end;
     except on E : Exception do
       RestRPC.ErrorMessage := E.Message;
       end;
end;

function TParametrosTiendaVirtualModule.GetGrupoCodigoTarifa(Index: SmallInt): String;
begin
     Result := FGrupoCodigoTarifa[ Index ];
end;

function TParametrosTiendaVirtualModule.GetGrupoSerie(Index: SmallInt): String;
begin
     Result := FGrupoSerie[ Index ];
end;

function TParametrosTiendaVirtualModule.GetGrupoConIVAIncluido(Index: SmallInt): Boolean;
begin
     Result := FGrupoConIVAIncluido[ Index ];
end;

function TParametrosTiendaVirtualModule.GetGrupoModeloImpositivo( Index : SmallInt ) : SmallInt;
begin
     Result := FGrupoModeloImpositivo[ Index ];
end;

function TParametrosTiendaVirtualModule.GetGrupoNombre(Index: SmallInt): String;
begin
     Result := FGrupoNombre[ Index ];
end;

function TParametrosTiendaVirtualModule.GetNombreUsuario: String;
begin
     Result := DataModule00.DmUsuarioFields.Tienda_NombreUsuario.Value;
end;

function TParametrosTiendaVirtualModule.GetPassword: String;
begin
     Result := DataModule00.DmUsuarioFields.Tienda_Password.Value;
end;

procedure TParametrosTiendaVirtualModule.SetGrupoCodigoTarifa(Index: SmallInt; Value: String);
begin
     FGrupoCodigoTarifa[ Index ] := Value;
end;

procedure TParametrosTiendaVirtualModule.SetGrupoSerie(Index: SmallInt; Value: String);
begin
     FGrupoSerie[ Index ] := Value;
end;

procedure TParametrosTiendaVirtualModule.SetGrupoConIVAIncluido(Index: SmallInt; const Value: Boolean);
begin
     FGrupoConIVAIncluido[ Index ] := Value;
end;

procedure TParametrosTiendaVirtualModule.SetGrupoModeloImpositivo( Index: SmallInt;const Value: SmallInt );
begin
     FGrupoModeloImpositivo[ Index ] := Value;
end;

procedure TParametrosTiendaVirtualModule.SetGrupoNombre(Index: SmallInt;const Value: String);
begin
     FGrupoNombre[ Index ] := Value;
end;

procedure TParametrosTiendaVirtualModule.SuprimeRegistrosGruposClientes;

var  I : SmallInt;

begin
     For I := 0 to LastCustomerGroupIndex do
       begin
       Registro.SuprimeClave( ncrGrupoNombre + IntToStr( I ) );
       Registro.SuprimeClave( ncrGrupoCodigoTarifa + IntToStr( I ) );
       Registro.SuprimeClave( ncrGrupoModeloImpositivo + IntToStr( I ) );
       Registro.SuprimeClave( ncrGrupoConIVAIncluido + IntToStr( I ) );
       Registro.SuprimeClave( ncrGrupoSerie + IntToStr( I ) );
       end;
end;

procedure SetupModule;
begin
     ParametrosTiendaVirtual;
end;

procedure SetupMntUsuario;
begin
     If   Assigned( MntUsrForm )
     then MntUsrForm.OnCheckStoreUser := ParametrosTiendaVirtual.DoOnCheckStoreUser;
end;

initialization

   AddProcedure( imStartup, 0, SetupModule );

   AddProcedure( imGetParamConf, 0, ActualizaParametrosTiendaVirtual );

   AddProcedure( imOnCreateComponent, idMntUsrForm, SetupMntUsuario );

end.


