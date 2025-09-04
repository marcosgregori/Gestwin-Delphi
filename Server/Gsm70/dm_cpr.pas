
unit dm_cpr;

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

  dmi_odf,
  dmi_cpr,

  OrdenFabricacionIntf;

type

  TContenedorService = class( TSessionModule, IContenedorService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure SuprimeReferenciasOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt );
    function ContenidoProceso( EjercicioLanzamiento : SmallInt; NroOrden : LongInt; NroProceso : SmallInt; TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
    function ContenidoOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt; NroProcesoInicial, NroProcesoFinal : SmallInt; TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
    function UnidadesCorrectas( EjercicioLanzamiento : SmallInt; NroOrden : Integer ) : Decimal;
    function UnidadesDefectuosas( EjercicioLanzamiento : SmallInt; NroOrden : Integer ) : Decimal;
    end;

   TContenedorModule = class(TServerDataModule)
    DmContenedorTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    private

      DmContenedorFields : TContenedorFields;

      function ObtenResultados( TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
      procedure ObtenContenedor( Ejercicio : SmallInt; NroOrdenFabricacion : LongInt; NroProceso : SmallInt );

    public

     function  ContenidoProceso( EjercicioLanzamiento : SmallInt;
                                 NroOrden             : LongInt;
                                 NroProceso           : SmallInt;
                                 TipoContenedorSet    : TTipoContenedorSet ) : IExistenciasContenedor;

     function  ContenidoOrden( EjercicioLanzamiento : SmallInt;
                               NroOrden             : LongInt;
                               NroProcesoInicial,
                               NroProcesoFinal      : SmallInt;
                               TipoContenedorSet    : TTipoContenedorSet ) : IExistenciasContenedor;

     function UnidadesCorrectas( EjercicioLanzamiento : SmallInt;
                                 NroOrden             : Integer ) : Decimal;

     function UnidadesDefectuosas( EjercicioLanzamiento : SmallInt;
                                   NroOrden             : Integer ) : Decimal;

     procedure Actualiza ( EjercicioLanzamiento : SmallInt;
                           NroOrden             : LongInt;
                           NroProceso           : SmallInt;
                           TipoContenedor       : TTipoContenedor;
                           Cantidad             : Decimal;
                           Descontar            : Boolean );

     procedure Limpia( EjercicioLanzamiento : SmallInt;
                       NroOrden             : LongInt;
                       NroProceso           : SmallInt;
                       TipoContenedor       : TTipoContenedor;
                       OperacionTipo        : TOperacionTipo );

     procedure SuprimeReferenciasOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt );

     function ActualizaReferenciasNotificacionES( OrdenFabricacionFields  : TOrdenFabricacionFields;
                                                  NotificacionESFields    : TNotificacionESFields;
                                                  Descontar               : Boolean ) : Boolean;

     procedure LimpiaEjercicio( Ejercicio : SmallInt );
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

     Gim00Fields;

{$R *.DFM}

procedure TContenedorModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmContenedorFields := TContenedorFields.Create( DmContenedorTable );
end;

procedure TContenedorModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.ContenedorModule := nil;
end;

function TContenedorModule.ContenidoOrden( EjercicioLanzamiento : SmallInt;
                                           NroOrden             : LongInt;
                                           NroProcesoInicial,
                                           NroProcesoFinal      : SmallInt;
                                           TipoContenedorSet    : TTipoContenedorSet ) : IExistenciasContenedor;

begin
     try
       DmContenedorTable.SetRange( [ EjercicioLanzamiento, NroOrden, NroProcesoInicial ], [ EjercicioLanzamiento, NroOrden, NroProcesoFinal ] );
       Result := ObtenResultados( TipoContenedorSet );
     finally
       DmContenedorTable.CancelRange;
       end;
end;

function TContenedorModule.ContenidoProceso( EjercicioLanzamiento : SmallInt;
                                             NroOrden             : LongInt;
                                             NroProceso           : SmallInt;
                                             TipoContenedorSet    : TTipoContenedorSet ) : IExistenciasContenedor;

begin
     try
       DmContenedorTable.SetRange( [ EjercicioLanzamiento, NroOrden, NroProceso ] );
       Result := ObtenResultados( TipoContenedorSet );
     finally
       DmContenedorTable.CancelRange;
       end;
end;

function  TContenedorModule.UnidadesCorrectas( EjercicioLanzamiento : SmallInt;
                                               NroOrden             : LongInt ) : Decimal;

var ExistenciasContenedor : IExistenciasContenedor;

begin
     ExistenciasContenedor := ContenidoOrden( EjercicioLanzamiento, NroOrden, 0, MaxSmallInt, cnProductoAcabadoCorrecto );
     Result := ExistenciasContenedor.Saldo;
end;

function  TContenedorModule.UnidadesDefectuosas( EjercicioLanzamiento : SmallInt;
                                                 NroOrden             : LongInt ) : Decimal;

var ExistenciasContenedor : IExistenciasContenedor;

begin
     ExistenciasContenedor := ContenidoOrden( EjercicioLanzamiento, NroOrden, 0, MaxSmallInt, [ cnProductoDefectuoso ] );
     Result := ExistenciasContenedor.Saldo;
end;

function TContenedorModule.ObtenResultados( TipoContenedorSet  : TTipoContenedorSet ) : IExistenciasContenedor;

var  ExistenciasContenedor : IExistenciasContenedor;

begin

     ExistenciasContenedor := TExistenciasContenedor.Create;

     With DmContenedorTable, ExistenciasContenedor do
       begin

       First;
       While not Eof do
         begin

         If   cnProductoCorrecto in TipoContenedorSet
         then begin
              Entradas := Entradas + DmContenedorFields.Correctas[ otEntradas ].Value;
              Salidas  := Salidas  + DmContenedorFields.Correctas[ otSalidas ].Value;
              end;

         If   cnProductoSubcontratista in TipoContenedorSet
         then begin
              Entradas := Entradas + DmContenedorFields.Subcontratista[ otEntradas ].Value;
              Salidas  := Salidas  + DmContenedorFields.Subcontratista[ otSalidas ].Value;
              end;

         If   cnProductoDefectuoso in TipoContenedorSet
         then begin
              Entradas := Entradas + DmContenedorFields.Defectuosas[ otEntradas ].Value;
              Salidas  := Salidas  + DmContenedorFields.Defectuosas[ otSalidas ].Value;
              end;

         If   cnMermaExceso in TipoContenedorSet
         then begin
              Entradas := Entradas + DmContenedorFields.MermaExceso[ otEntradas ].Value;
              Salidas  := Salidas  + DmContenedorFields.MermaExceso[ otSalidas ].Value;
              end;

         If   cnExtraccionesIncorporaciones in TipoContenedorSet
         then begin
              Entradas := Entradas + DmContenedorFields.IncorporadasExtraidas[ otEntradas ].Value;
              Salidas  := Salidas  + DmContenedorFields.IncorporadasExtraidas[ otSalidas ].Value;
              end;

         Next;
         end;

       Saldo := Entradas - Salidas;
       end;

     Result := ExistenciasContenedor;
end;

procedure TContenedorModule.ObtenContenedor( Ejercicio           : SmallInt;
                                             NroOrdenFabricacion : LongInt;
                                             NroProceso          : SmallInt );
begin
     With DmContenedorTable do
       begin
       CancelRange;   // Solo por si acaso
       If   not FindKey( [ Ejercicio, NroOrdenFabricacion, NroProceso ] )
       then begin
            Append;
            DmContenedorFields.Ejercicio.Value := Ejercicio;
            DmContenedorFields.NroOrdenFabricacion.Value := NroOrdenFabricacion;
            DmContenedorFields.NroProceso.Value  := NroProceso;
            Post;
            end;
       Edit;
       end;

end;

procedure TContenedorModule.Limpia( EjercicioLanzamiento : SmallInt;
                                    NroOrden             : LongInt;
                                    NroProceso           : SmallInt;
                                    TipoContenedor       : TTipoContenedor;
                                    OperacionTipo        : TOperacionTipo );

begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmContenedorTable ] );

     try

       With DmContenedorTable do
         try

           ObtenContenedor( EjercicioLanzamiento, NroOrden, NroProceso );

           With DmContenedorFields do
             case TipoContenedor of
               cnProductoCorrecto            : Correctas[ OperacionTipo ].Value := 0.0;
               cnProductoSubcontratista      : Subcontratista[ OperacionTipo ].Value := 0.0;
               cnProductoDefectuoso          : Defectuosas[ OperacionTipo ].Value := 0.0;
               cnMermaExceso                 : MermaExceso[ OperacionTipo ].Value := 0.0;
               cnExtraccionesIncorporaciones : IncorporadasExtraidas[ OperacionTipo ].Value := 0.0;
               end;

           Post;

         finally
           Cancel;  // Por si se produce algún error
           end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

