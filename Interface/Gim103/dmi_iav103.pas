{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_iav103;

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
     CLSID_ImportacionAlbaranesVenta103Service : TGuid = '{2D9A1306-B9B3-407D-A012-C6820F5854F7}';

type

    IImportacionAlbaranesVenta103Service = interface( ISessionModule )
     ['{B553736A-BAFC-4218-932D-0BB1D5DD406E}']

      procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IImportacionAlbaranesVenta103Service ) );

end.


