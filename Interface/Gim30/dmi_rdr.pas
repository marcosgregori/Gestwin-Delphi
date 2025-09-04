{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_rdr;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim30Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const
     CLSID_ReconstruccionResultadosService : TGuid = '{DC9C6C0E-4A1D-4B7D-912A-12049D09220C}';

type

    IReconstruccionResultadosService = interface( ISessionModule )
      ['{91B62BF6-D4C9-424A-8553-190AB9223DB0}']

      procedure Reconstruccion( EjercicioInicial, EjercicioFinal : SmallInt; RevisarEstadoTablas, ReasignaNrosRegistro, RecalcularLineas : Boolean; RecalcularFacturados : Boolean = False; RecalcularCosteFacturas : Boolean = False );
      function RecalculaFactura( CodigoCliente, Serie : String; NroFactura : LongInt ) : Boolean;
      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IReconstruccionResultadosService ) );

end.


