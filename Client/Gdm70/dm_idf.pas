unit dm_idf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppContainer,
  AppForms,

  Datamanager,
  DB,
  nxdb,
  nxsdTypes,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim40Fields,

  Gim70Fields,

  Gdm70Dm,

  dmi_idf,

  OrdenFabricacionIntf,
  InformeFabricacionIntf;

type
  TInformeFabricacionModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private
    InformeFabricacionService : IInformeFabricacionService;
  public

    procedure ActualizaInformeFabricacion( InformeFabricacionFields : TInformeFabricacionFields; RecalcularProceso : Boolean );
    function  SuprimeInformeFabricacion( InformeFabricacionFields : TInformeFabricacionFields; RecalcularProceso : Boolean ): Boolean;
      
    function CalculaCosteArticulo( OrdenFabricacionFields : TOrdenFabricacionFields ) : Decimal;
    function ActualizaReferenciasRegistro( OrdenFabricacionFields : TOrdenFabricacionFields; InformeFabricacionFields : TInformeFabricacionFields; Descontar : Boolean ) : Boolean;
  end;

var InformeFabricacionModule : TInformeFabricacionModule = nil;

function  InformeFabricacion : TInformeFabricacionModule;

implementation

uses DateUtils,

     EnterpriseDataAccess,
     AppManager,
     NexusRpcData,

     Gdm00Dm,

     b_pro,
     b_msg,

     f_prg;

{$R *.DFM}

function InformeFabricacion : TInformeFabricacionModule;
begin
     CreateDataModule( TInformeFabricacionModule, InformeFabricacionModule );
     Result := InformeFabricacionModule;
end;

procedure TInformeFabricacionModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_InformeFabricacionService, IInformeFabricacionService, InformeFabricacionService );
end;

procedure TInformeFabricacionModule.DataModuleDestroy(Sender: TObject);
begin
     InformeFabricacionModule := nil;
end;

{ Servicios }

procedure TInformeFabricacionModule.ActualizaInformeFabricacion( InformeFabricacionFields : TInformeFabricacionFields; RecalcularProceso : Boolean );
begin
     InformeFabricacionService.ActualizaInformeFabricacion( TInformeFabricacion.FromDataset( InformeFabricacionFields ), RecalcularProceso );
end;

function TInformeFabricacionModule.SuprimeInformeFabricacion( InformeFabricacionFields : TInformeFabricacionFields; RecalcularProceso : Boolean ) : Boolean;
begin
     // Ejercicio;NroOrden;NroProceso;Fecha;Turno
     With InformeFabricacionFields do
       Result := InformeFabricacionService.SuprimeInformeFabricacion( GetRemoteCursorID, Ejercicio.Value, NroOrden.Value, NroProceso.Value, Fecha.Value, Turno.Value, RecalcularProceso );
end;

function TInformeFabricacionModule.CalculaCosteArticulo( OrdenFabricacionFields : TOrdenFabricacionFields ) : Decimal;
begin
     Result := InformeFabricacionService.CalculaCosteArticulo( TOrdenFabricacion.FromDataset( OrdenFabricacionFields ) )
end;

function TInformeFabricacionModule.ActualizaReferenciasRegistro( OrdenFabricacionFields : TOrdenFabricacionFields; InformeFabricacionFields : TInformeFabricacionFields; Descontar : Boolean ) : Boolean;
begin
     Result := InformeFabricacionService.ActualizaReferenciasRegistro( TOrdenFabricacion.FromDataset( OrdenFabricacionFields ), TInformeFabricacion.FromDataset( InformeFabricacionFields ), Descontar );
end;



end.
