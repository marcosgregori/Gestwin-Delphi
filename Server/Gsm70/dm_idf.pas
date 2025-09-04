
unit dm_idf;

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

  dmi_odf,
  dmi_idf,
  dmi_cla,

  OrdenFabricacionIntf,
  InformeFabricacionIntf;

type


  TInformeFabricacionService = class( TSessionModule, IInformeFabricacionService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaInformeFabricacion( InformeFabricacion : IInformeFabricacion; RecalcularProceso : Boolean );
    function  SuprimeInformeFabricacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOrden: LongInt; NroProceso : SmallInt; Fecha : TDate; Turno : SmallInt; RecalcularProceso : Boolean ) : Boolean;

    function CalculaCosteArticulo( OrdenFabricacion : IOrdenFabricacion ) : Decimal;
    function ActualizaReferenciasRegistro( OrdenFabricacion : IOrdenFabricacion; InformeFabricacion : IInformeFabricacion; Descontar : Boolean ) : Boolean;
    end;


   TInformeFabricacionModule = class(TServerDataModule)
    DmLineaOFOperacionTable: TnxeTable;
    DmRelacionMaterialesTable: TnxeTable;
    DmLineaOFComponenteTable: TnxeTable;
    DmRelacionOperacionesTable: TnxeTable;
    DmOperacionTable: TnxeTable;
    DmArticuloTable: TnxeTable;
    DmInformeFabricacionTable: TnxeTable;
    DmMaquinaTable: TnxeTable;
    DmCosteMaquinaTable: TnxeTable;
    DmCodigoCosteTable: TnxeTable;
    DmLineaInformeFabricacionTable: TnxeTable;
    DmCosteOperarioTable: TnxeTable;
    DmNotificacionESTable: TnxeTable;
    DmOrdenFabricacionTable: TnxeTable;
    DmSecuenciaAsignacionTable: TnxeTable;
    DmSecuenciaAsignacionAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    private

      DmArticuloFields : TArticuloFields;
      DmMaquinaFields : TMaquinaFields;
      DmCosteMaquinaFields : TCosteMaquinaFields;
      DmCosteOperarioFields : TCosteOperarioFields;
      DmCodigoCosteFields : TCodigoCosteFields;
      DmOperacionFields : TOperacionFields;
      DmRelacionMaterialesFields : TRelacionMaterialesFields;
      DmRelacionOperacionesFields : TRelacionOPeracionesFields;

      DmOrdenFabricacionFields : TOrdenFabricacionFields;
      DmInformeFabricacionFields : TInformeFabricacionFields;
      DmLineaInformeFabricacionFields : TLineaInformeFabricacionFields;
      DmNotificacionESFields : TNotificacionESFields;
      DmLineaOFComponenteFields,
      DmLineaOFComponenteAuxFields : TLineaOFComponenteFields;
      DmLineaOFOperacionFields,
      DmLineaOFOperacionAuxFields : TLineaOFOperacionFields;
      DmSecuenciaAsignacionFields,
      DmSecuenciaAsignacionAuxFields : TSecuenciaAsignacionFields;

      DsOrdenFabricacionFields : TOrdenFabricacionFields;
      DsInformeFabricacionFields : TInformeFabricacionFields;

      UnidadesProcesadas,
      HorasProceso,
      CosteProceso,
      CantidadProcesada,
      PrecioCosteComponentes,
      PrecioCosteFabricacion  : Decimal;

    public

      procedure ActualizaInformeFabricacion( InformeFabricacion : IInformeFabricacion; RecalcularProceso : Boolean );
      function SuprimeInformeFabricacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOrden: LongInt; NroProceso : SmallInt; Fecha : TDate; Turno : SmallInt; RecalcularProceso : Boolean ) : Boolean; overload;

      function SuprimeInformeFabricacion( Ejercicio : SmallInt; NroOrden: LongInt; NroProceso : SmallInt; Fecha : TDate; Turno : SmallInt; RecalcularProceso : Boolean ) : Boolean; overload;

      function CalculaCosteArticulo( OrdenFabricacion : IOrdenFabricacion ) : Decimal; overload;
      function CalculaCosteArticulo( OrdenFabricacionFields : TOrdenFabricacionFields ) : Decimal; overload;
      function ActualizaReferenciasRegistro( OrdenFabricacion : IOrdenFabricacion; InformeFabricacion : IInformeFabricacion; Descontar : Boolean ) : Boolean; overload;
      function ActualizaReferenciasRegistro( OrdenFabricacionFields : TOrdenFabricacionFields; InformeFabricacionFields : TInformeFabricacionFields; Descontar : Boolean ) : Boolean; overload;

  end;

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

     Gsm30Dm,

     Gim00Fields,

     dmi_mov,
     dmi_sto,
     dmi_cpr,

     dm_cnd,
     dm_art,
     dm_mov,
     dm_rla,
     dm_cpr;

