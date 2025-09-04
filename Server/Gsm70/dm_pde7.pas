
unit dm_pde7;

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
  Gim70Fields;

type
  TConfiguracionProduccionModule = class(TServerDataModule)
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    ParametrosProduccionRec : TParametrosProduccionRec;

    procedure ObtenParametrosProduccion;

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

procedure TConfiguracionProduccionModule.ServerDataModuleCreate( Sender: TObject);
begin
     SessionDataModule.Dm00.ConfiguracionModule.OnObtenParametros.Add( ObtenParametrosProduccion );
end;

procedure TConfiguracionProduccionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.ConfiguracionModule.OnObtenParametros.Remove( ObtenParametrosProduccion );
     SessionDataModule.Dm70.ConfiguracionProduccionModule := nil;
end;

procedure TConfiguracionProduccionModule.ObtenParametrosProduccion;
begin
     SessionDataModule.Dm00.ConfiguracionModule.ObtenParametros( ctParametrosModuloProduccion, SessionDataModule.CodigoEmpresa, TParametrosRec( ParametrosProduccionRec ) );
end;

end.


