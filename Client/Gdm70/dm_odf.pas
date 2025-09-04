unit dm_odf;

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

  dmi_cla,
  dmi_odf;

type
  TOrdenFabricacionModule = class(TDataModule)
    DmOrdenFabricacionTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    OrdenFabricacionService : IOrdenFabricacionService;

    DmOrdenFabricacionFields : TOrdenFabricacionFields;

  public

    function TextoEstado(Estado : TEstadoOrdenFabricacion): String;
    function TextoPrioridad( Prioridad : Byte ): String;

    function Estado( Ejercicio, Tipo: SmallInt; NroOrden: Integer ): TEstadoOrdenFabricacion;
    procedure GeneraOrdenFabricacionDesdePedido( EjercicioPedido : SmallInt; SeriePedido : String; NroPedido : LongInt; FechaLanzamiento : TDate; Prioridad : SmallInt; Simulacion : Boolean = False );
    function PedidoLanzado( EjercicioPedido : SmallInt; SeriePedido : String; NroPedido : LongInt ) : Boolean;
    function CompletaOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt; Simulacion : Boolean; NroPreOrden : LongInt; ProcesaOrdenesVinculadas : Boolean; NroOrdenVinculada : LongInt; FechaInicio : TDate; var FechaFinalizacion : TDate ) : Boolean;
    function AjustaFechasFabricacion( Ejercicio : SmallInt; NroOrden : LongInt; PrimerNroProceso : SmallInt; var FechaInicio : TDate; var FechaFinalizacion : TDate; AjustarVinculos, AsignarOperadores, AsignarSecuencias : Boolean ) : Boolean;
    function ActualizaOrden( OrdenFabricacionFields : TOrdenFabricacionFields; Reasignar : Boolean ) : Boolean;
    function SuprimeOrden( OrdenFabricacionFields : TOrdenFabricacionFields; SuprimeCabecera, SuprimeLineas : Boolean ) : Boolean;
    procedure ReajustaTareas( FechaInicial : TDate; NuevoTipoJornada : TTipoJornada = edSinAsignar );
    procedure ReabreOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt );
    
    function Valida( Ejercicio : SmallInt; Tipo : SmallInt; EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl  : Boolean = False; ShowFullDescription : Boolean = False; OrdenFabricacionFields : TOrdenFabricacioNFields = nil ) : String;
    function Obten(  Ejercicio, Tipo : SmallInt; NroOrden : LongInt; OrdenFabricacionFields : TOrdenFabricacionFields = nil ) : Boolean;

  end;

var OrdenFabricacionModule : TOrdenFabricacionModule = nil;

function  OrdenFabricacion : TOrdenFabricacionModule;

implementation

uses DateUtils,

     EnterpriseDataAccess,
     AppManager,
     NexusRpcData,

     OrdenFabricacionIntf,

     Gdm00Dm,

     dm_art,

     b_pro,
     b_msg,

     f_prg;

{$R *.DFM}

resourceString
     RsMsg1  = 'Orden de fabricación inexistente.';
     RsMsg2  = 'Lanzada el %s. (%d)';

function OrdenFabricacion : TOrdenFabricacionModule;
begin
     CreateDataModule( TOrdenFabricacionModule, OrdenFabricacionModule );
     Result := OrdenFabricacionModule;
end;

procedure TOrdenFabricacionModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_OrdenFabricacionService, IOrdenFabricacionService, OrdenFabricacionService );

     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
end;

procedure TOrdenFabricacionModule.DataModuleDestroy(Sender: TObject);
begin
     OrdenFabricacionModule := nil;
end;

function TOrdenFabricacionModule.TextoEstado( Estado : TEstadoOrdenFabricacion ) : String;

const TextoEstado : Array of String = [ 'No iniciada', 'En curso', 'Finalizada', 'Cerrada' ];

begin
     Result := TextoEstado[ Ord( Estado ) ] + '.';
end;

function TOrdenFabricacionModule.TextoPrioridad( Prioridad : Byte ): String;

const TextoPrioridad : Array of String = [ 'Alta', 'Normal', 'Baja' ];

begin
     If   Prioridad in [ 0..2 ]
     then Result := TextoPrioridad[ Ord( Prioridad ) ]
     else Result := '';
end;


function TOrdenFabricacionModule.Valida(     Ejercicio,
                                             Tipo                   : SmallInt;
                                             EditControl            : TcxCustomEdit;
                                         var DisplayValue           : Variant;
                                         var ErrorText              : TCaption;
                                         var Error                  : Boolean;
                                             IsInfoControl          : Boolean = False;
                                             ShowFullDescription    : Boolean = False;
                                             OrdenFabricacionFields : TOrdenFabricacioNFields = nil ) : String;

var  NroOrden : LongInt;
     Descripcion : String;

