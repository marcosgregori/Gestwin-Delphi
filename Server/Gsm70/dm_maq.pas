
unit dm_maq;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  LibUtils,

  Gim30Fields,
  Gim40Fields,
  Gim70Fields,

  dmi_maq;

type

  TMaquinaService = class( TSessionModule, IMaquinaService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    function  HayTareasPendientes( Fecha : TDate ) : Boolean;
    procedure OrdenaSecuenciaTurno( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt; Reordenar : Boolean = False );
    procedure OrdenaSecuenciaOrdenFabricacion( Ejercicio : SmallInt; NroOrden : LongInt );
    end;

  TRegistroOrdenModificada = class
     Ejercicio : SmallInt;
     NroOrden : LongInt;
     NroProceso  : SmallInt;
     Fecha : TDate;
     constructor Create( UnEjercicio : SmallInt; UnNroOrden : LongInt; UnNroProceso : SmallInt; UnaFecha : TDate );
     end;

   TMaquinaModule = class(TServerDataModule)
    DmMaquinaTable: TnxeTable;
    DmMaquinaTipoTable: TnxeTable;
    DmOperacionTable: TnxeTable;
    DmRelacionOperacionesTable: TnxeTable;
    DmOcupacionMaquinaTable: TnxeTable;
    DmSecuenciaAsignacionTable: TnxeTable;
    DmSecuenciaAsignacion2Table: TnxeTable;
    DmInformeFabricacionTable: TnxeTable;
    DmAsignacionMaquinasTable: TnxeTable;
    DmTurnoTable: TnxeTable;
    DmOrdenFabricacionTable: TnxeTable;
    DmLineaOFOperacionTable: TnxeTable;
    DmOperariosMaquinaTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    private

      DmMaquinaFields : TMaquinaFields;
      DmMaquinaTipoFields : TMaquinaTipoFields;
      DmOperacionFields : TOperacionFields;
      DmRelacionOperacionesFields : TRelacionOperacionesFields;

      DmOcupacionMaquinaFields : TOcupacionMaquinaFields;
      DmSecuenciaAsignacionFields,
      DmSecuenciaAsignacion2Fields : TSecuenciaAsignacionFields;
      DmAsignacionMaquinasFields : TAsignacionMaquinasFields;
      DmTurnoFields : TTurnoFields;
      DmInformeFabricacionFields : TInformeFabricacionFields;
      DmOrdenFabricacionFields : TOrdenFabricacionFields;
      DmLineaOFOperacionFields : TLineaOFOperacionFields;

      DsCalendarioFields : TCalendarioFields;

      ListaTurnoFields : array[ 1..4 ] of TTurnoFields;
      RegistroOrdenModificada  : TRegistroOrdenModificada;

    public

      procedure CompruebaSolapamientoTurnos( DmMaquinaFields : TMaquinaFields; Fecha : TDate );
      procedure AsignaTiempoMaquina( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt; Tiempo : TDuration );
      procedure ObtenRegistroOcupacion( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt );
      function  AsignaMaquina( CodigoMaquinaTipo : String; FechaLanzamiento : TDate; var Fecha : TDate; var TurnoInicial : SmallInt; Actualizar : Boolean; Prioridad : SmallInt ): String;
      function  AsignaTurno( DmMaquinaFields : TMaquinaFields; FechaLanzamiento, Fecha : TDate; var Turno : SmallInt; Prioridad : SmallInt ) : Boolean;
      function  TiempoDisponibleMaquina( DmMaquinaFields : TMaquinaFields; Fecha : TDate; Turno : SmallInt; TiempoSolicitado : TDuration; var TiempoDisponibleInicial : TDuration; var TiempoOcupado : TDuration ) : TDuration;
      function  CalculaTiempoFabricacion( OrdenFabricacionFields : TOrdenFabricacionFields; LineaOFOperacionFields : TLineaOFOperacionFields; CantidadAFabricar : Decimal ) : TDuration;
      function  CalculaUnidadesAfabricar( Tiempo : TDuration ) : Decimal;
      function  AsignaSecuenciaOperador( OrdenFabricacionFields : TOrdenFabricacionFields; LineaOFOperacionFields : TLineaOFOperacionFields {; ListaOrdenesModificadas : TList } ) : Boolean;
      // procedure IniciaAsignacionesOrden( ListaOrdenesModificadas : TList );
      // procedure FinalizaAsignacionesOrden( ListaOrdenesModificadas : TList );
      procedure OrdenaSecuenciaTurno( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt; Reordenar : Boolean = False );
      procedure OrdenaSecuenciaOrdenFabricacion( Ejercicio : SmallInt; NroOrden : LongInt );
      procedure SuprimeSecuenciaProceso( Ejercicio : SmallInt; NroOrden : LongInt; NroProceso : SmallInt = -1; PreservarTareasRealizadas : Boolean = True; OperacionExterna : Boolean = False );
      procedure SuprimeRelacionesMaquina( CodigoMaquina : String );
      procedure ActualizaSecuencia( Ejercicio : SmallInt; NroOrden : LongInt; NroProceso : SmallInt; Fecha : TDate; Turno : SmallInt; Realizado : Boolean );
      function  HayTareasPendientes( Fecha : TDate ) : Boolean;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,
     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsdServerEngine,

     DateUtils,

     Gim00Fields,

     dmi_cpr,
     dmi_odf,

     dm_cla,
     dm_odf;

{$R *.DFM}

resourceString
     RsMsg1  = 'El intento de asignación de una máquina del tipo %s - %s ha excedido el retraso máximo permitido (%d dias).';
     RsMsg2  = 'Se cancela el proceso de asignación de máquinas.';
     RsMsg3  = 'No existe ninguna máquina del tipo %s.';
     RsMsg4  = 'La máquina no tiene actividad en el turno indicado.';
     RsMsg5  = 'Consulte la ficha de la máquina para comprobar los turnos en los que tiene actividad.';
     RsMsg6  = 'El tiempo transcurrido entre la asignación de 2 tareas del tipo [%s] a excedido el retraso máximo permitido (%d dias).';
     RsMsg7  = 'Los turno nº %d y nº %d se solapan el día %s para la máquina %s.';
     RsMsg8  = 'Revise la asignación de turnos para ese día y/o máquina.';
     RsMsg9  = 'El tiempo de fabricación de %f unidades del artículo %s %s %s %s, en el proceso nº %d, es nulo.';
     RsMsg10 = 'La tarea %s consta como realizada pero no existe el informe de fabricación correspondiente.';
     RsMsg11 = 'Realice una RECONSTRUCCION de datos desde la opción de menú Procesos->Procesos especiales->Reconstrucción de datos internos.';
     RsMsg12 = 'La máquina [%s] ha sido dada de baja.';
     RsMsg13 = 'Código de máquina incorrecto.';
     RsMsg14 = 'La máquina %s no es del tipo %s, tal y como corresponde a una operacion %s, %s.';
     RsMsg15 = 'La orden nº %d ha sido afectada por la creación de una orden de prioridad alta.';
     RsMsg16 = '      Fechas de finalización anterior y actual : %s, %s. Retraso : %d dia/s.';

{ TRegistroOrdenModificada }

constructor TRegistroOrdenModificada.Create( UnEjercicio  : SmallInt;
                                             UnNroOrden   : LongInt;
                                             UnNroProceso : SmallInt;
                                             UnaFecha     : TDate );
begin
     inherited Create;
     Ejercicio  := UnEjercicio;
     NroOrden   := UnNroOrden;
     NroProceso := UnNroProceso;
     Fecha      := UnaFecha;
end;

{ TMaquinaModule }

procedure TMaquinaModule.ServerDataModuleCreate(Sender: TObject);

var  I : SmallInt;

begin
     DmMaquinaFields := TMaquinaFields.Create( DmMaquinaTable );
     DmMaquinaTipoFields := TMaquinaTipoFields.Create( DmMaquinaTipoTable );
     DmOperacionFields := TOperacionFields.Create( DmOperacionTable );
     DmRelacionOperacionesFields := TRelacionOperacionesFields.Create( DmRelacionOperacionesTable );
     DmOcupacionMaquinaFields := TOcupacionMaquinaFields.Create( DmOcupacionMaquinaTable );
     DmSecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( DmSecuenciaAsignacionTable );
     DmSecuenciaAsignacion2Fields := TSecuenciaAsignacionFields.Create( DmSecuenciaAsignacion2Table );
     DmInformeFabricacionFields := TInformeFabricacionFields.Create( DmInformeFabricacionTable );
     DmAsignacionMaquinasFields := TAsignacionMaquinasFields.Create( DmAsignacionMaquinasTable );
     DmTurnoFields := TTurnoFields.Create( DmTurnoTable );
     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
     DmLineaOFOperacionFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionTable );

     DsCalendarioFields := TCalendarioFields.Create( Self );

     For I := 1 to 4 do
       ListaTurnoFields[ I ] := TTurnoFields.Create( Self );
