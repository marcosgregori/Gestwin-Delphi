
unit dm_sal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,
  nxdb,
  DataManager,

  LibUtils,
  Gim10Fields,

  dmi_sal,

  SqlSet;

const
  NivelMaximo = 5;
  NroMaximoCuentas = 60;

type
  TSaldoPeriodo = array[ 0..14 ] of Decimal;
  TVariable    = record
    Nombre   : String;
    Valor    : array[ 1..2 ] of Decimal;
    end;

  TSeccionBalance = ( sbActivo, sbPasivo );
  TTipoRegistro = ( trCabecera, trLinea, trDesglose, trTotal, trTotalgeneral );
  TListaSaldos = array[ 1..2 ] of Decimal;

  TSaldosModule = class(TDataModule )
    DmSaldosTable: TnxeTable;
    DmExistenciasTable: TnxeTable;

    procedure SaldosModuleCreate(Sender: TObject);
    procedure SaldosModuleDestroy(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);

  private

    DmSaldosFields : TSaldosFields;
    DmExistenciaFields : TExistenciaFields;

    SaldosService : ISaldosService;

    // SaldosPerdidasyGanancias

    ConfigTextList : TStringList;

      Saldo,
      SaldoDebe,
      SaldoHaber,
      SaldoTitulo,
      TotalGrupo,
      SaldoVacio : TListaSaldos;

      UltimoNroCuenta,
      NroCuenta : SmallInt;

      CodigoCuenta : String;

      TextoCabecera : String;
      CodigoVariableNivel : array[ 1..NivelMaximo ] of String;
      CodigoNivel,
      TextoNivel : array[ 1..NivelMaximo ] of String;
      ImprimirNivel : array[ 1..NivelMaximo ] of Boolean;

      UltimoNivelImpreso,
      Nivel : SmallInt;

      MesInicialExistencias,
      MesFinalExistencias,
      MesFinalExistAnterior : SmallInt;

      SaldoExistInicial,
      SaldoExistFinal : Decimal;

      CodigoExistInicial,
      CodigoExistFinal : String;

      St,
      Cuentas,
      Linea : String;
      NroLineaFichero : Word;

      ListaCuenta : array[ 1..NroMaximoCuentas ] of String;
      IndDescripcion : SmallInt;

      PilaVariables : array[ 1..100 ] of TVariable;
      PunteroPila : SmallInt;

      NivelActivo : array[ 1..NivelMaximo ] of boolean;
      Variable : array[ 1..NivelMaximo ] of TVariable;
      VariableTmp : TVariable;
      Operacion : String[ 1 ];

      FicheroAbierto,
      Existe,
      Error : boolean;

      MesFinalAnterior,
      I, J, K : SmallInt;

      // SaldosBalanceSituacion

      Seccion : TSeccionBalance;

      // Variables acumulables (hay que ponerlas a 0 por si el usuario interrumpe el listado)

      SaldoActivo,
      SaldoPasivo : TListaSaldos;

    function SaldoPeriodoReport( SubCuenta,
                                 CentroCoste  : String;
                                 TodosLosCC   : Boolean;
                                 Ejercicio    : Integer;
                                 MesInicial,
                                 MesFinal     : Byte;
                                 Apertura     : Boolean = False ) : Decimal;

  public


    procedure ActualizaSaldos( TipoAsiento   : SmallInt;
                               ApunteFields  : TApunteFields;
                               Deducir       : Boolean = False );

    function  SaldoPeriodo(    SubCuenta     : String;
                               CentroCoste   : String;
                               TodosLosCC    : Boolean;
                               Ejercicio     : SmallInt;
                               MesInicial,
                               MesFinal      : Byte;
                               Apertura      : Boolean = False ) : ISumasySaldos;

    function  SaldoFecha ( Cuenta      : String;
                           CentroCoste : String;
                           TodosLosCC  : Boolean;
                           Fecha       : TDateTime;
                           NroAsiento  : LongWord = 0;
                           NroApunte   : SmallInt = 0;
                           Incluido    : Boolean  = False ) : ISumasySaldos;

    function MesAsientoApertura( Ejercicio : SmallInt ) : SmallInt;

    function SaldoApertura( Cuenta      : String;
                            CentroCoste : String;
                            TodosLosCC  : Boolean;
                            Ejercicio   : SmallInt;
                            SoloAsiento : Boolean = False ) : ISumasySaldos;


    function  Cuadra( PeriodoInicial : Byte = 0; PeriodoFinal : Byte = 14 ) : Boolean;

    function  Sumas( FechaInicial : TDateTime; var SumasySaldos : ISumasySaldos ) : Boolean;

    procedure ReconstruyeSaldos( EjercicioInicial, EjercicioFinal : SmallInt; ComprobarCuadre : Boolean; LimpiarSaldosApertura : Boolean = True );

    procedure SaldosBalanceSituacion( BalanceTable         : TnxeTable;
                                      Ejercicio            : SmallInt;
                                      PeriodoInicial,
                                      PeriodoFinal         : Byte;
                                      DesglosarCuentas     : Boolean = False;
                                      SaldosFinales        : Boolean = False;
                                      ModeloAbreviado      : Boolean = False;
                                      Comparativo          : Boolean = False );

    procedure SaldosPerdidasyGanancias( BalanceTable         : TnxeTable;
                                        SeleccionCentroCoste : Byte;
                                        CentroCoste          : String;
                                        Ejercicio            : SmallInt;
                                        PeriodoInicial,
                                        PeriodoFinal         : Byte;
                                        DesglosarCuentas     : Boolean = False;
                                        SaldosFinales        : Boolean = False;
                                        ModeloAbreviado      : Boolean = False );

  end;

var  SaldosModule: TSaldosModule = nil;


function Saldos : TSaldosModule;

implementation

uses nxpsiMessagePumpInterceptor,
     nxptBasePooledTransport,

     Variants,
     DateUtils,

     AppContainer,
     AppManager,
     DataAccess,

     EnterpriseDataAccess,
     SessionDataAccess,
     ReportManager,

     cxEdit,
     frxNXRTTI,
     ProcID,
     NexusRpcData,

     Gim00Fields,

     AsientoIntf,
     ApunteIntf,

     Gdm00Dm,
     Gdm10Dm,

     dm_ast,
     dm_sub,
     dm_ban,
     dm_sec,

     b_msg,
     b_pro,

     f_prg;

{$R *.DFM}

