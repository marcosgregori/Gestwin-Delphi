{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_lmp;

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
     CLSID_ListaMaterialesProcesosService : TGuid = '{1CF62C68-8957-4418-9890-54515785638C}';

type

  IListaMaterialesProcesosService = interface( ISessionModule )
    ['{0B6994C6-B19A-47AB-A256-B70D0D25B198}']

    function Bucle( CodigoBusqueda, CodigoReferencia : String ) : Boolean;
    function TieneRelacion( CodigoArticulo : String; CodigoClaseA, CodigoClaseB, CodigoClaseC : String ) : Boolean;
    function EsComponente( CodigoArticulo : String ) : Boolean;
    end;

implementation

var Control : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IListaMaterialesProcesosService ) );

end.


