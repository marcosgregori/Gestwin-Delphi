
unit dm_odf;

interface

uses
  Windows, Messages, SysUtils, Classes, Generics.Collections,

  DB,
  nxdb,
  nxsdTypes,

  DataManager,
  ServerDataModule,
  SessionIntf,

  LibUtils,

  Gim30Fields,
  Gim40Fields,
  Gim70Fields,

  OrdenFabricacionIntf,

  dmi_odf,
  dmi_cla;

type


  TOrdenFabricacionService = class( TSessionModule, IOrdenFabricacionService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    function Estado( Ejercicio : SmallInt; Tipo : SmallInt; NroOrden : LongInt ) : TEstadoOrdenFabricacion;
    procedure GeneraOrdenFabricacionDesdePedido( Ejercicio : SmallInt; Serie : String; NroPedido : LongInt; FechaLanzamiento : TDate; Prioridad : TPrioridadOrdenFabricacion; Simulacion : Boolean = False );
    function PedidoLanzado( EjercicioPedido : SmallInt; SeriePedido : String; NroPedido : LongInt ) : Boolean;
    function CompletaOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt; Simulacion : Boolean; NroPreOrden : LongInt; ProcesaOrdenesVinculadas : Boolean; NroOrdenVinculada : LongInt; FechaInicio : TDate; var FechaFinalizacion : TDate ) : Boolean;
    function AjustaFechasFabricacion( Ejercicio : SmallInt; NroOrden : LongInt; PrimerNroProceso : SmallInt; var FechaInicio : TDate; var FechaFinalizacion : TDate; AjustarVinculos, AsignarOperadores, AsignarSecuencias : Boolean ) : Boolean;
    procedure ReajustaTareas( FechaInicial : TDate; NuevoTipoJornada : TTipoJornada = edSinAsignar );

    function ActualizaOrden( OrdenFabricacion : IOrdenFabricacion; Reasignar : Boolean ) : Boolean;
    function SuprimeOrden( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Tipo : SmallInt; NroOrden : LongInt; SuprimeCabecera, SuprimeLineas : Boolean ) : Boolean;

    procedure ReabreOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt );
    end;


   TOrdenFabricacionModule = class(TServerDataModule)
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmOrdenFabricacionTable: TnxeTable;
    DmLineaOFOperacionTable: TnxeTable;
    DmLineaLanzamientoTable: TnxeTable;
    DmLanzamientoTable: TnxeTable;
    DmRelacionMaterialesTable: TnxeTable;
    DmLineaOFComponenteTable: TnxeTable;
    DmOrdenFabricacionAuxTable: TnxeTable;
    DmRelacionOperacionesTable: TnxeTable;
    DmLineaOFPedidoTable: TnxeTable;
    DmLineaOFOperacionAuxTable: TnxeTable;
    DmLineaOFComponenteAuxTable: TnxeTable;
    DmOperacionTable: TnxeTable;
    DmMovimientoAuxTable: TnxeTable;
    DmLineaMovimientoAuxTable: TnxeTable;
    OperacionesMemTable: TnxMemTable;
    OperacionesMemTableEjercicio: TSmallintField;
    OperacionesMemTableNroOrden: TLongWordField;
    OperacionesMemTableNroProceso: TSmallintField;
    OperacionesMemTablePrioridad: TSmallintField;
    OperacionesMemTableFechaInicio: TDateField;
    OperacionesMemTableFechaFinalizacion: TDateField;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    private

      DmOperacionFields : TOperacionFields;
      DmRelacionMaterialesFields : TRelacionMaterialesFields;
      DmRelacionOperacionesFields : TRelacionOPeracionesFields;

      DmMovimientoFields,
      DmMovimientoAuxFields : TMovimientoFields;
      DmLineaMovimientoFields,
      DmLineaMovimientoAuxFields : TLineaMovimientoFields;
      DmOrdenFabricacionFields,
      DmOrdenFabricacionAuxFields : TOrdenFabricacionFields;
      DmLineaOFComponenteFields,
      DmLineaOFComponenteAuxFields : TLineaOFComponenteFields;
      DmLineaOFOperacionFields,
      DmLineaOFOperacionAuxFields : TLineaOFOperacionFields;
      DmLineaOFPedidoFields : TLineaOFPedidoFields;
      DmLanzamientoFields : TLanzamientoFields;
      DmLineaLanzamientoFields : TLineaLanzamientoFields;

      DsArticuloFields : TArticuloFields;
      DsCalendarioFields : TCalendarioFields;

      NroLineaActual,
      NroRegistroActual : LongInt;
      ContadorTipo : SmallInt;
      CodigoContador : String;

      // FechaInicialReajuste,
      // FechaActual : TDate;

      UnidadesProcesadas,
      UnidadesIniciales : Decimal;

      procedure InicializaContadorOrdenFabricacion( OrdenFabricacionFields : TOrdenFabricacionFields );
      function ExisteRegistroContadorEvent( ValorActual : LongInt ) : Boolean;
      function ObtenCargas( UnidadesAFabricar, UnidadesCarga : Decimal ) : Integer;

    public

      function ProximaOrdenFabricacion( Modelo : SmallInt; RegistrarValor : Boolean = True ) : LongInt;
      function Estado( OrdenFabricacionFields : TOrdenFabricacionFields ) : TEstadoOrdenfabricacion; overload;
      function Estado( Ejercicio : SmallInt; Tipo : SmallInt; NroOrden : LongInt ) : TEstadoOrdenFabricacion; overload;

      procedure GeneraOrdenFabricacionDesdePedido( EjercicioPedido    : SmallInt;
                                                   SeriePedido        : String;
                                                   NroPedido          : LongInt;
                                                   FechaLanzamiento   : TDate;
                                                   Prioridad          : TPrioridadOrdenFabricacion;
                                                   Simulacion         : Boolean = False );

      function PedidoLanzado( EjercicioPedido    : SmallInt;
                              SeriePedido        : String;
                              NroPedido          : LongInt ) : Boolean;

      function ObtenOrden( Ejercicio,
                           Tipo                   : SmallInt;
                           NroOrden               : LongInt;
                           OrdenFabricacionFields : TOrdenFabricacionFields ) : Boolean;

      function CompletaOrden(     Ejercicio,
                                  Tipo                      : SmallInt;
                                  NroOrden                  : LongInt;
                                  Simulacion                : Boolean;
                                  NroPreOrden               : LongInt;
                                  ProcesaOrdenesVinculadas  : Boolean;
                                  NroOrdenVinculada         : LongInt;
                                  FechaInicio               : TDate;
                              var FechaFinalizacion         : TDate ) : Boolean;

      function ActualizaOrden( OrdenFabricacion : IOrdenFabricacion;
                               Reasignar        : Boolean ) : Boolean;

      function SuprimeOrden( RemoteCursorID    : TnxCursorID;
                             Ejercicio,
                             Tipo              : SmallInt;
                             NroOrden          : LongInt;
                             SuprimeCabecera,
                             SuprimeLineas     : Boolean ) : Boolean; overload;

      function SuprimeOrden( Ejercicio,
                             Tipo              : SmallInt;
                             NroOrden          : LongInt;
                             SuprimeCabecera,
                             SuprimeLineas     : Boolean ) : Boolean; overload;

      function AjustaFechasFabricacion(      Ejercicio             : SmallInt;
                                             NroOrden              : LongInt;
                                             PrimerNroProceso      : SmallInt;
                                         var FechaInicio           : TDate;
                                         var FechaFinalizacion     : TDate;
                                             AjustarVinculos,
                                             AsignarOperadores     : Boolean;
                                             AsignarSecuencias     : Boolean ) : Boolean;

      procedure AsignaNumeroLote( UnaOrdenFabricacionFields : TOrdenFabricacionFields; EsUnaPreOrden : Boolean );
      procedure ReajustaTareas( FechaInicial : TDate; NuevoTipoJornada : TTipoJornada = edSinAsignar );
      procedure ReabreOrden( Ejercicio, Tipo : SmallInt; NroOrden : LongInt );

      procedure SuprimeSecuencias( FechaInicial : TDate );
      procedure AsignaSecuencias( FechaInicial : TDate; Ejercicio : SmallInt = 0; NroOrden : LongInt = 0 );

  end;

const

    CodigoListaTemporal  = #0#0#0;   // es imposible editarlo o verlo en un listado.
    NivelMaximoAnidacion = 10;       // Nivel maximo de anidación

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     AppManager,
     SessionData,
     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsrServerEngine,

     Gim00Fields,

     dmi_art,
     dmi_mov,
     dmi_sto,
     dmi_cpr,
     dmi_cnd,

     dm_cnd,
     dm_art,
     dm_mov,
     dm_rla,
     dm_cpr;

{$R *.DFM}

