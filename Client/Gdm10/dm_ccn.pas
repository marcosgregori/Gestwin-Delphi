
unit dm_ccn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_ccn;

type

  TCierreContableModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    CierreContableService : ICierreContableService;
  public
    procedure EjecutaProceso( TipoProceso: TTipoProcesoCierre; FechaCierre, FechaApertura: TDate );
  end;

var CierreContableModule: TCierreContableModule = nil;

function  CierreContable : TCierreContableModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function CierreContable : TCierreContableModule;
begin
     CreateDataModule( TCierreContableModule, CierreContableModule );
     Result := CierreContableModule;
end;

procedure TCierreContableModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_CierreContableService, ICierreContableService, CierreContableService );
end;

procedure TCierreContableModule.DataModuleDestroy(Sender: TObject);
begin
     CierreContableModule := nil;
end;

procedure TCierreContableModule.EjecutaProceso( TipoProceso: TTipoProcesoCierre; FechaCierre, FechaApertura: TDate );
begin
     CierreContableService.EjecutaProceso( TipoProceso, FechaCierre, FechaApertura );
end;

end.