end;

procedure TMaquinaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.MaquinaModule := nil;
end;

procedure TMaquinaModule.CompruebaSolapamientoTurnos( DmMaquinaFields : TMaquinaFields;
                                                      Fecha           : TDate );

var   I, J  : SmallInt;
      Error : Boolean;

begin

     SessionDataModule.Dm70.CalendarioModule.ObtenRegistroFecha( Fecha, DsCalendarioFields );

     For I := 1 to 4 do
       begin
       ListaTurnoFields[ I ].Clear( DmTurnoTable );
       If   DmMaquinaFields.TurnoActividad[ I ].Value<>0
       then For J := 1 to 4 do
              If   DmMaquinaFields.TurnoActividad[ I ].Value=DsCalendarioFields.Turno[ J ].Value
              then begin
                   If   DmTurnoTable.FindKey( [ DmMaquinaFields.TurnoActividad[ I ].Value ] )
                   then ListaTurnoFields[ I ].Update( DmTurnoTable );
                   Break;   // sale sólo del bucle interior
                   end;
       end;

     For I := 1 to 3 do
       For J := I + 1 to 4 do
         If   ( ListaTurnoFields[ I ].NroTurno.Value<>0 ) and
              ( ListaTurnoFields[ J ].NroTurno.Value<>0 )
         then begin

              Error := ( ( ListaTurnoFields[ I ].Inicio1.Value<ListaTurnoFields[ J ].Inicio1.Value ) and ( ListaTurnoFields[ I ].Fin1.Value>ListaTurnoFields[ J ].Inicio1.Value ) ) or
                       ( ( ListaTurnoFields[ I ].Inicio1.Value>ListaTurnoFields[ J ].Inicio1.Value ) and ( ListaTurnoFields[ J ].Fin1.Value>ListaTurnoFields[ I ].Inicio1.Value ) ) or

                       ( ( ListaTurnoFields[ I ].Inicio2.Value<ListaTurnoFields[ J ].Inicio1.Value ) and ( ListaTurnoFields[ I ].Fin2.Value>ListaTurnoFields[ J ].Inicio1.Value ) ) or
                       ( ( ListaTurnoFields[ I ].Inicio2.Value>ListaTurnoFields[ J ].Inicio1.Value ) and ( ListaTurnoFields[ J ].Fin1.Value>ListaTurnoFields[ I ].Inicio2.Value ) ) or

                       ( ( ListaTurnoFields[ I ].Inicio2.Value<ListaTurnoFields[ J ].Inicio2.Value ) and ( ListaTurnoFields[ I ].Fin2.Value>ListaTurnoFields[ J ].Inicio2.Value ) ) or
                       ( ( ListaTurnoFields[ I ].Inicio2.Value>ListaTurnoFields[ J ].Inicio2.Value ) and ( ListaTurnoFields[ J ].Fin2.Value>ListaTurnoFields[ I ].Inicio2.Value ) );

              If   Error
              then begin
                   SessionDataModule.SendNotification( ntStop, Format( RsMsg7, [ ListaTurnoFields[ I ].NroTurno.Value, ListaTurnoFields[ J ].NroTurno.Value, StrFormatDate( Fecha ), DmMaquinaFields.Codigo.Value ] ), RsMsg8 );
                   Abort;
                   end;
              end;

end;

function TMaquinaModule.AsignaTurno(     DmMaquinaFields    : TMaquinaFields;
                                         FechaLanzamiento,
                                         Fecha              : TDate;
                                     var Turno              : SmallInt;
                                         Prioridad          : SmallInt ) : Boolean;

     {  Parámetros :
          Fecha - la Fecha a comprobar.
          Turno - si es = 0, el primer Turno válido,
                  si tiene valor el Turno siguiente
     }

var   Index,
      TurnoIndex : SmallInt;
      TurnoValido : Boolean;
      TiempoDisponible,
      TiempoDisponibleInicial,
      TiempoOcupado : TDuration;

