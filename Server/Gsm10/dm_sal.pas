
unit dm_sal;

interface

uses
  Windows, Messages, SysUtils, Classes,

  nxllTypes,
  nxivTypes,
  nxrdClass,
  nxrbTypes,
  nxsdTypes,

  DB,
  nxdb,
  LibUtils,
  DataManager,
  ServerDataModule,
  AppManager,

  Gim10Fields,
  SqlSet,

  SessionIntf,

  dmi_sal,

  ApunteIntf;

type

  TSaldosService = class( TSessionModule, ISaldosService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    {
    procedure ActualizaSaldos( SaldosCursorID : TnxCursorID;
                               TipoAsiento    : SmallInt;
                               Apunte         : IApunte;
                               Deducir        : Boolean = False );
    }
    function  SaldoPeriodo(  SubCuenta     : String;
                             CentroCoste   : String;
                             TodosLosCC    : Boolean;
                             Ejercicio,
                             MesInicial,
                             MesFinal      : SmallInt;
                             Apertura      : Boolean = False ) : ISumasySaldos;

    function  SaldoFecha ( Cuenta      : String;
                           CentroCoste : String;
                           TodosLosCC  : Boolean;
                           Fecha       : TDateTime;
                           NroAsiento  : LongInt  = 0;
                           NroApunte   : SmallInt = 0;
                           Incluido    : Boolean  = False ) : ISumasySaldos;

    function MesAsientoApertura( Ejercicio : SmallInt ) : SmallInt;

    function SaldoApertura( Cuenta      : String;
                            CentroCoste : String;
                            TodosLosCC  : Boolean;
                            Ejercicio   : SmallInt;
                            SoloAsiento : Boolean = False ) : ISumasySaldos;

    function  Cuadra( Ejercicio      : Word;
                      PeriodoInicial : Byte = 0;
                      PeriodoFinal   : Byte = 14 ) : Boolean;

    function  Sumas( FechaInicial : TDateTime ) : ISumasySaldos;

    procedure ReconstruyeSaldos( Ejercicio,
                                 EjercicioInicial,
                                 EjercicioFinal        : SmallInt;
                                 ComprobarCuadre       : Boolean;
                                 LimpiarSaldosApertura : Boolean = True );

    end;

  TSaldosModule = class(TServerDataModule)
    DmSaldosTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    DmExtractoQuery: TnxeQuery;
    DmExtractoQueryEjercicio: TSmallintField;
    DmExtractoQueryNroAsiento: TIntegerField;
    DmExtractoQueryNroApunte: TSmallintField;
    DmExtractoQueryFecha: TDateField;
    DmExtractoQuerySubcuenta: TWideStringField;
    DmExtractoQueryCentroCoste: TWideStringField;
    DmExtractoQueryContrapartida: TWideStringField;
    DmExtractoQueryDebe: TBCDField;
    DmExtractoQueryHaber: TBCDField;
    SQLSet: TgxSQLSet;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    DmSaldosFields : TSaldosFields;
    DmAsientoFields : TAsientoFields;
    DmApunteFields : TApunteFields;

    FReconstruyendoSaldos : Boolean;

    procedure GetFirstAndLastDay( Ejercicio : SmallInt; var FirstDayOfYearDate : TDateTime; var LastDayOfYearDate  : TDateTime );

  public


    {
    procedure ActualizaSaldos( SaldosCursorID : TnxCursorID;
                               TipoAsiento    : SmallInt;
                               Apunte         : IApunte;
                               Deducir        : Boolean = False ); overload;
    }
    Procedure ActualizaSaldos( TipoAsiento   : SmallInt;
                               ApunteFields  : TApunteFields;
                               Deducir       : Boolean = False ); overload;

    function  SaldoPeriodo(    SubCuenta     : String;
                               CentroCoste   : String;
                               TodosLosCC    : Boolean;
                               Ejercicio,
                               MesInicial,
                               MesFinal      : SmallInt;
                               Apertura      : Boolean = False ) : ISumasySaldos;

    function  SaldoFecha ( Cuenta      : String;
                           CentroCoste : String;
                           TodosLosCC  : Boolean;
                           Fecha       : TDateTime;
                           NroAsiento  : LongInt  = 0;
                           NroApunte   : SmallInt = 0;
                           Incluido    : Boolean  = False ) : ISumasySaldos;

    // function Extracto( Subcuenta : String; FechaInicial, FechaFinal: TDateTime; TipoAsiento: SmallInt ): Boolean;

    function MesAsientoApertura( Ejercicio : SmallInt ) : SmallInt;

    function SaldoApertura( Cuenta      : String;
                            CentroCoste : String;
                            TodosLosCC  : Boolean;
                            Ejercicio   : SmallInt;
                            SoloAsiento : Boolean = False ) : ISumasySaldos;


    function  Cuadra( Ejercicio : Word; PeriodoInicial : Byte = 0; PeriodoFinal : Byte = 14 ) : Boolean;

    function  Sumas( FechaInicial : TDateTime ) : ISumasySaldos;

    procedure ReconstruyeSaldos( Ejercicio, EjercicioInicial, EjercicioFinal : SmallInt; ComprobarCuadre  : Boolean; LimpiarSaldosApertura : Boolean = True );

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     DateUtils,
     ProcID,
     nxllBde,
     nxsdServerEngine,
     kbmMWObjectUtils,

     BaseSessionData,
     SessionData,
     EnterpriseData,

     SessionService,

     Gsm00Dm,

     dmi_ast,
     dm_ast;

{$R *.DFM}

resourceString
  RsMsg4   = 'Realizando la reconstrucción de saldos solicitada.'#13'Espere un momento, por favor ...';
  RsMsg5   = 'Subcuenta o Nivel : ';
  RsMsg6   = 'Asiento - Apunte - Fecha : ';
  RsMsg7   = '%d - %d - %s';
  RsMsg8   = 'El asiento nº %d está descuadrado.';
  RsMsg9   = 'Proceso interrumpido.'#13'Debe repetir la reconstrucción de saldos antes de trabajar con el ejercicio activo.';

  RsMsg14  = 'Hay otro usuario realizando la reconstrucción de saldos.'#13'Espere a que finalice y reintente el proceso.';
  RsMsg16  = 'Suprimiendo los saldos existentes.';

procedure TSaldosModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmSaldosFields := TSaldosFields.Create( DmSaldosTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );

     DmSaldosTable.Timeout := LockWaitTimeout;
end;

procedure TSaldosModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.SaldosModule := nil;
end;

Procedure TSaldosModule.ActualizaSaldos( TipoAsiento   : SmallInt;
                                         ApunteFields  : TApunteFields;
                                         Deducir       : Boolean = False );

var   I,J,
      Nivel,
      NroMes,
      Longitud : SmallInt;
      Debe,
      Haber : Decimal;

begin

     If   ( ApunteFields.Debe.Value<>0.0 ) or ( ApunteFields.Haber.Value<>0.0 )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmSaldosTable ] );

          try

            Debe := DecSign( ApunteFields.Debe.Value, not Deducir );
            Haber := DecSign( ApunteFields.Haber.Value, not Deducir );

            case TipoAsiento of
                3 : NroMes := 13;
                4 : NroMes := 14
               else NroMes := MonthOf( ApunteFields.Fecha.Value );
               end;

            With DmSaldosTable do
              try

                // BeginBatchAppend( RecordSize * Cuenta.NivelSubcuenta );

                CancelRange;

                For Nivel := 1 to SessionDataModule.Dm10.CuentaModule.NivelSubcuenta do
                  begin

                  If   Nivel=SessionDataModule.Dm10.CuentaModule.NivelSubcuenta
                  then Longitud := 9
                  else Longitud := Nivel;

                  try
                    If   FindKey( [ ApunteFields.Ejercicio.Value, Copy( ApunteFields.Subcuenta.Value, 1, Longitud ), ApunteFields.CentroCoste.Value ] )
                    then begin
                         Edit; // El timeout es muy alto. Confío en que esto emule al LockWait
                         DmSaldosFields.Mes[ NroMes, 1 ].Value := DmSaldosFields.Mes[ NroMes, 1 ].Value + Debe;
                         DmSaldosFields.Mes[ NroMes, 2 ].Value := DmSaldosFields.Mes[ NroMes, 2 ].Value + Haber;
                         Post;
                         end
                    else begin
                         Append;
                         DmSaldosFields.Ejercicio.Value := ApunteFields.Ejercicio.Value;
                         DmSaldosFields.Codigo.Value := Copy( ApunteFields.Subcuenta.Value, 1, Longitud );
                         DmSaldosFields.CentroCoste.Value := ApunteFields.CentroCoste.Value;
                         DmSaldosFields.Mes[ NroMes, 1 ].Value := Debe;
                         DmSaldosFields.Mes[ NroMes, 2 ].Value := Haber;
                         Post;
                         end;

                  except
                    Cancel;   // No es cuestión de que se quede algún bloqueo
                    raise;
                    end;

                  end;

              finally
                // EndBatchAppend;
                end;

            TransactionTag.Commit;

          except
            TransactionTag.Rollback;
            raise;
            end;

          end;