resourceString
     RsMsg1  = 'Las sumas del debe y haber no coinciden.';
     RsMsg2  = 'Compruebe la existencia de un asiento descuadrado o, si este no existiera, reconstruya los saldos.';
     RsMsg3  = 'Los saldos no cuadran.';
     RsMsg4  = 'Las sumas al debe y haber de los saldos iniciales no coinciden.';
     RsMsg5  = 'Éstos se obtienen del traspaso de los saldos realizado desde el ejercicio anterior.'#13'' +
                'Esta situación transitoria puede provocar que las sumas al debe y al haber no cuadren y debe tenerla en cuenta al consultar la información contable.';
     RsMsg6  = #13 + 'Indique si desea proseguir de todas formas ...';


     RsPygMsg1  = 'No consigo abrir el fichero de configuracion.';
     RsPygMsg2  = 'Por algún motivo el fichero [%s] no es accesible. Revise su instalación';
     RsPygMsg3  = 'CUENTA DE PERDIDAS Y GANANCIAS';
     RsPygMsg4  = 'La cabecera del fichero de configuracion es incorrecta.';
     RsPygMsg5  = 'Si ha modificado el fichero CPG_2008.RCF ó CPGA_2008.RCF, revíselo.';
     //..
     RsPygMsg8  = 'Total';

     RsBsiMsg1  = 'No consigo abrir el fichero de configuracion.';
     RsBsiMsg2  = 'Por algún motivo el fichero [%s] no es accesible. Revise su instalación';
     RsBsiMsg3  = 'BALANCE DE SITUACION';
     RsBsiMsg4  = 'La cabecera del fichero de configuracion es incorrecta.';
     RsBsiMsg5  = 'Si ha modificado el fichero CBS_2008.RCF ó CBSA_2008.RCF, revíselo.';
     RsBsiMsg6  = 'ACTIVO';
     RsBsiMsg7  = 'PATRIMONIO NETO Y PASIVO';
     RsBsiMsg8  = 'Total';
     RsBsiMsg9  = 'TOTAL GENERAL';

function Saldos : TSaldosModule;
begin
     CreateDataModule( TSaldosModule, SaldosModule );
     Result := SaldosModule;
end;

procedure TSaldosModule.SaldosModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteINstance( CLSID_SaldosService, ISaldosService, SaldosService );

     DmSaldosFields := TSaldosFields.Create( DmSaldosTable );
     DmExistenciaFields := TExistenciaFields.Create( DmExistenciasTable );

     SaldoPeriodoEvent := SaldoPeriodoReport;
end;

procedure TSaldosModule.SaldosModuleDestroy(Sender: TObject);
begin
     SaldosModule := nil;
     SaldoPeriodoEvent := nil;
end;

{ Esta función está tanto en el servidor como en el cliente. La duplicidad es necesaria porque en los casos en que se utiliza (importaciones)
  no se puede garantizar el uso de transacciones en ambos lados porque las sesiones son distintas }

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

          var StId := EnterpriseDataModule.StartTransaction( [ DmSaldosTable ], False );

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

                For Nivel := 1 to Cuenta.NivelSubcuenta do
                  begin

                  If   Nivel=Cuenta.NivelSubcuenta
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

            EnterpriseDataModule.Commit( StId );

          except
            EnterpriseDataModule.Rollback( StId );
            raise;
            end;

          end;
end;

procedure TSaldosModule.SaldosBalanceSituacion( BalanceTable         : TnxeTable;
                                                Ejercicio            : SmallInt;
                                                PeriodoInicial,
                                                PeriodoFinal         : Byte;
                                                DesglosarCuentas     : Boolean = False;
                                                SaldosFinales        : Boolean = False;
                                                ModeloAbreviado      : Boolean = False;
                                                Comparativo          : Boolean = False );

var Index  : SmallInt;
    BalanceFields : TBalanceFields;

procedure InsertaRegistro( Tipo        : TTipoRegiStro;
                           Nivel       : SmallInt;
                           Codigo,
                           Cuenta,
                           Descripcion : String;
                           Debe,
                           Haber       : Decimal );
begin
     BalanceTable.Append;

     BalanceFields.Tipo.Value := Ord( Tipo );
     BalanceFields.Nivel.Value := Nivel;
     BalanceFields.Codigo.Value := Codigo;
     BalanceFields.Cuenta.Value := Cuenta;
     BalanceFields.Descripcion.Value := Descripcion;
     BalanceFields.Debe.Value := Debe;
     BalanceFields.Haber.Value := Haber;

     BalanceTable.Post;

     ApplicationContainer.ShowProgression;
end;

procedure AbreFicheroConfiguracion;

Var NombreFichero,
    Path : String;

begin

     If   ModeloAbreviado
     then NombreFichero := 'CBSA_2008.RCF'
     else NombreFichero := 'CBS_2008.RCF';

     ConfigTextList := nil;
     Path := ReportManagerDataModule.GetReportLocation( NombreFichero, CodigoEmpresaActual, dtReportSchema );

     ConfigTextList := TStringList.Create;
     try
       ConfigTextList.LoadFromFile( Path );
       // Si el fichero no es UTF8, se guarda con esa codificación
       If   ConfigTextList.Encoding<>TEncoding.UTF8
       then ConfigTextList.SaveToFile( Path, TEncoding.UTF8 );
     except
       ShowNotification( ntError, RsBsiMsg1, Format( RsBsiMsg2, [ Path ] ) );
       Abort;
       end;

     If   ConfigTextList.Strings[ 0 ]<>RsBsiMsg3
     then begin
          ShowNotification( ntError, RsBsiMsg4, RsBsiMsg5 );
          Abort;
          end
     else NroLineaFichero := 1;

     FicheroAbierto := True;
end;

function ObtenSaldoPyG( Ejerc : SmallInt ) : Decimal;

var   SaldoAcumulado,
      SaldoExistInicial,
      SaldoExistFinal,
      SaldoExistencias : Decimal;
      NroCuentaExistencias,
      NroCuenta : SmallInt;
      SubgrupoExistencias : String;

const CuentaVariacion      : array[ 1..20 ] of String[ 2 ] = ( '60', '61', '62', '63', '64', '65', '66', '67', '68', '69',
                                                               '70', '71', '72', '73', '74', '75', '76', '77', '78', '79' );