resourceString

   RsMsg1  = 'El artículo %s no tiene plan maestro de fabricación (relación de materiales y procesos). Se cancela el proceso.';
   RsMsg2  = '';
   RsMsg3  = 'Orden de fabricación %d, proceso %d.';
   RsMsg4  = 'No he conseguido recuperar la orden de fabricación nº %d.';
   RsMsg5  = 'Se cancela el proceso de generación de la orden de fabricación.';
   RsMsg6  = 'Orden nº %d. %s';
   RsMsg7  = 'Orden nº %d, del artículo %s. Unidades a fabricar : %f. Se inicia el %s y finaliza el %s.';
   RsMsg8  = 'No iniciada.';
   RsMsg9  = 'En curso.';
   RsMsg10 = 'Finalizada.';
   RsMsg11 = 'Cerrada.';
   RsMsg12 = 'Ha ocurrido un error al intentar obtener información de la pre-órden de fabricación.';
   RsMsg13 = 'La operacion [%s], que aparece en el proceso nº %d del artículo %s, ha sido dada de baja.';
   RsMsg14 = 'Se inicia el proceso de creación de la orden de fabricación. Artículo %s, unidades a fabricar : %f.';
   RsMsg15 = 'Se ha suprimido el movimiento de almacén, nº %d, al dar de baja la orden de fabricación nº %d.';
   RsMsg16 = 'Se ha suprimido la orden de fabricación nº %d y todos los registros vinculados a ésta.';
   RsMsg17 = 'Orden de fabricación nº %d completada con éxito.';
   RsMsg18 = 'Se ha creado el movimiento de almacén nº %d (dispuesto para fabricación), con los componentes utilizados.';
   RsMsg19 = 'Realizando el reajuste de todas las tareas afectadas.';
   RsMsg20 = 'Suprimiendo tareas asignadas ...';
   RsMsg21 = 'Reasignando tareas ...';
   RsMsg22 = 'Procesando la orden nº %d, proceso nº %d.';
   RsMsg23 = 'Se cancela en proceso de reajuste.' + #13 + 'Los datos quedan como antes de intentar el cambio.';
   RsMsg24 = 'La orden de fabricación nº %d no existe.';
   RsMsg25 = 'No puedo suprimir las ordenes de este pedido.';
   RsMsg26 = 'La orden de fabricación nº %d ya ha sido iniciada.';
   RsMsg27 = 'No se ha podido obtener el pedido nº %s %d.';
   RsMsg29 = 'Se ha cancelado el proceso de lanzamiento. Los datos quedan como estaban antes de intentar el proceso.';
   RsMsg30 = 'El pedido no genera ninguna orden de fabricación.';
   RsMsg31 = 'Compruebe su contendo y los registros de lanzamiento asociados a este pedido.';
   RsMsg32 = 'No existe ninguna Cantidad pendiente de procesar y no se ha generado ningún registro de lanzamiento.';
   RsMsg33 = 'No se ha podido completar la orden nº %d.';
   RsMsg34 = 'Operación ->';
   RsMsg35 = 'Componente -> ';
   RsMsg36 = 'Asignando máquinas, turnos y fechas.';
   RsMsg37 = 'Se ha cancelado el proceso de reajuste de tareas. Los datos quedan como estaban antes de intentar el proceso.';
   RsMsg38 = 'Se ha producido un error durante el proceso de reapertura.';
   RsMsg39 = 'Los datos quedan como estaban antes de intentar el proceso.';
   RsMsg40 = 'No se ha podido recuperar el registro de la orden de fabricación.';
   RsMsg41 = 'Se ha reabierto correctamente la orden de fabricación nº %d.';
   RsMsg42 = 'Se ha superado el nivel máximo de anidación de relaciones de materiales.';
   RsMsg43 = 'Compruebe que no exista un bucle cerrado en las relaciones de materiales y procesos.';

procedure TOrdenFabricacionModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmOperacionFields := TOperacionFields.Create( DmOperacionTable );
     DmRelacionMaterialesFields := TRelacionMaterialesFields.Create( DmRelacionMaterialesTable );
     DmRelacionOperacionesFields := TRelacionOperacionesFields.Create( DmRelacionOperacionesTable );

     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoAuxFields := TLineaMovimientoFields.Create( DmLineaMovimientoAuxTable );
     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
     DmOrdenFabricacionAuxFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionAuxTable );
     DmLineaOFComponenteFields := TLineaOFComponenteFields.Create( DmLineaOFComponenteTable );
     DmLineaOFComponenteAuxFields := TLineaOFComponenteFields.Create( DmLineaOFComponenteAuxTable );
     DmLineaOFOperacionFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionTable );
     DmLineaOFOperacionAuxFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionAuxTable );
     DmLineaOFPedidoFields := TLineaOFPedidoFields.Create( DmLineaOFPedidoTable );
     DmLanzamientoFields := TLanzamientoFields.Create( DmLanzamientoTable );
     DmLineaLanzamientoFields := TLineaLanzamientoFields.Create( DmLineaLanzamientoTable );

     DsArticuloFields := TArticuloFields.Create( Self );
     DsCalendarioFields := TCalendarioFields.Create( Self );

end;

procedure TOrdenFabricacionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.OrdenFabricacionModule := nil;
end;

function TOrdenFabricacionModule.Estado( Ejercicio   : SmallInt;
                                         Tipo        : SmallInt;
                                         NroOrden    : LongInt ) : TEstadoOrdenFabricacion;
begin
     Result := eoNoIniciada;
     With DmOrdenFabricacionTable do
       begin
       IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       If   FindKey( [ Ejercicio, moOrden, NroOrden ] )
       then Result := Estado( DmOrdenFabricacionFields );
       end;
end;

function TOrdenFabricacionModule.Estado( OrdenFabricacionFields : TOrdenFabricacionFields ) : TEstadoOrdenFabricacion;

var   UnidadesProcesoAnterior : Decimal;

begin

     Result := eoNoIniciada;

     If   not OrdenFabricacionFields.Cerrado.Value
     then begin

          UnidadesProcesadas := SessionDataModule.Dm70.ContenedorModule.ContenidoOrden( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, 0, MaxSmallInt, cnProductoAcabadoTotal ).Saldo;
          UnidadesIniciales  := SessionDataModule.Dm70.ContenedorModule.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, 0, cnProductoAcabadoCorrecto ).Saldo;

            If   UnidadesIniciales<>UnidadesProcesadas  // Se ha iniciado
            then begin

                 Result := eoEnCurso;

                 With DmLineaOFOperacionTable do
                   try
                     IndexFieldNames := 'Ejercicio;Tipo;NroOrden;NroProceso';
                     SetRange( [ OrdenFabricacionFields.Ejercicio.Value, moOrden, OrdenFabricacionFields.NroOrden.Value ] );
                     Last; // la última operacion de la orden
                     If   not Bof
                     then With DmLineaOFOperacionFields do
                            If   SessionDataModule.Dm70.ContenedorModule.ContenidoOrden( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, 0, MaxSmallInt, cnProductoAcabadoCorrectoTotal ).Saldo=
                                 SessionDataModule.Dm70.ContenedorModule.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, NroProceso.Value, [ cnProductoCorrecto, cnProductoSubcontratista ] ).Saldo
                            then Result := Eofinalizada;
                   finally
                     CancelRange;
                     end;

                 end;

            end
       else Result := eoCerrada;
end;

function TOrdenFabricacionModule.ObtenCargas( UnidadesAFabricar, UnidadesCarga : Decimal ) : Integer;
begin
     If   UnidadesCarga=0.0
     then Result := 1
     else Result := Round( UnidadesAFabricar / UnidadesCarga );
end;

function TOrdenFabricacionModule.ObtenOrden( Ejercicio,
                                             Tipo                   : SmallInt;
                                             NroOrden               : Integer;
                                             OrdenFabricacionFields : TOrdenFabricacionFields ) : Boolean;
begin
     With DmOrdenFabricacionTable do
       begin
       IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       Result := FindKey( [ Ejercicio, Tipo, NroOrden] );
       OrdenFabricacionFields.Update( DmOrdenFabricacionTable );
       end;
end;

function TOrdenFabricacionModule.PedidoLanzado( EjercicioPedido    : SmallInt;
                                                SeriePedido        : String;
                                                NroPedido          : LongInt ) : Boolean;
begin
     With DmOrdenFabricacionTable do
       begin
       IndexFieldNames := 'EjercicioPedido;SeriePedido;NroPedido';
       Result := FindKey( [ EjercicioPedido, SeriePedido, NroPedido ] );
       end;
end;

procedure TOrdenFabricacionModule.GeneraOrdenFabricacionDesdePedido( EjercicioPedido    : SmallInt;
                                                                     SeriePedido        : String;
                                                                     NroPedido          : LongInt;
                                                                     FechaLanzamiento   : TDate;
                                                                     Prioridad          : TPrioridadOrdenFabricacion;
                                                                     Simulacion         : Boolean = False );

var   FechaFinalizacion : TDate;