end;

//* 17.04.2008  Ahora el parámetro Apertura significa más bien 'Apertura diferenciada', es decir incluir los saldos
//              del asiento de apertura en el periodo 0 o dejarlos donde estén (en el mes del asiento).

function TSaldosModule.SaldoPeriodo ( Subcuenta     : String;
                                      CentroCoste   : String;
                                      TodosLosCC    : Boolean;
                                      Ejercicio,
                                      MesInicial,
                                      MesFinal      : SmallInt;
                                      Apertura      : Boolean = False ) : ISumasySaldos;

{
   Los DmSaldosFields mensuales se acumulan en todos los casos.
   En Saldo, SumaDebe, SumaHaber estan el saldo y las
   Sumas del periodo seleccionado (MesInicial/MesFinal)
}


var  SumasySaldos : ISumasySaldos;

     SaldoTotal,
     Debe,
     Haber : Decimal;

     Indice,
     NroMes,
     MesApertura : SmallInt;

     TopCC,
     BottomCC : String;

     Eop : Boolean;

begin

     If   Apertura and ( MesFinal=0 )
     then Result := SaldoApertura( SubCuenta, CentroCoste, TodosLosCC, Ejercicio, False )
     else begin

          SumasySaldos := nil;
          SaldoTotal := 0.0;

          If   Apertura
          then begin
               MesApertura := MesAsientoApertura( Ejercicio );
               Apertura := MesApertura<>0;
               If   Apertura
               then SumasySaldos := SaldoApertura( SubCuenta, CentroCoste, TodosLosCC, Ejercicio, True );
               end;

          If   not Assigned( SumasySaldos )
          then SumasySaldos := TSumasySaldos.Create( Ejercicio );

          With DmSaldosTable do
            begin

            If   TodosLosCC
            then begin
                 TopCC := '';
                 BottomCC := HighStrCode;
                 end
            else begin
                 TopCC := CentroCoste;
                 BottomCC := CentroCoste;
                 end;

            try

              SetRange( [ Ejercicio, SubCuenta, TopCC ], [ Ejercicio, SubCuenta, BottomCC ] );
              First;
              While not Eof do
                begin

                // Cuidado : si existen saldos de apertura y Apertura=True los saldos del asiento de apertura se suman a los del periodo 0, si existen.

                For Indice := 0 to 14 do
                  begin
                  SumasySaldos.Debe[ Indice ] := SumasySaldos.Debe[ Indice ]  + DmSaldosFields.Mes[ Indice, 1 ].Value;
                  SumasySaldos.Haber[ Indice ] := SumasySaldos.Haber[ Indice ] + DmSaldosFields.Mes[ Indice, 2 ].Value;
                  end;

                NroMes := MesInicial;
                Eop := False;

                // Tratando de evitar un bucle infinito cuando los rangos no son correctos

                If   ( SessionDataModule.NroMesInicial=1 ) and ( MesFinal<MesInicial )
                then MesFinal := MesInicial
                else If   not ( ( MesInicial=0 ) or ( MesFinal>12 ) )
                     then If   SessionDataModule.NroMesInicial=1
                          then begin
                               If   ( MesInicial>=SessionDataModule.NroMesInicial ) and ( MesFinal>SessionDataModule.NroMesFinal )
                               then MesFinal := SessionDataModule.NroMesFinal;
                               end
                          else If   ( MesInicial<=SessionDataModule.NroMesFinal ) and ( ( MesFinal<MesInicial ) or ( MesFinal>SessionDataModule.NroMesFinal ) )  // Solo puede ocurrir en ejercicios partidos
                               then MesFinal := SessionDataModule.NroMesFinal;

                While ( not Eop ) do
                  begin

                  SumasySaldos.SumaDebe := SumasySaldos.SumaDebe + DmSaldosFields.Mes[ NroMes, 1 ].Value;
                  SumasySaldos.SumaHaber := SumasySaldos.SumaHaber + DmSaldosFields.Mes[ NroMes, 2 ].Value;

                  Eop := ( MesInicial=MesFinal ) or ( NroMes=MesFinal ) or ( MesFinal=0 );

                  If   not Eop
                  then If   ( SessionDataModule.NroMesInicial<>1 )  and ( NroMes=SessionDataModule.NroMesFinal )
                       then begin
                            If   MesFinal>12
                            then NroMes := 13;
                            end
                       else begin
                            Inc( NroMes );
                            If   NroMes>14
                            then Eop := True
                            else If   ( SessionDataModule.NroMesInicial<>1 ) and ( MesFinal<>0 )
                                 then begin
                                      If   NroMes=13
                                      then NroMes := 1
                                      else If   NroMes=1
                                           then NroMes := SessionDataModule.NroMesInicial;
                                      end;
                            end;

                 end;

                Next;
                end;

            finally
              CancelRange;
              end;

            end;

          SumasySaldos.SumaDebeInicial := Redondea( SumasySaldos.Debe[ 0 ] );
          SumasySaldos.SumaHaberInicial := Redondea( SumasySaldos.Haber[ 0 ] );
          SumasySaldos.SaldoInicial := SumasySaldos.SumaDebeInicial - SumasySaldos.SumaHaberInicial;

          If   Apertura
          then begin
               SumasySaldos.Debe[ MesApertura ] := SumasySaldos.Debe[ MesApertura ] - SumasySaldos.SumaDebeInicial;
               SumasySaldos.Haber[ MesApertura ] := SumasySaldos.Haber[ MesApertura ] - SumasySaldos.SumaHaberInicial;
               SumasySaldos.SumaDebe := SumasySaldos.SumaDebe - SumasySaldos.SumaDebeInicial;
               SumasySaldos.SumaHaber := SumasySaldos.SumaHaber - SumasySaldos.SumaHaberInicial;
               end;

          SumasySaldos.SumaDebe := Redondea( SumasySaldos.SumaDebe );
          SumasySaldos.SumaHaber := Redondea( SumasySaldos.SumaHaber );
          SumasySaldos.Saldo := SumasySaldos.SumaDebe - SumasySaldos.SumaHaber;

          Result := SumasySaldos;
          end;