begin

    //* 23.08.2005  Incluido el tratamiento del nuevo parámetro 'NoUsarExistencias' que permite
    //              extraer los Saldos de existencias de la contabilidad y no del Fichero de existencias

    SaldoAcumulado    := 0.0;
    SaldoExistInicial := 0.0;
    SaldoExistFinal   := 0.0;

    For NroCuenta := 1 to 20 do
      If   not( not DataModule00.DmEmpresaFields.Contable_NoUsarExistencias.Value and ( ( CuentaVariacion[ NroCuenta ]='61' ) or ( CuentaVariacion[ NroCuenta ]='71' ) ) )
      then case Ejerc of
             1 : DecAdd( SaldoAcumulado, -Saldos.SaldoPeriodo( CuentaVariacion[ NroCuenta ], '', True, Ejercicio, PeriodoInicial, PeriodoFinal, True ).Saldo );
             2 : DecAdd( SaldoAcumulado, -Saldos.SaldoPeriodo( CuentaVariacion[ NroCuenta ], '', True, Ejercicio - 1, PeriodoInicial, MesFinalAnterior, True ).Saldo );
             end;

    //*  21.01.2003 Modificado para no incluir en el cálculo de las perdidas y ganancias las variaciones de 39-provisiones , puesto que ya se han considerado
    //              al incluir los movimientos de las Cuentas del grupo 69 (arriba).

    If   DataModule00.DmEmpresaFields.Contable_NoUsarExistencias.Value
    then SaldoExistencias := 0.0
    else begin

         case Ejerc of
           1 : With DmExistenciasTable do
                 try
                   SetRange( [ Ejercicio, '', Null ] , [ Ejercicio, HighStrCode, HighStrCode ] );
                   First;
                   While not Eof  do
                     begin
                     SubgrupoExistencias := Copy( DmExistenciaFields.Codigo.Value, 1, 2 );
                     If   ( SubgrupoExistencias>='30' ) and
                          ( SubgrupoExistencias<='36' )
                     then begin
                          DecAdd( SaldoExistInicial, DmExistenciaFields.Saldo[ MesInicialExistencias ].Value );
                          DecAdd( SaldoExistFinal, DmExistenciaFields.Saldo[ MesFinalExistencias ].Value );
                          end;
                     Next;
                     end;
                 finally
                   CancelRange;
                   end;

           2 : With DmExistenciasTable do
                 try
                   SetRange( [ Ejercicio - 1, '', Null ] , [ Ejercicio - 1, HighStrCode, HighStrCode ] );
                   First;
                   While not Eof  do
                     begin
                     SubgrupoExistencias := Copy( DmExistenciaFields.Codigo.Value, 1, 2 );
                     If   ( SubgrupoExistencias>='30' ) and
                          ( SubgrupoExistencias<='36' )
                     then begin
                          DecAdd( SaldoExistInicial, DmExistenciaFields.Saldo[ MesInicialExistencias  ].Value );
                          DecAdd( SaldoExistFinal, DmExistenciaFields.Saldo[ MesFinalExistAnterior ].Value );
                          end;
                     next;
                     end;
                 finally
                   CancelRange;
                   end;
           end;
         SaldoExistencias := SaldoExistFinal - SaldoExistInicial;
         end;

    Result := SaldoAcumulado + SaldoExistencias;

end;

procedure CompruebaExcepciones;
begin
     If   ( Copy( CodigoCuenta, 1, 3 )='551' ) or
          ( Copy( CodigoCuenta, 1, 3 )='552' )
     then begin
          If   Saldo[ 1 ]<0.0
          then Saldo[ 1 ] := 0.0;
          If   Saldo[ 2 ]<0.0
          then Saldo[ 2 ] := 0.0;
          end
     else If   CodigoCuenta='129'
          then begin
               DecAdd( Saldo[ 1 ], ObtenSaldoPyG( 1 ) );
               DecAdd( Saldo[ 2 ], ObtenSaldoPyG( 2 ) );
               end;
end;

procedure SaldoCuentas( var UnSaldoTitulo   : TListaSaldos;
                            MostrarDesglose : boolean );

var   Index : integer;
      SubGrupo : String;

begin
     NroCuenta   := 1;

     For Index := 1 to 2 do
       UnSaldoTitulo[ Index ] := 0.0;

     While NroCuenta<=UltimoNroCuenta do
       begin

       CodigoCuenta := ListaCuenta[ NroCuenta ];
       Saldo[ 1 ] := 0.0;
       Saldo[ 2 ] := 0.0;

       case Seccion of
         sbActivo : begin

                    //* 21.01.2003 Más consecuencias del ajuste en el tratamiento de las existencias

                    SubGrupo := Copy( CodigoCuenta, 1, 2 );
                    If   not DataModule00.DmEmpresaFields.Contable_NoUsarExistencias.Value and ( SubGrupo>='30' ) and ( SubGrupo<='36' )
                    then begin

                         { las existencias del ejercicio n }

                         var Len := Length( ListaCuenta[ NroCuenta ] );
                         With DmExistenciasTable do
                           begin
                           FindGreaterOrEqual( [ Ejercicio, CodigoCuenta ] );
                           While not Eof and
                                     ( DmExistenciaFields.Ejercicio.Value=Ejercicio ) and
                                     ( Copy( DmExistenciaFields.Codigo.Value, 1, Len )=ListaCuenta[ NroCuenta ] ) do
                             begin
                             DecAdd( UnSaldoTitulo[ 1 ], DmExistenciaFields.Saldo[ MesFinalExistencias ].Value );
                             Next;
                             end;
                           end;

                         { las existencias del ejercicio n - 1 }

                         Len := Length( ListaCuenta[ NroCuenta ] );
                         With DmExistenciasTable do
                           begin
                           FindGreaterOrEqual( [ Ejercicio - 1, CodigoCuenta ] );
                           While not Eof and
                                     ( DmExistenciaFields.Ejercicio.Value=Ejercicio - 1 ) and
                                     ( Copy( DmExistenciaFields.Codigo.Value, 1, len )=ListaCuenta[ NroCuenta ] ) do
                             begin
                             DecAdd( UnSaldoTitulo[ 2 ], DmExistenciaFields.Saldo[  MesFinalExistAnterior ].Value );
                             Next;
                             end;
                           end;

                         end
                    else begin

                         Saldo[ 1 ] := 0.0;
                         Saldo[ 2 ] := 0.0;

                         { los Saldos del ejercicio n }

                         DecAdd( Saldo[ 1 ], Saldos.SaldoPeriodo( CodigoCuenta, '', True, Ejercicio, PeriodoInicial, PeriodoFinal, True ).Saldo );

                         { los Saldos del ejercicio n-1 }

                         DecAdd( Saldo[ 2 ], Saldos.SaldoPeriodo( CodigoCuenta, '', True, Ejercicio - 1, PeriodoInicial, MesFinalAnterior, True ).Saldo );

                         CompruebaExcepciones;

                         DecAdd( UnSaldoTitulo[ 1 ], Saldo[ 1 ] );
                         DecAdd( UnSaldoTitulo[ 2 ], Saldo[ 2 ] );

                         end;
                    end;

         sbPasivo : begin

                    Saldo[ 1 ] := 0.0;
                    Saldo[ 2 ] := 0.0;

                    { los Saldos del ejercicio n }

                    DecAdd( Saldo[ 1 ], -Saldos.SaldoPeriodo( CodigoCuenta, '', True, Ejercicio, PeriodoInicial, PeriodoFinal, True ).Saldo );

                    { los Saldos del ejercicio n - 1 }

                    DecAdd( Saldo[ 2 ], -Saldos.SaldoPeriodo( CodigoCuenta, '', True, Ejercicio - 1, PeriodoInicial, MesFinalAnterior, True ).Saldo );

                    CompruebaExcepciones;

                    DecAdd( UnSaldoTitulo[ 1 ], Saldo[ 1 ] );
                    DecAdd( UnSaldoTitulo[ 2 ], Saldo[ 2 ] );

                    end;

         end;

       If   MostrarDesglose and ( ( Saldo[ 1 ]<>0.0 ) or ( Saldo[ 2 ]<>0.0 ) )
       then InsertaRegistro( trDesglose, 0, CodigoCuenta, CodigoCuenta, Cuenta.Descripcion( CodigoCuenta, False, True ), Saldo[ 1 ], Saldo[ 2 ] );

       Inc( NroCuenta );
       end;

