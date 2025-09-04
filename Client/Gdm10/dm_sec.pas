unit dm_sec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,

  AppForms,
  DataManager;

type
  TDatasetOperation = ( dsoCreate, dsoUpdate, dsoClear );
  TUpdateDataEvent = procedure( const NroOrden : SmallInt; const NroMes : SmallInt ) of object;

  TSecuenciaMesModule = class(TDataModule)
    procedure SecuenciaMesModuleDestroy(Sender: TObject);
  private
  public

    FEjercicioPartido : Boolean;
    FMesInicial,
    FMesFinal,

    FEjercicioActual,
    FMesActual : SmallInt;

    FFin : Boolean;

    procedure Reset( Ejercicio, MesInicial, MesFinal : SmallInt; EjercicioPartido : Boolean = True ); overload;
    procedure Reset( MesInicial, MesFinal : SmallInt ); overload;

    function MesValido( NroMes : SmallInt ) : Boolean;
    function FinSecuencia : Boolean;
  end;

var
  SecuenciaMesModule: TSecuenciaMesModule = nil;


function SecuenciaMes : TSecuenciaMesModule;
// procedure IncrementaMes( var Mes : SmallInt ); overload;
procedure ObtenRangoMeses( var NroMesInicial : SmallInt; var NroMesFinal : SmallInt; EjercicioPartido : Boolean = True );
procedure IncrementaMes( var Mes : SmallInt; var Ejercicio : SmallInt; EjercicioPartido : Boolean = True ); // overload;
procedure DecrementaMes( var Mes : SmallInt; var Ejercicio : SmallInt; EjercicioPartido : Boolean = True );
procedure ActualizaRegistrosPeriodo( Data : TgxMemData; DatasetOperation : TDatasetOperation = dsoUpdate; OnUpdateData : TUpdateDataEvent = nil );

function ObtenExpresionRango( MesInicial, MesFinal : SmallInt; Prefijo : String ) : String;
function IndiceMes( Mes : SmallInt ) : SmallInt;

implementation

uses    DateUtils,
        AppManager,
        AppContainer,

        Gim00Fields;

{$R *.DFM}

// Devuelve el índice del mes teniendo en cuenta los ejercicios partidos

function IndiceMes( Mes : SmallInt ) : SmallInt;
begin
     If   ApplicationContainer.NroMesInicial=1
     then Result := Mes
     else If   Mes>=ApplicationContainer.NroMesInicial
          then Result := Mes - ApplicationContainer.NroMesInicial + 1
          else Result := ApplicationContainer.NroMesInicial + Mes - 1;
end;

function SecuenciaMes : TSecuenciaMesModule;
begin
     CreateDataModule( TSecuenciaMesModule, SecuenciaMesModule );
     Result := SecuenciaMesModule;
end;

procedure TSecuenciaMesModule.SecuenciaMesModuleDestroy(Sender: TObject);
begin
     SecuenciaMesModule := nil;
end;

procedure TSecuenciaMesModule.Reset( MesInicial,
                                     MesFinal    : SmallInt );
begin
     Reset( ApplicationContainer.Ejercicio, MesInicial, MesFinal );
end;

procedure TSecuenciaMesModule.Reset( Ejercicio,
                                     MesInicial,
                                     MesFinal         : SmallInt;
                                     EjercicioPartido : Boolean = True );
begin
     FEjercicioPartido := EjercicioPartido;

     FMesInicial := MesInicial;
     FMesFinal := MesFinal;

     FEjercicioActual := Ejercicio;
     FMesActual := MesInicial;

     FFin := False;
end;

function TSecuenciaMesModule.MesValido( NroMes : SmallInt ) : Boolean;
begin
     If   not FEjercicioPartido
     then Result := NroMes in [ FMesInicial..FMesFinal ]
     else If   FMesInicial<ApplicationContainer.NroMesInicial     // Está en el rango 1..NroMesFinal
          then Result := NroMes in [ 1..FMesFinal ]
          else If   FMesFinal<FMesInicial
               then Result := ( NroMes in [ FMesInicial..12 ] ) or ( NroMes in [ 1..FMesFinal ] )
               else Result := NroMes in [ FMesInicial..FMesFinal ]
end;

function TSecuenciaMesModule.FinSecuencia : Boolean;
begin
    Result := FFin;
    If   not Result
    then If   FMesActual<>FMesFinal
         then begin
              IncrementaMes( FMesActual, FEjercicioActual, FEjercicioPartido );
              { ? No incluye el mes final en la secuencia
              If   FMesActual=FMesFinal
              then FFin := True;
              }
              end
         else Result := True;