begin

     Result     := False;

     If   Fecha<SessionDataModule.FechaHoy
     then Exit;

     TurnoIndex := 4;

     For Index := 1 to 4 do   // busco el primer Turno válido o el actual
       If   ( ( Turno=0 )  and ( DmMaquinaFields.TurnoActividad[ Index ].Value<>0 ) )    or
            ( ( Turno<>0 ) and ( DmMaquinaFields.TurnoActividad[ Index ].Value=Turno ) )
       then begin
            TurnoIndex := Index;
            Break;
            end;

     If   Turno<>0
     then If   TurnoIndex=4
          then Exit
          else Inc( TurnoIndex );

     repeat

       If   DmMaquinaFields.TurnoActividad[ TurnoIndex ].Value<>0  // esta máquina está activa en el Turno
       then begin

            TurnoValido := True;

            If   ( FechaLanzamiento=SessionDataModule.FechaHoy ) and
                 ( Fecha=SessionDataModule.FechaHoy )                                                         // es hoy. Habrá que comprobar si el Turno ya se ha iniciado.
            then If   DmTurnoTable.FindKey( [ DmMaquinaFields.TurnoActividad[ TurnoIndex ].Value ] )
                 then TurnoValido := ( Time<DmTurnoFields.Inicio1.Value ) or                                  // el criterio es que si el Turno se ha iniciado se considera cerrado.
                                     ( Time<DmTurnoFields.Inicio2.Value );

            If   TurnoValido
            then begin

                 If   Prioridad=0   // Alta
                 then TiempoDisponible := SessionDataModule.Dm70.CalendarioModule.ObtenDisponibilidadFecha( Fecha, DmMaquinaFields.TurnoActividad[ TurnoIndex ].Value )
                 else TiempoDisponible := TiempoDisponibleMaquina( DmMaquinaFields,
                                                                   Fecha,
                                                                   DmMaquinaFields.TurnoActividad[ TurnoIndex ].Value,
                                                                   DmMaquinaFields.TiempoMinAsignacion.Value,
                                                                   TiempoDisponibleInicial,
                                                                   TiempoOcupado );
                 If   TiempoDisponible<>0
                 then begin                                                         // encontrada !!
                      CompruebaSolapamientoTurnos( DmMaquinaFields, Fecha );
                      Turno  := DmMaquinaFields.TurnoActividad[ TurnoIndex ].Value;
                      Result := True;
                      end;

                 end;
            end;

       Inc( TurnoIndex );

     until ( TurnoIndex=5 ) or
           Result;


end;

function TMaquinaModule.AsignaMaquina(     CodigoMaquinaTipo : String;
                                           FechaLanzamiento  : TDate;
                                       var Fecha             : TDate;
                                       var TurnoInicial      : SmallInt;
                                           Actualizar        : Boolean;
                                           Prioridad         : SmallInt  ) : String;

     {  Parámetros :
          Fecha - la Fecha de partida. Se buscará cualquier hueco a partir de ella.
          Turno - si es = 0, el primer Turno válido, si tiene valor se asignará al Turno en cuestión.
     }

var     Finalizado,
        SegundoPase : Boolean;
        PrimerCodigoMaquina,
        UltimoCodigoMaquina : String;
        FechaActual : TDate;
        NroMaximoDias,
        NroDias : SmallInt;

procedure UpdateAsignacionMaquina( CodigoMaquina : String );
begin
     With DmAsignacionMaquinasTable do
       If   FindKey( [ CodigoMaquinaTipo ] )
       then begin
            DmAsignacionMaquinasFields.CodigoMaquina.Value := CodigoMaquina;
            Post;
            end;
end;

procedure NoExisteMaquina;
begin
     SessionDataModule.SendNotification( ntStop, Format( RsMsg3, [ CodigoMaquinaTipo ] ), RsMsg2 );
     Abort;
end;

begin
     { Notas :

          Basta con encontrar una máquina (del tipo <CodigoMaquinaTipo>) que tenga libre al menos <tiempoMinimo>.
          Hay que tener en cuenta : el método de asignación.
                                    el Turno inicial (comprobar la hora actual -si la Fecha de lanzamiento es de hoy- y el próximo Turno disponible).

     }

     Result := '';

     If   DmMaquinaTipoTable.FindKey( [ CodigoMaquinaTipo ] )
     then With DmAsignacionMaquinasTable do
            begin

            FechaActual := Fecha;
            NroDias := 0;
            NroMaximoDias := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.RetrasoMaximoLanzamiento;

            {   Cuidado, si se activa este código hay que incluirlo en una transaccion

            If   not FindKey( [ CodigoMaquinaTipo ] )
            then begin
                 Append;
                 DmAsignacionMaquinasFields.CodigoMaquinaTipo.Value := CodigoMaquinaTipo;
                 Post;
                 end;
            }

            With DmMaquinaTable do
              begin

              IndexFieldNames := 'CodigoMaquinaTipo;Codigo';

              repeat

                UltimoCodigoMaquina := '';

                If   ( DmMaquinaTipoFields.MetodoAsignacion.Value=1 )  or    // 0 = Alternar, 1 = Completar
                     ( DmAsignacionMaquinasFields.CodigoMaquina.Value='' )
                then begin
                     If   FindSmallerOrEqual( [ CodigoMaquinaTipo, HighStrCode ] )
                     then begin
                          If   DmMaquinaFields.CodigoMaquinaTipo.Value=CodigoMaquinaTipo
                          then PrimerCodigoMaquina := DmMaquinaFields.Codigo.Value
                          else NoExisteMaquina;  //  no existe ninguna máquina de este tipo
                          end
                     else NoExisteMaquina;
                     end
                else begin
                     PrimerCodigoMaquina := DmAsignacionMaquinasFields.CodigoMaquina.Value;
                     FindSmaller( [ CodigoMaquinaTipo, PrimerCodigoMaquina ] );
                     end;

                SegundoPase := False;
                Finalizado := False;

                repeat

                  If   SegundoPase and ( DmMaquinaFields.Codigo.Value=UltimoCodigoMaquina )
                  then Finalizado := True
                  else If   Finalizado or
                            ( DmMaquinaFields.CodigoMaquinaTipo.Value<>CodigoMaquinaTipo )      // se ha llegado al principio. ¿Hay que empezar en la última máquina?
                       then begin

                            If   not( ( DmMaquinaTipoFields.MetodoAsignacion.Value=1 ) or
                                      ( DmAsignacionMaquinasFields.CodigoMaquina.Value='' ) )   // es decir, puede que no se haya empezado desde el principio
                            then begin
                                 If   FindSmallerOrEqual( [ CodigoMaquinaTipo, HighStrCode ] )
                                 then If   ( UltimoCodigoMaquina='' )                or
                                           ( DmMaquinaFields.Codigo.Value>UltimoCodigoMaquina )
                                      then SegundoPase := True;
                                 Finalizado := not SegundoPase;
                                 end
                            else Finalizado := True;

                            end
                       else begin      // tenemos una máquina que puede ser válida. Comprobémoslo.

                            UltimoCodigoMaquina := DmMaquinaFields.Codigo.Value;
                            TurnoInicial := 0;
                            If   AsignaTurno( DmMaquinaFields, FechaLanzamiento, FechaActual, TurnoInicial, Prioridad )
                            then begin
                                 Fecha := FechaActual;
                                 Result := DmMaquinaFields.Codigo.Value;
                                 If   Actualizar
                                 then UpdateAsignacionMaquina( DmMaquinaFields.Codigo.Value );
                                 Exit;
                                 end;

                            Prior;
                            end;

                until Eof or
                      Bof or
                      Finalizado or
                      ( DmMaquinaFields.CodigoMaquinaTipo.Value<>CodigoMaquinaTipo ) or
                      ( Result<>'' );

                Inc( NroDias );
                If   NroDias>NroMaximoDias
                then begin
                     SessionDataModule.SendNotification( ntStop, Format( RsMsg1, [ CodigoMaquinaTipo, DmMaquinaTipoFields.Descripcion.Value, NroMaximoDias ] ), RsMsg2 );
                     Abort;
                     end;

                FechaActual := IncDay( FechaActual );

              until Result<>'';
              end;

            end;