end;

begin

     BalanceTable.DeleteRecords;
     BalanceFields := TBalanceFields.Create( BalanceTable );

     ApplicationContainer.StartProgression( 30 );

     try

       AbreFicheroConfiguracion;

       try

         For Index := 1 to 2 do
           begin
           Saldo[ Index ]       := 0.0;
           SaldoActivo[ Index ] := 0.0;
           SaldoPasivo[ Index ] := 0.0;
           SaldoTitulo[ Index ] := 0.0;
           TotalGrupo[ Index ]  := 0.0;
           SaldoVacio[ Index ]  := 0.0;
           end;

         For Index := 1 to 3 do
           ImprimirNivel[ Index ] := False;

         If   PeriodoInicial=0
         then MesInicialExistencias := 0
         else If   PeriodoInicial>12
              then MesInicialExistencias := 12
              else MesInicialExistencias := PeriodoInicial - 1;

         If   PeriodoFinal>12
         then MesFinalExistencias := 12
         else MesFinalExistencias := PeriodoFinal;

         If   SaldosFinales
         then begin
              MesFinalAnterior := 12;
              MesFinalExistAnterior := 12;
              end
         else begin
              MesFinalAnterior := PeriodoFinal;
              MesFinalExistAnterior := MesFinalExistencias;
              end;

         Linea := ConfigTextList.Strings[ NroLineaFichero ];
         Inc( NroLineaFichero );

         While NroLineaFichero<ConfigTextList.Count do
           begin

           If   ( Copy( Linea, 1, 1 )<>';' ) and     { es un comentario }
                ( Linea<>'' )
           then begin

                For Index := 1 to 2 do SaldoTitulo[ Index ] := 0.0;

                If   ( Linea=RsBsiMsg6 ) or ( Linea=RsBsiMsg7 )
                then begin

                     TextoCabecera := Linea;

                     If   TextoCabecera=RsBsiMsg7
                     then begin

                          InsertaRegistro( trTotalGeneral, Nivel, 'A', '', RsBsiMsg9, SaldoActivo[ 1 ], SaldoActivo[ 2 ] );

                          For Index := 1 to 2 do
                            begin
                            SaldoPasivo[ Index ] := 0.0;
                            TotalGrupo[ Index ]  := 0.0;
                            end;

                          Seccion := sbPasivo;
                          end
                     else Seccion := sbActivo;

                     InsertaRegistro( trCabecera, 0, '', '', TextoCabecera, 0.0, 0.0 );
                     end
                else begin

                     var Ch := #0;
                     If   Length( Linea )>1
                     then Ch := Linea[ 1 ];

                     Nivel := 4;
                     If   Ch in [ '1'..'3' ]   { Indica que es un Nivel }
                     then Nivel := StrToIntDef( Copy( Linea, 1, 1 ), 4 );
                     Delete( Linea, 1, 1 );

                     St := '';
                     If   Copy( Linea, 1, 1 )='<'
                     then begin
                          I := Pos( '>', Linea );
                          If   I in [ 3..6 ]
                          then begin
                               St := Copy( Linea, 2, I - 2 );
                               Delete( Linea, 1, I );
                               end;
                          end;

                     CodigoNivel[ Nivel ] := St;

                     IndDescripcion := Pos( '=', Linea );

                     If   IndDescripcion<=2
                     then TextoNivel[ Nivel ] := Copy( Linea, 2, 70 )
                     else TextoNivel[ Nivel ] := TrimRight( Copy( Linea, 2, IndDescripcion - 4 ) );

                     TextoNivel[ Nivel ] := TrimLeft( TextoNivel[ Nivel ] );
                     ImprimirNivel[ Nivel ] := True;

                     If   IndDescripcion<>0
                     then begin

                          Delete( Linea, 1, Succ( IndDescripcion ) );
                          Cuentas := Linea;
                          NroCuenta := 0;
                          While ( Cuentas<>'' ) and ( NroCuenta<NroMaximoCuentas ) do
                            begin
                            Inc( NroCuenta );
                            Index := Pos( ',', Cuentas );
                            If   Index=0
                            then Index := Succ( Length( Cuentas ) );
                            ListaCuenta[ NroCuenta ] := Copy( Cuentas, 1, Index - 1 );
                            Delete( Cuentas, 1, Index );
                            end;

                          UltimoNroCuenta := NroCuenta;

                          SaldoCuentas( SaldoTitulo, False );
                          end;

                     end;

                If   ( SaldoTitulo[ 1 ]<>0.0 ) or
                     ( SaldoTitulo[ 2 ]<>0.0 )
                then begin

                     case Seccion of
                       sbActivo :
                         For Index := 1 to 2 do
                           DecAdd( SaldoActivo[ Index ], SaldoTitulo[ Index ] );
                       sbPasivo :
                         For Index := 1 to 2 do
                           DecAdd( SaldoPasivo[ Index ],  SaldoTitulo[ Index ] );
                       end;

                     For Index := 1 to 2 do
                       DecAdd( TotalGrupo[ Index ],  SaldoTitulo[ Index ] );

                     For Index := 1 to Nivel - 1 do
                       If   ImprimirNivel[ Index ]
                       then begin
                            ImprimirNivel[ Index ] := False;
                            InsertaRegistro( trLinea, Index, '', '', TextoNivel[ Index ], 0.0, 0.0 );
                            end;

                     InsertaRegistro( trLinea, Nivel, CodigoNivel[ Nivel ], '', TextoNivel[ Nivel ], SaldoTitulo[ 1 ], SaldoTitulo[ 2 ] );

                     If   DesglosarCuentas
                     then SaldoCuentas( SaldoVacio, True );

                     end;

                end;

           Linea := ConfigTextList.Strings[ NroLineaFichero ];
           Inc( NroLineaFichero );

           If   ( NroLineaFichero>=ConfigTextList.Count ) or
                ( Copy( Linea, 1, 1 )='1' ) or
                ( Linea=RsBsiMsg7 )
           then If   ( TotalGrupo[ 1 ]<>0.0 ) or
                     ( TotalGrupo[ 2 ]<>0.0 )
                then begin
                     InsertaRegistro( trTotal, 0, CodigoNivel[ 1 ], '', RsBsiMsg8, TotalGrupo[ 1 ], TotalGrupo[ 2 ] );
                     For Index := 1 to 2 do
                       TotalGrupo[ Index ]  := 0.0;
                     end;
           end;

         InsertaRegistro( trTotalGeneral, Nivel, 'P', '', RsBsiMsg9, SaldoPasivo[ 1 ], SaldoPasivo[ 2 ] );

       except on E : Exception do
         begin
         ShowException( E, Self );
         Abort;
         end;
       end;

     finally
       FreeAndNil( ConfigTextList );
       ApplicationContainer.EndProgression;
       end;