procedure TContenedorModule.Actualiza( EjercicioLanzamiento : SmallInt;
                                       NroOrden             : LongInt;
                                       NroProceso           : SmallInt;
                                       TipoContenedor       : TTipoContenedor;
                                       Cantidad             : Decimal;
                                       Descontar            : Boolean );

begin

     If   Cantidad<>0.0
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmContenedorTable ] );

          try

            With DmContenedorTable do
              try

                ObtenContenedor( EjercicioLanzamiento, NroOrden, NroProceso );

                With DmContenedorFields do
                  begin

                  If   Cantidad>0.0
                  then begin

                       If   Descontar
                       then Cantidad := -Cantidad;

                       case tipoContenedor of
                         cnProductoCorrecto            : Correctas[ otEntradas ].Value := Correctas[ otEntradas ].Value + Cantidad;
                         cnProductoSubcontratista      : Subcontratista[ otEntradas ].Value := Subcontratista[ otEntradas ].Value + Cantidad;
                         cnProductoDefectuoso          : Defectuosas[ otEntradas ].Value := Defectuosas[ otEntradas ].Value + Cantidad;
                         cnMermaExceso                 : MermaExceso[ otEntradas ].Value := MermaExceso[ otEntradas ].Value + Cantidad;
                         cnExtraccionesIncorporaciones : IncorporadasExtraidas[ otEntradas ].Value := IncorporadasExtraidas[ otEntradas ].Value + Cantidad;
                         end;

                       end
                  else begin

                       Cantidad := Abs( Cantidad );
                       If   Descontar
                       then Cantidad := -Cantidad;

                       case tipoContenedor of
                         cnProductoCorrecto            : Correctas[ otSalidas ].Value := Correctas[ otSalidas ].Value + Cantidad;
                         cnProductoSubcontratista      : Subcontratista[ otSalidas ].Value := Subcontratista[ otSalidas ].Value + Cantidad;
                         cnProductoDefectuoso          : Defectuosas[ otSalidas ].Value := Defectuosas[ otSalidas ].Value + Cantidad;
                         cnMermaExceso                 : MermaExceso[ otSalidas ].Value := MermaExceso[ otSalidas ].Value + Cantidad;
                         cnExtraccionesIncorporaciones : IncorporadasExtraidas[ otSalidas ].Value := IncorporadasExtraidas[ otSalidas ].Value + Cantidad;
                         end;

                       end;

                  end;

                Post;

              finally
                Cancel;  // Por si se produce algún error
                end;

            TransactionTag.Commit;

          except
            TransactionTag.Rollback;
            raise;
            end;
          end;
