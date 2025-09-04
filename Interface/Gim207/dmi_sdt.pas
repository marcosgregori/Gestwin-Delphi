{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_sdt;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     Gim207Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf;

const

     ncrParametrosTiendaVirtual = 'TiendaVirtual';
     ncrHost = 'Host';
     ncrNombreCategoriaRaiz = 'NombreCategoriaRaiz';
     ncrImagenesExternas = 'ImagenesExternas';
     ncrDirectorioImagenes = 'DirectorioImagenes';
     ncrFormatoImagenes = 'FormatoImagenes';
     ncrNoPublicarArticulosSinImagen = 'NoPublicarArticulosSinImagen';
     ncrNoPublicarArticulosSinPrecio = 'NoPublicarArticulosSinPrecio';
     ncrPublicarArticulosSinExistencias = 'PublicarArticulosSinExistencias';
     ncrNoIncluirPendienteRecibir = 'NoIncluirPendienteRecibir';
     ncrPreciosConDescuentoPrevio = 'PreciosConDescuentoPrevio';
     ncrCamposLibresComoAtributos = 'CamposLibresComoAtributos';
     ncrNombreAtributo1 = 'NombreAtributo1';
     ncrPreciosConIVAIncluido = 'PreciosIVAIncluido';
     ncrPublicarArticulosAlmacenSeleccionado = 'PublicarArticulosAlmacenSeleccionado';
     ncrPublicarClasesComoConfiguraciones = 'PublicarClasesComoConfiguraciones';
     ncrUnidadesSonCajas = 'UnidadesSonCajas';

     // Grupos de clientes

     ncrGrupoNombre = 'GrupoNombre';
     ncrGrupoCodigoTarifa = 'GrupoCodigoTarifa';
     ncrGrupoSerie = 'GrupoSerie';
     ncrGrupoModeloImpositivo = 'GrupoModeloImpositivo';
     ncrGrupoConIVAIncluido = 'GrupoConIVAIncluido';

     ncrCodigoFormaCobro = 'CodigoFormaCobro';
     ncrPlantillaCodigoCliente = 'PlantillaCodigoCliente';
     ncrPreciosPorCliente = 'PreciosPorCliente';
     ncrArticulosPorGrupoCliente = 'ArticulosPorGrupoCliente';

     ncrSeleccionAlmacen = 'SeleccionAlmacen';   // 0 = Todos, 1 = El almacén seleccionado y 2 = El almacén de la ficha del artículo
     ncrCodigoAlmacen = 'CodigoAlmacen';

     // Pedidos

     ncrAplicarPreciosyDtos = 'AplicarPreciosDtosPedido';
     ncrEstadoPedidosADescargar = 'EstadoPedidosADescargar';
     ncrEstadoPedidosEnviados = 'EstadoPedidosEnviados';

     //

     LastCustomerGroupIndex = 59;   // 0..59  (60 grupos)
     LastTaxIndex = 6;

type
     TTipoArticuloTienda = ( tatSimple, tatConfigurable, tatVariacionConfigurable, tatVirtual );

const

     CLSID_SincronizacionTiendaService : TGuid = '{F9A85F7F-827C-44E4-B56E-0CE2B403F547}';

type ISincronizacionTiendaService = interface( ISessionModule )
       ['{B9010A9A-6889-4E73-BB01-C3A529FE66F9}']

       procedure Inicializa( RegistroActualizacionCursorID : TnxCursorID );
       end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( ISincronizacionTiendaService ) );

end.


