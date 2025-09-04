
unit dm_pde207;

interface

uses
  Windows, Messages, SysUtils, Classes,

  nxllTransport,
  nxptBasePooledTransport,
  nxllSimpleSession,
  nxllComponent,
  nxllPluginBase,
  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginClient,

  DataManager,
  ServerDataModule,
  DB,
  nxdb,

  Gim00Fields,

  dmi_sdt;

type
  TConfiguracionTiendaVirtualModule = class(TServerDataModule)
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    FNombreCategoriaRaiz : String;
    FImagenesExternas : Boolean;
    FDirectorioImagenes,
    FFormatoImagenes : String;
    FNoPublicarArticulosSinImagen,
    FNoPublicarArticulosSinPrecio,
    FPreciosConDescuentoPrevio,
    FCamposLibresComoAtributos : Boolean;
    FNombreAtributo1 : String;
    FPreciosConIVAIncluido : Boolean;   // Los precios en la tienda son con IVA incluido
    FPublicarArticulosAlmacenSeleccionado : Boolean;
    FPublicarClasesComoConfiguraciones : Boolean;
    FUnidadesSonCajas : Boolean;

    FGrupoNombre : array[ 0..LastCustomerGroupIndex ] of String;
    FGrupoCodigoTarifa : array[ 0..LastCustomerGroupIndex ] of String;
    FGrupoModeloImpositivo : array[ 0..LastCustomerGroupIndex ] of SmallInt;
    FGrupoConIVAIncluido : array[ 0..LastCustomerGroupIndex ] of Boolean;

    FCodigoFormaCobro,
    FPlantillaCodigoCliente : String;
    FSeleccionAlmacen : SmallInt;
    FCodigoAlmacen : String;
    FArticulosPorGrupoCliente,
    FPreciosPorCliente : Boolean;

    FAplicarPreciosyDtos : Boolean;
    FEstadoPedidosADescargar,
    FEstadoPedidosEnviados : String;

    function GetGrupoCodigoTarifa(Index: SmallInt): String;
    function GetGrupoConIVAIncluido(Index: SmallInt): Boolean;
    function GetGrupoModeloImpositivo(Index: SmallInt): SmallInt;
    function GetGrupoNombre(Index: SmallInt): String;
    function GetNombreUsuario: String;

  public

    procedure ActualizaParametros;

    property NombreCategoriaRaiz : String read FNombreCategoriaRaiz write FNombreCategoriaRaiz;
    property ImagenesExternas : Boolean read FImagenesExternas write FImagenesExternas;
    property DirectorioImagenes : String read FDirectorioImagenes write FDirectorioImagenes;
    property FormatoImagenes : String read FFormatoImagenes write FFormatoImagenes;
    property NoPublicarArticulosSinImagen : Boolean read FNoPublicarArticulosSinImagen write FNoPublicarArticulosSinImagen;
    property NoPublicarArticulosSinPrecio : Boolean read FNoPublicarArticulosSinPrecio write FNoPublicarArticulosSinPrecio;
    property PreciosConDescuentoPrevio : Boolean read FPreciosConDescuentoPrevio write FPreciosConDescuentoPrevio;
    property CamposLibresComoAtributos : Boolean read FCamposLibresComoAtributos write FCamposLibresComoAtributos;
    property NombreAtributo1 : String read FNombreAtributo1 write FNombreAtributo1;
    property PreciosConIVAIncluido : Boolean read FPreciosConIVAIncluido write FPreciosConIVAIncluido;
    property PublicarArticulosAlmacenSeleccionado : Boolean read FPublicarArticulosAlmacenSeleccionado write FPublicarArticulosAlmacenSeleccionado;
    property PublicarClasesComoConfiguraciones : Boolean read FPublicarClasesComoConfiguraciones write FPublicarClasesComoConfiguraciones;
    property UnidadesSonCajas : Boolean read FUnidadesSonCajas write FUnidadesSonCajas;

    // Grupos de clientes

    property GrupoNombre[ Index : SmallInt ] : String read GetGrupoNombre;
    property GrupoCodigoTarifa[ Index : SmallInt ] : String read GetGrupoCodigoTarifa;
    property GrupoModeloImpositivo[ Index : SmallInt ] : SmallInt read GetGrupoModeloImpositivo;
    property GrupoConIVAIncluido[ Index : SmallInt ] : Boolean read GetGrupoConIVAIncluido;

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

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   Variants,
       Math,

       LibUtils,

       AppManager,
       SessionData,

       Gsm00Dm,

       dmi_iva,

       MainData;

procedure TConfiguracionTiendaVirtualModule.ServerDataModuleCreate(Sender: TObject);
begin
     ActualizaParametros;
end;

procedure TConfiguracionTiendaVirtualModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm207.ConfiguracionTiendaVirtualModule := nil;
end;

procedure TConfiguracionTiendaVirtualModule.ActualizaParametros;

var  I : SmallInt;
     ValorIdTasa,
     ValorGrupoNombre : String;

begin

     var Registro := SessionDataModule.Dm00.RegistroModule;

     Registro.ClavePadre := SessionDataModule.CodigoEmpresa  + '.' + ncrParametrosTiendaVirtual;

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
     NoPublicarArticulosSinPrecio := StrToBoolDef( Registro.ObtenValorString( ncrNoPublicarArticulosSinPrecio ), False );
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
            FGrupoNombre[ I ] := ValorGrupoNombre;
            FGrupoCodigoTarifa[ I ] := Registro.ObtenValorString( ncrGrupoCodigoTarifa + IntToStr( I ) );
            FGrupoModeloImpositivo[ I ] := StrToIntDef( Registro.ObtenValorString( ncrGrupoModeloImpositivo + IntToStr( I ) ), micSinRE );
            FGrupoConIVAIncluido[ I ] := StrToBoolDef( Registro.ObtenValorString( ncrGrupoConIVAIncluido + IntToStr( I ) ), False );
            end
       else FGrupoNombre[ I ] := '';
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

function TConfiguracionTiendaVirtualModule.GetGrupoCodigoTarifa(Index: SmallInt): String;
begin
     Result := FGrupoCodigoTarifa[ Index ];
end;

function TConfiguracionTiendaVirtualModule.GetGrupoConIVAIncluido(Index: SmallInt): Boolean;
begin
     Result := FGrupoConIVAIncluido[ Index ];
end;

function TConfiguracionTiendaVirtualModule.GetGrupoModeloImpositivo(Index: SmallInt): SmallInt;
begin
     Result := FGrupoModeloImpositivo[ Index ];
end;

function TConfiguracionTiendaVirtualModule.GetGrupoNombre(Index: SmallInt): String;
begin
     Result := FGrupoNombre[ Index ];
end;

function TConfiguracionTiendaVirtualModule.GetNombreUsuario: String;
begin
     Result := SessionDataModule.UsuarioFields.Tienda_NombreUsuario.Value;
end;

end.