end;

procedure TContenedorModule.SuprimeReferenciasOrden( EjercicioLanzamiento : SmallInt;
                                                     NroOrden             : LongInt );
begin
     With DmContenedorTable do
       try
         SetRange( [ EjercicioLanzamiento, NroOrden, 0 ], [ EjercicioLanzamiento, NroOrden, MaxSmallInt ] );
         DeleteRecords;
       finally
         CancelRange;
         end;
end;

procedure TContenedorModule.LimpiaEjercicio( Ejercicio : SmallInt );
begin
     With DmContenedorTable do
       try
         SetRange( [ Ejercicio, 0, 0 ], [ Ejercicio, MaxLongint, MaxSmallInt ] );
         DeleteRecords;
       finally
         CancelRange;
         end;
end;

function TContenedorModule.ActualizaReferenciasNotificacionES( OrdenFabricacionFields  : TOrdenFabricacionFields;
                                                               NotificacionESFields    : TNotificacionESFields;
                                                               Descontar               : Boolean ) : Boolean;

begin
     Result := False;

     // Quito / añado del contenedor anterior la cantidad indicada

     // With OrdenFabricacionFields, NotificacionESFields do

     case NotificacionESFields.TipoOperacion.Value of

       // Salida hacia el subcontratista

       0 : begin

           // Lo añado / quito del contenedor de producto correcto (del proceso anterior)

           Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                      OrdenFabricacionFields.NroOrden.Value,
                      NotificacionESFields.NroProceso.Value - 1,
                      cnProductoCorrecto,
                      -NotificacionESFields.Correctas.Value, Descontar );

           // Y se la añado / quito al contenedor del subcontratista (del proceso actual)

           If   NotificacionESFields.Correctas.Value<>0.0
           then Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                           OrdenFabricacionFields.NroOrden.Value,
                           NotificacionESFields.NroProceso.Value,
                           cnProductoSubcontratista,
                           NotificacionESFields.Correctas.Value,
                           Descontar );


           Result := True;
           end;

       // Vuelta desde el subcontratista

       1 : begin

           // Lo añado / quito del contenedor del subcontratista (del proceso actual)

           Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                      OrdenFabricacionFields.NroOrden.Value,
                      NotificacionESFields.NroProceso.Value,
                      cnProductoSubcontratista,
                      - ( NotificacionESFields.Correctas.Value + NotificacionESFields.Defectuosas.Value - NotificacionESFields.MermaExceso.Value ),
                      Descontar );

           // Y se la añado / quito al contenedor actual de producto correcto.

           If   NotificacionESFields.Correctas.Value<>0.0
           then actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                           OrdenFabricacionFields.NroOrden.Value,
                           NotificacionESFields.NroProceso.Value,
                           cnProductoCorrecto,
                           NotificacionESFields.Correctas.Value,
                           Descontar );

           If   NotificacionESFields.Defectuosas.Value<>0.0
           then Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                           OrdenFabricacionFields.NroOrden.Value,
                           NotificacionESFields.NroProceso.Value,
                           cnProductoDefectuoso,
                           NotificacionESFields.Defectuosas.Value,
                           Descontar );

           If   NotificacionESFields.MermaExceso.Value<>0.0
           then Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                           OrdenFabricacionFields.NroOrden.Value,
                           NotificacionESFields.NroProceso.Value,
                           cnMermaExceso,
                           NotificacionESFields.MermaExceso.Value,
                           Descontar );

           If   NotificacionESFields.IncorpExtraidas.Value<>0.0
           then Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                           OrdenFabricacionFields.NroOrden.Value,
                           NotificacionESFields.NroProceso.Value,
                           cnExtraccionesIncorporaciones,
                           NotificacionESFields.IncorpExtraidas.Value,
                           Descontar );

           Result := True;
           end;

     end;
   
