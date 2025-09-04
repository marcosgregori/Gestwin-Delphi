{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_nda;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxsdTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf,

     Gim30Fields,
     Gim40Fields;

const
     CLSID_AprovisionamientoService : TGuid = '{1CEA3D87-3B11-4CE8-ABDE-5953F7FEDDF2}';

type

    TTipoSeleccionBajoMinimos =  ( tsPedidosCompra = 0, tsTraspasoAlmacenes = 1 );

    IAprovisionamientoService = interface( ISessionModule )
     ['{87BE7623-2909-4336-A365-8AC7A85EDF59}']

      function SeleccionaArticulosBajoMinimos( TipoSeleccion : TTipoSeleccionBajoMinimos; CodigoAlmacenOrigen, CodigoAlmacenDestino : String; ExistenciasVirtuales : Boolean = False; CodigoProveedor : String = ''; TodosLosAlmacenes  : Boolean = False ) : String;
      procedure GeneraPedidosCompra( Serie : String; Fecha : TDate; NombreTabla : String );
      procedure GeneraTraspasoAlmacen( Fecha : TDate; NombreTabla : String );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IAprovisionamientoService ) );

end.



