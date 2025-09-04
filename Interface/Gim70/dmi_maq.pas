{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_maq;

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
     CLSID_MaquinaService : TGuid = '{18263A86-8566-4F93-A350-B68B95379DDF}';

type

    IMaquinaService = interface( ISessionModule )
     ['{1C09B176-0F9C-4817-90A8-E1BAC9ED205C}']

      function HayTareasPendientes( Fecha : TDate ) : Boolean;
      procedure OrdenaSecuenciaTurno( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt; Reordenar : Boolean = False );
      procedure OrdenaSecuenciaOrdenFabricacion( Ejercicio : SmallInt; NroOrden : LongInt );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IMaquinaService ) );
end.