end;

procedure TSaldosModule.SaldosPerdidasyGanancias( BalanceTable         : TnxeTable;
                                                  SeleccionCentroCoste : Byte;
                                                  CentroCoste          : String;
                                                  Ejercicio            : SmallInt;
                                                  PeriodoInicial,
                                                  PeriodoFinal         : Byte;
                                                  DesglosarCuentas     : Boolean = False;
                                                  SaldosFinales        : Boolean = False;
                                                  ModeloAbreviado      : Boolean = False );

const DatasetName = 'Balance';

var   CreateSQL : String;
      BalanceFields : TBalanceFields;
      Index,
      IndiceNivel  : SmallInt;

procedure InsertaRegistro( Tipo        : TTipoRegistro;
                           Nivel       : SmallInt;
                           Codigo,
                           Cuenta,
                           Descripcion : String;
                           Debe,
                           Haber       : Decimal );
begin
     BalanceTable.Append;

     BalanceFields.Tipo.Value := Ord( Tipo );
     BalanceFields.Nivel.Value := Nivel;
     BalanceFields.Codigo.Value := Codigo;
     BalanceFields.Cuenta.Value := Cuenta;
     BalanceFields.Descripcion.Value := Descripcion;
     BalanceFields.Debe.Value := Debe;
     BalanceFields.Haber.Value := Haber;

     BalanceTable.Post;

     ApplicationContainer.showProgression;

end;

procedure AbreficheroConfiguracion;

Var Nombrefichero,
    Path          : String;

begin

     If   ModeloAbreviado
     then Nombrefichero := 'CPGA_2008.RCF'
     else Nombrefichero := 'CPG_2008.RCF';

     ConfigTextList := nil;
     Path := ReportManagerDataModule.GetReportLocation( Nombrefichero, CodigoEmpresaActual, dtReportSchema );

     ConfigTextList := TStringList.Create;
     try
       ConfigTextList.LoadFromFile( Path );
       // Si el fichero no es UTF8, se guarda con esa codificación
       If   ConfigTextList.Encoding<>TEncoding.UTF8
       then ConfigTextList.SaveToFile( Path, TEncoding.UTF8 );
     except
       ShowNotification( ntError, RsPygMsg1, Format( RsPygMsg2, [ Path ] ) );
       Abort;
       end;

     If   ConfigTextList.Strings[ 0 ]<>RsPygMsg3
     then begin
          ShowNotification( ntError, RsPygMsg4, RsPygMsg5 );
          Abort;
          end
     else NroLineaFichero := 1;

     FicheroAbierto := True;
end;

procedure InsertavalorPila( var Variable : TVariable );

begin
     If   PunteroPila<=100
     then begin
          PilaVariables[ PunteroPila ].Nombre := Variable.Nombre;
          PilaVariables[ PunteroPila ].Valor[ 1 ] := Variable.Valor[ 1 ];
          PilaVariables[ PunteroPila ].Valor[ 2 ] := Variable.Valor[ 2 ];
          Inc( PunteroPila );
          end;

end;

function ExtraeValorPila( var Variable : TVariable ) : Boolean;

Var  Index  : SmallInt;
     Existe : boolean;

begin

     Variable.Valor[ 1 ] := 0.0;
     Variable.Valor[ 2 ] := 0.0;
     Existe := False;

     Index := PunteroPila - 1;
     repeat
       If   PilaVariables[ Index ].Nombre = Variable.Nombre
       then begin
            Variable.Valor[ 1 ] := PilaVariables[ Index ].Valor[ 1 ];
            Variable.Valor[ 2 ] := PilaVariables[ Index ].Valor[ 2 ];
            Existe := True;
            Index  := 0;
            end
       else Dec( Index );
     until Index<=0;

     Result := Existe;

end;

Procedure CompruebaNivelActivo( NivelActual : SmallInt );

var Index : SmallInt;

begin

     For Index := NivelActual to NivelMaximo do
       If   NivelActivo[ Index ]
       then begin

            If   Variable[ Index ].Nombre<>''
            then InsertavalorPila( Variable[ Index ] );

            Variable[ Index ].Nombre := '';
            Variable[ Index ].Valor [ 1 ] := 0.0;
            Variable[ Index ].Valor [ 2 ] := 0.0;

            NivelActivo[ Index ] := False;

            end;

end;

procedure SaldoCuentas(     Cuentas         : String;
                        var SaldoTitulo     : TListaSaldos;
                            mostrarDesglose : boolean  );

Var   NroCuenta : SmallInt;

Function EsVariacionExistencias : Boolean;


Const Texto61 : array[ 0..2 ] of String[ 2 ] = ( '30', '31', '32' );
      Texto71 : array[ 0..3 ] of String[ 2 ] = ( '33', '34', '35', '36' );


Var   SubgrupoVariacion : String;
      NroOrden : SmallInt;
      I : integer;

