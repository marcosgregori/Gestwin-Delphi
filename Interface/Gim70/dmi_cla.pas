{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cla;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const
     CLSID_CalendarioService : TGuid = '{4E6607FD-9BD4-4E94-BE3D-0C3A7121128E}';

     edSinAsignar = -1;
     edEspecial = 0;
     edJornadaCompleta = 1;
     edMediaJornada = 2;
     edJornadaIntensiva = 3;
     edFestivo = 4;

type

    TTipoJornada = edSinAsignar..edFestivo;

    ICalendarioService = interface( ISessionModule )
     ['{E0F9FCA7-E6B7-4121-9C46-C3F438BDCD8E}']

      function  ObtenDisponibilidadFecha( Fecha : TDate; Turno : SmallInt ) : TDuration;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( ICalendarioService ) );
end.