begin
     Descripcion := '';
     If   ValueIsEmpty( DisplayValue )
     then DmOrdenFabricacionTable.ResetFound
     else begin
          NroOrden := VarToInteger( DisplayValue );
          If   DmOrdenFabricacionTable.FindKey( [ Ejercicio, Tipo, NroOrden ] )
          then begin
               If   IsInfoControl or ShowFullDescription
               then Descripcion := DmOrdenFabricacionFields.CodigoArticulo.Value + ', ' + Articulo.Descripcion( DmOrdenFabricacionFields.CodigoArticulo.Value, { NotificaSiNoExiste } False );
               If   Descripcion<>''
               then Descripcion := Descripcion + '. ';
               Descripcion := Descripcion + Format( RsMsg2, [ StrFormatDate( DmOrdenFabricacionFields.FechaLanzamiento.Value  ), YearOf( DmOrdenFabricacionFields.FechaLanzamiento.Value ) ] );
               If   Assigned( EditControl )
               then EditControl.Description := Descripcion;
               end
          else If   not IsInfoControl
               then begin
                    Error := True;
                    ErrorText := RsMsg1;
                    end;
          end;
     If   Assigned( OrdenFabricacionFields )
     then OrdenFabricacionFields.Update( DmOrdenFabricacionTable );
     Result := Descripcion;
end;

function TOrdenFabricacionModule.Obten(  Ejercicio,
                                         Tipo                   : SmallInt;
                                         NroOrden               : LongInt;
                                         OrdenFabricacionFields : TOrdenFabricacionFields = nil ) : Boolean;

begin
     Result := DmOrdenFabricacionTable.FindKey( [ Ejercicio, Tipo, NroOrden ] );
     If   Assigned( OrdenFabricacionFields )
     then OrdenFabricacionFields.Update( DmOrdenFabricacionTable );
end;

{ Servicios }

function TOrdenFabricacionModule.Estado( Ejercicio : SmallInt; Tipo : SmallInt; NroOrden : LongInt ) : TEstadoOrdenFabricacion;
begin
     Result := OrdenFabricacionService.Estado( Ejercicio, Tipo, NroOrden );
end;

procedure TOrdenFabricacionModule.GeneraOrdenFabricacionDesdePedido( EjercicioPedido    : SmallInt;
                                                                     SeriePedido        : String;
                                                                     NroPedido          : LongInt;
                                                                     FechaLanzamiento   : TDate;
                                                                     Prioridad          : SmallInt;
                                                                     Simulacion         : Boolean = False );
begin
     OrdenFabricacionService.GeneraOrdenFabricacionDesdePedido( EjercicioPedido, SeriePedido, NroPedido, FechaLanzamiento, Prioridad, Simulacion );
end;

function TOrdenFabricacionModule.PedidoLanzado(EjercicioPedido: SmallInt; SeriePedido: String; NroPedido: Integer): Boolean;
begin
     Result := OrdenFabricacionService.PedidoLanzado( EjercicioPedido, SeriePedido, NroPedido );
end;

procedure TOrdenFabricacionModule.ReabreOrden(Ejercicio, Tipo: SmallInt; NroOrden: LongInt);
begin
     OrdenFabricacionService.ReabreOrden( Ejercicio, Tipo, NroOrden );
end;

procedure TOrdenFabricacionModule.ReajustaTareas(FechaInicial: TDate; NuevoTipoJornada: TTipoJornada);
begin
     OrdenFabricacionService.ReajustaTareas( FechaInicial, NuevoTipoJornada );
end;

function TOrdenFabricacionModule.AjustaFechasFabricacion(     Ejercicio         : SmallInt;
                                                              NroOrden          : Integer;
                                                              PrimerNroProceso  : SmallInt;
                                                          var FechaInicio,
                                                              FechaFinalizacion : TDate;
                                                              AjustarVinculos,
                                                              AsignarOperadores,
                                                              AsignarSecuencias : Boolean ) : Boolean;

begin
     Result := OrdenFabricacionService.AjustaFechasFabricacion( Ejercicio, NroOrden, PrimerNroProceso, FechaInicio, FechaFinalizacion, AjustarVinculos, AsignarOperadores, AsignarSecuencias );
end;

function TOrdenFabricacionModule.CompletaOrden(Ejercicio, Tipo: SmallInt; NroOrden: Integer; Simulacion: Boolean; NroPreOrden: Integer; ProcesaOrdenesVinculadas: Boolean; NroOrdenVinculada: Integer; FechaInicio: TDate; var FechaFinalizacion: TDate) : Boolean;
begin
     Result := OrdenFabricacionService.CompletaOrden( Ejercicio, Tipo, NroOrden, Simulacion, NroPreOrden, ProcesaOrdenesVinculadas, NroOrdenVinculada, FechaInicio, FechaFinalizacion );
end;

function TOrdenFabricacionModule.ActualizaOrden( OrdenFabricacionFields : TOrdenFabricacionFields;
                                                 Reasignar              : Boolean ) : Boolean;
begin
     Result := OrdenFabricacionService.ActualizaOrden( TOrdenFabricacion.FromDataset( OrdenFabricacionFields ), Reasignar );
end;

function TOrdenFabricacionModule.SuprimeOrden( OrdenFabricacionFields : TOrdenFabricacionFields;
                                               SuprimeCabecera,
                                               SuprimeLineas          : Boolean ): Boolean;
begin
     With OrdenFabricacionFields do
       Result := OrdenFabricacionService.SuprimeOrden( GetRemoteCursorID, Ejercicio.Value, Tipo.Value, NroOrden.Value, SuprimeCabecera, SuprimeLineas );
end;

end.
