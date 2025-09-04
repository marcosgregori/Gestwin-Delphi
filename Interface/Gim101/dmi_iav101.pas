{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_iav101;

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
     CLSID_ImportacionAlbaranesVenta101Service : TGuid = '{DCCA4BD3-4E67-4B0E-B3A0-1949FDDDC300}';

type

    IImportacionAlbaranesVenta101Service = interface( ISessionModule )
     ['{B3B0610C-66E1-47B1-A166-1ADC25B4AA36}']

      procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IImportacionAlbaranesVenta101Service ) );

end.