begin

     // Utilizo DmMovimientoAuxTable y DmLineaMovimientoAuxTable porque la función 'CompletaOrden' utiliza los principales

     { Compruebo que no haya ninguna orden de fabricacion en curso }

     try

       With DmOrdenFabricacionTable do
         begin
         IndexFieldNames := 'EjercicioPedido;SeriePedido;NroPedido';
         SetRange( [ EjercicioPedido, SeriePedido, NroPedido ] );
         First;
         While not Eof do
           begin
           If   Estado( DmOrdenFabricacionFields )<>eoNoIniciada
           then begin
                SessionDataModule.SendNotification( ntStop, RsMsg25, Format( RsMsg26, [ DmOrdenFabricacionFields.NroOrden.Value ] ) );
                Exit;
                end;
           Next;
           end;
         end;

       // El rango asignado a DmOrdenFabricacionTable sigue activo

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLanzamientoTable,
                                                                       DmOrdenFabricacionTable,
                                                                       DmLineaLanzamientoTable ] );

       try

         { Suprimo las ordenes de fabricacion y los movimientos de almacen asociados }

         With DmOrdenFabricacionTable do
           try
           First;
           While not Eof do
             begin
             With DmOrdenFabricacionFields do
               SuprimeOrden( Ejercicio.Value, Tipo.Value, NroOrden.Value, True, True );
             Next;
             end;
           finally
             CancelRange;
             IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
             end;

         DmMovimientoAuxTable.IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';

         If   DmMovimientoAuxTable.FindKey( [ tmPedidoVenta, EjercicioPedido, SeriePedido, NroPedido ] )
         then begin

              With DmLineaMovimientoAuxTable do
                try

                  With DmMovimientoAuxFields do
                    SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

                  First;
                  // Ahora suprimo el posible registro de lanzamiento existente y creo uno nuevo
                  If   not Eof
                  then With DmLineaMovimientoAuxFields do
                         begin

                         If   DmLineaLanzamientoTable.FindKey( [ Ejercicio.Value, NroOperacion.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] )
                         then With DmLineaLanzamientoFields do
                                SessionDataModule.Dm70.LanzamientoModule.SuprimeRegistroLanzamiento( Ejercicio.Value, NroOperacion.Value );

                         With DmLanzamientoTable do
                           begin
                           Append;
                           DmLanzamientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                           DmLanzamientoFields.NroOperacion.Value := SessionDataModule.Dm70.LanzamientoModule.ProximoLanzamiento;
                           DmLanzamientoFields.Fecha.Value := SessionDataModule.FechaHoy;
                           DmLanzamientoFields.Tipo.Value := rlAutomatico;
                           Post;
                           end;

                         end;

                  NroRegistroActual := 1;

                  While not Eof do
                    begin
                    With DmLineaMovimientoAuxFields do
                      If   CodigoArticulo.Value<>ArticuloManual
                      then If   SessionDataModule.Dm70.ListaMaterialesProcesosModule.TieneRelacion( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value )
                           then begin

                                SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, DsArticuloFields );

                                DmOrdenFabricacionTable.Append;

                                DmOrdenFabricacionFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                                DmOrdenFabricacionFields.NroOrden.Value := ProximaOrdenFabricacion( moOrden, { RegistrarValor } not Simulacion );
                                DmOrdenFabricacionFields.EjercicioPedido.Value := EjercicioPedido;
                                DmOrdenFabricacionFields.SeriePedido.Value := SeriePedido;
                                DmOrdenFabricacionFields.NroPedido.Value := NroPedido;
                                DmOrdenFabricacionFields.CodigoArticulo.Value := CodigoArticulo.Value;
                                DmOrdenFabricacionFields.CodigoClaseA.Value:= CodigoClaseA.Value;
                                DmOrdenFabricacionFields.CodigoClaseB.Value := CodigoClaseB.Value;
                                DmOrdenFabricacionFields.CodigoClaseC.Value := CodigoClaseC.Value;
                                DmOrdenFabricacionFields.UnidadesAFabricar.Value := Cantidad.Value;
                                DmOrdenFabricacionFields.Cargas.Value := ObtenCargas( DmOrdenFabricacionFields.UnidadesAFabricar.Value, DsArticuloFields.UnidadesCarga.Value );
                                DmOrdenFabricacionFields.FechaLanzamiento.Value := FechaLanzamiento;
                                DmOrdenFabricacionFields.EjercicioLanzamiento.Value := YearOf( FechaLanzamiento );
                                DmOrdenFabricacionFields.Prioridad.Value := Ord( Prioridad );

                                DmOrdenFabricacionTable.Post;

                                With DmOrdenFabricacionFields do
                                  If   not CompletaOrden( Ejercicio.Value, Tipo.Value, NroOrden.Value, Simulacion, 0, True, 0, DmOrdenFabricacionFields.FechaLanzamiento.Value, FechaFinalizacion )
                                  then begin
                                       SessionDataModule.SendNotification( ntStop, Format( RsMsg33, [ DmOrdenFabricacionFields.NroOrden.Value ] ) );
                                       Abort;
                                       end;

                                With DmLineaLanzamientoTable do
                                  begin

                                  Append;

                                  DmLineaLanzamientoFields.Ejercicio.Value := DmLanzamientoFields.Ejercicio.Value;
                                  DmLineaLanzamientoFields.NroOperacion.Value := DmLanzamientoFields.NroOperacion.Value;
                                  DmLineaLanzamientoFields.NroRegistro.Value := NroRegistroActual;
                                  DmLineaLanzamientoFields.EjercicioPedido.Value := DmLineaMovimientoAuxFields.Ejercicio.Value;
                                  DmLineaLanzamientoFields.NroOperacionPedido.Value := DmLineaMovimientoAuxFields.NroOperacion.Value;
                                  DmLineaLanzamientoFields.CodigoArticulo.Value := DmLineaMovimientoAuxFields.CodigoArticulo.Value;
                                  DmLineaLanzamientoFields.CodigoClaseA.Value := DmLineaMovimientoAuxFields.CodigoClaseA.Value;
                                  DmLineaLanzamientoFields.CodigoClaseB.Value := DmLineaMovimientoAuxFields.CodigoClaseB.Value;
                                  DmLineaLanzamientoFields.CodigoClaseC.Value := DmLineaMovimientoAuxFields.CodigoClaseC.Value;
                                  DmLineaLanzamientoFields.Pendiente.Value := DmLineaMovimientoAuxFields.Cantidad.Value;
                                  DmLineaLanzamientoFields.Fabricar.Value := DmLineaMovimientoAuxFields.Cantidad.Value;

                                  Post;

                                  Inc( NroRegistroActual );
                                  end;

                                end;

                    Next;
                    end;

                finally
                  CancelRange;
                  end;

              end
         else begin
              SessionDataModule.SendNotification( ntStop, Format( RsMsg27, [ SeriePedido, NroPedido ] ) );
              Abort;
              end;

         If   Simulacion or ( NroRegistroActual=1 )
         then begin
              If   NroRegistroActual=1
              then SessionDataModule.SendNotification( ntStop, RsMsg30, RsMsg31 );
              Abort;
              end
         else TransactionTag.Commit;

       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendNotification( ntError, RsMsg29 );
         SessionDataModule.SendException( E, Self );
         raise;
         end;
       end;

     finally
       DmOrdenFabricacionTable.CancelRange;  // Redundante y solo por si se produce un error antes de intentar suprimir las órdenes de fabricación
       DmOrdenFabricacionTable.IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       DmMovimientoAuxTable.Cancel;
       end;

end;

function TOrdenFabricacionModule.CompletaOrden(    Ejercicio,
                                                   Tipo                      : SmallInt;
                                                   NroOrden                  : LongInt;
                                                   Simulacion                : Boolean;
                                                   NroPreOrden               : LongInt;
                                                   ProcesaOrdenesVinculadas  : Boolean;
                                                   NroOrdenVinculada         : LongInt;
                                                   FechaInicio               : TDate;
                                               var FechaFinalizacion         : TDate ) : Boolean;

var NroProcesoActual : SmallInt;
    CantidadAFabricar : Decimal;
    Nivel : SmallInt;
    ExistenciasArticulo : IExistenciasArticulo;

{ Esta función se utiliza de forma recursiva, por eso las tablas DrRelacionMaterialesTable y DrOrdenFabricacionTable son locales }

procedure ProcesaOrdenFabricacion(     Ejercicio,
                                       Tipo                      : SmallInt;
                                       NroOrden,
                                       ExtNroOrdenVinculada      : LongInt;
                                       FechaInicio               : TDate;
                                   var FechaFinalizacion         : TDate );

var  FechaActual,
     FechaLanzamientoOrden : TDate;

     DrRelacionMaterialesTable,
     DrRelacionOperacionesTable,
     DrOrdenFabricacionTable : TnxeTable;

     DrRelacionMaterialesFields : TRelacionMaterialesFields;
     DrRelacionOperacionesFields : TRelacionOperacionesFields;
     DrOrdenFabricacionFields : TOrdenFabricacionFields;