{$R *.DFM}

resourceString
     RsMsg1 = 'Se ha cancelado el proceso de actualización de referencias del informe de fabricación.'#13'Los datos quedan como estaban antes de intentar el proceso.';

     RsMsg6  = 'El registro actual no se va a actualizar.';
     RsMsg8  = 'El número de unidades es superior al registrado en el proceso anterior.';
     RsMsg9  = 'No he conseguido recuperar el registro del proceso actual.';
     RsMsg10 = 'No se ha podido realizar el trasvase de material desde/hacia los contenedor involucrados.';
     RsMsg11 = 'Revise el estado de sus ficheros y , en particular, el de la orden de fabricación utilizada.';

procedure TInformeFabricacionModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmMaquinaFields := TMaquinaFields.Create( DmMaquinaTable );
     DmCosteMaquinaFields := TCosteMaquinaFields.Create( DmCosteMaquinaTable );
     DmCosteOperarioFields := TCosteOperarioFields.Create( DmCosteOperarioTable );
     DmCodigoCosteFields := TCodigoCosteFields.Create( DmCodigoCosteTable );
     DmOperacionFields := TOperacionFields.Create( DmOperacionTable );
     DmRelacionMaterialesFields := TRelacionMaterialesFields.Create( DmRelacionMaterialesTable );
     DmRelacionOperacionesFields := TRelacionOPeracionesFields.Create( DmRelacionOPeracionesTable );

     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
     DmInformeFabricacionFields := TInformeFabricacionFields.Create( DmInformeFabricacionTable );
     DmLineaInformeFabricacionFields := TLineaInformeFabricacionFields.Create( DmLineaInformeFabricacionTable );
     DmNotificacionESFields := TNotificacionESFields.Create( DmNotificacionESTable );
     DmLineaOFComponenteFields := TLineaOFComponenteFields.Create( DmLineaOFComponenteTable );
     DmLineaOFOperacionFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionTable );
     DmSecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( DmSecuenciaAsignacionTable );
     DmSecuenciaAsignacionAuxFields := TSecuenciaAsignacionFields.Create( DmSecuenciaAsignacionAuxTable );

     DsOrdenFabricacionFields := TOrdenFabricacionFields.Create( Self );
     DsInformeFabricacionFields := TInformeFabricacionFields.Create( Self );

end;

procedure TInformeFabricacionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.InformeFabricacionModule := nil;
end;

procedure TInformeFabricacionModule.ActualizaInformeFabricacion( InformeFabricacion : IInformeFabricacion;
                                                                 RecalcularProceso  : Boolean );

var  TableCursor : TnxServerTableCursor;

     RegistroNuevo : Boolean;

     FechaInicio,
     FechaFinalizacion : TDate;

     StockProcesoAnterior,
     CantidadPendienteAnterior,
     CantidadAtipica,
     Cantidad,
     CantidadProcesadaCorrecta : Decimal;

function ReconsiderarCantidad : Boolean;

