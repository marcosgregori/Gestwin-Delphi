
unit dm_rdip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim70Fields,

  dmi_rdip;

type

  TReconstruccionDatosInternosModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ReconstruccionDatosInternosService : IReconstruccionDatosInternosService;
  public
    procedure Reconstruccion;
  end;

var ReconstruccionDatosInternosModule: TReconstruccionDatosInternosModule = nil;

function  ReconstruccionDatosInternos : TReconstruccionDatosInternosModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function ReconstruccionDatosInternos : TReconstruccionDatosInternosModule;
begin
     CreateDataModule( TReconstruccionDatosInternosModule, ReconstruccionDatosInternosModule );
     Result := ReconstruccionDatosInternosModule;
end;

procedure TReconstruccionDatosInternosModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ReconstruccionDatosInternosService, IReconstruccionDatosInternosService, ReconstruccionDatosInternosService );
end;

procedure TReconstruccionDatosInternosModule.DataModuleDestroy(Sender: TObject);
begin
     ReconstruccionDatosInternosModule := nil;
end;

procedure TReconstruccionDatosInternosModule.Reconstruccion;
begin
     ReconstruccionDatosInternosService.Reconstruccion;
end;

end.
