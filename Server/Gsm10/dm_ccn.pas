
unit dm_ccn;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,

  dmi_ccn;

type
    TCierreContableService = class( TSessionModule, ICierreContableService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( TipoProceso: TTipoProcesoCierre; FechaCierre, FechaApertura: TDate );
    end;

  TCierreContableModule = class(TServerDataModule)
    Saldos1Table: TnxeTable;
    Saldos2Table: TnxeTable;
    ApunteBrowseTable: TnxeTable;
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    AsientoAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    procedure EjecutaProceso( TipoProceso : TTipoProcesoCierre; FechaCierre, FechaApertura : TDate );
    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     dmi_ast,
     dmi_sal,

     dm_sub,
     dm_ast,
     dm_sal;

{$R *.DFM}

resourceString

  RsMsg1   = 'Pérdidas y ganancias';
  RsMsg2   = 'Realizando el proceso de cierre del ejercicio contable.';
  RsMsg3   = 'Regularización del Grupo 6';
  RsMsg4   = 'Regularización del Grupo 7';
  RsMsg5   = 'Cierre';
  RsMsg6   = 'Apertura';
  RsMsg7   = 'Traspaso de saldos al próximo ejercicio.';

  RsMsg10  = 'Proceso realizado satisfactoriamente.';
  RsMsg11  = 'Regularización';
  RsMsg12  = 'No se ha generado ningún asiento de cierre.'#13'No existen movimientos en este ejercicio o ya ha realizado el cierre con anterioridad.';
  RsMsg13  = 'No existe asiento de cierre en este ejercicio o no es el último.';
  RsMsg14  = 'Realizando el proceso de traspaso de saldos.';
  RsMsg15  = 'Limpiando los saldos de apertura del próximo ejercicio.';
  RsMsg16  = 'Acumulando saldos.';

var Procesos10Control : InxClassFactoryControl;

procedure TCierreContableModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.CierreContableModule := nil;
end;

procedure TCierreContableModule.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

{ TCierreContableService }

procedure TCierreContableService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TCierreContableService.EjecutaProceso( TipoProceso: TTipoProcesoCierre; FechaCierre, FechaApertura: TDate);
begin
     SessionDataModule.Dm10.CierreContableModule.EjecutaProceso( TipoProceso, FechaCierre, FechaApertura );
end;

// TProcesos10Module

procedure TCierreContableModule.EjecutaProceso( TipoProceso   : TTipoProcesoCierre;
                                                FechaCierre,
                                                FechaApertura : TDate );

var   AsientoFields : TAsientoFields;
      ApunteFields,
      ApunteBrowseFields : TApunteFields;
      Saldos1Fields,
      Saldos2Fields : TSaldosFields;

      NroAsientoCierre,
      NroAsiento : LongInt;
      SaldoAcumulado : Decimal;
      EjercicioCierre,
      NroApunteAcreedor,
      NroApunte : Integer;
      Nivel,
      Index : SmallInt;
      SumaDebe,
      SumaHaber,
      DebePyG,
      HaberPyG : Decimal;
      SubcuentaCodigo : String;
      ProcesoCancelado : Boolean;

const CuentaPyG : String = '129000000';

procedure CheckCanceled;
begin
     If   ProcesoCancelado
     then Abort;
end;

procedure Regulariza( Grupo       : String;
                      SaldoDeudor : Boolean  );

Var   PrimerNroApunte : SmallInt;
      SumasySaldos : ISumasySaldos;

begin

     If   SaldoDeudor
     then PrimerNroApunte := 2
     else PrimerNroApunte := 1;

     SaldoAcumulado := 0.0;
     NroAsiento := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
     NroApunte := PrimerNroApunte;

     try

       AsientoTable.Append;

       AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       AsientoFields.NroAsiento.Value  := NroAsiento;
       AsientoFields.Fecha.Value := FechaCierre;
       AsientoFields.TipoAsiento.Value := taRegularizacion;

       AsientoTable.Post;

       With Saldos1Table do
         begin
         SetRange( [ SessionDataModule.Ejercicio, Grupo, '' ],
                   [ SessionDataModule.Ejercicio, Grupo + HighStrCode, HighStrCode ] );
         First;
         While not Eof do
           begin

           If   Length( Saldos1Fields.Codigo.Value )=9   // comprueba que no sea un Nivel
           then begin

                SumasySaldos := SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( Saldos1Fields.Codigo.Value,
                                                                                  Saldos1Fields.CentroCoste.Value,
                                                                                  False,
                                                                                  SessionDataModule.Ejercicio,
                                                                                  0,
                                                                                  13 );

                If   ( SaldoDeudor and ( SumasySaldos.Saldo>0.0 ) ) or
                     ( not SaldoDeudor and ( SumasySaldos.Saldo<0.0 ) )
                then begin

                     SaldoAcumulado := SaldoAcumulado + Abs( SumasySaldos.Saldo );

                     SessionDataModule.SendNotification( ntRecord, Saldos1Fields.Codigo.Value );

                     ApunteTable.Append;

                     ApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     ApunteFields.NroAsiento.Value := NroAsiento;
                     ApunteFields.NroApunte.Value := NroApunte;
                     ApunteFields.Fecha.Value := FechaCierre;
                     ApunteFields.Subcuenta.Value := Saldos1Fields.Codigo.Value;
                     ApunteFields.CentroCoste.Value := Saldos1Fields.CentroCoste.Value;
                     ApunteFields.Contrapartida.Value := CuentaPyG;
                     ApunteFields.Concepto.Value := RsMsg11;
                     ApunteFields.TipoApunte.Value := tapManual;

                     If   SaldoDeudor
                     then begin
                          ApunteFields.Debe.Value := 0.0;
                          ApunteFields.Haber.Value := Abs( SumasySaldos.Saldo );
                          end
                     else begin
                          ApunteFields.Debe.Value := Abs( SumasySaldos.Saldo );
                          ApunteFields.Haber.Value := 0.0;
                          end;

                     SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                     ApunteTable.Post;

                     Inc( NroApunte );

                     end;
                end;

           Next;
           CheckCanceled;
           end;
         end;

       If   NroApunte<>PrimerNroApunte
       then begin

            ApunteTable.Append;

            ApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
            ApunteFields.NroAsiento.Value := NroAsiento;

            If   SaldoDeudor
            then ApunteFields.NroApunte.Value := 1
            else ApunteFields.NroApunte.Value := NroApunte;

            ApunteFields.Fecha.Value := FechaCierre;
            ApunteFields.Subcuenta.Value := CuentaPyG;
            ApunteFields.CentroCoste.Value := '';
            ApunteFields.Contrapartida.Value := '';
            ApunteFields.Concepto.Value := RsMsg11;
            ApunteFields.TipoApunte.Value := tapManual;

            If   SaldoDeudor
            then begin
                 ApunteFields.Debe.Value := Abs( SaldoAcumulado );
                 ApunteFields.Haber.Value := 0.0;
                 end
            else begin
                 ApunteFields.Debe.Value := 0.0;
                 ApunteFields.Haber.Value := Abs( SaldoAcumulado );
                 end;

            SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

            ApunteTable.Post;

            end
       else With AsientoTable do
              If   FindKey( [ SessionDataModule.Ejercicio, AsientoFields.NroAsiento.Value ] )
              then begin
                   SessionDataModule.Dm10.AsientoModule.RetiraNroAsiento( AsientoFields, { CompruebaEstado } False );
                   Delete;
                   end;

     except
       ApunteTable.Cancel;
       AsientoTable.Cancel;
       raise;
       end;

end;

procedure Cierre( SaldoDeudor : Boolean );

var  SumasySaldos : ISumasySaldos;

begin

     With Saldos1Table do
       begin
       SetRange( [ SessionDataModule.Ejercicio, '', '' ], [ SessionDataModule.Ejercicio, HighStrCode, HighStrCode ] );
       First;
       While not Eof do
         begin

         If   Length( Saldos1Fields.Codigo.Value )=9
         then begin

              SumasySaldos := SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( Saldos1Fields.Codigo.Value,
                                                                                Saldos1Fields.CentroCoste.Value,
                                                                                False,
                                                                                SessionDataModule.Ejercicio,
                                                                                0,
                                                                                14 );

              If   (     SaldoDeudor and ( SumasySaldos.Saldo<0.0 ) ) or
                   ( not SaldoDeudor and ( SumasySaldos.Saldo>0.0 ) )
              then begin

                   SessionDataModule.SendNotification( ntRecord, Saldos1Fields.Codigo.Value );

                   ApunteTable.Append;

                   ApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                   ApunteFields.NroAsiento.Value := NroAsiento;
                   ApunteFields.NroApunte.Value := NroApunte;
                   ApunteFields.Fecha.Value := FechaCierre;
                   ApunteFields.Subcuenta.Value := Saldos1Fields.Codigo.Value;
                   ApunteFields.CentroCoste.Value := Saldos1Fields.CentroCoste.Value;
                   ApunteFields.Contrapartida.Value := '';
                   ApunteFields.Concepto.Value := RsMsg5;
                   ApunteFields.TipoApunte.Value := tapManual;

                   If   SaldoDeudor
                   then begin
                        ApunteFields.Debe.Value := Abs( SumasySaldos.Saldo );
                        ApunteFields.Haber.Value := 0.0;
                        end
                   else begin
                        ApunteFields.Debe.Value := 0.0;
                        ApunteFields.Haber.Value := Abs( SumasySaldos.Saldo );
                        end;

                   SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                   ApunteTable.Post;

                   Inc( NroApunte );
                   end;
              end;

         Next;
         CheckCanceled;
         end;
       end;
end;

procedure ObtenSaldoPyG( var DebePyG  : Decimal;
                         var HaberPyG : Decimal );

var   NroCuenta : Byte;
      SaldoPyG : Decimal;

const Cuenta : array[ 1..2 ] of String = ( '6', '7' );

begin

     SaldoPyG := 0.0;

     For NroCuenta := 1 to 2 do
       SaldoPyG := SaldoPyG + SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( Cuenta[ NroCuenta ], '', True, SessionDataModule.Ejercicio, 0, 12 ).Saldo;

    If   SaldoPyG>0.0
    then begin
         DebePyG  := SaldoPyG;
         HaberPyG := 0.0;
         end
    else begin
         DebePyG  := 0.0;
         HaberPyG := Abs( SaldoPyG );
         end;

end;

procedure GeneraAsientoApertura( NroAsientoCierre   : LongInt;
                                 NroApunteAcreedor  : SmallInt );

var FieldValuesArray : TFieldValuesArray;

begin
     SessionDataModule.SendNotification( ntInformation, RsMsg6 );

     try

       try

         EjercicioCierre := SessionDataModule.Ejercicio;
         SessionDataModule.Ejercicio := SessionDataModule.Ejercicio + 1;

         With AsientoAuxTable do
           If   FindKey( [ SessionDataModule.Ejercicio, 1 ] )
           then NroAsiento := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento
           else NroAsiento := 1;

         AsientoTable.Append;

         AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
         AsientoFields.NroAsiento.Value := NroAsiento;
         AsientoFields.Fecha.Value := FechaApertura;
         AsientoFields.TipoAsiento.Value := taApertura;

         AsientoTable.Post;

         NroApunte := 1;

         With ApunteBrowseTable do
           begin
           SetRange( [ EjercicioCierre, NroAsientoCierre, NroApunteAcreedor ],
                     [ EjercicioCierre, NroAsientoCierre, MaxSmallInt ] );
           First;
           While not Eof  do
             begin

             SessionDataModule.SendNotification( ntRecord, ApunteFields.Subcuenta.Value );

             FieldValuesArray := GetFieldValues;
             ApunteTable.Append;
             ApunteTable.SetFieldValues( FieldValuesArray );

             ApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
             ApunteFields.NroAsiento.Value := NroAsiento;
             ApunteFields.NroApunte.Value := NroApunte;
             ApunteFields.Fecha.Value := FechaApertura;
             ApunteFields.Concepto.Value := RsMsg6;

             SwapFieldValues( ApunteFields.Debe, ApunteFields.Haber );

             SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

             ApunteTable.Post;

             Inc( NroApunte );
             Next;
             end;

           SetRange( [ EjercicioCierre, NroAsientoCierre, 1 ],
                     [ EjercicioCierre, NroAsientoCierre, NroApunteAcreedor - 1 ] );
           First;
           While not Eof do
             begin

             SessionDataModule.SendNotification( ntRecord, ApunteFields.Subcuenta.Value );

             FieldValuesArray := GetFieldValues;
             ApunteTable.Append;
             ApunteTable.SetFieldValues( FieldValuesArray );

             ApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
             ApunteFields.NroAsiento.Value := NroAsiento;
             ApunteFields.NroApunte.Value := NroApunte;
             ApunteFields.Fecha.Value := FechaApertura;
             ApunteFields.Concepto.Value := RsMsg6;

             SwapFieldValues( ApunteFields.Debe, ApunteFields.Haber );

             SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

             ApunteTable.Post;

             Inc( NroApunte );
             next;
             end;

           end;

       except
         AsientoTable.Cancel;
         ApunteTable.Cancel;
         raise;
         end;

     finally
       SessionDataModule.Ejercicio := EjercicioCierre;
       end;
end;

procedure SinAsientoDeCierre;
begin
     SessionDataModule.SendNotification( ntError, RsMsg13 );
     Abort;
end;

procedure SuprimeSaldosApertura;
begin
     SessionDataModule.SendNotification( ntInformation, RsMsg15 );

     With Saldos1Table do
       begin
       SetRange( [ SessionDataModule.Ejercicio + 1, '', '' ], [ SessionDataModule.Ejercicio + 1, HighStrCode, HighStrCode ] );
       First;
       While not Eof  do
         begin
         try
           Edit;
           Saldos1Fields.Mes[ 0, 1 ].Value := 0.0;
           Saldos1Fields.Mes[ 0, 2 ].Value := 0.0;
           Post;
         except
           Cancel;
           raise;
           end;
         Next;
         CheckCanceled;
         end;
       end;

end;

begin
     try

       ProcesoCancelado := False;

       AsientoTable.Open;
       AsientoAuxTable.Open;
       ApunteTable.Open;
       ApunteBrowseTable.Open;
       Saldos1Table.Open;
       Saldos2Table.Open;

       AsientoFields := TAsientoFields.Create( AsientoTable );
       ApunteFields := TApunteFields.Create( ApunteTable );
       ApunteBrowseFields := TApunteFields.Create( ApunteBrowseTable );
       Saldos1Fields := TSaldosFields.Create( Saldos1Table );
       Saldos2Fields := TSaldosFields.Create( Saldos2Table );

       var TransactionTag := SessionDataModule.StartTransactionWith( [ AsientoTable, ApunteTable, Saldos1Table, Saldos2Table ] );

       try


         SuprimeSaldosApertura;

         case TipoProceso of

          tpcCierreApertura :
            begin

            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg2 );

            SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( CuentaPyG, RsMsg1 );

            // Regularización

            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg3 );

            Regulariza( '6', True );
            Regulariza( '6', False );

            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg4 );

            Regulariza( '7', True );
            Regulariza( '7', False );

            // Cierre

            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg5 );

            NroAsiento := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
            NroApunte := 1;

            AsientoTable.Append;

            AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
            AsientoFields.NroAsiento.Value := NroAsiento;
            AsientoFields.Fecha.Value := FechaCierre;
            AsientoFields.TipoAsiento.Value := taCierre;

            AsientoTable.Post;

            NroAsientoCierre  := NroAsiento;

            Cierre( True );

            NroApunteAcreedor := NroApunte;

            Cierre( False );

            If   NroApunte=1
            then With AsientoTable do
                   If   FindKey( [ SessionDataModule.Ejercicio, NroAsiento ] )
                   then begin
                        Delete;
                        SessionDataModule.SendNotification( ntError, RsMsg12 );
                        Abort;
                        end;

            // Apertura

            GeneraAsientoApertura( NroAsientoCierre, NroApunteAcreedor );

            end;

          tpcApertura :
            With AsientoTable do
              try
                SetRange( [ SessionDataModule.Ejercicio, 1 ], [ SessionDataModule.Ejercicio, MaxLongint ] );
                Last;
                If   not Bof
                then begin
                     If   AsientoFields.TipoAsiento.Value=taCierre
                     then begin

                          NroAsientoCierre := AsientoFields.NroAsiento.Value;
                          NroApunteAcreedor := 1;

                          With ApunteTable do
                            try
                              SetRange( [ SessionDataModule.Ejercicio, NroAsientoCierre,  1 ],
                                        [ SessionDataModule.Ejercicio, NroAsientoCierre, MaxSmallInt ] );
                              First;
                              While not Eof do
                                begin
                                If   not ValueIsEmpty( ApunteFields.Haber.Value )
                                then begin
                                     NroApunteAcreedor := ApunteFields.NroApunte.Value;
                                     Break;
                                     end;
                                Next;
                                end;
                            finally
                              CancelRange;
                              end;

                          // Apertura

                          GeneraAsientoApertura( NroAsientoCierre, NroApunteAcreedor );

                          end
                     else SinAsientoDeCierre;
                     end
                else SinAsientoDeCierre;

              finally
                CancelRange;
                end;

          tpcTraspaso :
            begin

            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg14 );

            With Saldos1Table do
              begin

              ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg16 );

              SetRange(  [ SessionDataModule.Ejercicio, '', '' ], [ SessionDataModule.Ejercicio, HighStrCode, HighStrCode ] );
              First;
              While not Eof do
                begin

                If   CharInSet( Saldos1Fields.Codigo.Value[ 1 ], [ '1', '2', '3', '4', '5' ] )
                then begin

                     SumaDebe  := 0.0;
                     SumaHaber := 0.0;
                     For Index := 0 to 12 do
                       begin
                       SumaDebe  := SumaDebe  + Saldos1Fields.Mes[ Index, 1 ].Value;
                       SumaHaber := SumaHaber + Saldos1Fields.Mes[ Index, 2 ].Value;
                       end;

                     With Saldos2Table do
                       try
                         If   FindKey( [ SessionDataModule.Ejercicio + 1, Saldos1Fields.Codigo.Value, Saldos1Fields.CentroCoste.Value ] )
                         then begin
                              Edit;
                              Saldos2Fields.Mes[ 0, 1 ].Value := SumaDebe;
                              Saldos2Fields.Mes[ 0, 2 ].Value := SumaHaber;
                              end
                         else begin
                              Append;
                              Saldos2Fields.Ejercicio.Value := SessionDataModule.Ejercicio + 1;
                              Saldos2Fields.Codigo.Value := Saldos1Fields.Codigo.Value;
                              Saldos2Fields.CentroCoste.Value := Saldos1Fields.CentroCoste.Value;
                              Saldos2Fields.Mes[ 0, 1 ].Value := SumaDebe;
                              Saldos2Fields.Mes[ 0, 2 ].Value := SumaHaber;
                              end;
                         Post;
                         ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, Saldos2Fields.Codigo.Value );
                       except
                         Cancel;
                         raise;
                         end;
                     end;

                Next;
                CheckCanceled;
                end;

              end;

            ObtenSaldoPyG( DebePyG, HaberPyG );

            CheckCanceled;

            For Nivel := 1 to SessionDataModule.Dm10.CuentaModule.NivelSubcuenta do
              begin

              If   Nivel=SessionDataModule.Dm10.CuentaModule.NivelSubcuenta
              then SubcuentaCodigo := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaPerdidasGanancias )
              else SubcuentaCodigo := Copy( SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaPerdidasGanancias ), 1, Nivel );

              With Saldos2Table do
                try

                  If   FindKey( [ SessionDataModule.Ejercicio + 1, SubcuentaCodigo, '' ] )
                  then begin
                       Edit;
                       Saldos2Fields.Mes[ 0, 1 ].Value := Saldos2Fields.Mes[ 0, 1 ].Value + DebePyG;
                       Saldos2Fields.Mes[ 0, 2 ].Value := Saldos2Fields.Mes[ 0, 2 ].Value + HaberPyG;
                       end
                  else begin
                       Append;
                       For  Index := 0 to 14 do
                         begin
                         Saldos2Fields.Mes[ Index, 1 ].Value := 0.0;
                         Saldos2Fields.Mes[ Index, 2 ].Value := 0.0;
                         end;

                       Saldos2Fields.Ejercicio.Value := SessionDataModule.Ejercicio + 1;
                       Saldos2Fields.Codigo.Value := SubcuentaCodigo ;
                       Saldos2Fields.CentroCoste.Value := '';
                       Saldos2Fields.Mes[ 0, 1 ].Value := DebePyG;
                       Saldos2Fields.Mes[ 0, 2 ].Value := HaberPyG;

                       end;

                  Post;

                except
                  Cancel;
                  raise;
                  end;

              end;

            end;

          end;

         TransactionTag.Commit;

         SessionDataModule.SendNotification( ntInformation, RsMsg10 );

       except on e : exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
         end;
       end;

     finally
       AsientoTable.Close;
       AsientoAuxTable.Close;
       ApunteTable.Close;
       ApunteBrowseTable.Close;
       Saldos1Table.Close;
       Saldos2Table.Close;
       end;

end;

initialization
    TnxClassFactory.RegisterClass( CLSID_CierreContableService, TCierreContableService, Procesos10Control );

end.