function UltimaTareaDelProceso: Boolean;
begin
     With DmSecuenciaAsignacionAuxTable  do
       begin
       Result := ( not RegistroNuevo and not FindEqualLast( [ DmInformeFabricacionFields.Ejercicio.Value, DmInformeFabricacionFields.NroOrden.Value, DmInformeFabricacionFields.NroProceso.Value ] ) and ( DmSecuenciaAsignacionAuxFields.Segmento.Value<>DmSecuenciaAsignacionFields.Segmento.Value ) ) or
                 (     RegistroNuevo and not FindKey( [ DmInformeFabricacionFields.Ejercicio.Value, DmInformeFabricacionFields.NroOrden.Value, DmInformeFabricacionFields.NroProceso.Value, DmSecuenciaAsignacionFields.Segmento.Value + 1 ] ) );
       If   Result
       then CantidadPendienteAnterior := SessionDataModule.Dm70.ContenedorModule.ContenidoOrden( YearOf( DmOrdenFabricacionFields.FechaLanzamiento.Value ),
                                                                                                 DmInformeFabricacionFields.NroOrden.Value,
                                                                                                 0,
                                                                                                 DmInformeFabricacionFields.NroProceso.Value - 1,
                                                                                                 cnProductoAcabadoCorrecto ).Saldo;
       end;
end;

begin

     Result := False;

     {
      Posible reajuste del proceso SIGUIENTE (y posteriores, por supuesto)

      Comprobacion 1 : 1 - Si se está editando el informe cabe el reajuste si ya está introducido el último de este proceso.
                       2 - Si es un informe nuevo, sólo si éste es el último del proceso.

      Comprobación 2: Si la suma de cantidades correctas no coincide con la suma de unidades a fabricar del proceso actual o
                      se han producido mermas/incrementos o extracciones/incorporaciones
                      habrá que reconsiderar las unidades a fabricar a partir del próximo proceso.

      }

      With DmSecuenciaAsignacionAuxTable do
        If   UltimaTareaDelProceso
        then begin

             CantidadProcesadaCorrecta := DmInformeFabricacionFields.Correctas.Value;
             If   not RegistroNuevo
             then CantidadProcesadaCorrecta := CantidadProcesadaCorrecta - DsInformeFabricacionFields.Correctas.Value;

             CantidadAtipica := SessionDataModule.Dm70.ContenedorModule.ContenidoProceso( DmOrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                                          DmOrdenFabricacionFields.NroOrden.Value,
                                                                                          DmInformeFabricacionFields.NroProceso.Value,
                                                                                          cnProductoContenedorAtipico ).Saldo;

             // Compruebo que no sea, además, el último proceso de la orden

             Result  := ( CantidadPendienteAnterior<>CantidadProcesadaCorrecta + DmInformeFabricacionFields.IncorpExtraidas.Value ) or ( CantidadAtipica<>0.0 );

             end;

end;