end;

procedure TMaquinaModule.ObtenRegistroOcupacion( CodigoMaquina : String;
                                                 Fecha         : TDate;
                                                 Turno         : SmallInt );
begin
     With DmOcupacionMaquinaTable do
        begin
        CancelRange;
        If   not FindKey( [ CodigoMaquina, Fecha, Turno ] )
        then begin
             Append;
             DmOcupacionMaquinaFields.CodigoMaquina.Value := CodigoMaquina;
             DmOcupacionMaquinaFields.Fecha.Value := Fecha;
             DmOcupacionMaquinaFields.Turno.Value := Turno;
             Post;
             end;
        Edit;
        end;
end;

function TMaquinaModule.TiempoDisponibleMaquina(     DmMaquinaFields         : TMaquinaFields;
                                                     Fecha                   : TDate;
                                                     Turno                   : SmallInt;
                                                     TiempoSolicitado        : TDuration;
                                                 var TiempoDisponibleInicial : TDuration;
                                                 var TiempoOcupado           : TDuration ) :TDuration;
var   TiempoLibre  : TDuration;

begin

     { CUIDADO, entre el proceso de comprobación de disponibilidad y la asignación
       otro cliente podría modificar el Tiempo disponible. Veremos si origina problemas .... }

     Result := 0;
     With DmOcupacionMaquinaTable do
       begin
       TiempoDisponibleInicial := SessionDataModule.Dm70.CalendarioModule.ObtenDisponibilidadFecha( Fecha, Turno );
       TiempoOcupado := 0;
       If   TiempoDisponibleInicial>0
       then begin
            ObtenRegistroOcupacion( DmMaquinaFields.Codigo.Value, Fecha, Turno );
            TiempoOcupado := DmOcupacionMaquinaFields.Ocupado.Value;
            TiempoLibre := ( TiempoDisponibleInicial * DmMaquinaFields.ProcesosSimultaneos.Value ) - TiempoOcupado;
            If   TiempoLibre>=DmMaquinaFields.TiempoMinAsignacion.Value
            then begin

                 If   TiempoSolicitado>TiempoLibre
                 then TiempoSolicitado := TiempoLibre;

                 If   TiempoSolicitado>TiempoDisponibleInicial   // anunque haya en total TiempoDisponibleInicial * ProcesosSimultaneos solo se puede asignar TiempoDisponibleInicial.
                 then Result := TiempoDisponibleInicial
                 else Result := TiempoSolicitado;

                 end;
            end;
       end;
end;

procedure TMaquinaModule.AsignaTiempoMaquina( CodigoMaquina : String;
                                              Fecha         : TDate;
                                              Turno         : SmallInt;
                                              Tiempo        : TDuration );
begin
     With DmOcupacionMaquinaTable do
       begin
       ObtenRegistroOcupacion( CodigoMaquina, Fecha, Turno );
       DmOcupacionMaquinaFields.Ocupado.Value := DmOcupacionMaquinaFields.Ocupado.Value + Tiempo;
       Post;
       end;
end;

{
procedure TMaquinaModule.IniciaAsignacionesOrden( ListaOrdenesModificadas : TList );
begin
     ListaOrdenesModificadas.Clear;
end;

procedure TMaquinaModule.FinalizaAsignacionesOrden( ListaOrdenesModificadas : TList );

var   Index : SmallInt;
      FechaAnterior,
      FechaFinalizacion : TDate;
      ListaOrdenes : TList;

begin

     // Creo una lista temporal porque la llamada a AjustaFechasFabricacion llama a IniciaAsignacionesOrden y limpia la lista.
     // Habría que guardar una lista por cada orden (ya veremos)

     ListaOrdenes := TList.Create;
     try
       ListaOrdenes.Assign( ListaOrdenesModificadas );
       With ListaOrdenes do
         If   Count>0
         then For Index := 0 to Count - 1 do
                 With TRegistroOrdenModificada( Items[ Index ] ) do
                   If   DmOrdenFabricacionTable.FindKey( [ Ejercicio, moOrden, NroOrden ] )
                   then begin

                        DmLineaOFOperacionTable.FindSmallerOrEqual( [ Ejercicio, moOrden, NroOrden ] );
                        FechaAnterior := DmLineaOFOperacionFields.FechaFinalizacion.Value;

                        SessionDataModule.Dm70.OrdenFabricacionModule.AjustaFechasFabricacion( Ejercicio, NroOrden, NroProceso, Fecha, FechaFinalizacion, True, True );

                        SessionDataModule.SendNotification( ntInformation, Format( RsMsg15, [ NroOrden ] ) );
                        SessionDataModule.SendNotification( ntInformation, Format( RsMsg16, [ StrFormatDate( FechaAnterior, dfDefault ), StrFormatDate( FechaFinalizacion ), DaysBetween( FechaAnterior, FechaFinalizacion ) ] ) );
                        end;
       finally
         ListaOrdenes.Free;
         end;

end;
}