begin

     DrOrdenFabricacionTable := nil;

     DrRelacionMaterialesTable := TnxeTable.Create( nil );
     DrRelacionMaterialesTable.AssignRootPropertiesFrom( DmRelacionMaterialesTable );
     DrRelacionMaterialesTable.Open;
     DrRelacionMaterialesFields := TRelacionMaterialesFields.Create( DrRelacionMaterialesTable ) ;

     DrRelacionOperacionesTable := TnxeTable.Create( nil );
     DrRelacionOperacionesTable.AssignRootPropertiesFrom( DmRelacionOperacionesTable );
     DrRelacionOperacionesTable.Open;
     DrRelacionOperacionesFields := TRelacionOperacionesFields.Create( DrRelacionOperacionesTable ) ;

     DrOrdenFabricacionTable := TnxeTable.Create( nil );
     DrOrdenFabricacionTable.AssignRootPropertiesFrom( DmOrdenFabricacionTable );
     DrOrdenFabricacionTable.Open;
     DrOrdenFabricacionFields := TOrdenFabricacionFields.Create( DrOrdenFabricacionTable ) ;

     try

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DrRelacionMaterialesTable,
                                                                       DrRelacionOperacionesTable,
                                                                       DrOrdenFabricacionTable,

                                                                       DmOrdenFabricacionTable,
                                                                       DmLineaOFOperacionTable,
                                                                       DmLineaOFComponenteTable,
                                                                       DmMovimientoTable,
                                                                       DmLineaMovimientoTable,
                                                                       DmOperacionTable ] );

       try

         If   DrOrdenFabricacionTable.FindKey( [ Ejercicio, Tipo, NroOrden ] )
         then DrOrdenFabricacionTable.Edit
         else begin
              SessionDataModule.SendNotification( ntStop, Format( RsMsg4, [ NroOrden ] ), RsMsg5 );
              Abort;
              end;

         With DrRelacionMaterialesTable do
           begin

           If   ( Nivel=0 ) and   // Es el articulo raiz de una pre-orden convirtiéndose en orden
                ( NroPreOrden<>0 )
           then SetRange ( [ CodigoListaTemporal, '', '', '', 1, 1 ], [ CodigoListaTemporal, '', '', '', MaxSmallInt, MaxSmallInt ] )
           else With DrOrdenFabricacionFields do
                  SetRange ( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 1, 1 ],
                             [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MaxSmallInt, MaxSmallInt ] );

           First;
           If   Eof
           then begin
                With DrOrdenFabricacionFields do
                  SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ PadIf( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] ) ] ) );
                Abort;
                end;

           {
           DrOrdenFabricacionFields.Tipo.Value := moOrden;
           If   DrOrdenFabricacionFields.NroOrden.Value=0
           then DrOrdenFabricacionFields.NroOrden.Value := ProximaOrdenFabricacion( moOrden );
           }

           If   ProcesaOrdenesVinculadas
           then begin

                FechaActual := FechaInicio;

                If   not SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.NoLanzarOrdenesRecursivas
                then While not Eof do
                       begin

                       If   DrRelacionOperacionesTable.FindKey( [ DrRelacionMaterialesFields.CodigoComponente.Value,
                                                                  DrRelacionMaterialesFields.ClaseAComponente.Value,
                                                                  DrRelacionMaterialesFields.ClaseBComponente.Value,
                                                                  DrRelacionMaterialesFields.ClaseCComponente.Value,
                                                                  1 ] )
                       then begin
                            Inc( Nivel );

                            If   Nivel>NivelMaximoAnidacion
                            then begin
                                 SessionDataModule.SendNotification( ntStop, RsMsg42, RsMsg43 );
                                 Abort;
                                 end;

                            SessionDataModule.Dm30.ArticuloModule.Obten( DrRelacionMaterialesFields.CodigoComponente.Value, DsArticuloFields );

                            DmOrdenFabricacionTable.Append;

                            DmOrdenFabricacionTable.CopyFields( DrOrdenFabricacionFields.Dataset );

                            DmOrdenFabricacionFields.Tipo.Value := moOrden;
                            DmOrdenFabricacionFields.NroOrden.Value := ProximaOrdenFabricacion( moOrden );
                            DmOrdenFabricacionFields.CodigoArticulo.Value := DrRelacionMaterialesFields.CodigoComponente.Value;
                            DmOrdenFabricacionFields.CodigoClaseA.Value := DrRelacionMaterialesFields.ClaseAComponente.Value;
                            DmOrdenFabricacionFields.CodigoClaseB.Value := DrRelacionMaterialesFields.ClaseBComponente.Value;
                            DmOrdenFabricacionFields.CodigoClaseC.Value := DrRelacionMaterialesFields.ClaseCComponente.Value;
                            DmOrdenFabricacionFields.UnidadesAFabricar.Value := DrOrdenFabricacionFields.UnidadesAFabricar.Value * DrRelacionMaterialesFields.Cantidad.Value;
                            DmOrdenFabricacionFields.Cargas.Value := ObtenCargas( DrOrdenFabricacionFields.UnidadesAFabricar.Value, DsArticuloFields.UnidadesCarga.Value );

                            DmOrdenFabricacionTable.Post;

                            ProcesaOrdenFabricacion( DmOrdenFabricacionFields.Ejercicio.Value,
                                                     DmOrdenFabricacionFields.Tipo.Value,
                                                     DmOrdenFabricacionFields.NroOrden.Value,
                                                     NroOrden,  { ExtNroOrdenVinculada }
                                                     FechaInicio,
                                                     FechaActual );

                            Dec( Nivel );
                            end;

                       Next;
                       end;

                DrOrdenFabricacionFields.FechaLanzamiento.Value := FechaActual;
                DrOrdenFabricacionFields.EjercicioLanzamiento.Value := YearOf( FechaActual );
                DrOrdenFabricacionFields.NroOrdenVinculada.Value := ExtNroOrdenVinculada;

                AsignaNumeroLote( DrOrdenFabricacionFields, False );

                // DrOrdenFabricacionTable.Post;

                end
           else begin

                // No se crean órdenes vinculadas

                DrOrdenFabricacionFields.NroOrdenVinculada.Value := ExtNroOrdenVinculada;
                DrOrdenFabricacionFields.FechaLanzamiento.Value := FechaInicio;
                DrOrdenFabricacionFields.EjercicioLanzamiento.Value := YearOf( FechaInicio );

                AsignaNumeroLote( DrOrdenFabricacionFields, False );

                // DrOrdenFabricacionTable.Post;

                end;

           end;

           {
           If   Nivel=0
           then OrgOrdenFabricacionFields.Dataset.CopyFields( DrOrdenFabricacionFields.Dataset );    // el contenido final de la orden inicial se devuelve en <OrgOrdenFabricacionFields>
           }

           If   ( Nivel=0 ) and
                ( NroPreOrden<>0 )
           then begin
                DrRelacionMaterialesTable.SetRange( [ CodigoListaTemporal, '', '', '', 1, 1 ], [ CodigoListaTemporal, '', '', '', MaxSmallInt, MaxSmallInt ] );
                DrRelacionOperacionesTable.SetRange( [ CodigoListaTemporal, '', '', '', 1 ], [ CodigoListaTemporal, '', '', '', MaxSmallInt ] );
                end
           else With DrOrdenFabricacionFields do
                  begin
                  DrRelacionMaterialesTable.SetRange ( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 1, 1 ], [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MaxSmallInt, MaxSmallInt ] );
                  DrRelacionOperacionesTable.SetRange( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 1 ], [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MaxSmallInt ] );
                  end;

           // Me aseguro de que no existan líneas sueltas (utilizando transacciones no debería ocurrir, pero por si acaso)

           With DrOrdenFabricacionFields do
             If   NroOrden.Value<>0
             then begin
                  DmLineaOFOperacionTable.DeleteRangeRecords ( [ Ejercicio.Value, moOrden, NroOrden.Value, 1 ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt ] );
                  DmLineaOFComponenteTable.DeleteRangeRecords( [ Ejercicio.Value, moOrden, NroOrden.Value, 1, 1 ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt, MaxSmallInt ] );
                  DmLineaOFPedidoTable.DeleteRangeRecords( [ Ejercicio.Value, moOrden, NroOrden.Value, 1, 1 ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt, MaxLongint ] );
                  end;

           With DrRelacionOperacionesTable do
             begin
             First;
             While not Eof do
               begin

               DmLineaOFOperacionTable.Append;

               DmLineaOFOperacionFields.Ejercicio.Value := DrOrdenFabricacionFields.Ejercicio.Value;
               DmLineaOFOperacionFields.Tipo.Value := moOrden;
               DmLineaOFOperacionFields.NroOrden.Value := DrOrdenFabricacionFields.NroOrden.Value;
               DmLineaOFOperacionFields.NroProceso.Value := DrRelacionOperacionesFields.Proceso.Value;
               DmLineaOFOperacionFields.CodigoOperacion.Value := DrRelacionOperacionesFields.CodigoOperacion.Value;

               // Los valores CodigoMaquina, Turno se asignarán (si no proviene de una pre-orden) cuando la orden esté completa
               // FechaInicio y FechaFinalizacion se ajustan con 'AjustaFechasFabricacion'

               If   ( Nivel=0 ) and
                    ( NroPreOrden<>0 )
               then begin

                    If   DmLineaOFOperacionAuxTable.FindKey( [ DmLineaOFOperacionFields.Ejercicio.Value, moPreOrden, NroPreOrden, DmLineaOFOperacionFields.NroProceso.Value ] )
                    then With DmLineaOFOperacionFields do
                           begin
                           DmLineaOFOperacionFields.CodigoMaquina.Value := DmLineaOFOperacionAuxFields.CodigoMaquina.Value;
                           DmLineaOFOperacionFields.Turno.Value := DmLineaOFOperacionAuxFields.Turno.Value;
                           DmLineaOFOperacionFields.Observaciones.Value := DmLineaOFOperacionAuxFields.Observaciones.Value;
                           end
                    else begin
                         SessionDataModule.SendNotification( ntInformation, RsMsg12 );
                         Abort;
                         end;

                    end;

               DmLineaOFOperacionTable.Post;

               SessionDataModule.SendNotification( ntRecord, RsMsg34 + Format( RsMsg3, [ DrOrdenFabricacionFields.NroOrden.Value, DrRelacionMaterialesFields.Proceso.Value ] ) );

               Next;
               end;

             end;

           // lista de materiales

           With DrRelacionMaterialesTable do
             begin
             First;
             While not Eof do
               begin

               DmLineaOFComponenteTable.Append;

               DmLineaOFComponenteFields.Ejercicio.Value := DrOrdenFabricacionFields.Ejercicio.Value;
               DmLineaOFComponenteFields.Tipo.Value := moOrden;
               DmLineaOFComponenteFields.NroOrden.Value := DrOrdenFabricacionFields.NroOrden.Value;
               DmLineaOFComponenteFields.NroProceso.Value := DrRelacionMaterialesFields.Proceso.Value;
               DmLineaOFComponenteFields.NroRegistro.Value := DrRelacionMaterialesFields.NroLinea.Value;
               DmLineaOFComponenteFields.CodigoArticulo.Value := DrRelacionMaterialesFields.CodigoComponente.Value;
               DmLineaOFComponenteFields.CodigoClaseA.Value := DrRelacionMaterialesFields.ClaseAComponente.Value;
               DmLineaOFComponenteFields.CodigoClaseB.Value := DrRelacionMaterialesFields.ClaseBComponente.Value;
               DmLineaOFComponenteFields.CodigoClaseC.Value := DrRelacionMaterialesFields.ClaseCComponente.Value;

               If   ( Nivel=0 ) and
                    ( NroPreOrden<>0 )
               then begin
                    If   DmLineaOFComponenteAuxTable.FindKey( [ DmLineaOFComponenteFields.Ejercicio.Value, moPreOrden, NroPreOrden, DmLineaOFComponenteFields.NroProceso.Value, DmLineaOFComponenteFields.NroRegistro.Value ] )
                    then begin
                         DmLineaOFComponenteFields.CantidadOriginal.Value := DmLineaOFComponenteAuxFields.Cantidad.Value;
                         DmLineaOFComponenteFields.Cantidad.Value := DmLineaOFComponenteFields.CantidadOriginal.Value;
                         DmLineaOFComponenteFields.ConsumoPrevisto.Value := DmLineaOFComponenteAuxFields.ConsumoPrevisto.Value;
                         DmLineaOFComponenteFields.ConsumoReal.Value := DmLineaOFComponenteFields.ConsumoPrevisto.Value;
                         end
                    else begin
                         SessionDataModule.SendNotification( ntInformation, RsMsg12 );
                         Abort;
                         end;
                    end
               else begin
                    DmLineaOFComponenteFields.CantidadOriginal.Value := DrRelacionMaterialesFields.Cantidad.Value;
                    DmLineaOFComponenteFields.Cantidad.Value := DmLineaOFComponenteFields.CantidadOriginal.Value;
                    DmLineaOFComponenteFields.ConsumoPrevisto.Value := DmLineaOFComponenteFields.Cantidad.Value * DrOrdenFabricacionFields.UnidadesAFabricar.Value;
                    DmLineaOFComponenteFields.ConsumoReal.Value := DmLineaOFComponenteFields.ConsumoPrevisto.Value;
                    end;

                 DmLineaOFComponenteTable.Post;

                 SessionDataModule.SendNotification( ntRecord, RsMsg35 + Format( RsMsg3, [ DrOrdenFabricacionFields.NroOrden.Value, DrRelacionMaterialesFields.Proceso.Value ] ) );
                 Next;
                 end;

             end;

           // Ahora coloco en el Proceso 0 (inexistente y previo a todos), la Cantidad a fabricar

           SessionDataModule.Dm70.ContenedorModule.Actualiza( DrOrdenFabricacionFields.EjercicioLanzamiento.Value, DrOrdenFabricacionFields.NroOrden.Value, 0, cnProductoCorrecto, DrOrdenFabricacionFields.UnidadesAFabricar.Value, False );

           SessionDataModule.SendNotification( ntInformation, RsMsg36 );

           { La orden se ha completado. Pasemos a asignar máquinas, turnos y fechas ... }

           With DrOrdenFabricacionFields do
             begin

             FechaLanzamientoOrden := FechaLanzamiento.Value;  // Se debe pasar como referencia

             AjustaFechasFabricacion( Ejercicio.Value,
                                      NroOrden.Value,
                                      1,
                                      FechaLanzamientoOrden,
                                      FechaFinalizacion,
                                      { AjustarVinculos } False,
                                      { AsignarOperadores } not ( ( Nivel=0 ) and ( NroPreOrden<>0 ) ),
                                      { AsignarSecuencias } True );


             SessionDataModule.SendNotification( ntInformation, Format( RsMsg7, [ NroOrden.Value,
                                                                                  PadIf( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] ),
                                                                                  UnidadesAFabricar.Value,
                                                                                  StrFormatDate( FechaLanzamientoOrden ),
                                                                                  StrFormatDate( FechaFinalizacion ) ] ) );

             end;

           { Ahora genero un movimiento de almacen que justifique la salida de los componentes
             desde el registro de existencias comercial al de fabricación }

           If   not SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.NoDescontarComponentes
           then begin

                NroLineaActual := 1;

                DmMovimientoTable.Append;

                DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                DmMovimientoFields.TipoMovimiento.Value := tmDispFabricacion;
                DmMovimientoFields.Serie.Value := '';
                DmMovimientoFields.Fecha.Value := DrOrdenFabricacionFields.FechaLanzamiento.Value;
                DmMovimientoFields.NroDocumento.Value := DrOrdenFabricacionFields.NroOrden.Value;
                DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg6, [ DmMovimientoFields.NroDocumento.Value, DrOrdenFabricacionFields.CodigoArticulo.Value ] );
                DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

                DmMovimientoTable.Post;

                SessionDataModule.SendNotification( ntInformation, Format( RsMsg18, [ DmMovimientoFields.NroOperacion.Value ] ) );

                // guardo el número de operación del movimiento de dispuesto para fabricación y lo grabo en DrOrdenFabricacionFields

                DrOrdenFabricacionFields.mDispFabricacion1.Value := DmMovimientoFields.NroOperacion.Value;

                With DmLineaOFComponenteTable do
                  begin

                  With DrOrdenFabricacionFields do
                    SetRange( [ Ejercicio.Value, moOrden, NroOrden.Value, 1, 1 ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt, MaxSmallInt ] );

                  NroProcesoActual := 0;

                  First;
                  While not Eof  do
                    begin

                    If   DmLineaOFComponenteFields.NroProceso.Value<>NroProcesoActual
                    then begin
                         NroProcesoActual := DmLineaOFComponenteFields.NroProceso.Value;
                         DmLineaOFOperacionTable.IndexFieldNames := 'Ejercicio;Tipo;NroOrden;NroProceso';
                         If   DmLineaOFOperacionTable.FindKey( [ DmLineaOFComponenteFields.Ejercicio.Value, moOrden, DmLineaOFComponenteFields.NroOrden.Value, NroProcesoActual ] )
                         then DmOperacionTable.FindKey( [ DmLineaOFOperacionFields.CodigoOperacion.Value ] );
                         If   DmOperacionFields.AlmacenComponentes.Value =''
                         then begin
                              DmOperacionTable.Edit;
                              DmOperacionFields.AlmacenComponentes.Value := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AlmacenComponentes;
                              DmOperacionTable.Post;
                              end;
                         end;

                    With DmLineaOFComponenteFields do
                      ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( CodigoArticulo.Value,
                                                                                                   False,
                                                                                                   CodigoClaseA.Value,
                                                                                                   CodigoClaseB.Value,
                                                                                                   CodigoClaseC.Value,
                                                                                                   True,
                                                                                                   '',
                                                                                                   False,
                                                                                                   DmOperacionFields.AlmacenComponentes.Value,
                                                                                                   True,
                                                                                                   '',
                                                                                                   True,
                                                                                                   SessionDataModule.Ejercicio,
                                                                                                   0,
                                                                                                   12 );

                    DmLineaMovimientoTable.Append;

                    DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                    DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                    DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;
                    DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                    DmLineaMovimientoFields.CodigoArticulo.Value := DmLineaOFComponenteFields.CodigoArticulo.Value;
                    DmLineaMovimientoFields.CodigoClaseA.Value := DmLineaOFComponenteFields.CodigoClaseA.Value;
                    DmLineaMovimientoFields.CodigoClaseB.Value := DmLineaOFComponenteFields.CodigoClaseB.Value;
                    DmLineaMovimientoFields.CodigoClaseC.Value := DmLineaOFComponenteFields.CodigoClaseC.Value;
                    DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
                    DmLineaMovimientoFields.CodigoAlmacen.Value := DmOperacionFields.AlmacenComponentes.Value;
                    DmLineaMovimientoFields.Cantidad.Value := -( DmLineaOFComponenteFields.Cantidad.Value * DrOrdenFabricacionFields.UnidadesAFabricar.Value );
                    DmLineaMovimientoFields.Precio.Value := ExistenciasArticulo.CosteUltEntrada;

                    SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

                    SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, False );

                    DmLineaMovimientoTable.Post;

                    Inc( NroLineaActual );

                    Next;
                    end;

                  end;

                end;

           DrOrdenFabricacionTable.Post;

           TransactionTag.Commit;

         except
           TransactionTag.Rollback;
           raise;
           end;

     finally
       FreeAndNil( DrRelacionOperacionesTable );
       FreeAndNil( DrRelacionMaterialesTable );
       FreeAndNil( DrOrdenFabricacionTable );
       end;