begin

     If   ( TnxServerTableCursor.LookupByID( InformeFabricacion.RemoteCursorID, TableCursor )=DBIERR_NONE ) and
          DmOrdenFabricacionTable.FindKey( [ InformeFabricacion.Ejercicio, moOrden, InformeFabricacion.NroOrden ] )  // Ejercicio;Tipo;NroOrden
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmInformeFabricacionTable ] );

          try

            RegistroNuevo := InformeFabricacion.State=dsInsert;

            If   not RegistroNuevo
            then begin

                 // Ejercicio;NroOrden;NroProceso;Fecha;Turno

                 If   DmInformeFabricacionTable.FindKey( [ InformeFabricacion.Ejercicio, InformeFabricacion.NroOrden, InformeFabricacion.NroProceso, InformeFabricacion.Fecha, InformeFabricacion.Turno ] )
                 then begin
                      TableCursor.RecordLockRelease( False );
                      DsInformeFabricacionFields.Update( DmInformeFabricacionTable );   // Guardo el contenido del registro anterior
                      If   not ActualizaReferenciasRegistro( DmOrdenFabricacionFields, DmInformeFabricacionFields, True )
                      then begin
                           SessionDataModule.SendNotification( ntStop, RsMsg10, RsMsg11 );
                           Abort;
                           end;
                      end
                 else RaiseRecordNotFoundException;

                 end;

            InformeFabricacion.ToDataset( DmInformeFabricacionFields );

            // El registro actual

            If   not ActualizaReferenciasRegistro( DmOrdenFabricacionFields, DmInformeFabricacionFields, False )
            then begin
                 SessionDataModule.SendNotification( ntStop, RsMsg10, RsMsg11 );
                 Abort;
                 end;

            DmInformeFabricacionTable.Post;

            // Ahora reajusto el proceso, si esta incompleto y así lo ha solicitado el usuario.

            If   RecalcularProceso
            then begin

                 If   DmLineaOFOperacionTable.FindKey( [ DmInformeFabricacionFields.Ejercicio.Value,
                                                         moOrden,
                                                         DmInformeFabricacionFields.NroOrden.Value,
                                                         DmInformeFabricacionFields.NroProceso.Value ] )
                 then begin
                      FechaInicio := DmLineaOFOperacionFields.FechaInicio.Value;
                      FechaFinalizacion := DmLineaOFOperacionFields.FechaFinalizacion.Value;
                      SessionDataModule.Dm70.OrdenFabricacionModule.AjustaFechasFabricacion( DmInformeFabricacionFields.Ejercicio.Value,
                                                                                             DmInformeFabricacionFields.NroOrden.Value,
                                                                                             DmLineaOFOperacionFields.NroProceso.Value,
                                                                                             FechaInicio,
                                                                                             FechaFinalizacion,
                                                                                             { AjustarVinculos } True,
                                                                                             { AsignarOperadores } True,
                                                                                             { AsignarSecuencias } True )
                      end
                 else begin
                      SessionDataModule.SendNotification( ntStop, RsMsg9, RsMsg6 );
                      Abort;
                      end;

                 // Puede ser necesario reconsiderar la cantidad tras recalcular el proceso actual

                 If   ReconsiderarCantidad
                 then begin

                      If   not DmLineaOFOperacionTable.FindKey( [ DmInformeFabricacionFields.Ejercicio.Value,
                                                                  moOrden,
                                                                  DmInformeFabricacionFields.NroOrden.Value,
                                                                  DmInformeFabricacionFields.NroProceso.Value + 1 ] )
                      then If   not DmLineaOFOperacionTable.FindKey( [ DmInformeFabricacionFields.Ejercicio.Value,
                                                                       moOrden,
                                                                       DmInformeFabricacionFields.NroOrden.Value,
                                                                       DmInformeFabricacionFields.NroProceso.Value ] )
                           then begin
                                SessionDataModule.SendNotification( ntStop, RsMsg9, RsMsg6 );
                                Abort;
                                end;

                      FechaInicio := DmLineaOFOperacionFields.FechaInicio.Value;
                      FechaFinalizacion := DmLineaOFOperacionFields.FechaFinalizacion.Value;
                      SessionDataModule.Dm70.OrdenFabricacionModule.AjustaFechasFabricacion( DmInformeFabricacionFields.Ejercicio.Value,
                                                                                             DmInformeFabricacionFields.NroOrden.Value,
                                                                                             DmLineaOFOperacionFields.NroProceso.Value,
                                                                                             FechaInicio,
                                                                                             FechaFinalizacion,
                                                                                             { AjustarVinculos } True,
                                                                                             { AsignarOperadores } True,
                                                                                             { AsignarSecuencias } True );
                      end;

                 end;

            TransactionTag.Commit;

          except
            TransactionTag.Rollback;
            DmInformeFabricacionTable.Cancel;
            raise;
            end;

          end
     else RaiseNoCurrentRecordException;

end;

function TInformeFabricacionModule.SuprimeInformeFabricacion( RemoteCursorID    : TnxCursorID;
                                                              Ejercicio         : SmallInt;
                                                              NroOrden          : LongInt;
                                                              NroProceso        : SmallInt;
                                                              Fecha             : TDate;
                                                              Turno             : SmallInt;
                                                              RecalcularProceso : Boolean ) : Boolean;
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          TableCursor.RecordLockRelease( False );
          Result := SuprimeInformeFabricacion( Ejercicio, NroOrden, NroProceso, Fecha, Turno, RecalcularProceso );
          end
     else RaiseNoCurrentRecordException;
