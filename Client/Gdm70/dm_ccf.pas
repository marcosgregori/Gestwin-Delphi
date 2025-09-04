
unit dm_ccf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim70Fields,

  dmi_ccf;

type

  TCierreCicloFabricacionModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    CierreCicloFabricacionService : ICierreCicloFabricacionService;
  public
    procedure Realizar( FechaInicial, FechaFinal : TDate; AltasPorFabricacion, AlbaranesDeSalida : Boolean );
  end;

var CierreCicloFabricacionModule: TCierreCicloFabricacionModule = nil;

function  CierreCicloFabricacion : TCierreCicloFabricacionModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function CierreCicloFabricacion : TCierreCicloFabricacionModule;
begin
     CreateDataModule( TCierreCicloFabricacionModule, CierreCicloFabricacionModule );
     Result := CierreCicloFabricacionModule;
end;

procedure TCierreCicloFabricacionModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_CierreCicloFabricacionService, ICierreCicloFabricacionService, CierreCicloFabricacionService );
end;

procedure TCierreCicloFabricacionModule.DataModuleDestroy(Sender: TObject);
begin
     CierreCicloFabricacionModule := nil;
end;

procedure TCierreCicloFabricacionModule.Realizar( FechaInicial, FechaFinal : TDate; AltasPorFabricacion, AlbaranesDeSalida : Boolean );
begin
     CierreCicloFabricacionService.Realizar( FechaInicial, FechaFinal, AltasPorFabricacion, AlbaranesDeSalida );
end;

end.