end;

//* 09.03.2000  La supresión del periodo 0 para las Aperturas exige que se obtenga el saldo de otro modo
//              El proceso de busqueda es relativamente lento, pero tan solo se utiliza en el balance de Sumas
//              y Saldos con la opción 'Incluir Saldos iniciales' activada.

function TSaldosModule.MesAsientoApertura( Ejercicio : SmallInt ) : SmallInt;
begin
     Result := 0;
     With DmAsientoTable do
       try
       IndexFieldNames := 'TipoAsiento;Ejercicio;NroRegistro';
       If   FindEqualFirst( [ taApertura, Ejercicio ] )
       then Result := MonthOf( DmAsientoFields.Fecha.Value );
     finally
       IndexFieldNames := 'Ejercicio;NroAsiento';
       end;
end;

procedure TSaldosModule.GetFirstAndLastDay(     Ejercicio          : SmallInt;
                                            var FirstDayOfYearDate : TDateTime;
                                            var LastDayOfYearDate  : TDateTime );
begin
     FirstDayOfYearDate := EncodeDate(  Ejercicio, SessionDataModule.NroMesInicial, 1 );
     If   SessionDataModule.NroMesInicial>1
     then LastDayOfYearDate := EncodeDate( Ejercicio + 1, SessionDataModule.NroMesFinal, DaysInAMonth( Ejercicio + 1, SessionDataModule.NroMesFinal ) )
     else LastDayOfYearDate := EncodeDate( Ejercicio, SessionDataModule.NroMesFinal, DaysInAMonth( Ejercicio, SessionDataModule.NroMesFinal ) );
