
unit dm_pde4;

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
  Gim40Fields;

type
  TConfiguracionAprovisionamientoModule = class(TServerDataModule)
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    ParametrosAprovisionamientoRec : TParametrosAprovisionamientoRec;

    procedure ObtenParametrosAprovisionamiento;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   Variants,
       Math,

       LibUtils,

       AppManager,
       SessionData,

       MainData;

procedure TConfiguracionAprovisionamientoModule.ServerDataModuleCreate( Sender: TObject);
begin
     SessionDataModule.Dm00.ConfiguracionModule.OnObtenParametros.Add( ObtenParametrosAprovisionamiento );
end;

procedure TConfiguracionAprovisionamientoModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.ConfiguracionModule.OnObtenParametros.Remove( ObtenParametrosAprovisionamiento );
     SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule := nil;
end;

procedure TConfiguracionAprovisionamientoModule.ObtenParametrosAprovisionamiento;
begin
     SessionDataModule.Dm00.ConfiguracionModule.ObtenParametros( ctParametrosModuloAprovisionamiento, SessionDataModule.CodigoEmpresa, TParametrosRec( ParametrosAprovisionamientoRec ) );
end;


end.