end;

begin

     Result := False;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaOFOperacionTable ] );

     try

       Nivel := 0;

       SuprimeOrden( Ejercicio, Tipo, NroOrden, { SuprimeCabecera } False, { SuprimeLineas } True );   // No se suprime la orden, solo los registros vinculados

       With DmOrdenFabricacionFields do
         SessionDataModule.SendNotification( ntHeaderInformation, Format( RsMsg14, [ PadIf( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] ), UnidadesAFabricar.Value ] ) );

       ProcesaOrdenFabricacion( Ejercicio, Tipo, NroOrden, NroOrdenVinculada, FechaInicio, FechaFinalizacion );

       SessionDataModule.SendNotification( ntInformation, Format( RsMsg17, [ NroOrden ] ) );

       TransactionTag.Commit;

       Result := True;

      except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendException( E, Self );
       end;

      end;

end;

function TOrdenFabricacionModule.AjustaFechasFabricacion(     Ejercicio             : SmallInt;
                                                              NroOrden              : LongInt;
                                                              PrimerNroProceso      : SmallInt;
                                                          var FechaInicio           : TDate;      // Determina el Ejercicio
                                                          var FechaFinalizacion     : TDate;
                                                              AjustarVinculos,
                                                              AsignarOperadores     : Boolean;
                                                              AsignarSecuencias     : Boolean ) : Boolean;
var   FechaActual,
      FechaInicioOperacion : TDate;
      ListaOrdenesModificadas : TList;
      TurnoOperacion : SmallInt;

