{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_art;

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

     SessionIntf,

     dmi_mov;

const
     CLSID_ArticuloService : TGuid = '{CA5B85A3-C593-4362-9EE5-1A9FC68ABD3A}';

     ArticuloManual          = '.';
     ArticuloManualProx      = '..';

     // Tipos de registro de consumo

     tcFamilia               = 1;
     tcArticulo              = 2;

     // Tipos de relaciones de tarifas de ventas

     rtvTarifaArticulo       = 0;
     rtvClienteArticulo      = 1;
     rtvTarifaFamilia        = 2;
     rtvClienteFamilia       = 3;

     // Tipos de relaciones de tarifas de compras

     rtcProveedorArticulo    = 0;
     rtcGrupoArticulo        = 1;

     // Tipos de relaciones de la tabla de comisiones

     rtcoVendedorArticulo    = 0;
     rtcoVendedorFamilia     = 1;

     // Tarifas de compras y ventas por código de tarifa o propietario y clase de artículo

     rtclComprasProveedor    = 0;
     rtclVentasCliente       = 1;
     rtclComprasCodigoTarifa = 2;  // No implementado aún
     rtclVentasCodigoTarifa  = 3;

type

    IArticuloService = interface( ISessionModule )
      ['{9DC08D0E-2683-4CC3-8A2E-B280E2C98EA7}']

      procedure ObtenPrecioyDtoCompra(   CodigoProveedor,
                                         CodigoArticulo,
                                         CodigoClaseA,
                                         CodigoClaseB,
                                         CodigoClaseC    : String;
                                         Cantidad        : Decimal;
                                     var Precio          : Double;
                                     var PuntoVerde      : Decimal;
                                     var Descuento       : Decimal;
                                         Inicializar     : Boolean = False;
                                         Fecha           : TDateTime = 0 );

      procedure ObtenPrecioyDtoVenta(     TipoMovimiento  : TTipoMovimiento;
                                          CodigoCliente,
                                          CodigoArticulo,
                                          CodigoClaseA,
                                          CodigoClaseB,
                                          CodigoClaseC    : String;
                                          Cantidad        : Decimal;
                                      var Precio          : Double;
                                      var PuntoVerde      : Decimal;
                                      var Recargo         : Decimal;
                                      var Descuento       : Decimal;
                                      out EsUnaOferta     : Boolean;
                                          CodigoTarifa    : String = '';
                                          Inicializar     : Boolean = False;
                                          Fecha           : TDateTime = 0 );

      procedure ObtenPrecioVentaPorTarifa(     CodigoArticulo,
                                               CodigoFamilia,
                                               CodigoTarifa          : String;
                                           var Cantidad              : Decimal;
                                           var Precio                : Double;
                                           var Recargo               : Decimal;
                                           var Descuento             : Decimal;
                                               ObtenerCantidadMinima : Boolean = False );

      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IArticuloService ) );

end.