function TMaquinaModule.AsignaSecuenciaOperador( OrdenFabricacionFields  : TOrdenFabricacionFields;
                                                 LineaOFOperacionFields  : TLineaOFOperacionFields {;
                                                 ListaOrdenesModificadas : TList } ) : Boolean;

var   TiempoTotal,
      TiempoTarea,
      TiempoMaximoDisponible,
      TiempoQueFalta : TDuration;
      SegmentoActual : SmallInt;
      FechaActual : TDate;
      Porcentaje : LongInt;
      NroDias,
      TurnoActual,
      NroMaximoDias : SmallInt;

      ExistenTareasRealizadas,
      OtroTurno                    : Boolean;

      TiempoDisponibleInicial,
      TiempoOcupado : TDuration;
      CantidadInicial,
      CantidadAFabricar,
      CantidadProcesada,
      CantidadTarea : Decimal;

function ExisteOtroTurnoDisponible : Boolean;
begin
     If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.MantenerTurnoEnAsignacion
     then OtroTurno := False
     else OtroTurno := AsignaTurno( DmMaquinaFields, OrdenFabricacionFields.FechaLanzamiento.Value, FechaActual, TurnoActual, OrdenFabricacionFields.Prioridad.Value );
     Result := OtroTurno;
end;

function RecalculaTiempoFabricacion( Unidades : Decimal ) : TDuration;
begin

     // Se supone que DmRelacionOperacionesFields se ha leído con anterioridad

     With DmRelacionOperacionesFields do
          Result := Round( ( TiempoPreparacion.Value + ( ( Unidades / UnidadesTiempo.Value ) * TiempoFabricacion.Value ) ) + 0.5 );
end;

procedure ProximoDia;

var   TurnoValido : Boolean;

begin
     TurnoValido := True;
     repeat

       FechaActual := IncDay( FechaActual );
       If   not LineaOFOperacionFields.OperacionExterna.Value
       then If   not SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.MantenerTurnoEnAsignacion
            then begin
                 TurnoActual := 0;  // Empezamos de nuevo desde el primer turno posible
                 TurnoValido := ExisteOtroTurnoDisponible;
                 end;

       If   LineaOFOperacionFields.OperacionExterna.Value or
            ( not LineaOFOperacionFields.OperacionExterna.Value and not TurnoValido )
       then begin
            Inc( NroDias );
            If   NroDias>NroMaximoDias
            then begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg6, [ LineaOFOperacionFields.CodigoOperacion.Value, NroMaximoDias ] ), RsMsg2 );
                 Abort;
                 end;
            end;

     until TurnoValido;
end;

{  Ya no es necesario des-ocupar tareas porque se suprimen y vuelven a generar todas

procedure DesOcupaTareas( Fecha           : TDate;
                          Turno           : SmallInt;
                          TiempoNecesario : TTime );

begin
     With DmSecuenciaAsignacion2Table do
       begin

       try

         IndexFieldNames := 'CodigoMaquina;Fecha;Turno;Prioridad;NroOrdenFabricacion';

         SetRange( [ DmMaquinaFields.Codigo.Value, Fecha, Turno, 1, 1 ],
                   [ DmMaquinaFields.Codigo.Value, Fecha, Turno, 2, MaxLongint ] );
         Last;         // Desde la menor prioridad a la mayor, empezando por las órdenes de número mayor (más recientes)
         While not Bof and ( TiempoNecesario>0 ) do
           begin

           If   DmOrdenfabricacionTable.FindKey( [ DmSecuenciaAsignacion2Fields.Ejercicio.Value, moOrden, DmSecuenciaAsignacion2Fields.NroOrdenFabricacion.Value ] ) and
                DmLineaOFOperacionTable.FindKey( [ DmSecuenciaAsignacion2Fields.Ejercicio.Value, moOrden, DmSecuenciaAsignacion2Fields.NroOrdenFabricacion.Value, DmSecuenciaAsignacion2Fields.NroProceso.Value ] )
           then begin

                TiempoNecesario := TiempoNecesario - DmSecuenciaAsignacion2Fields.Tiempo.Value;

                With DmLineaOFOperacionFields do
                  begin
                  SuprimeSecuenciaProceso( Ejercicio.Value, NroOrden.Value, NroProceso.Value );
                  RegistroOrdenModificada := TRegistroOrdenModificada.Create( Ejercicio.Value, NroOrden.Value, NroProceso.Value, FechaInicio.Value );
                  end;

                ListaOrdenesModificadas.Add( RegistroOrdenModificada );
                end;

           Prior;
           end;

       finally
         end;

       end;


end;
}