begin

     { Hay que tener en cuenta la vinculación de ordenes, de forma que cuando una orden
       sea necesariamente anterior a otra el cambio de las fechas de inicio afecte al resto
       de las ordenes vinculadas ...
     }

     Result := False;

     ListaOrdenesModificadas := TList.Create;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaOFOperacionTable ] );

     try

       try

         DmOrdenFabricacionTable.IndexFieldNames := 'Ejercicio;Tipo;NroOrden';

         If   DmOrdenFabricacionTable.FindKey( [ Ejercicio, moOrden, NroOrden ] )
         then begin

              // Si es de prioridad alta, hay que suprimir todas las secuencias de órdenes de fecha igual o posterior a la orden actual
              // con la intención de reordenar todas las tareas

              If   DmOrdenFabricacionFields.Prioridad.Value=poAlta
              then SuprimeSecuencias( DmOrdenFabricacionFields.FechaLanzamiento.Value );

              // SessionDataModule.Dm70.MaquinaModule.IniciaAsignacionesOrden( ListaOrdenesModificadas );

              With DmLineaOFOperacionTable do
                try

                  FechaActual := FechaInicio;
                  IndexFieldNames := 'Ejercicio;Tipo;NroOrden;NroProceso';

                  SetRange( [ Ejercicio, moOrden, NroOrden, PrimerNroProceso ], [ Ejercicio, moOrden, NroOrden, MaxSmallInt ] );

                  First;
                  While not Eof do
                    begin

                    SessionDataModule.Dm70.MaquinaModule.SuprimeSecuenciaProceso( DmOrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                                  DmOrdenFabricacionFields.NroOrden.Value,
                                                                                  DmLineaOFOperacionFields.NroProceso.Value );  // se preservan las tareas realizadas

                    If   DmOperacionTable.FindKey( [ DmLineaOFOperacionFields.CodigoOperacion.Value ] )
                    then begin

                         Edit;

                         DmLineaOFOperacionFields.OperacionExterna.Value := DmOperacionFields.OperacionExterna.Value;
                         DmLineaOFOperacionFields.FechaInicio.Value := FechaActual;

                         If   AsignarOperadores
                         then If   DmOperacionFields.OperacionExterna.Value
                              then begin
                                   If   DmLineaOFOperacionFields.CodigoSubcontratista.Value=''
                                   then DmLineaOFOperacionFields.CodigoSubcontratista.Value := DmOperacionFields.CodigoOperador.Value;
                                   DmLineaOFOperacionFields.CodigoMaquina.Value := '';
                                   end
                              else begin
                                   DmLineaOFOperacionFields.CodigoSubcontratista.Value := '';
                                   If   DmLineaOFOperacionFields.CodigoMaquina.Value=''
                                   then With DmLineaOFOperacionFields do
                                          begin

                                          FechaInicioOperacion := FechaInicio.Value;
                                          TurnoOperacion := Turno.Value;

                                          CodigoMaquina.Value := SessionDataModule.Dm70.MaquinaModule.AsignaMaquina( DmOperacionFields.CodigoOperador.Value,
                                                                                                                     DmOrdenFabricacionFields.FechaLanzamiento.Value,
                                                                                                                     FechaInicioOperacion,
                                                                                                                     TurnoOperacion,
                                                                                                                     True,
                                                                                                                     DmOrdenFabricacionFields.Prioridad.Value );

                                          FechaInicio.Value := FechaInicioOperacion;
                                          Turno.Value := TurnoOperacion;

                                          end;
                                   end;

                         SessionDataModule.Dm70.MaquinaModule.AsignaSecuenciaOperador( DmOrdenFabricacionFields, DmLineaOFOperacionFields {, ListaOrdenesModificadas } );

                         If   PrimerNroProceso=DmLineaOFOperacionFields.NroProceso.Value        // Guardo la Fecha de inicio del primer proceso, puesto que puede no ser la original
                         then FechaInicio := DmLineaOFOperacionFields.FechaInicio.Value;

                         FechaActual := DmLineaOFOperacionFields.FechaFinalizacion.Value;

                         Post;

                         end
                    else begin
                         SessionDataModule.SendNotification( ntStop, Format( RsMsg13, [ DmLineaOFOperacionFields.CodigoOperacion.Value,
                                                                                        DmLineaOFOperacionFields.NroProceso.Value,
                                                                                        PadIf( [ DmOrdenFabricacionFields.CodigoArticulo.Value, DmOrdenFabricacionFields.CodigoClaseA.Value, DmOrdenFabricacionFields.CodigoClaseB.Value, DmOrdenFabricacionFields.CodigoClaseC.Value ] ) ] ) );
                         Abort;
                         end;

                    Next;
                    end;

                finally
                  CancelRange;
                end;

              FechaFinalizacion := FechaActual;

              // SessionDataModule.Dm70.MaquinaModule.FinalizaAsignacionesOrden( ListaOrdenesModificadas );

              With DmOrdenFabricacionFields do
                If   AjustarVinculos and
                    ( NroOrdenVinculada.Value<>0 )
                then AjustaFechasFabricacion( Ejercicio.Value,
                                              NroOrdenVinculada.Value,
                                              1,
                                              FechaActual,
                                              FechaFinalizacion,
                                              True,
                                              True,
                                              True );

              // Al final asigno a cada secuencia un orden de entrada, teniendo en cuenta las existentes y el orden actual
              // Cuando una orden desplaza a otra de prioridad inferior se procesan primero las de las órdenes desplazadas,
              // dándoles prioridad en la entrada en máquina, pero no en la secuencia de asignación
              // (este comportamiento podría ser configurable)

              SessionDataModule.Dm70.MaquinaModule.OrdenaSecuenciaOrdenFabricacion( Ejercicio, NroOrden );

              // Re-asignando las secuencias suprimidas anteriormente

              If   AsignarSecuencias and ( DmOrdenFabricacionFields.Prioridad.Value=poAlta )
              then AsignaSecuencias( DmOrdenFabricacionFields.FechaLanzamiento.Value,
                                     DmOrdenFabricacionFields.EjercicioLanzamiento.Value,
                                     DmOrdenFabricacionFields.NroOrden.Value );

              Result := True;
              end
         else begin
              SessionDataModule.SendNotification( ntStop, Format( RsMsg4, [ NroOrden  ] ) );
              Abort;
              end;


       finally
         ListaOrdenesModificadas.Free;
         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

procedure TOrdenFabricacionModule.AsignaNumeroLote( UnaOrdenFabricacionFields : TOrdenFabricacionFields; EsUnaPreOrden : Boolean );

var  StrEjercicio : string;
     Contador : Integer;

function ObtenContadorDiario( Fecha : TDate; CodigoArticulo : String ) : Integer;
begin
     Result := 1;
     With DmOrdenFabricacionAuxTable do
       try
         IndexFieldNames := 'FechaLanzamiento;CodigoArticulo';
         SetRange( [ Fecha, CodigoArticulo ] );
         Result := RecordCount;   // La orden de fabricación actual ya existe
       finally
         CancelRange;
         end;
end;

begin
     If   UnaOrdenFabricacionFields.Lote.Value=''   // El usuario puede asignar el lote manualmente
     then begin
          StrEjercicio := IntToStr( SessionDataModule.Ejercicio );
          var MetodoNumeracionLote := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.MetodoNumeracionLote;
          With UnaOrdenFabricacionFields do
            case MetodoNumeracionLote of

              0 : ;

              1,
              2 : begin
                  var NroLote := SessionDataModule.Dm00.ContadoresModule.Incrementa( cnLoteFabricacion, 0, '', 0, 1, 99999999 );
                  If   MetodoNumeracionLote=1
                  then Lote.Value := StrIntPadded( NroLote, 8 )
                  else Lote.Value := StrEjercicio + '/' + StrIntPadded( NroLote, 8 );
                  end;

              3 : If   not EsUnaPreOrden
                  then Lote.Value := StrIntPadded( NroOrden.Value, 8 );

              4 : If   not EsUnaPreOrden
                  then Lote.Value := StrEjercicio + '/' + StrIntPadded( NroOrden.Value, 8 );

              5 : begin
                  Contador := ObtenContadorDiario( FechaLanzamiento.Value, CodigoArticulo.Value );
                  Lote.Value := StrIntPadded( DayOf( SessionDataModule.FechaHoy), 2 ) + StrIntPadded( MonthOf( SessionDataModule.FechaHoy), 2 ) + IntToStr( Contador ) + Copy( StrEjercicio, 4, 1 );
                  end;
              6 : Lote.Value := Copy( StrEjercicio, 4, 1 ) + StrIntPadded( MonthOf( SessionDataModule.FechaHoy ), 2 ) + StrIntPadded( NroOrden.Value, 4 );
              7 : Lote.Value := Copy( StrEjercicio, 3, 2 ) + '-' + StrIntPadded( MonthOf( SessionDataModule.FechaHoy ), 2 ) + '-' + StrIntPadded( NroOrden.Value, 7 );
              end;
          end;
end;

function TOrdenFabricacionModule.ActualizaOrden( OrdenFabricacion : IOrdenFabricacion;
                                                 Reasignar        : Boolean ) : Boolean;

var  TableCursor : TnxServerTableCursor;
     FechaFinalizacion : TDate;

