
unit dm_cla;

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

  dmi_cla;


type

  TCalendarioService = class( TSessionModule, ICalendarioService )
  private

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public
    function  ObtenDisponibilidadFecha( Fecha : TDate; Turno : SmallInt ) : TDuration;
    end;

type
   TCalendarioModule = class(TServerDataModule)
    DmCalendarioTable: TnxeTable;
    DmTurnoTable: TnxeTable;
    DmCalendarioTipoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    private

      DmCalendarioFields,
      DsCalendarioFields,
      DsCalendarioAuxFields,
      DmCalendarioTipoFields : TCalendarioFields;
      DmTurnoFields : TTurnoFields;


    public

     function ObtenTipoJornadaDefecto( DayOfWeek : SmallInt ) : TTipoJornada;
     procedure ObtenTurnos( CalendarioFields : TCalendarioFields );
     procedure ObtenRegistroFecha( UnaFecha : TDate; CalendarioFields : TCalendarioFields );
     function ObtenDisponibilidadFecha( UnaFecha : TDate; UnTurno : SmallInt ) : TDuration;
     function ModificaTipoJornadaFecha( UnaFecha : TDate; NuevoTipoJornada : TTipoJornada ) : TTipoJornada;


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

     dm_odf;

{$R *.DFM}

resourceString
       RsMsg1  = 'El tipo de jornada [%s] no ha sido definido. No puede calcularse el tiempo disponible.';
       RsMsg2  = 'El tiempo externo para el tipo de jornada [%s] no ha sido definido. No puede calcularse el tiempo disponible.';
       RsMsg3  = 'El tipo de jornada [%s] no tiene tiempo externo.';

const  StTipoJornada : array[ 1..4 ] of string = ( 'Jornada completa',
                                                   'Media jornada',
                                                   'Jornada intensiva',
                                                   'Festivo' );

procedure TCalendarioModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmCalendarioFields := TCalendarioFields.Create( DmCalendarioTable );
     DmCalendarioTipoFields :=  TCalendarioFields.Create( DmCalendarioTipoTable );
     DmTurnoFields := TTurnoFields.Create( DmTurnoTable );

     DsCalendarioFields := TCalendarioFields.Create( Self );
     DsCalendarioAuxFields := TCalendarioFields.Create( Self );
end;

procedure TCalendarioModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.CalendarioModule := nil;
end;

function  TCalendarioModule.ObtenTipoJornadaDefecto( DayOfWeek : SmallInt ) : TTipoJornada;
begin

     // DayOfWeek esta comprendido ente 1 y 7. Domingo es el 1 y Sábado el 7

     case DayOfWeek of
          1 : Result := edFestivo;
       2..6 : Result := edJornadaCompleta;
          7 : case SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.TipoJornadaSabado of
                0 : Result := edFestivo;
                1 : Result := edMediaJornada;
                2 : Result := edJornadaCompleta;
                end;
          end;
end;

procedure TCalendarioModule.ObtenTurnos( CalendarioFields : TCalendarioFields );

var  Index : SmallInt;

begin

     // Obteniendo los turnos del calendario tipo

     If   CalendarioFields.TipoJornada.Value in [ edJornadaCompleta..edFestivo ]
     then With DmCalendarioTipoTable do
            If   FindKey( [ EncodeDate( CalendarioFields.TipoJornada.Value + 100, 1, 1 ) ] )  // Calendarios tipo (101, 1, 1), ( 102, 1, 1 ), ( 103, 1, 1 ) ...
            then begin
                 For Index := 1 to 4 do
                   CalendarioFields.Turno[ Index ].Value := DmCalendarioTipoFields.Turno[ Index ].Value;
                 CalendarioFields.TiempoExterno.Value := DmCalendarioTipoFields.TiempoExterno.Value;
                 end
            else begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg1, [ StTipoJornada[ CalendarioFields.TipoJornada.Value ] ] ) );
                 Abort;
                 end;
end;

procedure TCalendarioModule.ObtenRegistroFecha( UnaFecha         : TDate;
                                                CalendarioFields : TCalendarioFields );