begin

     Result := False;
     SegmentoActual := 1;
     NroDias := 0;
     NroMaximoDias := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.RetrasoMaximoTareas;

     DmMaquinaTable.IndexFieldNames := 'Codigo'; // por si acaso
     DmSecuenciaAsignacionTable.IndexFieldNames := 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento';

     If   not LineaOFOperacionFields.OperacionExterna.Value
     then If   not DmMaquinaTable.FindKey( [ LineaOFOperacionFields.CodigoMaquina.Value ] )
          then begin
               SessionDataModule.SendNotification( ntStop, Format( RsMsg12, [ LineaOFOperacionFields.CodigoMaquina.Value ] ), RsMsg2 );
               Abort;
               end;

     If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.RealizarProduccionPrevista and
          ( LineaOFOperacionFields.NroProceso.Value=1 )
     then begin
          With LineaOFOperacionFields do
            CantidadAFabricar := SessionDataModule.Dm70.ContenedorModule.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, NroProceso.Value, cnProductoAcabadoCorrectoTotal ).Saldo;
          CantidadAFabricar := OrdenFabricacionFields.UnidadesAFabricar.Value - CantidadAFabricar;
          end
     else With LineaOFOperacionFields do
            CantidadAFabricar := SessionDataModule.Dm70.ContenedorModule.ContenidoOrden( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, 0, NroProceso.Value - 1, cnProductoAcabadoCorrectoTotal ).Saldo;

     If   CantidadAFabricar=0.0
     then Exit;

     FechaActual := LineaOFOperacionFields.FechaInicio.Value;
     TurnoActual := LineaOFOperacionFields.Turno.Value;   // es el Turno inicial
     ExistenTareasRealizadas := False;

     If   not LineaOFOperacionFields.OperacionExterna.Value
     then With DmSecuenciaAsignacionTable do
            begin

            With LineaOFOperacionFields do
              SetRange( [ OrdenFabricacionFields.Ejercicio.Value, NroOrden.Value, NroProceso.Value, 0 ],
                        [ OrdenFabricacionFields.Ejercicio.Value, NroOrden.Value, NroProceso.Value, MaxSmallInt ] );
            First;
            While not Eof do
              begin

              If   DmSecuenciaAsignacionFields.Realizado.Value
              then ExistenTareasRealizadas := True;

              If   FechaActual<DmSecuenciaAsignacionFields.Fecha.Value
              then FechaActual := DmSecuenciaAsignacionFields.Fecha.Value;

              If   TurnoActual<>DmSecuenciaAsignacionFields.Turno.Value
              then TurnoActual := DmSecuenciaAsignacionFields.Turno.Value;

              If   SegmentoActual<DmSecuenciaAsignacionFields.Segmento.Value + 1
              then SegmentoActual := DmSecuenciaAsignacionFields.Segmento.Value + 1;

              Next;
              end;
            end;

     CantidadInicial := CantidadAFabricar;

     If   ExistenTareasRealizadas
     then If   not LineaOFOperacionFields.OperacionExterna.Value
          then If   not ExisteOtroTurnoDisponible
               then ProximoDia;

     If   CantidadAFabricar>0.0
     then begin
          repeat

            TiempoTarea := 0;
            CantidadTarea := 0;
            OtroTurno := False;

            TiempoTotal := CalculaTiempoFabricacion( OrdenFabricacionFields, LineaOFOperacionFields, CantidadAFabricar );

            If   LineaOFOperacionFields.OperacionExterna.Value
            then TiempoTarea := SessionDataModule.Dm70.CalendarioModule.ObtenDisponibilidadFecha( FechaActual, 0 )   // Tiempo externo
            else begin
                 CompruebaSolapamientoTurnos( DmMaquinaFields, FechaActual );
                 If   TiempoTotal=0
                 then begin
                      With OrdenFabricacionFields do
                        SessionDataModule.SendNotification( ntStop, Format( RsMsg9, [ CantidadAFabricar, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, LineaOFOperacionFields.NroProceso.Value ] ), RsMsg2 );
                      Abort;
                      end;

                 TiempoTarea := TiempoDisponibleMaquina( DmMaquinaFields, FechaActual, TurnoActual, TiempoTotal, TiempoDisponibleInicial, TiempoOcupado );

                 case OrdenFabricacionFields.Prioridad.Value of
                   0  : begin
                        If   TiempoTarea<TiempoTotal
                        then begin
                             // TiempoMaximoDisponible := Calendario.obtenDisponibilidadFecha( FechaActual, TurnoActual, notificacionTable );
                             {
                             TiempoQueFalta := TiempoTotal - TiempoTarea;
                             If   TiempoQueFalta>0  // No es suficiente con el tiempo disponible. Habrá que hacerle un hueco al proceso.
                             then DesOcupaTareas( FechaActual, TurnoActual, TiempoQueFalta );
                             }
                             TiempoTarea := TiempoDisponibleMaquina( DmMaquinaFields, FechaActual, TurnoActual, TiempoTotal, TiempoDisponibleInicial, TiempoOcupado );
                             end;
                        end;
                   else If   TiempoTarea<>0
                        then case OrdenFabricacionFields.Prioridad.Value of
                               1 : If   DmMaquinaFields.TiempoMaxAsignacion.Value<>0
                                   then If   TiempoTarea>DmMaquinaFields.TiempoMaxAsignacion.Value              // media
                                        then TiempoTarea := DmMaquinaFields.TiempoMaxAsignacion.Value;
                               2 : begin                                                                        // baja
                                   Porcentaje := ( TiempoOcupado * 100 ) div TiempoDisponibleInicial;           // La carga debe ser menor del 75%
                                   If   Porcentaje>75
                                   then TiempoTarea := 0
                                   else If   DmMaquinaFields.TiempoMaxAsignacion.Value<>0
                                        then If   TiempoTarea>DmMaquinaFields.TiempoMaxAsignacion.Value
                                             then TiempoTarea := DmMaquinaFields.TiempoMaxAsignacion.Value;
                                   end;
                               end;
                   end;
                 end;

            If   LineaOFOperacionFields.OperacionExterna.Value and
                 ( ( DmRelacionOperacionesFields.TiempoFabricacion.Value=0 ) or ( DmRelacionOperacionesFields.UnidadesTiempo.Value=0 ) )
            then begin

                 // Es un caso muy particular que permite utilizar el tiempo de preparación como tiempo total de fabricación del proceso externo

                 If   DmRelacionOperacionesFields.TiempoPreparacion.Value<>0.0
                 then begin
                      CantidadTarea  := Trunc( ( CantidadInicial * TiempoTarea ) / DmRelacionOperacionesFields.TiempoPreparacion.Value );
                      If   CantidadTarea>CantidadAFabricar
                      then CantidadTarea := CantidadAFabricar;
                      end;

                 end
            else begin
                 CantidadTarea  := CalculaUnidadesAfabricar( TiempoTarea );
                 If   CantidadTarea=0
                 then TiempoTarea := 0
                 else begin
                      If   CantidadTarea>CantidadAFabricar
                      then CantidadTarea := CantidadAFabricar;
                      TiempoTarea := RecalculaTiempoFabricacion( CantidadTarea );
                      end;
                 CantidadTarea := Redondea( CantidadTarea, SessionDataModule.EmpresaFields.Ventas_DecCantidad.Value );
                 end;

            If   CantidadTarea>0
            then begin

                 NroDias := 0;   // Controlo los días entre 2 tareas, no los días acumulados

                 If   not LineaOFOperacionFields.OperacionExterna.Value
                 then begin

                      DmSecuenciaAsignacionTable.Append;

                      DmSecuenciaAsignacionFields.Ejercicio.Value := OrdenFabricacionFields.EjercicioLanzamiento.Value;
                      DmSecuenciaAsignacionFields.NroOrdenFabricacion.Value := LineaOFOperacionFields.NroOrden.Value;
                      DmSecuenciaAsignacionFields.NroProceso.Value := LineaOFOperacionFields.NroProceso.Value;
                      DmSecuenciaAsignacionFields.Segmento.Value := SegmentoActual;
                      DmSecuenciaAsignacionFields.CodigoMaquina.Value := LineaOFOperacionFields.CodigoMaquina.Value;
                      DmSecuenciaAsignacionFields.Fecha.Value := FechaActual;
                      DmSecuenciaAsignacionFields.Turno.Value := TurnoActual;
                      DmSecuenciaAsignacionFields.Cantidad.Value := CantidadTarea;
                      DmSecuenciaAsignacionFields.Tiempo.Value := TiempoTarea;
                      DmSecuenciaAsignacionFields.Prioridad.Value := OrdenFabricacionFields.Prioridad.Value;

                      DmSecuenciaAsignacionTable.Post;

                      Inc( SegmentoActual );

                      AsignaTiempoMaquina( LineaOFOperacionFields.CodigoMaquina.Value,
                                           FechaActual,
                                           TurnoActual,
                                           TiempoTarea );

                      ExisteOtroTurnoDisponible;

                      end;

                 CantidadAFabricar :=  CantidadAFabricar - CantidadTarea;

                 end;

            If       LineaOFOperacionFields.OperacionExterna.Value or
                 not OtroTurno
            then If   CantidadAFabricar>0
                 then ProximoDia;

          until CantidadAFabricar<=0;

          end
     else ;

     LineaOFOperacionFields.FechaFinalizacion.Value := FechaActual;

     Result := True;