begin

     Result := False;

     If   TnxServerTableCursor.LookupByID( OrdenFabricacion.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmOrdenFabricacionTable ] );

          try

            If   OrdenFabricacion.State=dsEdit
            then If   DmOrdenFabricacionTable.FindKey( [ OrdenFabricacion.Ejercicio, OrdenFabricacion.Tipo, OrdenFabricacion.NroOrden ] )
                 then TableCursor.RecordLockRelease( False )
                 else RaiseRecordNotFoundException;

            OrdenFabricacion.ToDataset( DmOrdenFabricacionFields );

            DmOrdenFabricacionTable.Post;

            If   Reasignar
            then With DmOrdenFabricacionFields do
                   Result := CompletaOrden( Ejercicio.Value,
                                            Tipo.Value,
                                            NroOrden.Value,
                                            False,
                                            0,
                                            False,
                                            0,
                                            FechaLanzamiento.Value,
                                            FechaFinalizacion );

            TransactionTag.Commit;

          except
            DmOrdenFabricacionTable.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end
     else RaiseNoCurrentRecordException;

end;

function TOrdenFabricacionModule.SuprimeOrden( RemoteCursorID    : TnxCursorID;
                                               Ejercicio,
                                               Tipo              : SmallInt;
                                               NroOrden          : LongInt;
                                               SuprimeCabecera,
                                               SuprimeLineas     : Boolean ) : Boolean;
var  TableCursor : TnxServerTableCursor;

begin
     Result := False;
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          TableCursor.RecordLockRelease( False );
          Result := SuprimeOrden( Ejercicio, Tipo, NroOrden, SuprimeCabecera, SuprimeLineas );
          end
     else RaiseNoCurrentRecordException;
end;

function TOrdenFabricacionModule.SuprimeOrden( Ejercicio,
                                               Tipo              : SmallInt;
                                               NroOrden          : LongInt;
                                               SuprimeCabecera,
                                               SuprimeLineas     : Boolean ) : Boolean;
var   HayLineas : Boolean;

begin

     Result := False;

     With DmOrdenFabricacionAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       If   not FindKey( [ Ejercicio, Tipo, NroOrden ] )
       then begin
            SessionDataModule.SendNotification( ntError, Format( RsMsg24, [ NroOrden ] ) );
            Abort;
            end;
       end;

      var TransactionTag := SessionDataModule.StartTransactionWith( [ DmOrdenFabricacionAuxTable,
                                                                      DmLineaOFOperacionTable,
                                                                      DmLineaOFComponenteTable,
                                                                      DmLineaOFPedidoTable,

                                                                      DmMovimientoTable,
                                                                      DmLineaMovimientoTable ] );

      try

       { Movimientos de almacen ... }

       With DmMovimientoTable do
         begin
         IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
         If   FindKey( [ tmDispFabricacion, Ejercicio, '', NroOrden ] )
         then begin
              With DmLineaMovimientoTable do
                try
                  SetRange( [ DmMovimientoFields.Ejercicio.Value, DmMovimientoFields.NroOperacion.Value, 0, 1 ],
                            [ DmMovimientoFields.Ejercicio.Value, DmMovimientoFields.NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );
                  First;
                  While not Eof do
                    begin
                    With DmLineaMovimientoFields do
                      SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, True );
                    Delete;
                    end;
                finally
                  CancelRange;
                end;

              SessionDataModule.SendNotification( ntInformation, Format( RsMsg15, [ DmMovimientoFields.NroOperacion.Value, DmOrdenFabricacionAuxFields.NroOrden.Value ] ) );
              Delete;
              end;

         end;

       If   SuprimeLineas
       then begin
            HayLineas := False;
            With DmLineaOFOperacionTable do
              try
                IndexFieldNames := 'Ejercicio;Tipo;NroOrden;NroProceso';
                SetRange( [ DmOrdenFabricacionAuxFields.Ejercicio.Value, moOrden, DmOrdenFabricacionAuxFields.NroOrden.Value, 0 ],
                          [ DmOrdenFabricacionAuxFields.Ejercicio.Value, moOrden, DmOrdenFabricacionAuxFields.NroOrden.Value, MaxSmallInt ] );
                First;
                While not Eof do
                  begin
                  HayLineas := True;
                  SessionDataModule.Dm70.MaquinaModule.SuprimeSecuenciaProceso( DmOrdenFabricacionAuxFields.EjercicioLanzamiento.Value,
                                                                                DmOrdenFabricacionAuxFields.NroOrden.Value,
                                                                                DmLineaOFOperacionFields.NroProceso.Value,
                                                                                { PreservarTareasRealizadas } not SuprimeCabecera );
                  Delete;
                  end;
              finally
                CancelRange;
              end;

            With DmOrdenFabricacionAuxFields do
              begin
              DmLineaOFOperacionTable.DeleteRangeRecords ( [ Ejercicio.Value, moOrden, NroOrden.Value, 1  ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt ] );
              DmLineaOFComponenteTable.DeleteRangeRecords( [ Ejercicio.Value, moOrden, NroOrden.Value, 1, 1 ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt, MaxSmallInt ] );
              DmLineaOFPedidoTable.DeleteRangeRecords ( [ Ejercicio.Value, moOrden, NroOrden.Value, 1, 1 ], [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallInt, MaxLongint ] );
              end;

            // Quito del contenedor 0 la Cantidad inicial.

            If   HayLineas
            then SessionDataModule.Dm70.ContenedorModule.Limpia( DmOrdenFabricacionAuxFields.EjercicioLanzamiento.Value,
                                                                 DmOrdenFabricacionAuxFields.NroOrden.Value,
                                                                 0,
                                                                 cnProductoCorrecto,
                                                                 otEntradas );

            Result := True;
            end;

       If   SuprimeCabecera
       then begin
            SessionDataModule.SendNotification( ntInformation, Format( RsMsg16, [ DmOrdenFabricacionAuxFields.NroOrden.Value ] ) );
            DmOrdenFabricacionAuxTable.Delete;
            end;

       TransactionTag.Commit;

      except
        TransactionTag.Rollback;
        raise;
      end;

end;

function TOrdenFabricacionModule.ExisteRegistroContadorEvent( ValorActual : LongInt ) : Boolean;
begin
     With DmOrdenFabricacionAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       Result := FindKey( [ SessionDataModule.Ejercicio, ContadorTipo, ValorActual ] )
       end;
end;

procedure TOrdenFabricacionModule.InicializaContadorOrdenFabricacion( OrdenFabricacionFields : TOrdenFabricacionFields );
begin
     ContadorTipo := OrdenFabricacionFields.Tipo.Value;
     CodigoContador := IntToStr( ContadorTipo );
end;

function TOrdenFabricacionModule.ProximaOrdenFabricacion( Modelo         : SmallInt;
                                                          RegistrarValor : Boolean = True  ) : LongInt;

var  ValorActual : LongInt;
     RecordFound,
     ExisteContador : Boolean;

begin

     ValorActual := 0;

     With DmOrdenFabricacionAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       RecordFound := FindEqualLast( [ SessionDataModule.Ejercicio, Modelo ] );
       end;

     If   RecordFound
     then ValorActual := DmOrdenFabricacionAuxFields.NroOrden.Value + 1
     else ValorActual := 1;

     ValorActual := SessionDataModule.Dm00.ContadoresModule.ProximoValor( ExisteRegistroContadorEvent, cnOrdenFabricacion, SessionDataModule.Ejercicio, CodigoContador, ValorActual, 1 );
     If   not RegistrarValor
     then SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnOrdenFabricacion, SessionDataModule.Ejercicio, CodigoContador, ValorActual );

     SessionDataModule.Dm00.ContadoresModule.CompruebaValorMaximo( ValorActual );

     Result := ValorActual;

end;

procedure TOrdenFabricacionModule.ReabreOrden( Ejercicio,
                                               Tipo        : SmallInt;
                                               NroOrden    : LongInt );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmOrdenFabricacionTable ] );

     try

       If   DmOrdenFabricacionTable.FindKey( [ Ejercicio, Tipo, NroOrden ] )
       then begin

            DmOrdenFabricacionTable.Edit;

            DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';

            If   DmMovimientoTable.FindKey( [ Ejercicio, DmOrdenFabricacionFields.mFabricDefectuosa.Value ] )
            then SessionDataModule.Dm30.MovimientoModule.SuprimeMovimiento( Ejercicio, DmMovimientoFields.NroOperacion.Value );

            If   DmMovimientoTable.FindKey( [ Ejercicio, DmOrdenFabricacionFields.mFabricacion.Value ] )
            then SessionDataModule.Dm30.MovimientoModule.SuprimeMovimiento( Ejercicio, DmMovimientoFields.NroOperacion.Value );

            If   DmMovimientoTable.FindKey( [ Ejercicio, DmOrdenFabricacionFields.mExtraidoIncorporado.Value ] )
            then SessionDataModule.Dm30.MovimientoModule.SuprimeMovimiento( Ejercicio, DmMovimientoFields.NroOperacion.Value );

            DmOrdenFabricacionFields.mFabricDefectuosa.Clear;
            DmOrdenFabricacionFields.mFabricacion.Clear;
            DmOrdenFabricacionFields.mExtraidoIncorporado.Clear;

            DmOrdenFabricacionFields.Cerrado.Value := False;

            DmOrdenFabricacionTable.Post;

            end
       else begin
            SessionDataModule.SendNotification( ntError, RsMsg40 );
            Abort;
            end;

       TransactionTag.Commit;

       SessionDataModule.SendNotification( ntInformation, Format( RsMsg41, [ DmOrdenFabricacionFields.NroOrden.Value ] ) );

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendNotification( ntError, RsMsg38, RsMsg39 );
       SessionDataModule.SendException( E, Self );
       end;

     end;

end;