end;

function TSaldosModule.SaldoApertura(     Cuenta      : String;
                                          CentroCoste : String;
                                          TodosLosCC  : Boolean;
                                          Ejercicio   : SmallInt;
                                          SoloAsiento : Boolean = False ) : ISumasySaldos;

var  SumasySaldos : ISumasySaldos;
     FirstDayOfYearDate,
     LastDayOfYearDate : TDateTime;

begin
     If   SoloAsiento or ( MesAsientoApertura( Ejercicio )<>0 )
     then begin

          SumasySaldos := TSumasySaldos.Create( Ejercicio );

          With DmAsientoTable do
            try

              IndexFieldNames := 'TipoAsiento;Fecha';
              DmApunteTable.IndexFieldNames := 'Ejercicio;NroAsiento;Subcuenta';

              GetFirstAndLastDay( Ejercicio, FirstDayOfYearDate, LastDayOfYearDate );

              SetRange( [ taApertura, FirstDayOfYearDate ], [ taApertura, LastDayOfYearDate ] );
              First;
              While not Eof do
                begin

                With DmApunteTable do
                  try

                    With DmAsientoFields do
                      SetRange( [ Ejercicio.Value, NroAsiento.Value, Cuenta ], [ Ejercicio.Value, NroAsiento.Value, Cuenta + HighStrCode ] );

                  First;
                  While not Eof do
                    begin

                    If   TodosLosCC or ( DmApunteFields.CentroCoste.Value=CentroCoste )
                    then begin
                           SumasySaldos.Debe[ 0 ] := SumasySaldos.Debe[ 0 ] + DmApunteFields.Debe.Value;
                           SumasySaldos.Haber[ 0 ] := SumasySaldos.Haber[ 0 ] + DmApunteFields.Haber.Value;

                           SumasySaldos.SumaDebeInicial := SumasySaldos.SumaDebeInicial + DmApunteFields.Debe.Value;
                           SumasySaldos.SumaHaberInicial := SumasySaldos.SumaHaberInicial + DmApunteFields.Haber.Value;

                           SumasySaldos.SumaDebe := SumasySaldos.SumaDebe + DmApunteFields.Debe.Value;
                           SumasySaldos.SumaHaber := SumasySaldos.SumaHaber + DmApunteFields.Haber.Value;
                         end;

                    Next;
                    end;

                  finally
                    CancelRange;
                  end;

                Next;
                end;

            finally
              CancelRange;
              end;

          SumasySaldos.SaldoInicial := SumasySaldos.SumaDebeInicial - SumasySaldos.SumaHaberInicial;
          SumasySaldos.Saldo := SumasySaldos.SumaDebe - SumasySaldos.SumaHaber; // Coinciden
          Result := SumasySaldos;

          end
     else Result := SaldoPeriodo( Cuenta, CentroCoste, TodosLosCC, Ejercicio, 0, 0 );