end;

//  Excepto cuando se suprime una orden de fabricación, siempre se preservan las tareas realizadas

procedure TMaquinaModule.SuprimeSecuenciaProceso( Ejercicio                 : SmallInt;
                                                  NroOrden                  : LongInt;
                                                  NroProceso                : SmallInt = -1;
                                                  PreservarTareasRealizadas : Boolean = True;
                                                  OperacionExterna          : Boolean = False );

var  NroProcesoInicial,
     NroProcesoFinal : SmallInt;

begin
     With DmSecuenciaAsignacionTable do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmSecuenciaAsignacionTable ] );

       try

          If   NroProceso=-1
          then begin
               NroProcesoInicial := 0;
               NroProcesoFinal := MaxSmallInt;
               end
          else begin
               NroProcesoInicial := NroProceso;
               NroProcesoFinal := NroProceso;
               end;

         IndexFieldNames := 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento';
         try

           SetRange( [ Ejercicio, NroOrden, NroProcesoInicial, 0 ],
                     [ Ejercicio, NroOrden, NroProcesoFinal, MaxSmallInt ] );
           First;
           While not Eof do
             begin
             If   not ( PreservarTareasRealizadas and DmSecuenciaAsignacionFields.Realizado.Value )
             then begin
                  If   not OperacionExterna
                  then With DmSecuenciaAsignacionFields do
                         AsignaTiempoMaquina( CodigoMaquina.Value, Fecha.Value, Turno.Value, -Tiempo.Value );
                  Delete;
                  end
             else Next;
             end;

         finally
           CancelRange;
           end;

         TransactionTag.Commit;

       except
         TransactionTag.Rollback;
         raise;
         end;

       end;

end;

procedure TMaquinaModule.OrdenaSecuenciaTurno( CodigoMaquina : String;
                                               Fecha         : TDate;
                                               Turno         : SmallInt;
                                               Reordenar     : Boolean = False );

var  NroOrdenEntradaActual : SmallInt;

begin

     With DmSecuenciaAsignacion2Table do
       try

         IndexFieldNames := 'CodigoMaquina;Fecha;Turno;NroOrdenEntrada';

         SetRange( [ CodigoMaquina, Fecha, Turno, 0 ],
                   [ CodigoMaquina, Fecha, Turno, MaxSmallInt ] );

         If   RecordCount>0
         then begin

              Last;

              If   Reordenar
              then begin
                   NroOrdenEntradaActual := 1;
                   First;
                   While not Eof do
                     begin
                       try
                         Edit;
                         DmSecuenciaAsignacion2Fields.NroOrdenEntrada.Value := NroOrdenEntradaActual;
                         Post;
                       except
                         Cancel;
                         raise;
                         end;
                     Inc( NroOrdenEntradaActual );
                     Next;
                     end;
                   end
              else begin
                   NroOrdenEntradaActual := DmSecuenciaAsignacion2Fields.NroOrdenEntrada.Value + 1;   // Si es 0, porque no está asignado, se empezará numerando desde el 1
                   First;
                   While not Eof do
                     If   DmSecuenciaAsignacion2Fields.NroOrdenEntrada.Value=0
                     then begin
                          try
                            Edit;
                            DmSecuenciaAsignacion2Fields.NroOrdenEntrada.Value := NroOrdenEntradaActual;
                            Post;
                          except
                            Cancel;
                            raise;
                            end;
                          Inc( NroOrdenEntradaActual );
                          First;
                          end
                     else Next;

                   end;

              // Ahora la asignación de horas de inicio

              DmTurnoTable.FindKey( [ Turno ] );
              var HoraInicioTarea := DmTurnoFields.Inicio1.Value;

              First;
              While not Eof do
                begin

                try

                  Edit;
                  DmSecuenciaAsignacion2Fields.HoraInicio.Value := HoraInicioTarea;
                  HoraInicioTarea := IncSecond( HoraInicioTarea, DmSecuenciaAsignacion2Fields.Tiempo.Value );
                  If   HoraInicioTarea>DmTurnoFields.Fin1.Value
                  then HoraInicioTarea := DmTurnoFields.Inicio2.Value;
                  Post;

                except
                  Cancel;
                  raise;
                  end;

                Next;
                end;

              end;

       finally
         CancelRange;
         end;
end;

procedure TMaquinaModule.OrdenaSecuenciaOrdenFabricacion( Ejercicio : SmallInt;
                                                          NroOrden  : LongInt );
begin

     // No utilizo transacciones : la signación de orden de entrada y hora de inicio se reconstruye continuamente.

     With DmSecuenciaAsignacionTable do
       begin

       IndexFieldNames := 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento';

       try

         SetRange( [ Ejercicio, NroOrden, 1, 0 ],
                   [ Ejercicio, NroOrden, MaxSmallInt, MaxSmallInt ] );
         First;
         While not Eof do
           begin
           With  DmSecuenciaAsignacionFields do
             OrdenaSecuenciaTurno( CodigoMaquina.Value, Fecha.Value, Turno.Value );
           Next;
           end;

       finally
         CancelRange;
         end;

       end;

