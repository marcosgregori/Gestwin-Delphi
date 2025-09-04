{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_sen;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     Gim203Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf;

const

     CLSID_StockEnvasesService : TGuid = '{6052CAE5-0D5C-412A-A488-DEFEA52702D6}';

type IStockEnvasesService = interface( ISessionModule )
       ['{FC9E3267-1B6B-4DE4-B1DB-2E5D444CC594}']

       procedure Inicializa( RegistroActualizacionCursorID : TnxCursorID );
       end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IStockEnvasesService ) );

end.