end;

//* 13.02.2000 Algunos cambios en los parámetros. He añadido algunos valores por defecto. Cuando lo que
//             se solicita es un saldo a una Fecha determinada (sin indicar el apunte en concreto ) no
//             tiene sentido excluir el último movimiento.

function TSaldosModule.SaldoFecha ( Cuenta      : String;
                                    CentroCoste : String;
                                    TodosLosCC  : Boolean;
                                    Fecha       : TDateTime;
                                    NroAsiento  : LongInt  = 0;
                                    NroApunte   : SmallInt = 0;
                                    Incluido    : Boolean  = False ) : ISumasySaldos;

var  SumasySaldos : ISumasySaldos;
     NroMes,
     NroEjercicio : SmallInt;
     IncluirApunte,
     Procesado : Boolean;
     FechaInicial : TDateTime;
     SQLSelectText : String;

begin

     // Hay que hacer algunos ajustes en la comprobación del periodo anterior en Ejercicios partidos

     NroEjercicio := SessionDataModule.EjercicioFecha( Fecha );

     If   SessionDataModule.NroMesInicial<>1
     then begin
          If   MonthOf( Fecha )=1
          then NroMes := 12
          else If   MonthOf( Fecha )=SessionDataModule.NroMesInicial
               then NroMes := 0
               else NroMes := MonthOf( Fecha ) - 1;
          end
     else NroMes := MonthOf( Fecha ) - 1;

     SumasySaldos := SaldoPeriodo( Cuenta, CentroCoste, TodosLosCC, NroEjercicio, 0, NroMes );

     With DmExtractoQuery do
       try

         Close;  // Por si acaso

         FechaInicial := EncodeDate( YearOf( Fecha ), MonthOf( Fecha ), 1 );

         SQLSelectText := ' WHERE Apunte.Fecha BETWEEN ' + SQLDateString( FechaInicial ) + ' AND ' + SQLDateString( Fecha ) + ' ';

         If   Length( Cuenta )=9   // Es una subcuenta
         then StrAdd( SQLSelectText, ' AND Subcuenta=' + QuotedStr( Cuenta ) )
         else StrAdd( SQLSelectText, ' AND Subcuenta LIKE ' + QuotedStr( Cuenta + '%' ) );

         If   not TodosLosCC
         then StrAdd( SQLSelectText, ' AND CentroCoste=' + QuotedStr( CentroCoste ) );

         StrAdd( SQLSelectText, ' ORDER BY Fecha, NroAsiento, NroApunte' );

         SQL.Text := SQLSet.SQLItems.Items[ 0 ].SQLText  + SQLSelectText;

         Open;

         IncluirApunte := True;

         First;
         While not Eof and IncluirApunte do
           begin

           If   DmExtractoQueryFecha.Value=Fecha
           then begin

                IncluirApunte := DmExtractoQueryNroAsiento.Value<NroAsiento;
                If   not IncluirApunte and ( DmExtractoQueryNroAsiento.Value=NroAsiento )
                then If   Incluido
                     then IncluirApunte := DmExtractoQueryNroApunte.Value<=NroApunte
                     else IncluirApunte := DmExtractoQueryNroApunte.Value<NroApunte;

                end
           else IncluirApunte := True;

           If   IncluirApunte
           then begin
                SumasySaldos.SumaDebe  := SumasySaldos.SumaDebe  + DmExtractoQueryDebe.Value;
                SumasySaldos.SumaHaber := SumasySaldos.SumaHaber + DmExtractoQueryHaber.Value;
                end;

           Next;

           end;

       finally
         Close;
         end;

     SumasySaldos.SumaDebe  := Redondea( SumasySaldos.SumaDebe );
     SumasySaldos.SumaHaber := Redondea( SumasySaldos.SumaHaber );

     SumasySaldos.Saldo := SumasySaldos.SumaDebe - SumasySaldos.SumaHaber;

     Result := SumasySaldos;

end;

