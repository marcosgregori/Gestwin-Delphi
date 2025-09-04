
unit dm_rda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_rda;

type

  TRenumeracionAsientosModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    RenumeracionAsientosService : IRenumeracionAsientosService;
  public
    procedure EjecutaProceso( PrimerNumeroAsiento : LongInt );
  end;

var RenumeracionAsientosModule: TRenumeracionAsientosModule = nil;

function  RenumeracionAsientos : TRenumeracionAsientosModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}

function RenumeracionAsientos : TRenumeracionAsientosModule;
begin
     CreateDataModule( TRenumeracionAsientosModule, RenumeracionAsientosModule );
     Result := RenumeracionAsientosModule;
end;

procedure TRenumeracionAsientosModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_RenumeracionAsientosService, IRenumeracionAsientosService, RenumeracionAsientosService );
end;

procedure TRenumeracionAsientosModule.DataModuleDestroy(Sender: TObject);
begin
     RenumeracionAsientosModule := nil;
end;

procedure TRenumeracionAsientosModule.EjecutaProceso(PrimerNumeroAsiento: Integer);
begin
     RenumeracionAsientosService.EjecutaProceso( PrimerNumeroAsiento );
end;

end.