end;

function TMaquinaModule.CalculaTiempoFabricacion( OrdenFabricacionFields : TOrdenFabricacionFields;
                                                  LineaOFOperacionFields : TLineaOFOperacionFields;
                                                  CantidadAFabricar      : Decimal ) : TDuration;
begin
     Result := 0;
     If   DmRelacionOperacionesTable.FindKey( [ OrdenFabricacionFields.CodigoArticulo.Value,
                                                OrdenFabricacionFields.CodigoClaseA.Value,
                                                OrdenFabricacionFields.CodigoClaseB.Value,
                                                OrdenFabricacionFields.CodigoClaseC.Value,
                                                LineaOFOperacionFields.NroProceso.Value ] )
     then Result := Round( ( DmRelacionOperacionesFields.TiempoPreparacion.Value + ( ( CantidadAFabricar / DmRelacionOperacionesFields.UnidadesTiempo.Value ) * DmRelacionOperacionesFields.TiempoFabricacion.Value ) ) + 0.5 );
end;

function TMaquinaModule.CalculaUnidadesAFabricar( Tiempo : TDuration ) : Decimal;

// Solo se debe utilizar si se ha leido correctamento un DmRelacionOperacionesFields, utilizando el Table DmRelacionOperacionesTable.

// var  TiempoUnidad : Decimal;

{  He quitado la comprobación de que se pueda fabricar al menos una unidad porque, a veces, utilizan cantidades inferiores (muestras)

   TiempoUnidad := DmRelacionOperacionesFields.TiempoFabricacion.Value / DmRelacionOperacionesFields.UnidadesTiempo.Value;
   If   TiempoUnidad>0.0
   then If   Tiempo>=DmRelacionOperacionesFields.TiempoPreparacion.Value + TiempoUnidad     // puedo fabricar al menos una unidad ?
        then
  // OJO : No utilizar TiempoUnidad en lugar de (TiempoFabricacion/UnidadesTiempo), produce un Error de redondeo.

}

begin
     Result := 0;
     If   ( Tiempo>0 ) and
          ( DmRelacionOperacionesFields.UnidadesTiempo.Value>0 )
     then Result := ( Tiempo - DmRelacionOperacionesFields.TiempoPreparacion.Value ) /
                    ( DmRelacionOperacionesFields.TiempoFabricacion.Value / DmRelacionOperacionesFields.UnidadesTiempo.Value );
end;

{  Trasladar al módulo cliente                                            ·$

procedure TMaquinaModule.CompruebaTurnoActividad( CodigoMaquina : String;
                                                  TurnoField    : TIntegerField );
begin
     With DmMaquinaTable do
       begin
       IndexFieldNames := 0;
       If   FindKey( [ CodigoMaquina ] )
       then With DmMaquinaFields do
              If   ( TurnoField.Value<>TurnoActividad[ 1 ] ) and
                   ( TurnoField.Value<>TurnoActividad[ 2 ] ) and
                   ( TurnoField.Value<>TurnoActividad[ 3 ] ) and
                   ( TurnoField.Value<>TurnoActividad[ 4 ] )
              then inputError( RsMsg4, RsMsg5 );
       end;
end;

function TMaquinaModule.Descripcion( Codigo : String; notificaSiNoExiste : Boolean ) : string;
begin
     Result := '';
     With DmMaquinaTable do
       try
         IndexFieldNames := 0;
         If   FindKey( [ Codigo ], loNoLock )
         then Result := DmMaquinaFields.Descripcion
         else If    notificaSiNoExiste
              then Result := rsgMsg349;
       finally
         resetIndexNumber;
         end;
end;

}

procedure TMaquinaModule.SuprimeRelacionesMaquina( CodigoMaquina : String );
begin
     DmOperariosMaquinaTable.DeleteRangeRecords( [ CodigoMaquina, 0, 0 ], [ CodigoMaquina, MaxSmallInt, MaxSmallInt ] );
end;

procedure TMaquinaModule.ActualizaSecuencia( Ejercicio   : SmallInt;
                                             NroOrden    : LongInt;
                                             NroProceso  : SmallInt;
                                             Fecha       : TDate;
                                             Turno       : SmallInt;
                                             Realizado   : Boolean );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmSecuenciaAsignacionTable ] );
     try
       With DmSecuenciaAsignacionTable do
         begin
         IndexFieldNames := 'Ejercicio;NroOrdenFabricacion;NroProceso;Fecha;Turno';
         If   FindKey( [ Ejercicio, NroOrden, NroProceso, Fecha, Turno ] )
         then try
                Edit;
                DmSecuenciaAsignacionFields.Realizado.Value := Realizado;
                Post;
              except
                Cancel;
                raise;
                end;
         end;
       TransactionTag.Commit;
     except
       TransactionTag.Rollback;
       raise;
       end;
end;

function TMaquinaModule.HayTareasPendientes( Fecha : TDate ) : Boolean;
begin
     Result := False;
     With DmSecuenciaAsignacionTable do
       try
         IndexFieldNames := 'Fecha;Turno;CodigoMaquina;NroOrdenEntrada';
         SetRange( [ Fecha, 0, '', 0 ], [ Fecha, MaxSmallInt, HighStrCode, MaxSmallInt ] );
         First;
         While not Eof do
           begin
           If   not DmSecuenciaAsignacionFields.Realizado.Value
           then begin
                Result := True;
                Exit;
                end;
           Next;
           end;
       finally
         CancelRange;
         end;
end;

{ TMaquinaService }

procedure TMaquinaService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TMaquinaService.HayTareasPendientes( Fecha : TDate ) : Boolean;
begin
     Result := SessionDataModule.Dm70.MaquinaModule.HayTareasPendientes( Fecha );
end;

procedure TMaquinaService.OrdenaSecuenciaOrdenFabricacion( Ejercicio: SmallInt; NroOrden: LongInt);
begin
     SessionDataModule.Dm70.MaquinaModule.OrdenaSecuenciaOrdenFabricacion( Ejercicio, NroOrden );
end;

procedure TMaquinaService.OrdenaSecuenciaTurno(CodigoMaquina: String; Fecha: TDate; Turno: SmallInt; Reordenar : Boolean = False);
begin
     SessionDataModule.Dm70.MaquinaModule.OrdenaSecuenciaTurno( CodigoMaquina, Fecha, Turno, Reordenar );
end;

var MaquinaControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_MaquinaService, TMaquinaService, MaquinaControl );

end.