end;

function TInformeFabricacionModule.SuprimeInformeFabricacion( Ejercicio         : SmallInt;
                                                              NroOrden          : LongInt;
                                                              NroProceso        : SmallInt;
                                                              Fecha             : TDate;
                                                              Turno             : SmallInt;
                                                              RecalcularProceso : Boolean ) : Boolean;
begin
     Result := False;

     If   DmInformeFabricacionTable.FindKey( [ Ejercicio, NroOrden, NroProceso, Fecha, Turno ] )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmInformeFabricacionTable, DmLineaInformeFabricacionTable ] );

          try

            If   RecalcularProceso and
                 DmOrdenFabricacionTable.FindKey( [ Ejercicio, moOrden, NroOrden ] )
            then If   not ActualizaReferenciasRegistro( DmOrdenFabricacionFields, DmInformeFabricacionFields, True )
                 then begin
                      SessionDataModule.SendNotification( ntStop, RsMsg10, RsMsg11 );
                      Abort;  // no quiero que se borre si no se ha actualizado correctamente
                      end;

            try

              // Ejercicio;NroOrden;NroProceso;Fecha;Turno;NroRegistro

              DmLineaInformeFabricacionTable.SetRange( [ Ejercicio, NroOrden, NroProceso, Fecha, Turno ] );
              DmLineaInformeFabricacionTable.DeleteRecords;

            finally
              DmLineaInformeFabricacionTable.CancelRange;
              end;

            DmInformeFabricacionTable.Delete;

            TransactionTag.Commit;

            Result := True;
          except
            TransactionTag.Rollback;
            raise;
            end;

          end
     else RaiseRecordNotFoundException;
end;

function TInformeFabricacionModule.CalculaCosteArticulo( OrdenFabricacion : IOrdenFabricacion ) : Decimal;
begin
     DsOrdenFabricacionFields.Setup( DmOrdenFabricacionTable, True );  // Por si no está inicializado
     OrdenFabricacion.ToDataset( DsOrdenFabricacionFields );

     Result := CalculaCosteArticulo( DsOrdenFabricacionFields );
end;

function TInformeFabricacionModule.CalculaCosteArticulo( OrdenFabricacionFields : TOrdenFabricacionFields ) : Decimal;

var   PrecioCoste  : Decimal;

procedure ProcesaArticulo( CodigoArticulo,
                           CodigoClaseA,
                           CodigoClaseB,
                           CodigoClaseC,
                           LoteFabricacion  : String;
                           CantidadArticulo : Decimal );

var  DrArticuloTable,
     DrRelacionMaterialesTable : TnxeTable;
     DrArticuloFields : TArticuloFields;
     DrRelacionMaterialesFields : TRelacionMaterialesFields;
     ExistenciasArticulo : IExistenciasArticulo;
     CosteComponente : Decimal;
     NroRegistroOrigen : LongInt;

