
unit dm_gaa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_gaa;

type

  TGeneracionAmortizacionesModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    GeneracionAmortizacionesService : IGeneracionAmortizacionesService;
  public
    procedure EjecutaProceso( Fecha : TDate );
  end;

var GeneracionAmortizacionesModule: TGeneracionAmortizacionesModule = nil;

function  GeneracionAmortizaciones : TGeneracionAmortizacionesModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}

function GeneracionAmortizaciones : TGeneracionAmortizacionesModule;
begin
     CreateDataModule( TGeneracionAmortizacionesModule, GeneracionAmortizacionesModule );
     Result := GeneracionAmortizacionesModule;
end;

procedure TGeneracionAmortizacionesModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_GeneracionAmortizacionesService, IGeneracionAmortizacionesService, GeneracionAmortizacionesService );
end;

procedure TGeneracionAmortizacionesModule.DataModuleDestroy(Sender: TObject);
begin
     GeneracionAmortizacionesModule := nil;
end;

procedure TGeneracionAmortizacionesModule.EjecutaProceso( Fecha : TDate );
begin
     GeneracionAmortizacionesService.EjecutaProceso( Fecha );
end;

end.
