{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cnd;

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
     CLSID_ContadoresService : TGuid = '{640D3ED5-AC0F-4CA6-A578-A054B87EC0FF}';

      cnConexiones              = 0;     // Contador de nº de conexiones simultáneas por aplicación
      cnBackupIndex             = 1;     // El contador de copias de seguridad

      cnAsiento                 = 10;
      cnNroRegAsiento           = 11;
      cnPedidoVentas            = 12;
      cnAlbaranVentas           = 13;
      cnFacturaVentas           = 14;
      cnNumeroPago              = 15;
      cnTarea                   = 16;

      cnNroPresentacion349      = 17;

      cnNroHojaCarga            = 18;
      cnMovimientoOperacion     = 19;
      cnMovimientoDocumento     = 20;

      cnUIDArticulo             = 21;
      cnCodigoBarras            = 22;

      cnControlMercancias       = 23;

      cnOrdenFabricacion        = 24;
      cnLanzamiento             = 25;
      cnLoteFabricacion         = 26;

      cnNroPresentacion347      = 27;

      cnNroRegistroPresentacion = 28;

type

    TTipoContador = cnConexiones..cnNroRegistroPresentacion;
     
    IContadoresService = interface( ISessionModule )
      ['{3A9D5CA3-D8F0-4DD4-8E11-477D351D7152}']

      function LimpiaStack : Integer;
      procedure RetiraValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 );
      function Incrementa( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0; ValorInicial : LongInt = 1; ValorMaximo : LongInt = MaxInt ) : LongInt;
      function ExisteValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 ) : Boolean;
      procedure Fija( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String; UnValor : LongInt );

      {

      function CompruebaContador( UnTipoContador : TTipoContador; Forzar : Boolean = False ) : Boolean;
      }
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IContadoresService ) );

end.