begin


     SubgrupoVariacion := Copy( CodigoCuenta, 1, 2 );

     If   ( SubgrupoVariacion='61' ) or
          ( SubgrupoVariacion='71' )
     then begin

          If   Length( CodigoCuenta )=2
          then begin
               If   SubgrupoVariacion='61'
               then begin
                    CodigoExistInicial := '300000000';
                    CodigoExistFinal   := '329999999';
                    end
               else begin
                    CodigoExistInicial := '330000000';
                    CodigoExistFinal   := '369999999';
                    end;
               end
          else begin
               val( Copy( CodigoCuenta, 3, 1 ), NroOrden, I );
               If   SubgrupoVariacion='61'
               then begin
                    If   not NroOrden in [ 0..2 ]
                    then NroOrden := 0;
                    CodigoExistInicial := RightPad( Texto61[ NroOrden ], 9, '0' );
                    CodigoExistFinal := RightPad( Texto61[ NroOrden ], 9, '9' );
                    end
               else begin
                    If   not NroOrden in [ 0..3 ]
                    then NroOrden := 0;
                    CodigoExistInicial := RightPad( Texto71[ NroOrden ], 9, '0' );
                    CodigoExistFinal := RightPad( Texto71[ NroOrden ], 9, '9' );
                    end;

               end;

          SaldoExistInicial := 0.0;
          SaldoExistFinal := 0.0;

          With DmExistenciasTable do
            try
              SetRange( [ Ejercicio, CodigoExistInicial, Null ],
                        [ Ejercicio, CodigoExistFinal,   HighStrCode ] );
              First;
              While not Eof do
                begin
                If   not DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value or
                         ( SeleccionCentroCoste=0 ) or
                         ( DmExistenciaFields.CentroCoste.Value=CentroCoste )
                then begin
                     DecAdd( SaldoExistInicial, DmExistenciaFields.Saldo[ MesInicialExistencias ].Value );
                     DecAdd( SaldoExistFinal,   DmExistenciaFields.Saldo[ MesFinalExistencias ].Value );
                     end;
                Next;
                end;
              finally
                CancelRange;
                end;

          Saldo[ 1 ] := SaldoExistFinal - SaldoExistInicial;

          SaldoExistInicial := 0.0;
          SaldoExistFinal := 0.0;

          With DmExistenciasTable do
            try
              SetRange( [ Ejercicio - 1, CodigoExistInicial, Null ],
                        [ Ejercicio - 1, CodigoExistFinal, HighStrCode ] );
              First;
              While not Eof do
                begin
                If   not DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value or
                         ( SeleccionCentroCoste=0 ) or
                         ( DmExistenciaFields.CentroCoste.Value=CentroCoste )
                then begin
                     DecAdd( SaldoExistInicial, DmExistenciaFields.Saldo[ MesInicialExistencias ].Value );
                     DecAdd( SaldoExistFinal,   DmExistenciaFields.Saldo[ MesFinalExistAnterior ].Value );
                     end;
                Next;
                end;
            finally
              CancelRange;
              end;

          Saldo[ 2 ] := SaldoExistFinal - SaldoExistInicial;

          Result := True;

          end
     else Result := False;

end;


begin

     NroCuenta := 0;
     While Cuentas<>'' do
       begin
       Inc( NroCuenta );
       I := Pos( ',', Cuentas );
       If   I=0
       then I := Succ( Length( Cuentas ) );
       ListaCuenta[ NroCuenta ] := Copy( Cuentas, 1, I - 1 );
       Delete( Cuentas, 1, I );
       end;

     SaldoTitulo[ 1 ] := 0.0;
     SaldoTitulo[ 2 ] := 0.0;

     UltimoNroCuenta := NroCuenta;
     NroCuenta := 1;

     While NroCuenta<=UltimoNroCuenta do
       begin

       CodigoCuenta := ListaCuenta[ NroCuenta ];

       Saldo[ 1 ] := 0.0;
       Saldo[ 2 ] := 0.0;

       If   DataModule00.DmEmpresaFields.Contable_NoUsarExistencias.Value or not EsVariacionExistencias
       then begin
            Saldo[ 1 ] := -Saldos.SaldoPeriodo( CodigoCuenta, CentroCoste, SeleccionCentroCoste=0, Ejercicio,     PeriodoInicial, PeriodoFinal ).Saldo;
            Saldo[ 2 ] := -Saldos.SaldoPeriodo( CodigoCuenta, CentroCoste, SeleccionCentroCoste=0, Ejercicio - 1, PeriodoInicial, MesFinalAnterior ).Saldo;
            end;

       DecAdd( SaldoTitulo[ 1 ], Saldo[ 1 ] );
       DecAdd( SaldoTitulo[ 2 ], Saldo[ 2 ] );

       If   MostrarDesglose and ( ( Saldo[ 1 ]<>0.0 ) or ( Saldo[ 2 ]<>0.0 ) )
       then InsertaRegistro( trDesglose, 0, CodigoCuenta, CodigoCuenta, Cuenta.Descripcion( CodigoCuenta, False, True ), Saldo[ 1 ], Saldo[ 2 ] );

       Inc( NroCuenta );
       end;


end;

procedure CalculoInicial;

Var   I   : integer;

begin

     PunteroPila := 1;

     If   PeriodoInicial=0
     then MesInicialExistencias := 0
     else If   PeriodoInicial>12
          then MesInicialExistencias := 12
          else MesInicialExistencias := PeriodoInicial - 1;

     If   PeriodoFinal>12
     then MesFinalExistencias := 12
     else MesFinalExistencias := PeriodoFinal;

     If   SaldosFinales
     then begin
          MesFinalAnterior := 12;
          MesFinalExistAnterior := 12;
          end
     else begin
          MesFinalAnterior := PeriodoFinal;
          MesFinalExistAnterior := MesFinalExistencias;
          end;

     AbreficheroConfiguracion;

     try

       InsertaRegistro( trCabecera, 0, '', '', TextoCabecera, 0.0, 0.0 );

       For I := 1 to NivelMaximo do
         begin
         NivelActivo[ I ] := False;
         Variable[ I ].Nombre  := '';
         Variable[ I ].Valor [ 1 ] := 0.0;
         Variable[ I ].Valor [ 2 ] := 0.0;
         end;

       Linea := ConfigTextList.Strings[ NroLineaFichero ];
       Inc( NroLineaFichero );

       While NroLineaFichero<ConfigTextList.Count do
         begin

         If   Copy( Linea, 1, 1 )<>';'   { es un comentario }
         then begin

              Linea := TrimLeft( Linea );

              If   Linea<>''
              then begin

                   Val( Copy( Linea, 1, 1 ), Nivel, I );
                   If   Nivel in [ 1..NivelMaximo - 1 ]
                   then Delete( Linea, 1, 1 )
                   else Nivel := NivelMaximo;

                   CompruebaNivelActivo( Nivel );

                   St := '';
                   If   Copy( Linea, 1, 1 )='<'
                   then begin
                        I := Pos( '>', Linea );
                        If   I in [ 3..6 ]
                        then begin
                             St := Copy( Linea, 2, I - 2 );
                             Delete( Linea, 1, I );
                             end;
                        end;

                   Variable[ Nivel ].Nombre := St;

                   I := Pos( '=', Linea );

                   If   I<>0
                   then begin

                        Delete( Linea, 1, Succ( I ) );

                        Linea := TrimLeft( Linea );

                        SaldoCuentas( Linea, SaldoTitulo, False );

                        If   ( SaldoTitulo[ 1 ]<>0.0 ) or
                             ( SaldoTitulo[ 2 ]<>0.0 ) or
                             ( Variable[ Nivel ].Nombre<>'' )
                        then begin
                             NivelActivo[ Nivel ] := True;
                             For I := 1 to NivelMaximo do
                               If   NivelActivo[ I ]
                               then begin
                                    DecAdd( Variable[ I ].Valor[ 1 ], SaldoTitulo[ 1 ] );
                                    DecAdd( Variable[ I ].Valor[ 2 ], SaldoTitulo[ 2 ] );
                                    end;
                             end;
                        end
                   else NivelActivo[ Nivel ] := True;

                   end;

              end;

         Linea := ConfigTextList.Strings[ NroLineaFichero ];
         Inc( NroLineaFichero );

         end;

       CompruebaNivelActivo( 1 );

     except on E : Exception do
       ShowException( E, Self );
       end;