begin

     CalendarioFields.Setup( DmCalendarioTable, { StaticData } True );    // Por si no está inicializado
     try
       CalendarioFields.MemDataset.Edit;
       With DmCalendarioTable do
         If   FindKey( [ UnaFecha ] )
         then begin
              CalendarioFields.Update( DmCalendarioTable );
              ObtenTurnos( CalendarioFields );
              end
         else begin
              CalendarioFields.Clear;
              CalendarioFields.Fecha.Value := UnaFecha;
              CalendarioFields.TipoJornada.Value := ObtenTipoJornadaDefecto( DayOfWeek( UnaFecha ) );
              ObtenTurnos( CalendarioFields );
              try
                Append;
                CalendarioFields.CopyMemDatasetFields( DmCalendarioTable );
                Post;
              except
                Cancel;
                raise;
                end;

              end;
       except
         CalendarioFields.MemDataset.Cancel;
         raise;
         end;


end;

function TCalendarioModule.ModificaTipoJornadaFecha( UnaFecha         : TDate;
                                                     NuevoTipoJornada : TTipoJornada ) : TTipoJornada;

var I : SmallInt;

begin

     Result := edSinAsignar;

     With DmCalendarioTable do
       try

         If   FindKey( [ UnaFecha ] )
         then begin
              Edit;
              Result := DmCalendarioFields.TipoJornada.Value;
              end
         else begin
              Append;
              DmCalendarioFields.Fecha.Value := UnaFecha;
              end;

         DmCalendarioFields.TipoJornada.Value := NuevoTipoJornada;
         If   NuevoTipoJornada in [ edJornadaCompleta..edFestivo ]
         then ObtenTurnos( DmCalendarioFields );

         Post;

       except
         Cancel;
         raise;
         end;

end;

{ Los números de Turno están comprendidos entre 1 y 4 }

function  TCalendarioModule.ObtenDisponibilidadFecha( UnaFecha : TDate;
                                                      UnTurno  : SmallInt ) : TDuration;

var   Index  : SmallInt;

      { Si el Turno es 0, se considera que se desea obtener el tiempo externo }

begin

     Result := 0;

     ObtenRegistroFecha( UnaFecha, DsCalendarioFields );

     If   UnTurno=0
     then begin
          If   DsCalendarioFields.TipoJornada.Value<>edFestivo
          then If   DsCalendarioFields.TiempoExterno.Value=0
               then begin
                    SessionDataModule.SendNotification( ntStop, Format( RsMsg3, [ StTipoJornada[ DsCalendarioFields.TipoJornada.Value ] ] ) );
                    Abort;
                    end
               else Result := DsCalendarioFields.TiempoExterno.Value;
          end
     else For Index := 1 to 4 do
            If   DsCalendarioFields.Turno[ Index ].Value=UnTurno
            then If   DmTurnoTable.FindKey( [ DsCalendarioFields.Turno[ Index ].Value ] )
                 then With DmTurnoFields do
                        begin
                        If   ( Fin1.Value=0 ) and ( Inicio2.Value=0 ) and ( Fin2.Value<>0 )  // Un turno entre días
                        then begin
                             ObtenRegistroFecha( IncDay( UnaFecha ), DsCalendarioAuxFields );
                             For Var Inx := 1 to 4 do
                               If   DsCalendarioAuxFields.Turno[ Inx ].Value=UnTurno
                               then Break
                               else If   Inx=4
                                    then Exit; // El día siguiente no está activo el turno

                             // Si se utiliza el valor de Fin1, el procedimiento calcula los segundos entre las 12 de la noche anterior e Inicio1

                             Result := SecondsBetween( Inicio1.Value, EncodeTime( 23, 59, 59, 999 ) ) + 1 +
                                       SecondsBetween( Inicio2.Value, Fin2.Value );

                             end
                        else Result := SecondsBetween( Inicio1.Value, Fin1.Value ) + SecondsBetween( Inicio2.Value, Fin2.Value );
                        Break;
                        end;
end;

{ TCalendarioService }

procedure TCalendarioService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TCalendarioService.ObtenDisponibilidadFecha( Fecha : TDate;
                                                      Turno : SmallInt) : TDuration;
begin
     Result := SessionDataModule.Dm70.CalendarioModule.ObtenDisponibilidadFecha( Fecha , Turno );
end;

var CalendarioControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_CalendarioService, TCalendarioService, CalendarioControl );

end.