{  Este procedimiento es muy costoso en términos de proceso y ya no lo utilizo. Se queda como ejemplo.

function TSaldosModule.Extracto( Subcuenta      : String;
                                 FechaInicial,
                                 FechaFinal     : TDateTime;
                                 TipoAsiento    : SmallInt ) : Boolean;
begin
     With DmApunteTable do
       begin
       IndexFieldNames := 'Subcuenta;Fecha';
       DmAsientoTable.IndexFieldNames := 'Ejercicio;NroAsiento';
       FindNearest( [ Subcuenta, FechaInicial ] );
       While not Eof and
                 ( DmApunteFields.Subcuenta.Value=Parametro[ Index ] ) and
                 ( DmApunteFields.Fecha.Value<=FechaFinal ) do
         begin

         With DmAsientoTable do
           begin

             With DmApunteFields do
               FindKey( [ Ejercicio.Value, NroAsiento.Value  ] );

             If   not ( Eof ) and
                  not ( ( TipoAsiento=0 )  and ( DmAsientoFields.TipoAsiento.Value in [ 1, 3, 4 ] ) ) and
                  not ( ( TipoAsiento<>0 ) and ( TipoAsiento<>DmAsientoFields.TipoAsiento.Value ) )
             then begin
                  Debe := DmApunteFields.Debe.Value;
                  Haber := DmApunteFields.Haber.Value;
                  case ComandoActual of
                    3, 6,  9 : DecAdd( Saldo, Debe - Haber );
                    4, 7, 10 : DecAdd( Saldo, Debe );
                    5, 8, 11 : DecAdd( Saldo, Haber );
                    end;

                  end;
             end;

           Next;
           end;

         end;
end;

}

function TSaldosModule.Sumas( FechaInicial  : TDateTime ) : ISumasySaldos;


var    SumasySaldos,
       SumasySaldosPeriodo : ISumasySaldos;
       Grupo,
       I,
       Mes,
       Ejercicio,
       PeriodoInicial : Integer;

       SumaDebeAsiento,
       SumaHaberAsiento : Decimal;

       FechaDePartida,
       FechaFinal : TDateTime;

       CancelaProceso : Boolean;