end;

Procedure CalculoNivel( Nivel : SmallInt );

Var   NroLinea,
      I : Integer;

begin

     try
       NroLinea := 1;

       Linea := ConfigTextList.Strings[ NroLinea ];
       Inc( NroLinea );

       While NroLinea<ConfigTextList.Count do
         begin

         Linea := TrimRight( Linea );

         If   ( ( Copy( Linea, Length( Linea ), 1 )='>' ) and ( Nivel=1 )           ) or
              ( ( Copy( Linea, Length( Linea ), 1 )=')' ) and ( Nivel in [ 2, 3 ] ) )

         then begin

              Delete( Linea, 1, 1 );
              St := '';
              I  := Pos( '>', Linea );
              If   I in [ 3..6 ]
              then begin

                   St := Copy( Linea, 2, I - 2 );
                   Delete( Linea, 1, I );

                   VariableTmp.Nombre := St;

                   I := Pos( '=', Linea );
                   Delete( Linea, 1, I );

                   Linea := TrimLeft( Linea );

                   If   Copy( Linea, 1, 1 )='('
                   then Delete( Linea, 1, 1 );

                   If   Copy( Linea, 1, 1 )='<'
                   then begin

                        For I := 1 to 2 do
                          SaldoTitulo[ I ] := 0.0;

                        Operacion := '';
                        Error := False;

                        repeat
                          If   Copy( Linea, 1, 1 )='<'
                          then begin
                               I := Pos( '>', Linea );
                               If   I in [ 3..6 ]
                               then begin

                                    Variable[ 1 ].Nombre := Copy( Linea, 2, I - 2 );
                                    Delete( Linea, 1, I );

                                    Existe := ExtraeValorPila( Variable[ 1 ] );

                                    If     ( Nivel=1 ) or ( ( Nivel in [ 2, 3 ] ) and ( Existe ) )
                                    then begin

                                         If   Operacion='-'
                                         then begin
                                              DecAdd( SaldoTitulo[ 1 ], -Variable[ 1 ].Valor[ 1 ] );
                                              DecAdd( SaldoTitulo[ 2 ], -Variable[ 1 ].Valor[ 2 ] );
                                              end
                                         else begin
                                              DecAdd( SaldoTitulo[ 1 ],  Variable[ 1 ].Valor[ 1 ] );
                                              DecAdd( SaldoTitulo[ 2 ],  Variable[ 1 ].Valor[ 2 ] );
                                              end;

                                         Operacion := Copy( Linea, 1, 1 );
                                         Delete( Linea, 1, 1 );

                                         end
                                    else Error := True;
                                    end
                               else Error := True;
                               end
                          else Error := True;
                        until Error or ( Linea='' );

                        If   not Error
                        then begin

                             VariableTmp.Valor[ 1 ] := SaldoTitulo[ 1 ];
                             VariableTmp.Valor[ 2 ] := SaldoTitulo[ 2 ];

                             InsertavalorPila( VariableTmp );

                             end;

                        end;

                   end;

              end;

         Linea := ConfigTextList.Strings[ NroLinea ];
         Inc( NroLinea );
         end;

     except on E : Exception do ShowException( E, Self );
       end;

end;