begin

     DrArticuloTable := TnxeTable.Create( nil );
     DrArticuloTable.AssignRootPropertiesFrom( DmArticuloTable );
     DrArticuloTable.Open;
     DrArticuloFields := TArticuloFields.Create( DrArticuloTable ) ;

     DrRelacionMaterialesTable := TnxeTable.Create( nil );
     DrRelacionMaterialesTable.AssignRootPropertiesFrom( DmRelacionMaterialesTable );
     DrRelacionMaterialesTable.Open;
     DrRelacionMaterialesFields := TRelacionMaterialesFields.Create( DrRelacionMaterialesTable ) ;

     try

       If   DmArticuloTable.FindKey( [ CodigoArticulo ] )
       then With DrRelacionMaterialesTable do
              begin
              SetRange( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 0, 1 ],
                        [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, MaxSmallint, MaxSmallint ] );
              First;
              If   not Eof and DmArticuloFields.CalcularPrecios.Value
              then While not Eof do
                     begin
                     With DrRelacionMaterialesFields do
                       ProcesaArticulo( CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, LoteFabricacion, CantidadArticulo );
                     Next;
                     end
              else begin
                   var CosteDisponible := False;
                   If   SessionDataModule.EmpresaFields.Stock_CosteEntradaPorLote.Value and ( LoteFabricacion<>'' )
                   then CosteDisponible := SessionDataModule.Dm30.MovimientoModule.ObtenCosteUltimaEntradaPorLote( SessionDataModule.FechaHoy,
                                                                                                                   CodigoArticulo,
                                                                                                                   CodigoClaseA,
                                                                                                                   CodigoClaseB,
                                                                                                                   CodigoClaseC,
                                                                                                                   LoteFabricacion,
                                                                                                                   { NroRegistroLinea } 0,  // No estamos en modo edición del movimiento
                                                                                                                   CosteComponente,
                                                                                                                   NroRegistroOrigen );     // No se utiliza

                   If   not CosteDisponible
                   then begin
                        ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( CodigoArticulo,
                                                                                                     False,
                                                                                                     CodigoClaseA,
                                                                                                     CodigoClaseB,
                                                                                                     CodigoClaseC,
                                                                                                     True, '',
                                                                                                     True, '',
                                                                                                     True, '',
                                                                                                     True,
                                                                                                     SessionDataModule.Ejercicio,
                                                                                                     0,
                                                                                                     12 );
                        CosteComponente := ExistenciasArticulo.Coste;
                        end;

                   DecAdd( PrecioCosteComponentes, CosteComponente * CantidadArticulo );
                   end;

              end;

       finally
         FreeAndNil( DrArticuloTable );
         FreeAndNil( DrRelacionMaterialesTable );
         end;
end;

