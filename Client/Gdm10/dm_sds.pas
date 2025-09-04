
unit dm_sds;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_sds;

type

  TSustitucionSubcuentasModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    SustitucionSubcuentasService : ISustitucionSubcuentasService;
  public
    procedure EjecutaProceso( SubcuentaActual, SubcuentaNueva : String; TodosLosEjercicios : Boolean = False );
  end;

var SustitucionSubcuentasModule: TSustitucionSubcuentasModule = nil;

function  SustitucionSubcuentas : TSustitucionSubcuentasModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}

function SustitucionSubcuentas : TSustitucionSubcuentasModule;
begin
     CreateDataModule( TSustitucionSubcuentasModule, SustitucionSubcuentasModule );
     Result := SustitucionSubcuentasModule;
end;

procedure TSustitucionSubcuentasModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_SustitucionSubcuentasService, ISustitucionSubcuentasService, SustitucionSubcuentasService );
end;

procedure TSustitucionSubcuentasModule.DataModuleDestroy(Sender: TObject);
begin
     SustitucionSubcuentasModule := nil;
end;

procedure TSustitucionSubcuentasModule.EjecutaProceso( SubcuentaActual,
                                                       SubcuentaNueva     : String;
                                                       TodosLosEjercicios : Boolean = False );
begin
     SustitucionSubcuentasService.EjecutaProceso( SubcuentaActual, SubcuentaNueva, TodosLosEjercicios );
end;

end.