begin

     try

       SumaDebeAsiento := 0.0;
       SumaHaberAsiento := 0.0;

       Ejercicio := SessionDataModule.EjercicioFecha( FechaInicial );
       Mes := MonthOf( FechaInicial ) - 1;
       DmApunteTable.IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';

       SumasySaldos := TSumasySaldos.Create( Ejercicio );

       PeriodoInicial := 0;

       If   SessionDataModule.NroMesInicial<>1
       then If   Mes=0
            then Mes := 12
            else If   Mes<SessionDataModule.NroMesInicial
                 then Mes := 0;

       For Grupo := 0 to 9 do
         begin
         SumasySaldosPeriodo := SaldoPeriodo( StrInt( Grupo ), '', True, Ejercicio, PeriodoInicial, Mes );
         SumasySaldos.SumaDebeInicial := SumasySaldos.SumaDebeInicial + SumasySaldosPeriodo.Debe[ 0 ];
         SumasySaldos.SumaHaberInicial := SumasySaldos.SumaHaberInicial + SumasySaldosPeriodo.Haber[ 0 ];
         SumasySaldos.DebeAcumulado := SumasySaldos.DebeAcumulado + SumasySaldosPeriodo.SumaDebe;
         SumasySaldos.HaberAcumulado := SumasySaldos.HaberAcumulado + SumasySaldosPeriodo.SumaHaber;
         end;

       With DmAsientoTable do
         try

           IndexFieldNames := 'Fecha';
           FechaDePartida := EncodeDate( YearOf( FechaInicial ), MonthOf( FechaInicial ), 1 );
           FechaFinal := IncDay( FechaInicial, -1 );

           SetRange( [ FechaDePartida ], [ FechaFinal ] );

           While not Eof do
             begin
             With DmApunteTable do
               try
                 With DmAsientoFields do
                   SetRange( [ Ejercicio.Value, NroAsiento.Value, 1 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );
                 First;
                 While not Eof do
                   begin
                   With DmApunteFields do
                     begin
                     SumasySaldos.DebeAcumulado := SumasySaldos.DebeAcumulado + Debe.Value;
                     SumasySaldos.HaberAcumulado := SumasySaldos.HaberAcumulado + Haber.Value;
                     end;
                   Next;
                   end;
                finally
                  CancelRange;
                  end;
             Next;
             end;

         finally
           CancelRange;
           end;

       SumasySaldos.DebeAcumulado := Redondea( SumasySaldos.DebeAcumulado );
       SumasySaldos.HaberAcumulado := Redondea( SumasySaldos.HaberAcumulado );

       Result := SumasySaldos;

     except on E : Exception do
       begin
       SessionDataModule.SendNotification( ntExceptionError, ExceptionMessage( E ) );
       Abort;
       end;
     end;
end;

function TSaldosModule.Cuadra( Ejercicio      : Word;
                               PeriodoInicial : Byte = 0;
                               PeriodoFinal   : Byte = 14 ) : Boolean;


var  Grupo : SmallInt;
     SaldoAcumulado  : Decimal;
     SumasySaldoPeriodo : ISumasySaldos;

begin
     SaldoAcumulado := 0.0;
     With DmSaldosTable do
       For Grupo := 0 to 9 do
         begin
         SumasySaldoPeriodo := SaldoPeriodo( StrInt( Grupo ), '', True, Ejercicio, PeriodoInicial, PeriodoFinal );
         SaldoAcumulado := SaldoAcumulado + SumasySaldoPeriodo.Saldo;
         end;
     Result := SaldoAcumulado=0.0;
end;

procedure TSaldosModule.ReconstruyeSaldos( Ejercicio,
                                           EjercicioInicial,
                                           EjercicioFinal        : SmallInt;
                                           ComprobarCuadre       : Boolean;
                                           LimpiarSaldosApertura : Boolean = True );

var   Index,
      NroMes  : SmallInt;
      Contador : Integer;
      EjercicioActual : SmallInt;
      FirstDayOfYearDate,
      LastDayOfYearDate : TDateTime;
      AsientoCuadra,
      CancelaProceso : Boolean;
      SQLCommand : String;

procedure ActualizaSaldosAsiento;

var  SumaDebe,
     SumaHaber   : Decimal;
     AsientoModificado : Boolean;

begin

     AsientoModificado := False;

     With DmApunteTable do
       try

         SumaDebe := 0.0;
         SumaHaber := 0.0;

         IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';
         With DmAsientoFields do
           SetRange( [ Ejercicio.Value, NroAsiento.Value, 1 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );
         First;
         While not Eof do
           begin

           If  ( Contador mod 200 )=0
           then CancelaProceso := SessionDataModule.SendNotification( ntRecord, Format( RsMsg7, [ DmAsientoFields.NroAsiento.Value, DmApunteFields.NroApunte.Value, StrFormatDate( DmAsientoFields.Fecha.Value, dfDefault2 ) ] ) );
           Inc( Contador );

           // Estos son algunos ajustes que he ido poniendo para corregir errores que tenía la aplicación

           If   CancelaProceso
           then Abort;

           Edit;

           If   DmApunteFields.Fecha.Value<>DmAsientoFields.Fecha.Value
           then DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

           If   Modified
           then begin
                Post;
                AsientoModificado := True;
                end
           else Cancel;

           With DmApunteFields do
             begin
             DecAdd( SumaDebe, Debe.Value );
             DecAdd( SumaHaber, Haber.Value );
             end;

           SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );
           Next;
           end;

       finally
         CancelRange;
         end;

     // 08.07.99 Elevado el límite de redondeo de 0.1 a 0.5

     If   AsientoModificado
     then With DmApunteTable do
            If   ( SumaDebe<>SumaHaber ) and ( Abs( SumaDebe - SumaHaber )<0.5 )
            then If   FindKey( [ DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, 2 ] )    // Siempre el segundo apunte
                 then With DmApunteFields do
                        begin
                        SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, True );

                        try
                          Edit;

                          If   ValueIsEmpty( Haber.Value )
                          then Debe.Value := Debe.Value - SumaDebe  + SumaHaber
                          else Haber.Value := Haber.Value - SumaHaber + SumaDebe;

                          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                          Post;
                        except
                          Cancel;
                          raise;
                          end;

                        end;

     AsientoCuadra := SumaDebe=SumaHaber;
end;

