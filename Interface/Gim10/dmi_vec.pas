{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_vec;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const
     CLSID_VerificacionContabilidadService : TGuid = '{114ABB4F-DE55-48C9-B7B5-404A0487B673}';

type

  TTipoProcesoCierre = ( tpcCierreApertura, tpcApertura, tpcTraspaso );

  IVerificacionContabilidadService = interface( ISessionModule )
   ['{1C8CB18D-5423-485A-8105-E904878DD02A}']

    procedure Verificacion( ComprobarRegistrosFactura : Boolean = False );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IVerificacionContabilidadService ) );

end.