begin
     Result := 0.0;
     PrecioCosteComponentes := 0.0;
     PrecioCosteFabricacion := 0.0;

     { Calculo el coste de los componentes utilizados.
       hay que tener en cuenta que pueden existir varios informes de fabricación que afecten a
       un solo proceso, por lo que la lista no depende del informe, sino de la orden.
     }

     // Le añado el coste resultante del tiempo de fabricación de cada proceso

     // *** En un futuro (espero que lejano) habría que pensar en almacenar los
     // consumos por informe de fabricación y no por proceso (je, je).

     With DmLineaOFComponenteTable do
       begin

       With OrdenFabricacionFields do
         SetRange( [ Ejercicio.Value, moOrden, NroOrden.Value, 1, 0 ],
                   [ Ejercicio.Value, moOrden, NroOrden.Value, MaxSmallint, MaxSmallint ] );
       First;
       While not Eof do
         begin
         With DmLineaOFComponenteFields do
           ProcesaArticulo( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, Lote.Value, ConsumoReal.Value );
         Next;
         end;

       end;

     // 1º Procesos internos : maquinas y operarios

     With DmInformeFabricacionTable do
       begin

       // Selecciono todos los informes que pertenecen a la misma orden de fabricación

       With OrdenFabricacionFields do
         SetRange( [ Ejercicio.Value, NroOrden.Value, 1, LowestDateTime, 1 ],
                   [ Ejercicio.Value, NroOrden.Value, MaxSmallint, HighestDateTime, 4 ] );
       First;
       While not Eof do
         begin

         (*
         With LineaOFComponenteTable, DmInformeFabricacionFields do
           begin

           SetRange( [ Ejercicio, moOrden, NroOrden, nroProceso,           0 ],
                         [ Ejercicio, moOrden, NroOrden, nroProceso, MaxSmallint ] );
           First;
           While not Eof do
             begin

             unidadesProcesadas := correctas + defectuosas + mermaExceso;
             If   extraidasIncorporadas<0.0   // es una extracción
             then unidadesProcesadas := unidadesProcesadas + abs( extraidasIncorporadas );

             If   unidadesProcesadas<>0.0
             then With DmLineaOFComponenteFields do
                    procesaArticulo( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, ConsumoReal {/ unidadesProcesadas} );

             Next;
             end;

           end;
         *)

         HorasProceso := ( DmInformeFabricacionFields.Preparacion.Value / 3600 ) +
                         ( DmInformeFabricacionFields.Fabricacion.Value / 3600 );

         // Añado el coste de la maquina

         With DmInformeFabricacionFields do
           If   DmLineaOFOperacionTable.FindKey( [ Ejercicio.Value, moOrden, NroOrden.Value, NroProceso.Value ] )
           then If   DmMaquinaTable.FindKey( [ DmLineaOFOperacionFields.CodigoMaquina.Value ] )
                then With DmCosteMaquinaTable do
                       begin
                       SetRange( [ DmLineaOFOperacionFields.CodigoMaquina.Value, 0 ], [ DmLineaOFOperacionFields.CodigoMaquina.Value, MaxSmallint ] );
                       First;
                       While not Eof do
                         begin
                         If   DmCodigoCosteTable.FindKey( [ DmCosteMaquinaFields.CodigoCoste.Value ] )
                         then begin
                              If   DmCodigoCosteFields.Tipo.Value=0  // coste por hora
                              then CosteProceso := HorasProceso * DmCosteMaquinaFields.Coste.Value
                              else CosteProceso := DmCosteMaquinaFields.Coste.Value;
                              DecAdd( PrecioCosteFabricacion, CosteProceso );
                              end;
                         Next;
                         end;
                     end;

         // y el de los operarios que han intervenido

         With DmLineaInformeFabricacionTable do
           begin

           With DmInformeFabricacionFields do
             SetRange( [ Ejercicio.Value, NroOrden.Value, nroProceso, Fecha.Value, Turno.Value, 1 ],
                       [ Ejercicio.Value, NroOrden.Value, nroProceso, Fecha.Value, Turno.Value, MaxSmallint ] );
           First;
           While not Eof do
             begin
             If   DmCosteOperarioTable.FindKey( [ DmLineaInformeFabricacionFields.CodigoOperario.Value, DmLineaInformeFabricacionFields.Turno.Value ] )
             then begin
                  CosteProceso := HorasProceso * DmCosteOperarioFields.CosteHora.Value;
                  DecAdd( PrecioCosteFabricacion, CosteProceso );
                  end;

             Next;
             end;

           end;


         Next;
         end;

       end;

     // 2º Procesos externos

     With DmNotificacionESTable do
       begin
       SetRange( [ OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, 1 ],
                 [ OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, MaxSmallint ] );
       First;
       While not Eof do
         begin
         DecAdd( PrecioCosteFabricacion, DmNotificacionESFields.Coste.Value );
         Next;
         end;
       end;

     CantidadProcesada := SessionDataModule.Dm70.ContenedorModule.UnidadesCorrectas( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value );
     If   CantidadProcesada<>0.0
     then begin
          PrecioCosteComponentes := PrecioCosteComponentes / CantidadProcesada;
          PrecioCosteFabricacion := PrecioCosteFabricacion / CantidadProcesada;
          end;

     Result := PrecioCosteComponentes + PrecioCosteFabricacion;
end;

function TInformeFabricacionModule.ActualizaReferenciasRegistro( OrdenFabricacion     : IOrdenFabricacion;
                                                                 InformeFabricacion   : IInformeFabricacion;
                                                                 Descontar            : Boolean ) : Boolean;
begin
     DsOrdenFabricacionFields.Setup( DmOrdenFabricacionTable, { StaticData } True );
     DsInformeFabricacionFields.Setup( DmInformeFabricacionTable, True );

     OrdenFabricacion.ToDataset( DsOrdenFabricacionFields );
     InformeFabricacion.ToDataset( DsInformeFabricacionFields );

     Result := ActualizaReferenciasRegistro( DsOrdenFabricacionFields, DsInformeFabricacionFields, Descontar );
end;

function TInformeFabricacionModule.ActualizaReferenciasRegistro( OrdenFabricacionFields   : TOrdenFabricacionFields;
                                                                 InformeFabricacionFields : TInformeFabricacionFields;
                                                                 Descontar                : Boolean ) : Boolean;

