
unit dm_pde209;

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

  dmi_cpo;

type
  TConfiguracionPedidosOnlineModule = class(TServerDataModule)
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    FFormatoImagenes : String;
    FNoPublicarArticulosSinPrecio,
    FPreciosConDescuentoPrevio,
    FCamposLibresComoAtributos : Boolean;
    FNombreAtributo1 : String;
    FPreciosConIVAIncluido : Boolean;   // Los precios en la web son con IVA incluido
    FPublicarClasesComoConfiguraciones : Boolean;

  public

    procedure ActualizaParametros;

    property FormatoImagenes : String read FFormatoImagenes write FFormatoImagenes;
    property NoPublicarArticulosSinPrecio : Boolean read FNoPublicarArticulosSinPrecio write FNoPublicarArticulosSinPrecio;
    property PreciosConDescuentoPrevio : Boolean read FPreciosConDescuentoPrevio write FPreciosConDescuentoPrevio;
    property CamposLibresComoAtributos : Boolean read FCamposLibresComoAtributos write FCamposLibresComoAtributos;
    property NombreAtributo1 : String read FNombreAtributo1 write FNombreAtributo1;
    property PreciosConIVAIncluido : Boolean read FPreciosConIVAIncluido write FPreciosConIVAIncluido;
    property PublicarClasesComoVariantes : Boolean read FPublicarClasesComoConfiguraciones write FPublicarClasesComoConfiguraciones;

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

       MainData;

procedure TConfiguracionPedidosOnlineModule.ServerDataModuleCreate(Sender: TObject);
begin
     ActualizaParametros;
end;

procedure TConfiguracionPedidosOnlineModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm207.ConfiguracionTiendaVirtualModule := nil;
end;

procedure TConfiguracionPedidosOnlineModule.ActualizaParametros;
begin

     var Registro := SessionDataModule.Dm00.RegistroModule;

     Registro.ClavePadre := SessionDataModule.CodigoEmpresa  + '.' + ncpParametrosPedidosOnline;

     FormatoImagenes := Registro.ObtenValorString( ncpFormatoImagenes );
     If   FormatoImagenes=''
     then FormatoImagenes := 'jpg';
     NoPublicarArticulosSinPrecio := StrToBoolDef( Registro.ObtenValorString( ncpNoPublicarArticulosSinPrecio ), False );
     NoPublicarArticulosSinPrecio := StrToBoolDef( Registro.ObtenValorString( ncpNoPublicarArticulosSinPrecio ), False );
     CamposLibresComoAtributos := StrToBoolDef( Registro.ObtenValorString( ncpCamposLibresComoAtributos ), False );
     NombreAtributo1 := Registro.ObtenValorString( ncpNombreAtributo1 );
     PreciosConIVAIncluido := StrToBoolDef( Registro.ObtenValorString( ncpPreciosConIVAIncluido ), False );
     PublicarClasesComoVariantes := StrToBoolDef( Registro.ObtenValorString( ncpPublicarClasesComoVariantes), False );

end;

end.


