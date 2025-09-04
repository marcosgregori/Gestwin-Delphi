unit dm_nda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppContainer,
  AppForms,

  Datamanager,
  DB,
  nxdb,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim40Fields,

  Gdm40Dm,

  dmi_nda;

type
  TAprovisionamientoModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private
  
    AprovisionamientoService : IAprovisionamientoService;

  public

    function SeleccionaArticulosBajoMinimos( TipoSeleccion : TTipoSeleccionBajoMinimos; CodigoAlmacenOrigen, CodigoAlmacenDestino : String; ExistenciasVirtuales : Boolean = False; CodigoProveedor : String = ''; TodosLosAlmacenes : Boolean = False ) : String;
    procedure GeneraPedidosCompra( Serie : String; Fecha : TDate; NombreTabla : String );
    procedure GeneraTraspasoAlmacen( Fecha : TDate; NombreTabla : String );
    
  end;

var AprovisionamientoModule : TAprovisionamientoModule = nil;

function  Aprovisionamiento : TAprovisionamientoModule;

implementation

uses EnterpriseDataAccess,
     AppManager,
     NexusRpcData,

     Gdm00Dm,

     a_pde4,
     a_hdc,

     dmi_mov,

     dm_sdf,
     dm_art,
     dm_cli,
     dm_mov,
     dm_sto,
     dm_pga,
     dm_tma,
     dm_cnd,
     dm_fdv,

     b_pro,
     b_msg,

     f_prg;

{$R *.DFM}

{
resourceString
     RsMsg1   = 'Generación de albaranes de salida';
}

function Aprovisionamiento : TAprovisionamientoModule;
begin
     CreateDataModule( TAprovisionamientoModule, AprovisionamientoModule );
     Result := AprovisionamientoModule;
end;

procedure TAprovisionamientoModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_AprovisionamientoService, IAprovisionamientoService, AprovisionamientoService );
end;

procedure TAprovisionamientoModule.DataModuleDestroy(Sender: TObject);
begin
     AprovisionamientoModule := nil;
end;

procedure TAprovisionamientoModule.GeneraPedidosCompra(Serie: String; Fecha: TDate; NombreTabla: String);
begin
     AprovisionamientoService.GeneraPedidosCompra( Serie, Fecha, NombreTabla );
end;

procedure TAprovisionamientoModule.GeneraTraspasoAlmacen( Fecha: TDate; NombreTabla : String );
begin
     AprovisionamientoService.GeneraTraspasoAlmacen( Fecha, NombreTabla );     
end;

function TAprovisionamientoModule.SeleccionaArticulosBajoMinimos( TipoSeleccion         : TTipoSeleccionBajoMinimos; 
                                                                  CodigoAlmacenOrigen, 
                                                                  CodigoAlmacenDestino  : String;
                                                                  ExistenciasVirtuales  : Boolean = False; 
                                                                  CodigoProveedor       : String = ''; 
                                                                  TodosLosAlmacenes     : Boolean = False ) : String;
begin
     Result := AprovisionamientoService.SeleccionaArticulosBajoMinimos( TipoSeleccion, CodigoAlmacenOrigen, CodigoAlmacenDestino, ExistenciasVirtuales, CodigoProveedor, TodosLosAlmacenes );
end;

end.