var Cantidad : Decimal;

begin

     Result := False;

     try

       // Quito / añado del contenedor anterior la cantidad indicada

       If   ( SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.RealizarProduccionPrevista ) and
            ( InformeFabricacionFields.NroProceso.Value=1 )
       then Cantidad := InformeFabricacionFields.Correctas.Value - InformeFabricacionFields.MermaExceso.Value
       else Cantidad := InformeFabricacionFields.Correctas.Value + InformeFabricacionFields.Defectuosas.Value - InformeFabricacionFields.MermaExceso.Value;

       SessionDataModule.Dm70.ContenedorModule.Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value - 1, cnProductoCorrecto, -Cantidad, Descontar );

       // Y se la añado / quito al contenedor actual.

       If   InformeFabricacionFields.Correctas.Value<>0.0
       then SessionDataModule.Dm70.ContenedorModule.Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value, cnProductoCorrecto, InformeFabricacionFields.Correctas.Value, Descontar );

       If   InformeFabricacionFields.Defectuosas.Value<>0.0
       then SessionDataModule.Dm70.ContenedorModule.Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value, cnProductoDefectuoso, InformeFabricacionFields.Defectuosas.Value, Descontar );

       If   InformeFabricacionFields.MermaExceso.Value<>0.0
       then SessionDataModule.Dm70.ContenedorModule.Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value, cnMermaExceso, InformeFabricacionFields.MermaExceso.Value, Descontar );

       If   InformeFabricacionFields.IncorpExtraidas.Value<>0.0
       then SessionDataModule.Dm70.ContenedorModule.Actualiza( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value, cnExtraccionesIncorporaciones, InformeFabricacionFields.IncorpExtraidas.Value, Descontar );

       SessionDataModule.Dm70.MaquinaModule.ActualizaSecuencia( OrdenFabricacionFields.EjercicioLanzamiento.Value, OrdenFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value, InformeFabricacionFields.Fecha.Value, InformeFabricacionFields.Turno.Value, not Descontar );

       Result := True;

      except on E : Exception do
       begin
       SessionDataModule.SendNotification( ntError, RsMsg1 );
       SessionDataModule.SendException( E, Self );
       raise;
       end;
     end;

end;

{ TInformeFabricacionService }

procedure TInformeFabricacionService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TInformeFabricacionService.SuprimeInformeFabricacion( RemoteCursorID: TnxCursorID; Ejercicio: SmallInt; NroOrden: LongInt; NroProceso: SmallInt; Fecha: TDate; Turno: SmallInt; RecalcularProceso : Boolean ): Boolean;
begin
     Result := SessionDataModule.Dm70.InformeFabricacionModule.SuprimeInformeFabricacion( RemoteCursorID, Ejercicio, NroOrden, NroProceso, Fecha, Turno, RecalcularProceso );
end;

function TInformeFabricacionService.CalculaCosteArticulo( OrdenFabricacion : IOrdenFabricacion ) : Decimal;
begin
     Result := SessionDataModule.Dm70.InformeFabricacionModule.CalculaCosteArticulo( OrdenFabricacion );
end;

procedure TInformeFabricacionService.ActualizaInformeFabricacion( InformeFabricacion: IInformeFabricacion; RecalcularProceso : Boolean );
begin
     SessionDataModule.Dm70.InformeFabricacionModule.ActualizaInformeFabricacion( InformeFabricacion, RecalcularProceso );
end;

function TInformeFabricacionService.ActualizaReferenciasRegistro( OrdenFabricacion : IOrdenFabricacion; InformeFabricacion : IInformeFabricacion; Descontar : Boolean ) : Boolean;
begin
     Result := SessionDataModule.Dm70.InformeFabricacionModule.ActualizaReferenciasRegistro( OrdenFabricacion, InformeFabricacion, Descontar );
end;

var OrdenFabricacionControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_InformeFabricacionService, TInformeFabricacionService, OrdenFabricacionControl );

end.