end;

{ TContenedorService }

procedure TContenedorService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TContenedorService.SuprimeReferenciasOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt );
begin
     SessionDataModule.Dm70.ContenedorModule.SuprimeReferenciasOrden( EjercicioLanzamiento, NroOrden );
end;

function TContenedorService.UnidadesCorrectas(EjercicioLanzamiento: SmallInt; NroOrden: Integer): Decimal;
begin
     Result := SessionDataModule.Dm70.ContenedorModule.UnidadesCorrectas(EjercicioLanzamiento, NroOrden );
end;

function TContenedorService.UnidadesDefectuosas(EjercicioLanzamiento: SmallInt; NroOrden: Integer): Decimal;
begin
     Result := SessionDataModule.Dm70.ContenedorModule.UnidadesDefectuosas(EjercicioLanzamiento, NroOrden );
end;

function TContenedorService.ContenidoOrden( EjercicioLanzamiento : SmallInt;
                                            NroOrden             : Integer;
                                            NroProcesoInicial,
                                            NroProcesoFinal      : SmallInt;
                                            TipoContenedorSet    : TTipoContenedorSet): IExistenciasContenedor;
begin
     Result := SessionDataModule.Dm70.ContenedorModule.ContenidoOrden( EjercicioLanzamiento, NroOrden, NroProcesoInicial, NroProcesoFinal, TipoContenedorSet );
end;

function TContenedorService.ContenidoProceso( EjercicioLanzamiento : SmallInt;
                                              NroOrden             : Integer;
                                              NroProceso           : SmallInt;
                                              TipoContenedorSet    : TTipoContenedorSet ) : IExistenciasContenedor;
begin
     Result := SessionDataModule.Dm70.ContenedorModule.ContenidoProceso( EjercicioLanzamiento, NroOrden, NroProceso, TipoContenedorSet );
end;

var ContenedorControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_ContenedorService, TContenedorService, ContenedorControl );

end.
