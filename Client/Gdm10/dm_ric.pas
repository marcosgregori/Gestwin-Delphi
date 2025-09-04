
unit dm_ric;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_ric;

type

  TRegularizacionIVAModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    RegularizacionIVAService : IRegularizacionIVAService;
  public
    procedure EjecutaProceso( Fecha : TDate );
  end;

var RegularizacionIVAModule: TRegularizacionIVAModule = nil;

function  RegularizacionIVA : TRegularizacionIVAModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}

function RegularizacionIVA : TRegularizacionIVAModule;
begin
     CreateDataModule( TRegularizacionIVAModule, RegularizacionIVAModule );
     Result := RegularizacionIVAModule;
end;

procedure TRegularizacionIVAModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_RegularizacionIVAService, IRegularizacionIVAService, RegularizacionIVAService );
end;

procedure TRegularizacionIVAModule.DataModuleDestroy(Sender: TObject);
begin
     RegularizacionIVAModule := nil;
end;

procedure TRegularizacionIVAModule.EjecutaProceso( Fecha : TDate );
begin
     RegularizacionIVAService.EjecutaProceso( Fecha );
end;

end.
