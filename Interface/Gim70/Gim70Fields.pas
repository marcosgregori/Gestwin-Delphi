{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim70Fields;

interface

uses  DB,
      LibUtils,
      Datamanager,

      Gim00Fields;

{$TYPEINFO ON}   // Rtti

resourceString
       RsTextoEstadoOrden = 'TextoEstadoOrden';

const ctParametrosModuloProduccion = 1007;

      // Identificadores de ventanas (?)

       idMntLmpForm     = 7000;  // relacion de materiales y procesos

type

   TParametrosProduccionRec = packed record
      case Byte of
        0 : ( Parametros                 : TParametrosRec );
        1 : ( AlmacenComponentes,
              AlmacenProdAcabado         : String[ 2 ];
              TipoJornadaSabado          : SmallInt;
              RetrasoMaximoLanzamiento,
              DecimalesComponentes       : SmallInt;
              MetodoCalculoCoste         : SmallInt;
              IncrementoPorcentualCoste  : Decimal;
              UsarLotesfabricacion       : Boolean;
              MetodoNumeracionLote       : SmallInt;
              RetrasoMaximoTareas        : SmallInt;
              MantenerTurnoEnAsignacion,
              IncorporarExtraerArticulos : Boolean;
              AlmacenProdDefectuoso      : String[ 2 ];
              AlmacenarProdDefectuosos,
              MermaExcesoArticulos,
              RealizarProduccionPrevista,
              AjusteAutomaticoConsumos,
              NoDescontarComponentes     : Boolean;
              AlmacenExtracciones        : String[ 2 ];
              ExisteClase                : Array[ 1..3 ] of Boolean;
              NombreClase                : Array[ 1..3 ] of String[ 10 ];
              CosteComponentes           : SmallInt;
              NoLanzarOrdenesRecursivas  : Boolean );

        end;

    TOperarioTipoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       CosteHora : TBCDField;
     end;

     TMaquinaTipoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       CosteHora : TBCDField;
       MetodoAsignacion : TSmallIntField;
     end;

   TCodigoCosteFields = class( TnxeDatasetFields)
     Codigo : TSmallIntField;
     Descripcion : TWideStringField;
     Tipo : TSmallIntField;
     end;

   TTurnoActividadFields = array[ 1..4 ] of TSmallIntField;

   TMaquinaFields = class( TnxeDatasetFields)
   public
    Codigo : TWideStringField;
    Descripcion : TWideStringField;
    Ubicacion : TWideStringField;
    CodigoMaquinaTipo : TWideStringField;
    ProcesosSimultaneos : TSmallIntField;
    TurnoActividad : TTurnoActividadFields;
    TiempoMinAsignacion : TLongWordField;
    TiempoMaxAsignacion : TLongWordField;
    end;

   TCosteMaquinaFields = class( TnxeDatasetFields)
   public
     CodigoMaquina : TWideStringField;
     NroRegistro : TSmallIntField;
     CodigoCoste : TSmallIntField;
     Coste : TBCDField;
     end;

   TCosteOperarioFields = class( TnxeDatasetFields)
   public
     CodigoOperario : TWideStringField;
     NroRegistro : TSmallIntField;
     Turno : TSmallIntField;
     CosteHora : TBCDField;
     end;

   TOperariosMaquinaFields = class( TnxeDatasetFields)
   public
     CodigoMaquina : TWideStringField;
     Turno : TSmallIntField;
     NroRegistro : TSmallIntField;
     CodigoOperario : TWideStringField;
     end;

   TOperacionFields = class( TnxeDatasetFields)
   public
     Codigo : TWideStringField;
     Descripcion : TWideStringField;
     Reservado : TWideStringField;
     OperacionExterna : TBooleanField;
     UnidadesTiempo : TIntegerField;
     CodigoOperador : TWideStringField;
     Preparacion : TLongWordField;
     Fabricacion : TLongWordField;
     AlmacenComponentes : TWideStringField;
     AlmacenProdAcabado : TWideStringField;
     end;

   TRelacionMaterialesFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Proceso : TSmallIntField;
       NroLinea : TSmallIntField;
       CodigoComponente : TWideStringField;
       ClaseAComponente : TWideStringField;
       ClaseBComponente : TWideStringField;
       ClaseCComponente : TWideStringField;
       Cantidad : TFloatField;
     end;

     TRelacionOperacionesFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Proceso : TSmallIntField;
       CodigoOperacion : TWideStringField;
       TiempoPreparacion : TLongWordField;  // Tiempo en segundos (TDuration)
       TiempoFabricacion : TLongWordField;
       UnidadesTiempo : TIntegerField;
       Anotacion : TWideMemoField;
     end;

     TRelacionDocumentosFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Proceso : TSmallIntField;
       NroLinea : TSmallIntField;
       Documento : TWideStringField;
     end;

   TLineaOperacionFields = class( TnxeDatasetFields)
   public
     Codigo : TWideStringField;
     NroRegistro : TSmallIntField;
     CodigoOperarioTipo : TWideStringField;
     Cantidad : TSmallIntField;
     end;

   TOrdenFabricacionFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     Tipo : TSmallIntField;
     NroOrden : TIntegerField;
     EjercicioPedido : TSmallIntField;
     SeriePedido : TWideStringField;
     NroPedido : TIntegerField;
     EjercicioLanzamiento : TSmallIntField;
     NroOperacionLanzamiento : TIntegerField;
     CodigoArticulo : TWideStringField;
     CodigoClaseA : TWideStringField;
     CodigoClaseB : TWideStringField;
     CodigoClaseC : TWideStringField;
     Lote : TWideStringField;
     UnidadesAFabricar : TBCDField;
     FechaLanzamiento : TDateField;
     Prioridad : TSmallIntField;
     NroOrdenVinculada : TIntegerField;
     Aprovisionamiento : TBooleanField;
     Cerrado : TBooleanField;
     Cargas : TIntegerField;
     mDispFabricacion1 : TIntegerField;
     mFabricacion : TIntegerField;
     mFabricDefectuosa : TIntegerField;
     mExtraidoIncorporado : TIntegerField;
     Observaciones : TWideMemoField;
     [TAttrCalculatedField] EstadoOrden : TSmallIntField;
     end;

   TLineaOFOperacionFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     Tipo : TSmallIntField;
     NroOrden : TIntegerField;
     NroProceso : TSmallIntField;
     CodigoOperacion : TWideStringField;
     OperacionExterna : TBooleanField;
     CodigoSubcontratista : TWideStringField;
     CodigoMaquina : TWideStringField;
     Turno : TSmallIntField;
     FechaInicio : TDateField;
     FechaFinalizacion : TDateField;
     Observaciones : TWideStringField;
     end;

   TLineaOFComponenteFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     Tipo : TSmallIntField;
     NroOrden : TIntegerField;
     NroProceso : TSmallIntField;
     NroRegistro : TSmallIntField;
     CodigoArticulo : TWideStringField;
     CodigoClaseA : TWideStringField;
     CodigoClaseB : TWideStringField;
     CodigoClaseC : TWideStringField;
     Lote : TWideStringField;
     CantidadOriginal : TFloatField;
     Cantidad : TFloatField;
     ConsumoPrevisto : TFloatField;
     ConsumoReal : TFloatField;
     end;

   TLineaOFPedidoFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     Tipo : TSmallIntField;
     NroOrden : TIntegerField;
     EjercicioPedido : TSmallIntField;
     NroOperacionPedido : TIntegerField;
     end;

   TInformeFabricacionFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrden : TIntegerField;
     NroProceso : TSmallIntField;
     Fecha : TDateField;
     Turno : TSmallIntField;
     Correctas : TBCDField;
     Defectuosas : TBCDField;
     MermaExceso : TBCDField;
     IncorpExtraidas : TBCDField;
     CodigoDefecto : TSmallIntField;
     IncExtClaseA : TWideStringField;
     IncExtClaseB : TWideStringField;
     IncExtClaseC : TWideStringField;
     HoraInicio : TTimeField;
     HoraFinalizacion : TTimeField;
     Preparacion : TLongWordField;
     Fabricacion : TLongWordField;
     CodigoIncidencia : TSmallIntField;
     Observaciones : TWideMemoField;
     end;

   TLineaInformeFabricacionFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrden : TIntegerField;
     NroProceso : TSmallIntField;
     Fecha : TDateField;
     Turno : TSmallIntField;
     NroRegistro : TSmallIntField;
     CodigoOperario : TWideStringField;
     end;

   TDefectoInformeFabricacionFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrden : TIntegerField;
     NroProceso : TSmallIntField;
     Fecha : TDateField;
     Turno : TSmallIntField;
     NroRegistro : TSmallIntField;
     CodigoDefecto : TSmallIntField;
     Unidades : TBCDField;
     end;

   TOrdenAprovisionamientoFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrden : TIntegerField;
     Fecha : TDateField;
     FechaRecepcion : TDateField;
     Origen : TSmallIntField;
     EjercicioOrigen : TSmallIntField;
     NroRegistroOrigen : TIntegerField;
     end;

   TLineaOrdenAprovisionamientoFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrden : TIntegerField;
     NroRegistro : TSmallIntField;
     CodigoArticulo : TWideStringField;
     CodigoClaseA : TWideStringField;
     CodigoClaseB : TWideStringField;
     CodigoClaseC : TWideStringField;
     CodigoAlmacen : TWideStringField;
     CantidadOrden : TBCDField;
     Cantidad : TBCDField;
     CodigoProveedor : TWideStringField;
     EjercicioOrden : TSmallIntField;
     NroOrdenFabricacion : TIntegerField;
     EjercicioPedido : TSmallIntField;
     NroOperacionPedido : TIntegerField;
     end;

   TDefectoFields = class( TnxeDatasetFields)
   public
     Codigo : TSmallIntField;
     Descripcion : TWideStringField;
     CodigoClaseA : TWideStringField;
     CodigoClaseB : TWideStringField;
     CodigoClaseC : TWideStringField;
     end;

   TIncidenciaFields = class( TnxeDatasetFields)
   public
     Codigo : TSmallIntField;
     Descripcion : TWideStringField;
     end;

   TNotificacionESFields = class( TnxeDatasetFields)
   public
      Ejercicio : TSmallIntField;
      NroNotificacion : TIntegerField;
      EjercicioOrden : TSmallIntField;
      NroOrden : TIntegerField;
      NroProceso : TSmallIntField;
      Fecha : TDateField;
      TipoOperacion : TSmallIntField;
      Correctas,
      Defectuosas : TBCDField;
      CodigoDefecto : TSmallIntField;
      MermaExceso,
      IncorpExtraidas : TBCDField;
      IncExtClaseA,
      IncExtClaseB,
      IncExtClaseC : TWideStringField;
      Coste : TBCDField;
      Observaciones : TWideStringField;
      end;

   TTurnoFields = class( TnxeDatasetFields)
   public
     NroTurno : TSmallIntField;
     Descripcion : TWideStringField;
     Inicio1 : TTimeField;
     Fin1 : TTimeField;
     Inicio2 : TTimeField;
     Fin2 : TTimeField;
     end;

   TTurnoArray = array[ 1..4 ] of TSmallIntField;

   TCalendarioFields = class( TnxeDatasetFields)
   public
     Fecha : TDateField;
     TipoJornada : TSmallIntField;
     TiempoExterno : TLongWordField;
     Turno : TTurnoArray;
     end;

   TOcupacionMaquinaFields = class( TnxeDatasetFields)
   public
     CodigoMaquina : TWideStringField;
     Fecha : TDateField;
     Turno : TSmallIntField;
     Ocupado : TLongWordField;
     end;

   TAsignacionMaquinasFields = class( TnxeDatasetFields)
   public
     CodigomaquinaTipo,
     CodigoMaquina : TWideStringField;
     end;

   TOperacionTipo = ( otEntradas = 0, otSalidas = 1 );
   TEntradasSalidasFields = array[ otEntradas..otSalidas ] of TBCDField;

   TContenedorFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrdenFabricacion : TIntegerField;
     NroProceso : TSmallIntField;
     [ TAttrPeriodicalField( '', 'Entradas,Salidas' ) ] Correctas : TEntradasSalidasFields;
     [ TAttrPeriodicalField( '', 'Entradas,Salidas' ) ] Defectuosas : TEntradasSalidasFields;
     [ TAttrPeriodicalField( '', 'Entradas,Salidas' ) ] Subcontratista : TEntradasSalidasFields;
     [ TAttrPeriodicalField( '', 'Entradas,Salidas' ) ] MermaExceso : TEntradasSalidasFields;
     [ TAttrPeriodicalField( '', 'Entradas,Salidas' ) ] IncorporadasExtraidas : TEntradasSalidasFields;
     end;

   TSecuenciaAsignacionFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOrdenFabricacion : TIntegerField;
     NroProceso : TSmallIntField;
     Segmento : TSmallIntField;
     CodigoMaquina : TWideStringField;
     Fecha : TDateField;
     Turno : TSmallIntField;
     NroOrdenEntrada : TSmallIntField;
     Prioridad : TSmallIntField;
     HoraInicio : TTimeField;
     Tiempo : TLongWordField;
     Cantidad : TBCDField;
     Realizado : TBooleanField;
     end;

   TParteIncidenciaFields = class( TnxeDatasetFields)
   public
     CodigoMaquina : TWideStringField;
     Fecha : TDateField;
     Turno : TSmallIntField;
     NroRegistro : TSmallIntField;
     CodigoIncidencia : TSmallIntField;
     HoraInicio : TTimeField;
     HoraFinalizacion : TTimeField;
     Observaciones : TWideStringField;
     end;

   TLanzamientoFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOperacion : TIntegerField;
     Fecha : TDateField;
     Tipo : TSmallIntField;
     end;

   TLineaLanzamientoFields = class( TnxeDatasetFields)
   public
     Ejercicio : TSmallIntField;
     NroOperacion : TIntegerField;
     NroRegistro : TSmallIntField;
     EjercicioPedido : TSmallIntField;
     NroOperacionPedido : TIntegerField;
     CodigoArticulo : TWideStringField;
     CodigoClaseA : TWideStringField;
     CodigoClaseB : TWideStringField;
     CodigoClaseC : TWideStringField;
     Pendiente : TBCDField;
     ServirDeStock : TBCDField;
     Fabricar : TBCDField;
     EjercicioAlbaran : TSmallIntField;
     Serie : TWideStringField;
     NroAlbaran : TIntegerField;
     end;

   TCosteOperacExternasFields = class( TnxeDatasetFields)
   public
     CodigoSubcontratista : TWideStringField;
     CodigoOperacion : TWideStringField;
     NroRegistro : TSmallIntField;
     CodigoArticulo : TWideStringField;
     CodigoClaseA : TWideStringField;
     CodigoClaseB : TWideStringField;
     CodigoClaseC : TWideStringField;
     CosteUnitario : TBCDField;
     end;

implementation

end.
