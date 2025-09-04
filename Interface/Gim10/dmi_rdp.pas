{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_rdp;

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
     nxsdTypes,

     SessionIntf,

     RemesaPagoIntf;

const
     CLSID_RemesaPagoService : TGuid = '{131B4029-8645-42F2-B0B8-5D567769C619}';

     // Estados de la remesa

     erpPendiente  = 0;
     erpPagada     = 1;

     // Tipos de orden no normalizadas

     onnPagare               = 1000;
     onnPagosCertificadosBV  = 1001;
     onnPagosFactoringBBV    = 1002;


type

  IRemesaPagoService = interface( ISessionModule )
    ['{F9D91B76-3ED6-4E01-B7E6-287C813E1CB1}']

    procedure ActualizaRemesa( RemesaPago : IRemesaPago );
    procedure SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : LongInt );

    procedure ActualizaAnotacionPago( RemesaPago: IRemesaPago; Concepto : String );
    procedure SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    function  ObtenConceptoAsientoPago( Ejercicio : SmallInt; NroRemesa : LongInt; FechaPago : TDate ) : String;
    function  ImporteRemesa( Ejercicio : SmallInt; NroRemesa : LongInt ) : Decimal;
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IRemesaPagoService ) );

end.


