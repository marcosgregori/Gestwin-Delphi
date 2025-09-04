
unit dm_vec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_vec;

type

  TVerificacionContabilidadModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    VerificacionContabilidadService : IVerificacionContabilidadService;
  public
    procedure Verificacion( ComprobarRegistrosFactura : Boolean = False );
  end;

var VerificacionContabilidadModule: TVerificacionContabilidadModule = nil;

function  VerificacionContabilidad : TVerificacionContabilidadModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}

function VerificacionContabilidad : TVerificacionContabilidadModule;
begin
     CreateDataModule( TVerificacionContabilidadModule, VerificacionContabilidadModule );
     Result := VerificacionContabilidadModule;
end;

procedure TVerificacionContabilidadModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_VerificacionContabilidadService, IVerificacionContabilidadService, VerificacionContabilidadService );
end;

procedure TVerificacionContabilidadModule.DataModuleDestroy(Sender: TObject);
begin
     VerificacionContabilidadModule := nil;
end;

procedure TVerificacionContabilidadModule.Verificacion( ComprobarRegistrosFactura : Boolean = False );
begin
     VerificacionContabilidadService.Verificacion( ComprobarRegistrosFactura );
end;

end.
