unit dm_cpr;

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

  Gdm70Dm,

  dmi_cpr;

type
  TContenedorModule = class(TDataModule)

    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    ContenedorService : IContenedorService;

  public

    procedure SuprimeReferenciasOrden( Ejercicio : SmallInt; NroOrden : LongInt );
    function ContenidoProceso( EjercicioLanzamiento : SmallInt;NroOrden : LongInt; NroProceso : SmallInt; TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
    function ContenidoOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt; NroProcesoInicial, NroProcesoFinal : SmallInt; TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
    function UnidadesCorrectas( EjercicioLanzamiento : SmallInt; NroOrden : Integer ) : Decimal;
    function UnidadesDefectuosas( EjercicioLanzamiento : SmallInt; NroOrden : Integer ) : Decimal;

  end;

var ContenedorModule : TContenedorModule = nil;

function  Contenedor : TContenedorModule;

implementation

uses EnterpriseDataAccess,
     AppManager,
     NexusRpcData,

     Gdm00Dm,

     b_pro,
     b_msg,

     f_prg;

{$R *.DFM}

function Contenedor : TContenedorModule;
begin
     CreateDataModule( TContenedorModule, ContenedorModule );
     Result := ContenedorModule;
end;

procedure TContenedorModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ContenedorService, IContenedorService, ContenedorService );
end;

procedure TContenedorModule.DataModuleDestroy(Sender: TObject);
begin
     ContenedorModule := nil;
end;

{ Servicios }

procedure TContenedorModule.SuprimeReferenciasOrden( Ejercicio : SmallInt; NroOrden : Integer);
begin
     ContenedorService.SuprimeReferenciasOrden( Ejercicio, NroOrden);
end;

function TContenedorModule.UnidadesCorrectas(EjercicioLanzamiento: SmallInt; NroOrden: Integer): Decimal;
begin
     Result := ContenedorService.UnidadesCorrectas( EjercicioLanzamiento, NroOrden );
end;

function TContenedorModule.UnidadesDefectuosas(EjercicioLanzamiento: SmallInt; NroOrden: Integer): Decimal;
begin
     Result := ContenedorService.UnidadesDefectuosas( EjercicioLanzamiento, NroOrden );
end;

function TContenedorModule.ContenidoOrden( EjercicioLanzamiento : SmallInt; NroOrden: Integer; NroProcesoInicial, NroProcesoFinal: SmallInt; TipoContenedorSet: TTipoContenedorSet): IExistenciasContenedor;
begin
     Result := ContenedorService.ContenidoOrden( EjercicioLanzamiento, NroOrden, NroProcesoInicial, NroProcesoFinal, TipoContenedorSet );
end;

function TContenedorModule.ContenidoProceso( EjercicioLanzamiento : SmallInt; NroOrden: Integer; NroProceso: SmallInt; TipoContenedorSet: TTipoContenedorSet): IExistenciasContenedor;
begin
     Result := ContenedorService.ContenidoProceso( EjercicioLanzamiento, NroOrden, NroProceso, TipoContenedorSet );
end;

end.