begin
       If   FReconstruyendoSaldos
       then SessionDataModule.SendNotification( ntError, RsMsg14 )
       else try

              FReconstruyendoSaldos := True;

              SessionDataModule.SendNotification( ntInformation, RsMsg4 );

              CancelaProceso := False;
              Contador := 0;

              var TransactionTag := SessionDataModule.StartTransactionWith( [ DmSaldosTable ] );

              try

                EjercicioActual := Ejercicio;

                For Ejercicio := EjercicioInicial to EjercicioFinal do
                  begin

                  With DmSaldosTable do
                    begin

                    SessionDataModule.SendNotification( ntInformation, RsMsg16 );

                    If   LimpiarSaldosApertura
                    then SQLCommand := 'DELETE FROM Saldos WHERE Ejercicio=%d'
                    else SQLCommand := 'UPDATE Saldos ' +
                                       'SET Enero_Debe=0.0, Enero_Haber=0.0, ' +
                                       '    Febrero_Debe=0.0, Febrero_Haber=0.0, ' +
                                       '    Marzo_Debe=0.0, Marzo_Haber=0.0, ' +
                                       '    Abril_Debe=0.0, Abril_Haber=0.0, ' +
                                       '    Mayo_Debe=0.0, Mayo_Haber=0.0, ' +
                                       '    Junio_Debe=0.0, Junio_Haber=0.0, ' +
                                       '    Julio_Debe=0.0, Julio_Haber=0.0, ' +
                                       '    Agosto_Debe=0.0, Agosto_Haber=0.0, ' +
                                       '    Septiembre_Debe=0.0, Septiembre_Haber=0.0, ' +
                                       '    Octubre_Debe=0.0, Octubre_Haber=0.0, ' +
                                       '    Noviembre_Debe=0.0, Noviembre_Haber=0.0, ' +
                                       '    Diciembre_Debe=0.0, Diciembre_Haber=0.0, ' +
                                       '    Regularizacion_Debe=0.0, Regularizacion_Haber=0.0, ' +
                                       '    Cierre_Debe=0.0, Cierre_Haber=0.0 ' +
                                       'WHERE Ejercicio=%d';

                    SessionDataModule.EnterpriseDataModule.ExecSQLCommand( Format( SQLCommand, [ Ejercicio ] ) );

                    With DmAsientoTable do
                      try

                        IndexFieldNames := 'Ejercicio;NroAsiento';

                        SetRange( [ Ejercicio, 1 ], [ Ejercicio, MaxLongint ] );
                        First;
                        While not Eof do
                          begin

                          ActualizaSaldosAsiento;

                          //* 10.02.2003  Esto le tiene que permitir al usuario averiguar la posición de cualquier descuadre

                          If   ComprobarCuadre and not AsientoCuadra
                          then CancelaProceso := SessionDataModule.SendNotification( ntWarning, Format( RsMsg8, [ DmAsientoFields.NroAsiento.Value ] ) );

                          If   CancelaProceso
                          then Abort;

                          Next;
                          end;

                      finally
                        CancelRange;
                        end;

                    end;

                  end;

                TransactionTag.Commit;

              except on E : Exception do
                begin
                TransactionTag.Rollback;
                SessionDataModule.SendNotification( ntError, RsMsg9 );
                end;
              end;

            finally
              FReconstruyendoSaldos := False;
              end;

end;

procedure TSaldosModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     SessionDataModule.EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

{ TSaldosService }

{
procedure TSaldosService.ActualizaSaldos( TipoAsiento : SmallInt; Apunte: IApunte; Deducir: Boolean );
begin
     SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( TipoAsiento, Apunte, Deducir );
end;
}

{
procedure TSaldosService.ActualizaSaldos( SaldosCursorID: TnxCursorID; TipoAsiento: SmallInt; Apunte: IApunte; Deducir: Boolean);
begin
     SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( SaldosCursorID, TipoAsiento, Apunte, Deducir );
end;
}

procedure TSaldosService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TSaldosService.Cuadra( Ejercicio: Word; PeriodoInicial, PeriodoFinal: Byte): Boolean;
begin
     Result := SessionDataModule.Dm10.SaldosModule.Cuadra( Ejercicio, PeriodoInicial, PeriodoFinal );
end;

function TSaldosService.MesAsientoApertura( Ejercicio: SmallInt): SmallInt;
begin
     Result := SessionDataModule.Dm10.SaldosModule.MesAsientoApertura( Ejercicio );
end;

function TSaldosService.SaldoApertura( Cuenta, CentroCoste: String; TodosLosCC: Boolean; Ejercicio: SmallInt; SoloAsiento: Boolean): ISumasySaldos;
begin
     Result := SessionDataModule.Dm10.SaldosModule.SaldoApertura( Cuenta, CentroCoste, TodosLosCC, Ejercicio, SoloAsiento );
end;

function TSaldosService.SaldoFecha( Cuenta, CentroCoste: String; TodosLosCC: Boolean; Fecha: TDateTime; NroAsiento: Integer; NroApunte: SmallInt; Incluido: Boolean): ISumasySaldos;
begin
     Result := SessionDataModule.Dm10.SaldosModule.SaldoFecha( Cuenta, CentroCoste, TodosLosCC, Fecha, NroAsiento, NroApunte, Incluido );
end;

function TSaldosService.SaldoPeriodo( SubCuenta, CentroCoste: String; TodosLosCC: Boolean; Ejercicio, MesInicial, MesFinal: SmallInt; Apertura: Boolean): ISumasySaldos;
begin
     Result := SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( SubCuenta, CentroCoste, TodosLosCC, Ejercicio, MesInicial, MesFinal, Apertura );
end;

function TSaldosService.Sumas( FechaInicial: TDateTime): ISumasySaldos;
begin
     Result := SessionDataModule.Dm10.SaldosModule.Sumas( FechaInicial );
end;

procedure TSaldosService.ReconstruyeSaldos( Ejercicio,
                                            EjercicioInicial,
                                            EjercicioFinal        : SmallInt;
                                            ComprobarCuadre       : Boolean;
                                            LimpiarSaldosApertura : Boolean  );
begin
     SessionDataModule.Dm10.SaldosModule.ReconstruyeSaldos( Ejercicio, EjercicioInicial, EjercicioFinal, ComprobarCuadre, LimpiarSaldosApertura );
end;

var SaldosControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_SaldosService, TSaldosService, SaldosControl );

end.
