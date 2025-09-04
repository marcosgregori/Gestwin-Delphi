{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_odf;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf,

     OrdenFabricacionIntf,

     Gim30Fields,
     Gim40Fields,

     dmi_cla;

type

     // Estados en los que se que puede encontrar una orden de fabricación

     TEstadoOrdenFabricacion = ( eoNoIniciada, eoEnCurso, eoFinalizada, eoCerrada );
     TOperacionStockFabrica = ( osfInventario, osfNormal );

const
     CLSID_OrdenFabricacionService : TGuid = '{D7421B30-00BA-4DD7-8E71-A7EBFBDAABFC}';

     // Tipos de registro de orden de fabricación

     moOrden = 0;
     moPreOrden = 1;

     // Prioridad de las órdenes

     poAlta = 0;
     poNormal = 1;
     poBaja = 2;

type

    TPrioridadOrdenfabricacion = poAlta..poBaja;

    IOrdenFabricacionService = interface( ISessionModule )
     ['{25111A46-8FDE-4CBF-A8FE-EC64C7871A3E}']

      function Estado( Ejercicio : SmallInt; Tipo : SmallInt; NroOrden : LongInt ) : TEstadoOrdenFabricacion;
      procedure GeneraOrdenFabricacionDesdePedido( EjercicioPedido : SmallInt; Serie : String; NroPedido : LongInt; FechaLanzamiento : TDate; Prioridad : TPrioridadOrdenFabricacion; Simulacion : Boolean = False );
      function PedidoLanzado( EjercicioPedido : SmallInt; SeriePedido : String; NroPedido : LongInt ) : Boolean;
      function CompletaOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt; Simulacion : Boolean; NroPreOrden : LongInt; ProcesaOrdenesVinculadas : Boolean; NroOrdenVinculada : LongInt; FechaInicio : TDate; var FechaFinalizacion : TDate ) : Boolean;
      function AjustaFechasFabricacion( Ejercicio : SmallInt; NroOrden : LongInt; PrimerNroProceso : SmallInt; var FechaInicio : TDate; var FechaFinalizacion : TDate; AjustarVinculos, AsignarOperadores, AsignarSecuencias : Boolean ) : Boolean;
      function ActualizaOrden( OrdenFabricacion : IOrdenFabricacion; Reasignar : Boolean ) : Boolean;
      function SuprimeOrden( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Tipo : SmallInt; NroOrden : LongInt; SuprimeCabecera, SuprimeLineas : Boolean ) : Boolean;
      procedure ReajustaTareas( FechaInicial : TDate; NuevoTipoJornada : TTipoJornada = edSinAsignar );
      procedure ReabreOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IOrdenFabricacionService ) );

end.



