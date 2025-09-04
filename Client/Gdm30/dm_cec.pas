
unit dm_cec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim30Fields,

  dmi_cec;

type

  TCierreComercialModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    CierreComercialService : ICierreComercialService;
  public
    procedure EjecutaProceso( NoGenerarMovimientos : Boolean; PrecioValoracion : TPrecioValoracion; FechaInventario : TDate );
  end;

var CierreComercialModule: TCierreComercialModule = nil;

function  CierreComercial : TCierreComercialModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function CierreComercial : TCierreComercialModule;
begin
     CreateDataModule( TCierreComercialModule, CierreComercialModule );
     Result := CierreComercialModule;
end;

procedure TCierreComercialModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_CierreComercialService, ICierreComercialService, CierreComercialService );
end;

procedure TCierreComercialModule.DataModuleDestroy(Sender: TObject);
begin
     CierreComercialModule := nil;
end;

procedure TCierreComercialModule.EjecutaProceso( NoGenerarMovimientos : Boolean; PrecioValoracion : TPrecioValoracion; FechaInventario : TDate );
begin
     CierreComercialService.EjecutaProceso( NoGenerarMovimientos, PrecioValoracion, FechaInventario );
end;

end.
