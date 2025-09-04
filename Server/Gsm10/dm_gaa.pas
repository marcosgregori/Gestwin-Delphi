
unit dm_gaa;

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

  dmi_gaa;

type
    TGeneracionAmortizacionesService = class( TSessionModule, IGeneracionAmortizacionesService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( FechaAmortizacion : TDate );

    end;

  TGeneracionAmortizacionesModule = class(TServerDataModule)
    AsientoTable: TnxeTable;
    LineaInmovilizadoTable: TnxeTable;
    InmovilizadoTable: TnxeTable;
    SaldosTable: TnxeTable;
    ApunteTable: TnxeTable;
    ApunteAuxTable: TnxeTable;
    AsientoAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    InmovilizadoFields : TInmovilizadoFields;
    LineaInmovilizadoFields : TLineaInmovilizadoFields;
    AsientoFields,
    AsientoAuxFields : TAsientoFields;
    ApunteFields,
    ApunteAuxFields : TApunteFields;

    ValorElemento,
    ImporteAmortizacion,
    AmortizacionApertura,
    AmortizacionAcumulada : Decimal;
    FSubcuentaDotacion : String;
    NroDias : LongInt;

  public

    procedure EjecutaProceso( FechaAmortizacion : TDate );

    function SubcuentaAmortizAcumulada( SubcuentaElemento : String ) : String;
    function SubcuentaDotacion( CuentaAmortizacion : String ) : String;
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

     f_sec,

     dmi_ast,
     dmi_sal,

     dm_sub,
     dm_ast,
     dm_sal;

{$R *.DFM}

resourceString
     RsMsg1  = 'Suprimido el asiento de amortización nº %d.';
     RsMsg2  = 'Amortización al ';
     RsMsg3  = 'El elemento %s no se compró durante este ejercicio y sin embargo no existe saldo de apertura en la subcuenta de A. A. %s.';
     RsMsg4  = #13'No se realizará ninguna operación con el mismo.';
     RsMsg5  = 'Se ha creado el asiento de amortización nº %d. Puede revisarlo desde la opción [Mantenimiento de asientos] de la Gestión Contable.';
     RsMsg6  = 'Se han realizado amortizaciones con fecha posterior a la propuesta.';
     RsMsg7  = 'Si desea generar las amortizaciones en el mes indicado debe suprimir toda amortización posterior.';
     RsMsg8  = 'No se ha generado ningún asiento de amortización.';

procedure TGeneracionAmortizacionesModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.GeneracionAmortizacionesModule := nil;
end;

procedure TGeneracionAmortizacionesModule.ServerDataModuleCreate(Sender: TObject);
begin
     InmovilizadoFields := TInmovilizadoFields.Create( InmovilizadoTable );
     LineaInmovilizadoFields := TLineaInmovilizadoFields.Create( LineaInmovilizadoTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     AsientoAuxFields := TAsientoFields.Create( AsientoAuxTable );
     ApunteAuxFields := TApunteFields.Create( ApunteAuxTable );
end;

{ TGeneracionAmortizacionesService }

procedure TGeneracionAmortizacionesService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TGeneracionAmortizacionesService.EjecutaProceso( FechaAmortizacion : TDate );
begin
     SessionDataModule.Dm10.GeneracionAmortizacionesModule.EjecutaProceso( FechaAmortizacion );
end;

procedure TGeneracionAmortizacionesModule.EjecutaProceso( FechaAmortizacion : TDate );

var  FechaUltimaAmortizacion,
     MesProximo : TDateTime;
     ApunteFieldValues : TFieldValuesArray;
     Month : Word;
     PrimerAsiento : Boolean;
     NroApunteActual : SmallInt;
     SumasySaldos : ISumasySaldos;
     SecuenciaMes : TSecuenciaMes;
     ProcesoCancelado : Boolean;

begin

     SecuenciaMes := TSecuenciaMes.Create( SessionDataModule );

     try

       ProcesoCancelado := False;

       var TransactionTag := SessionDataModule.StartTransactionWith( [ AsientoTable, ApunteTable ] );

       try

         // Compruebo si hay Amortizaciones posteriores

         MesProximo := IncMonth( FechaAmortizacion, 1 );
         If   MesProximo<SessionDataModule.UltimoDiaEjercicio
         then With AsientoTable do
                try

                  IndexFieldNames := 'TipoAsiento;Fecha';

                  If   FindGreaterOrEqual( [ taAmortizacion, MesProximo ] )
                  then If   ( AsientoFields.TipoAsiento.Value=taAmortizacion ) and
                            ( YearOf( AsientoFields.Fecha.Value )=YearOf( FechaAmortizacion ) )
                       then begin
                            ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, RsMsg6, RsMsg7 );
                            Abort;
                            end;

                  // hay que suprimir los asientos de tipo 12 que puedan existir en este mes

                  Month := MonthOf( FechaAmortizacion );
                  SetRange( [ taAmortizacion, EncodeDate( YearOf( FechaAmortizacion ), Month, 1 ) ],
                            [ taAmortizacion, EncodeDate( YearOf( FechaAmortizacion ), Month, DaysInMonth( FechaAmortizacion ) ) ] );

                  First;
                  While not Eof and not ProcesoCancelado do
                    begin
                    SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( AsientoFields );
                    ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg1, [ AsientoFields.NroAsiento.Value ] ) );
                    Next;
                    end;

                finally
                  IndexFieldNames := 'Ejercicio;NroAsiento';
                  end;

         PrimerAsiento := True;
         NroApunteActual := 1;

         With InmovilizadoTable do
           begin
           First;
           While not Eof and not ProcesoCancelado do
             begin

             If   PrimerAsiento or ( NroApunteActual>255 )
             then begin

                  AsientoTable.Append;

                  AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                  AsientoFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
                  AsientoFields.Fecha.Value := FechaAmortizacion;
                  AsientoFields.TipoAsiento.Value := taAmortizacion;

                  AsientoTable.Post;

                  PrimerAsiento := False;
                  NroApunteActual := 1;

                  end;

             //** 05.01.2016  Compruebo primero el valor del bien a partir de su saldo contable. Puede que se haya realizado un asiento manual de baja.

             ValorElemento := SessionDataModule.Dm10.SaldosModule.SaldoFecha( InmovilizadoFields.Codigo.Value, InmovilizadoFields.CentroCoste.Value, True, FechaAmortizacion ).Saldo;

             If   ValorElemento>0.0
             then begin

                  AmortizacionApertura := -SessionDataModule.Dm10.SaldosModule.SaldoApertura( InmovilizadoFields.CuentaAmortizacion.Value, InmovilizadoFields.CentroCoste.Value, False, SessionDataModule.Ejercicio ).Saldo;

                  { Si no hay saldo de Amortizaciones anteriores y el elemento no
                    pertenece a este Ejercicio ... mal asunto }

                  If   not SessionDataModule.EjercicioActual( InmovilizadoFields.FechaCompra.Value ) and ( AmortizacionApertura=0.0 )
                  then ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg3, [ InmovilizadoFields.Codigo.Value, InmovilizadoFields.CuentaAmortizacion.Value ] ) + RsMsg4 )
                  else begin

                       SumasySaldos := SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( InmovilizadoFields.CuentaAmortizacion.Value, InmovilizadoFields.CentroCoste.Value, False, SessionDataModule.Ejercicio, 0, 13 );

                       AmortizacionAcumulada := 0.0;
                       SecuenciaMes.Reset( SessionDataModule.NroMesInicial, MonthOf( FechaAmortizacion ) );
                       With SecuenciaMes do
                         repeat
                           DecAdd( AmortizacionAcumulada, SumasySaldos.Haber[ MesActual ] - SumasySaldos.Debe[ MesActual ] );
                         until UltimoMes;

                       {
                         Obtengo la fecha de la última amortización realizada.
                         Si es un usuario nuevo y solo ha indicado la amortización acumulada en un asiento de apertura se debe poder utilizar
                         como fecha de referencia.
                       }

                       FechaUltimaAmortizacion := InmovilizadoFields.FechaCompra.Value;

                       ApunteAuxTable.SetRange( [ InmovilizadoFields.CuentaAmortizacion.Value, LowestDateTime ],
                                                [ InmovilizadoFields.CuentaAmortizacion.Value, FechaAmortizacion ] );
                       ApunteAuxTable.Last;
                       While not ApunteAuxTable.Bof do
                         begin
                         If   AsientoAuxTable.FindKey( [ ApunteAuxFields.Ejercicio.Value, ApunteAuxFields.NroAsiento.Value ] )
                         then begin
                              FechaUltimaAmortizacion := ApunteAuxFields.Fecha.Value;
                              If   AsientoAuxFields.TipoAsiento.Value=taApertura
                              then FechaUltimaAmortizacion := IncDay( FechaUltimaAmortizacion, -1 );
                              Break;
                              end;
                         ApunteAuxTable.Prior;
                         end;

                       // Obtengo el valor del elemento a la fecha

                       ValorElemento := InmovilizadoFields.Importe.Value;
                       With LineaInmovilizadoTable do
                         try
                           SetRange( [ InmovilizadoFields.Codigo.Value ] );
                           First;
                           While not Eof do
                             begin
                             If   LineaInmovilizadoFields.Fecha.Value<=FechaAmortizacion
                             then DecAdd( ValorElemento, LineaInmovilizadoFields.Importe.Value );
                             Next;
                             end;
                         finally
                           CancelRange;
                           end;

                       // Calculo el numero de días desde la fecha de compra o última amortización

                       NroDias := Trunc( FechaAmortizacion - FechaUltimaAmortizacion );
                       If   NroDias>0
                       then begin

                            //* 07.01.2020  Como ahora la amortización se calcula a partir de la última fecha de amortización
                            //              se puede variar el porcentaje de amortización en la ficha y el cálculo sigue siendo
                            //              correcto (ahora Hacienda permite realizar este tipo de modificaciones).

                            ImporteAmortizacion := Redondea( NroDias * ( ( ( InmovilizadoFields.Tipo.Value * ValorElemento ) / 100.0 ) / 365.0 ) );

                            If   ImporteAmortizacion + AmortizacionAcumulada>ValorElemento
                            then ImporteAmortizacion := ValorElemento - AmortizacionAcumulada;

                            If   ImporteAmortizacion>0.0
                            then begin

                                 FSubcuentaDotacion := SubcuentaDotacion( InmovilizadoFields.CuentaAmortizacion.Value );

                                 ApunteTable.Append;

                                 try
                                   ApunteFields.Ejercicio.Value := AsientoFields.Ejercicio.Value;
                                   ApunteFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                                   ApunteFields.NroApunte.Value := NroApunteActual;
                                   ApunteFields.Fecha.Value := AsientoFields.Fecha.Value;
                                   ApunteFields.Concepto.Value := RsMsg2 + StrFormat( InmovilizadoFields.Tipo.Value, 1 ) + '%';
                                   ApunteFields.TipoApunte.Value := tapManual;

                                   ApunteFieldValues := ApunteTable.GetFieldValues;

                                   ApunteFields.Subcuenta.Value := FSubcuentaDotacion;
                                   ApunteFields.CentroCoste.Value := InmovilizadoFields.CentroCoste.Value;
                                   ApunteFields.Contrapartida.Value := InmovilizadoFields.CuentaAmortizacion.Value;
                                   ApunteFields.Debe.Value := ImporteAmortizacion;
                                   ApunteFields.Haber.Value := 0.0;

                                   SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                                   ApunteTable.Post;

                                   Inc( NroApunteActual );

                                   ApunteTable.Append;

                                   ApunteTable.SetFieldValues( ApunteFieldValues );

                                   ApunteFields.NroApunte.Value := NroApunteActual;
                                   ApunteFields.Subcuenta.Value := InmovilizadoFields.CuentaAmortizacion.Value;
                                   ApunteFields.CentroCoste.Value := InmovilizadoFields.CentroCoste.Value;
                                   ApunteFields.Contrapartida.Value := FSubcuentaDotacion;
                                   ApunteFields.Debe.Value := 0.0;
                                   ApunteFields.Haber.Value := ImporteAmortizacion;

                                   SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                                   ApunteTable.Post;

                                 finally
                                   ApunteTable.Cancel;  // Por si se produce un error entre un Append y un Post
                                   end;

                                 Inc( NroApunteActual );

                                 end;
                            end;

                       end;
                  end;
             Next;
             end;
           end;

         If   ProcesoCancelado
         then Abort;

         If   NroApunteActual=1
         then begin
              AsientoTable.Delete;
              SessionDataModule.SendNotification( ntInformation, RsMsg8, '' );
              end
         else SessionDataModule.SendNotification( ntInformation, Format( RsMsg5, [ AsientoFields.NroAsiento.Value ] ) );

         TransactionTag.Commit;

       except on E : Exception do
         begin
         ApunteTable.Cancel;
         AsientoTable.Cancel;
         TransactionTag.Rollback;
         SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
         end;
       end;

     finally
       SecuenciaMes.Free;
       end;

end;

function TGeneracionAmortizacionesModule.SubcuentaAmortizAcumulada( SubcuentaElemento : String ) : String;
begin

     { 20x-xxxxx   -->  280xxxxx
       21x-xxxxx   -->  281xxxxx
       22x-xxxxx   -->  282xxxxx

       En la creación de la subcuenta de amortización acumulada se pierde el cuarto dígito
     }

     Result := '28' + Copy( SubcuentaElemento, 2, 2 ) + Copy( SubcuentaElemento, 5, 5 );
end;

function TGeneracionAmortizacionesModule.SubcuentaDotacion( CuentaAmortizacion : String ) : String;
begin
     Result := '6' + Copy( CuentaAmortizacion, 2, 8 );
end;

var GeneracionAmortizacionesControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_GeneracionAmortizacionesService, TGeneracionAmortizacionesService, GeneracionAmortizacionesControl );

end.
