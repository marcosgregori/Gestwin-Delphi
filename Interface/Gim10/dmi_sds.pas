{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_sds;

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
     CLSID_SustitucionSubcuentasService : TGuid = '{25E10CD3-CF0D-4A93-915E-A240249ABEDC}';

type

  TTipoProcesoCierre = ( tpcCierreApertura, tpcApertura, tpcTraspaso );

  ISustitucionSubcuentasService = interface( ISessionModule )
   ['{774772A3-9BCD-4776-A7EB-1F0840743018}']

    procedure EjecutaProceso( SubcuentaActual, SubcuentaNueva : String; TodosLosEjercicios : Boolean = False );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( ISustitucionSubcuentasService ) );

end.


