{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_rem;

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

     RemesaIntf;

const
     CLSID_RemesaService : TGuid = '{EF1313DC-36EB-4BA7-8604-00B73C573AB6}';

     // Estados de la Remesa

     erPendiente  = 0;
     erCobrada    = 1;
     erDescontada = 2;
     erCancelada  = 3;
     erAceptada   = 4;

type

  IRemesaService = interface( ISessionModule )
    ['{A056A250-A7E9-44F5-91F4-73C05C07D708}']

    procedure ActualizaRemesa( Remesa: IRemesa );
    procedure SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : LongInt );

    procedure ActualizaAnotacionCobro( Remesa: IRemesa; Concepto : String );
    procedure SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure ActualizaAceptacion( Remesa: IRemesa; Concepto : String );
    procedure SuprimeAceptacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure ActualizaDescuento( Remesa : IRemesa; Concepto : String );
    procedure SuprimeDescuento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure ActualizaCancelacion( Remesa : IRemesa );
    procedure SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure CancelacionAutomatica( Fecha : TDate; MesesAntiguedad : SmallInt );

    function  ObtenConcepto( Ejercicio : SmallInt; NroRemesa : LongInt; TipoAsiento : SmallInt ) : String;
    procedure ImporteRemesa( Ejercicio : SmallInt; NroRemesa : longInt; var Importe : Decimal; var ImporteImpagados : Decimal; var ImporteCancelados : Decimal );
    function UltimoVencimiento( Ejercicio : SmallInt; NroRemesa : longInt ) : TDate;
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IRemesaService ) );

end.