end;

{
procedure IncrementaMes( var Mes              : SmallInt;
                             EjercicioPartido : Boolean = True );
begin
     Inc( Mes );
     If   Mes=13
     then Mes := 1
     else If   Mes =1
          then Mes := ApplicationContainer.NroMesInicial;
end;
}

procedure ObtenRangoMeses( var NroMesInicial    : SmallInt;
                           var NroMesFinal      : SmallInt;
                               EjercicioPartido : Boolean = True );
begin
     NroMesInicial := 1;
     If   EjercicioPartido
     then NroMesInicial := ApplicationContainer.NroMesInicial;

     NroMesFinal := 12;
     If   EjercicioPartido
     then NroMesFinal := ApplicationContainer.NroMesFinal;
end;

procedure IncrementaMes( var Mes              : SmallInt;
                         var Ejercicio        : SmallInt;
                             EjercicioPartido : Boolean = True );

var NroMesInicial,
    NroMesFinal : SmallInt;

begin
     ObtenRangoMeses( NroMesInicial, NroMesFinal, EjercicioPartido );
     If   Mes=NroMesFinal
     then begin
          Mes := NroMesInicial;
          Inc( Ejercicio );
          end
     else If   EjercicioPartido and ( Mes=12 )
          then Mes := 1  // No se incrementa el ejercicio
          else Inc( Mes );

end;

procedure DecrementaMes( var Mes : SmallInt; var Ejercicio : SmallInt; EjercicioPartido : Boolean = True );

var NroMesInicial,
    NroMesFinal : SmallInt;

begin
     ObtenRangoMeses( NroMesInicial, NroMesFinal, EjercicioPartido );
     If   Mes=NroMesInicial
     then begin
          Mes := NroMesFinal;
          Dec( Ejercicio );
          end
     else If   EjercicioPartido and ( Mes=1 )
          then Mes := 12
          else Dec( Mes );
end;

procedure ActualizaRegistrosPeriodo( Data             : TgxMemData;
                                     DatasetOperation : TDatasetOperation = dsoUpdate;
                                     OnUpdateData     : TUpdateDataEvent = nil );

var  FldIndex, I, J : SmallInt;
     NroPeriodoField,
     TextoPeriodoField,
     AField : TField;
     Correct : Boolean;

begin
     With Data do
       try
         DisableControls;
         Open;

         NroPeriodoField := FindField( 'NroPeriodo' );
         TextoPeriodoField := FindField( 'TextoPeriodo' );

         If   Assigned( NroPeriodoField )
         then begin

              I := ApplicationContainer.NroMesInicial;
              J := 0;
              repeat

                Correct := True;

                If   DatasetOperation=dsoCreate
                then Append
                else begin
                     If   Locate( 'NroPeriodo', I, [] )
                     then Edit
                     else Correct := False;
                     end;

                If   Correct
                then case DatasetOperation of
                       dsoCreate  : begin
                                    NroPeriodoField.Value := I;
                                    If   Assigned( OnUpdateData )
                                    then OnUpdateData( J, I )
                                    else If   Assigned( TextoPeriodoField )
                                         then TextoPeriodoField.AsString := '  ' + StrMonth( I, False );
                                    end;
                       dsoClear   : For FldIndex := 0 to FieldCount - 1 do
                                      begin
                                      AField := Fields[ FldIndex ];
                                      If   ( AField<>RecIdField ) and
                                           ( AField<>NroPeriodoField ) and
                                           ( AField<>TextoPeriodoField )
                                      then AField.Clear;
                                      end;
                       dsoUpdate  : If   Assigned( OnUpdateData )
                                    then OnUpdateData( J, I );
                       end;

                Post;
                Inc( J );
                Inc( I );
                If   I=13
                then I := 1;
              until J=12;

              // Lo dejo en el mes actual (si está asociado a una rejilla se resalta el mes en cuestión)

              Locate( 'NroPeriodo', MonthOf( ApplicationContainer.TodayDate ), [] );

              end;

       finally
         EnableControls;
         end;
end;

function ObtenExpresionRango( MesInicial,
                              MesFinal     : SmallInt;
                              Prefijo      : String ) : String;
begin
     SecuenciaMes.Reset( ApplicationContainer.Ejercicio, MesInicial, MesFinal );
     Result := '';
     With SecuenciaMes do
       repeat
         If   FMesActual<>MesInicial
         then Result := Result + ' + ';
         Result := Result + Prefijo + '_' + StrMonth( FMesActual );
       until FinSecuencia;
end;

end.
