
unit dm_cla;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxEdit,

  DB, nxDB,

  AppContainer,
  LibUtils,
  AppForms,
  DataManager,

  Gim70Fields,

  dmi_cla;

type

  TCalendarioModule = class(TDataModule)
    DmCalendarioTable: TnxeTable;
    DmTurnoTable: TnxeTable;
    DmCalendarioAuxTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    CalendarioService : ICalendarioService;

    DmCalendarioFields,
    DmCalendarioAuxFields  : TCalendarioFields;
    DmTurnoFields  : TTurnoFields;

  public

    function  ObtenTipoJornadaDefecto( DayOfWeek : Byte ) : TTipoJornada;
    procedure ObtenRegistroFecha( Fecha : TDate; CalendarioFields : TCalendarioFields );
    function  ObtenDisponibilidadFecha( Fecha : TDate; Turno : SmallInt ) : TDuration;

  end;

var CalendarioModule: TCalendarioModule = nil;


function  Calendario : TCalendarioModule;

const   ccCosteHora = 0;
        ccCosteFijoProceso = 1;

implementation

uses DateUtils,
     Variants,
     EnterpriseDataAccess,
     AppManager,
     NexusRpcData,

     Gim00Fields,

     a_pde7;

{$R *.DFM}

resourceString
       RsMsg1  = 'El tipo de jornada [%s] no ha sido definido. No puede calcularse el tiempo disponible.';

const  stTipoJornada : array[ 1..4 ] of string = ( 'Jornada completa',
                                                   'Media jornada',
                                                   'Jornada intensiva',
                                                   'Festivo' );
function Calendario : TCalendarioModule;
begin
     CreateDataModule( TCalendarioModule, CalendarioModule );
     Result := CalendarioModule;
end;

procedure TCalendarioModule.DataModuleDestroy( Sender : TObject );
begin
     CalendarioModule := nil;
end;

procedure TCalendarioModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_CalendarioService, ICalendarioService, CalendarioService );

     DmCalendarioFields := TCalendarioFields.Create( DmCalendarioTable );
     DmCalendarioAuxFields := TCalendarioFields.Create( DmCalendarioAuxTable );
     DmTurnoFields := TTurnoFields.Create( DmTurnoTable );
end;

function  TCalendarioModule.ObtenTipoJornadaDefecto( DayOfWeek : Byte ) : TTipoJornada;
begin

     // DayOfWeek esta comprendido ente 1 y 7. Domingo es el 1 y Sábado el 7

     Result := edJornadaCompleta;

     case DayOfWeek of
          1 : Result := edFestivo;
       2..6 : ;
          7 : case ParametrosProduccionRec.TipoJornadaSabado of
                0 : Result := edFestivo;
                1 : Result := edMediaJornada;
                2 : Result := edJornadaCompleta;
                end;
          end;
end;

procedure TCalendarioModule.ObtenRegistroFecha( Fecha            : TDate;
                                                CalendarioFields : TCalendarioFields );

procedure ObtenTurnos;

var   Index : Byte;

begin
     If   DmCalendarioAuxTable.FindKey( [ DmCalendarioFields.TipoJornada.Value ] )
     then begin
          try
            DmCalendarioTable.Edit;
            For Index := 1 to 4 do
              DmCalendarioFields.Turno[ Index ].Value := DmCalendarioAuxFields.Turno[ Index ].Value;
            DmCalendarioFields.TiempoExterno.Value := DmCalendarioAuxFields.TiempoExterno.Value;
            DmCalendarioTable.Browse;
          except
            DmCalendarioTable.Cancel;
            raise;
            end;
          end
     else begin
          ShowNotification( ntStop, Format( RsMsg1, [ StTipoJornada[ DmCalendarioFields.TipoJornada.Value ] ] ) );
          Abort;
          end;
end;


begin
     If   DmCalendarioTable.FindKey ( [ Fecha ] )
     then begin
          If   DmCalendarioFields.TipoJornada.Value in [ edJornadaCompleta..edFestivo ]
          then ObtenTurnos;
          end
     else begin
          DmCalendarioTable.Append;
          DmCalendarioFields.Fecha.Value := Fecha;
          DmCalendarioFields.TipoJornada.Value := ObtenTipoJornadaDefecto( DayOfWeek( Fecha ) );
          ObtenTurnos;
          DmCalendarioTable.Post;
          end;

     CalendarioFields.Update( DmCalendarioTable );
end;

function  TCalendarioModule.ObtenDisponibilidadFecha( Fecha : TDate;
                                                      Turno : SmallInt ) : TDuration;

begin
     Result := CalendarioService.ObtenDisponibilidadFecha( Fecha, Turno );
end;

end.
