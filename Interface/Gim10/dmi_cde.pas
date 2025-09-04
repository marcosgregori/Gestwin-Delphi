{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cde;

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
     CLSID_ConsolidacionEmpresasService : TGuid = '{FD5EA8E5-EC58-46D0-A827-DDFB6007E0E0}';

type

  TTipoProcesoCierre = ( tpcCierreApertura, tpcApertura, tpcTraspaso );

  IConsolidacionEmpresasService = interface( ISessionModule )
    ['{DE9766EA-939E-4877-A87A-B4F06FA825D6}']

    procedure EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IConsolidacionEmpresasService ) );

end.


