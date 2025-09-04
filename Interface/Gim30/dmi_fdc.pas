{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_fdc;

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
     nxsdTypes,

     SessionIntf,

     FacturaComprasIntf,
     ParametrosFacturacionIntf;

const

     CLSID_FacturaComprasService : TGuid = '{F1A0369E-D22C-437F-BD09-7659D976BA84}';

type

    IFacturaComprasService = interface( ISessionModule )
     ['{9D20B73D-5056-42B7-BFC5-BB36366CC5E0}']

      procedure RecalculaFactura( FacturaCompras : IFacturaCompras; ModificarCuotaIVA : Boolean );
      function GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;
      procedure CierreCicloFacturacion( FechaInicial, FechaFinal : TDate; Contabilizar : Boolean );
      procedure RecuperaFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura: String );
      procedure RecalculaAlbaranesFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura  : String );
      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IFacturaComprasService ) );

end.