procedure TOrdenFabricacionModule.SuprimeSecuencias( FechaInicial : TDate );
begin

     With DmLineaOFOperacionTable do
       begin
       IndexFieldNames := 'FechaInicio';
       SetRange( [ FechaInicial ], [ HighestDateTime ] );
       First;
       While not Eof do
         begin

         With DmLineaOFOperacionFields do
           begin
           SessionDataModule.SendNotification( ntRecord, Format( RsMsg22, [ NroOrden.Value, NroProceso.Value ] ) );
           SessionDataModule.Dm70.MaquinaModule.SuprimeSecuenciaProceso( Ejercicio.Value, NroOrden.Value, NroProceso.Value ); // se preservan las tareas realizadas
           end;

         Next;
         end;

       end;
end;

// El Ejercicio y el NroOrden son de la orden a excluir (acaba de ser generada)

procedure TOrdenFabricacionModule.AsignaSecuencias( FechaInicial : TDate;
                                                    Ejercicio    : SmallInt = 0;
                                                    NroOrden     : LongInt = 0 );

var  FechaInicio,
     FechaFinalizacion : TDate;

begin

     try

       // Primero obtengo las ordenes para poder seleccionar primero las de prioridad alta

       OperacionesMemTable.Open;
       OperacionesMemTable.IndexFieldNames := 'Ejercicio;NroOrden';

       With DmLineaOFOperacionTable do
         begin
         IndexFieldNames := 'FechaInicio';
         SetRange( [ FechaInicial ], [ HighestDateTime ] );
         First;
         While not Eof do
           begin

           // Solo se guarda un registro por orden, indicando el primer número de proceso involucrado

           If   not ( ( Ejercicio=DmLineaOFOperacionFields.Ejercicio.Value ) and   // Orden a excluir
                      ( NroOrden=DmLineaOFOperacionFields.NroOrden.Value ) )
           then With DmLineaOFOperacionFields do
                       // Ejercicio;NroOrden
                  If   not OperacionesMemTable.FindKey( [ DmLineaOFOperacionFields.Ejercicio.Value, DmLineaOFOperacionFields.NroOrden.Value ] ) and
                       // Ejercicio;Tipo;NroOrden
                       DmOrdenFabricacionTable.FindKey( [ DmLineaOFOperacionFields.Ejercicio.Value, moOrden, DmLineaOFOperacionFields.NroOrden.Value ] )
                  then begin
                       OperacionesMemTable.Append;

                       OperacionesMemTableEjercicio.Value := DmLineaOFOperacionFields.Ejercicio.Value;
                       OperacionesMemTableNroOrden.Value := DmLineaOFOperacionFields.NroOrden.Value;
                       OperacionesMemTablePrioridad.Value := DmOrdenFabricacionFields.Prioridad.Value;
                       OperacionesMemTableNroProceso.Value := DmLineaOFOperacionFields.NroProceso.Value;
                       OperacionesMemTableFechaInicio.Value := DmLineaOFOperacionFields.FechaInicio.Value;
                       OperacionesMemTableFechaFinalizacion.Value := DmLineaOFOperacionFields.FechaFinalizacion.Value;

                       OperacionesMemTable.Post;
                       end;

             Next;
             end;

       // Prioridad;FechaInicio

       With OperacionesMemTable do
         begin
         IndexFieldNames := 'Prioridad;FechaInicio;NroOrden';
         First;
         While not Eof do
           begin

           SessionDataModule.SendNotification( ntRecord, Format( RsMsg22, [ OperacionesMemTableNroOrden.Value, OperacionesMemTableNroProceso.Value ] ) );

           FechaInicio := OperacionesMemTableFechaInicio.Value;
           FechaFinalizacion :=  OperacionesMemTableFechaFinalizacion.Value;

           AjustaFechasFabricacion( OperacionesMemTableEjercicio.Value,
                                    OperacionesMemTableNroOrden.Value,
                                    OperacionesMemTableNroProceso.Value,
                                    FechaInicio,
                                    FechaFinalizacion,
                                    True,
                                    False,
                                    { AsignarSecuencias } False );

           Next;
           end;

           end;

         end;

     finally
       OperacionesMemTable.Close;
       end;

end;

procedure TOrdenFabricacionModule.ReajustaTareas( FechaInicial     : TDate;
                                                  NuevoTipoJornada : TTipoJornada = edSinAsignar );

var  TipoJornadaAnterior : TTipoJornada;

begin

     var TransactionTag := SessionDataModule.StartTransaction;   // Ninguna tabla afectada en el nivel superior

     try

       If   NuevoTipoJornada<>edSinAsignar
       then TipoJornadaAnterior := SessionDataModule.Dm70.CalendarioModule.ModificaTipoJornadaFecha( FechaInicial, NuevoTipoJornada )
       else TipoJornadaAnterior := edSinAsignar;

       SessionDataModule.SendNotification( ntInformation, RsMsg19 );
       SessionDataModule.SendNotification( ntInformation, RsMsg20 );

       // Primero suprimo todas las tareas de los procesos involucrados

       SuprimeSecuencias( FechaInicial );

       // Y luego vuelvo a generarlas

       SessionDataModule.SendNotification( ntInformation, RsMsg21 );

       AsignaSecuencias( FechaInicial );

       TransactionTag.Commit;

     except on E : Exception do
       begin
       TransactionTag.Rollback;

       If   TipoJornadaAnterior<>edSinAsignar
       then SessionDataModule.Dm70.CalendarioModule.ModificaTipoJornadaFecha( FechaInicial, TipoJornadaAnterior );

       SessionDataModule.SendNotification( ntError, RsMsg37 );
       SessionDataModule.SendException( E, Self );
       raise;
       end;
     end;

end;

{ TOrdenFabricacionService }

procedure TOrdenFabricacionService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TOrdenFabricacionService.CompletaOrden(     Ejercicio,
                                                     Tipo                     : SmallInt;
                                                     NroOrden                 : Integer;
                                                     Simulacion               : Boolean;
                                                     NroPreOrden              : Integer;
                                                     ProcesaOrdenesVinculadas : Boolean;
                                                     NroOrdenVinculada        : Integer;
                                                     FechaInicio              : TDate;
                                                 var FechaFinalizacion        : TDate ) : Boolean;
begin
     Result := SessionDataModule.Dm70.OrdenFabricacionModule.CompletaOrden( Ejercicio, Tipo, NroOrden, Simulacion, NroPreOrden, ProcesaOrdenesVinculadas, NroOrdenVinculada, FechaInicio, FechaFinalizacion );
end;

function TOrdenFabricacionService.Estado( Ejercicio,
                                          Tipo       : SmallInt;
                                          NroOrden   : Integer ) : TEstadoOrdenFabricacion;
begin
     Result := SessionDataModule.Dm70.OrdenFabricacionModule.Estado( Ejercicio, Tipo, NroOrden );
end;

procedure TOrdenFabricacionService.GeneraOrdenFabricacionDesdePedido( Ejercicio : SmallInt; Serie : String; NroPedido : LongInt; FechaLanzamiento : TDate; Prioridad : TPrioridadOrdenFabricacion; Simulacion : Boolean = False );
begin
     SessionDataModule.Dm70.OrdenFabricacionModule.GeneraOrdenFabricacionDesdePedido( Ejercicio, Serie, NroPedido, FechaLanzamiento, Prioridad, Simulacion );
end;

function TOrdenFabricacionService.PedidoLanzado( EjercicioPedido : SmallInt;
                                                 SeriePedido     : String;
                                                 NroPedido       : Integer ) : Boolean;
begin
     Result := SessionDataModule.Dm70.OrdenFabricacionModule.PedidoLanzado( EjercicioPedido, SeriePedido, NroPedido );
end;

procedure TOrdenFabricacionService.ReabreOrden(Ejercicio, Tipo: SmallInt; NroOrden: LongInt);
begin
     SessionDataModule.Dm70.OrdenFabricacionModule.ReabreOrden( Ejercicio, Tipo, NroOrden );
end;

procedure TOrdenFabricacionService.ReajustaTareas(FechaInicial: TDate; NuevoTipoJornada: TTipoJornada);
begin
     SessionDataModule.Dm70.OrdenFabricacionModule.ReajustaTareas( FechaInicial, NuevoTipoJornada );
end;

function TOrdenFabricacionService.AjustaFechasFabricacion(     Ejercicio         : SmallInt;
                                                               NroOrden          : Integer;
                                                               PrimerNroProceso  : SmallInt;
                                                           var FechaInicio,
                                                               FechaFinalizacion : TDate;
                                                               AjustarVinculos,
                                                               AsignarOperadores,
                                                               AsignarSecuencias : Boolean ) : Boolean;
begin
     Result := SessionDataModule.Dm70.OrdenFabricacionModule.AjustaFechasFabricacion( Ejercicio, NroOrden, PrimerNroProceso, FechaInicio, FechaFinalizacion, AjustarVinculos, AsignarOperadores, AsignarSecuencias );
end;

function TOrdenFabricacionService.ActualizaOrden( OrdenFabricacion : IOrdenFabricacion;
                                                  Reasignar        : Boolean ) : Boolean;
begin
     Result := SessionDataModule.Dm70.OrdenFabricacionModule.ActualizaOrden( OrdenFabricacion, Reasignar );
end;

function TOrdenFabricacionService.SuprimeOrden( RemoteCursorID      : TnxCursorID;
                                                Ejercicio,
                                                Tipo                : SmallInt;
                                                NroOrden: Integer; SuprimeCabecera,
                                                SuprimeLineas: Boolean): Boolean;
begin
     Result := SessionDataModule.Dm70.OrdenFabricacionModule.SuprimeOrden( RemoteCursorID, Ejercicio, Tipo, NroOrden, SuprimeCabecera, SuprimeLineas );
end;

var OrdenFabricacionControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_OrdenFabricacionService, TOrdenFabricacionService, OrdenFabricacionControl );

end.