begin

     BalanceTable.DeleteRecords;
     BalanceFields := TBalanceFields.Create( BalanceTable );

     ApplicationContainer.StartProgression( 30 );

     try

       CalculoInicial;

       For IndiceNivel := 1 to 3 do
         CalculoNivel( IndiceNivel );

       NroLineaFichero := 1;

       try

         For Index := 1 to 2 do
           begin
           Saldo[ Index ] := 0.0;
           SaldoDebe[ Index ] := 0.0;
           SaldoHaber[ Index ] := 0.0;
           SaldoTitulo[ Index ] := 0.0;
           TotalGrupo[ Index ] := 0.0;
           SaldoVacio[ Index ] := 0.0;
           end;

         For Index := 1 to 3 do
           ImprimirNivel[ Index ] := False;

         Linea := ConfigTextList.Strings[ NroLineaFichero ];
         Inc( NroLineaFichero );

         While NroLineaFichero<ConfigTextList.Count do
           begin

              If   Copy( Linea, 1, 1 )<>';'   { es un comentario }
              then begin

                   For Index := 1 to 2 do
                     SaldoTitulo[ Index ] := 0.0;

                   Nivel := StrToIntDef( Copy( Linea, 1, 1 ), 4 );

                   If   Nivel in [ 1..NivelMaximo - 1 ]
                   then Delete( Linea, 1, 1 )
                   else Nivel := NivelMaximo;

                   St := '';
                   If   Copy( Linea, 1, 1 )='<'
                   then begin
                        Index := Pos( '>', Linea );
                        If   Index in [ 3..6 ]
                        then begin
                             St := Copy( Linea, 2, Index - 2 );
                             Delete( Linea, 1, Index );
                             end;
                        end;

                   VariableTmp.Nombre := St;

                   Linea := TrimLeft( Linea );

                   Index := Pos( '=', Linea );

                   If   Index<=3
                   then begin
                        TextoNivel[ Nivel ] := Copy( Linea, 1, 70 );
                        ImprimirNivel[ Nivel ] := True;
                        end
                   else TextoNivel[ Nivel ] := TrimRight( Copy( Linea, 1, Index - 1 ) );

                   TextoNivel[ Nivel ] := TrimLeft( TrimRight( TextoNivel[ Nivel ] ) );
                   CodigoVariableNivel[ Nivel ] := VariableTmp.Nombre;

                   If   Index<>0
                   then begin

                        Delete( Linea, 1, Succ( Index ) );

                        For Index := 1 to 2 do
                          SaldoTitulo[ Index ] := 0.0;

                        Linea := TrimLeft( Linea );

                        If   ( Copy( Linea, 1, 1 )='<' ) or
                             ( Copy( Linea, 1, 1 )='(' )
                        then begin

                             If   ExtraeValorPila( VariableTmp )
                             then begin
                                  SaldoTitulo[ 1 ] := VariableTmp.Valor[ 1 ];
                                  SaldoTitulo[ 2 ] := VariableTmp.Valor[ 2 ];
                                  end;

                             end
                        else SaldoCuentas( Linea, SaldoTitulo, False );

                        end;

                   end;


              If   ( SaldoTitulo[ 1 ]<>0.0 ) or ( SaldoTitulo[ 2 ]<>0.0 )
              then begin

                   For Index := 1 to 2 do
                     DecAdd( SaldoHaber[ Index ], SaldoTitulo[ Index ] );

                   For Index := 1 to 2 do
                     DecAdd( TotalGrupo[ Index ], SaldoTitulo[ Index ] );

                   If   Nivel<>1
                   then begin
                        For Index := 1 to Nivel - 1 do
                          If   ImprimirNivel[ Index ]
                          then begin
                               ImprimirNivel[ Index ] := False;
                               InsertaRegistro( trLinea, Index, '', '', TextoNivel[ Index ], 0.0, 0.0 );
                               end;
                        end;

                   InsertaRegistro( trLinea, Nivel, CodigoVariableNivel[ Nivel ], '', TextoNivel[ Nivel ], SaldoTitulo[ 1 ], SaldoTitulo[ 2 ] );

                   If   DesglosarCuentas
                   then SaldoCuentas( Linea, SaldoVacio, True );

                   ImprimirNivel[ Nivel ] := False;
                   UltimoNivelImpreso := Nivel;

                   end;

              Linea := ConfigTextList.Strings[ NroLineaFichero ];
              Inc( NroLineaFichero );

              If   ( NroLineaFichero>=ConfigTextList.Count ) or
                   ( Copy( Linea, 1, 1 )='1' )
              then If   ( TotalGrupo[ 1 ]<>0.0 ) or ( TotalGrupo[ 2 ]<>0.0 )
                   then begin
                        If   UltimoNivelImpreso<>1
                        then InsertaRegistro( trTotal, 0, '', '', RsPygMsg8, TotalGrupo[ 1 ], TotalGrupo[ 2 ] );
                        For Index := 1 to 2 do
                          TotalGrupo[ Index ]  := 0.0;
                        end;
              end;

       except on E : Exception do
         ShowException( E, Self );
         end;


     finally
       FreeAndNil( ConfigTextList );
       ApplicationContainer.EndProgression;
       end;

end;

function TSaldosModule.SaldoPeriodo ( SubCuenta     : String;
                                      CentroCoste   : String;
                                      TodosLosCC    : Boolean;
                                      Ejercicio     : SmallInt;
                                      MesInicial,
                                      MesFinal      : Byte;
                                      Apertura      : Boolean = False ) : ISumasySaldos;

begin
     Result := SaldosService.SaldoPeriodo( SubCuenta, CentroCoste, TodosLosCC, Ejercicio, MesInicial, MesFinal, Apertura );
end;

function TSaldosModule.SaldoPeriodoReport( SubCuenta      : String;
                                           CentroCoste    : String;
                                           TodosLosCC     : Boolean;
                                           Ejercicio      : Integer;
                                           MesInicial,
                                           MesFinal       : Byte;
                                           Apertura       : Boolean = False ) : Decimal;
begin
     Result := SaldoPeriodo( SubCuenta, CentroCoste, TodosLosCC, Ejercicio, MesInicial, MesFinal, Apertura ).Saldo;
end;

function TSaldosModule.MesAsientoApertura( Ejercicio : SmallInt ) : SmallInt;
begin
     Result := SaldosService.MesAsientoApertura( Ejercicio );
end;

function TSaldosModule.SaldoApertura( Cuenta      : String;
                                      CentroCoste : String;
                                      TodosLosCC  : Boolean;
                                      Ejercicio   : SmallInt;
                                      SoloAsiento : Boolean = False ) : ISumasySaldos;
begin
     Result := SaldosService.SaldoApertura( Cuenta, CentroCoste, TodosLosCC, Ejercicio, SoloAsiento );
end;

function TSaldosModule.SaldoFecha ( Cuenta      : String;
                                    CentroCoste : String;
                                    TodosLosCC  : Boolean;
                                    Fecha       : TDateTime;
                                    NroAsiento  : LongWord  = 0;
                                    NroApunte   : SmallInt = 0;
                                    Incluido    : Boolean  = False ) : ISumasySaldos;
begin
     Result := SaldosService.SaldoFecha( Cuenta, CentroCoste, TodosLosCC, Fecha, NroAsiento, NroApunte, Incluido );
end;

function TSaldosModule.Sumas(     FechaInicial : TDateTime;
                              var SumasySaldos : ISumasySaldos ) : Boolean;
begin
     SumasySaldos := SaldosService.Sumas( FechaInicial );
     If   SumasySaldos.SumaDebeInicial<>SumasySaldos.SumaHaberInicial
     then begin
          Result := ShowNotification( ntQuestion, RsMsg4, RsMsg5 )=mrYes;
          If   not Result
          then Exit;
          end;
     If   SumasySaldos.DebeAcumulado<>SumasySaldos.HaberAcumulado
     then Result := ShowNotification( ntQuestion, RsMsg1, RsMsg2 + RsMsg6 )=mrYes
     else Result := True;
end;

function TSaldosModule.Cuadra( PeriodoInicial : Byte = 0;
                               PeriodoFinal   : Byte = 14 ) : Boolean;
begin
     Result := SaldosService.Cuadra( ApplicationContainer.Ejercicio, PeriodoInicial, PeriodoFinal );
     If   not Result
     then ShowNotification( ntWarning, RsMsg3, RsMsg2 );
end;

procedure TSaldosModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

procedure TSaldosModule.ReconstruyeSaldos( EjercicioInicial,
                                           EjercicioFinal        : SmallInt;
                                           ComprobarCuadre       : Boolean;
                                           LimpiarSaldosApertura : Boolean = True  );
begin
     SaldosService.ReconstruyeSaldos( ApplicationContainer.Ejercicio, EjercicioInicial, EjercicioFinal, ComprobarCuadre, LimpiarSaldosApertura );
end;


procedure Inicializa;
begin
     If   not UpdatingDictionaries and ( CodigoUsuarioActual<>'' )
     then Saldos;
end;

initialization
  AddProcedure( imOnEnterpriseAccess, 0, Inicializa );

end.
