unit dm_sdt207;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  System.Generics.Collections,

  LibUtils,
  AppForms,
  AppContainer,

  DB,
  nxdb,

  cxEdit,
  cxEditRepositoryItems,

  dxmdaset,

  clJSON,
  clURIUtils,
  clEncoder,
  clUtils,

  AppManager,
  DataManager,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim207Fields,

  dmi_sdt,
  dmi_sto,

  dm_art,
  dm_rea,
  dm_rea207,
  dm_sto;


type

  TTiposIVATienda = object
    FIVA,
    FRE : Decimal;
    // FCustomerTaxClassIds : array of Integer;
    FProductTaxClassId : Integer;
    end;

  TAtributoClase = object
    CodigoAtributo,
    Nombre : String;
    Id : Integer;
    OptionIds : TStringList;
    end;

  TArticuloEspecial = class
  public
    Codigo : String;
    Agrupado,
    ConRelacionados  : Boolean;

    constructor Create( Codigo : String; Agrupado, ConRelacionados : Boolean );
    end;

  TListaArticulosEspeciales = TList< TArticuloEspecial >;

  TAddProductMediaEvent = procedure( ImageName, ImageDescription, ImageData : String ) of object;

  TSincronizacionTiendaMagentoModule = class(TDataModule)
    DmCategoriaTable: TnxeTable;
    DmArticuloTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmClienteTable: TnxeTable;
    DmClienteQuery: TnxeQuery;
    DmTiposIVATable: TnxeTable;
    DmClienteQueryCodigo: TWideStringField;
    DmClienteQueryEMail: TWideStringField;
    DmClaseTable: TnxeTable;
    DmArticulosRelacionadosTable: TnxeTable;
    DmRegistroActualizacionTable: TnxeTable;
    DmClienteQueryNombre: TWideStringField;
    NivelesCategoriaTable: TnxMemTable;
    CategoriaAuxTable: TnxeTable;
    CategoriaAuxTableCodigo: TWideStringField;
    CategoriaAuxTableCodigoPadre: TWideStringField;
    NivelesCategoriaTableNivel: TSmallintField;
    NivelesCategoriaTableCodigo: TnxStringField;
    DmLineaMovimientoOrigenTable: TnxeTable;
    DmMovimientoOrigenTable: TnxeTable;
    DmClasesArticuloTable: TnxeTable;
    DmRegistroActualizacionAuxTable: TnxeTable;
    Encoder: TclEncoder;
    DmTarifaVentasTable: TnxeTable;
    DmFamiliaTable: TnxeTable;
    DmClaseAuxTable: TnxeTable;
    DmArticuloAuxTable: TnxeTable;
    DmCategoriasArticuloTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    SincronizacionTiendaService : ISincronizacionTiendaService;

    FHTTPResult : Integer;

    DmCategoriaFields : TCategoriaFields;
    DmCategoriasArticuloFields : TCategoriasArticuloFields;
    DmFamiliaFields : TFamiliaFields;
    DmArticuloFields,
    DmArticuloAuxFields : TArticuloFields;
    DmArticulosRelacionadosFields : TArticulosRelacionadosFields;
    DmClasesArticuloFields : TClasesArticuloFields;
    DmClaseFields,
    DmClaseAuxFields : TClaseFields;
    DmRegistroActualizacionFields,
    DmRegistroActualizacionAuxFields : TRegistroActualizacionFields;
    DmMovimientoFields,
    DmMovimientoOrigenFields : TMovimientoFields;
    DmLineaMovimientoFields,
    DmLineaMovimientoOrigenFields : TLineaMovimientoFields;
    DmClienteFields : TClienteFields;
    DmTiposIVAFields : TTiposIVAFields;
    DmTarifaVentasFields : TTarifaVentasFields;

    // FTiposIVATienda : array[ 0..12 ] of TTiposIVATienda;

    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsTiposIVAFields : TTiposIVAFields;
    DsClienteFields : TClienteFields;
    DsGrupoClienteFields : TGrupoClienteFields;
    DsArticuloFields : TArticuloFields;
    // RegistroActualizacionFields : TRegistroActualizacionFields;

    ReinicioTienda,
    ReiniciarAtributos,
    InvalidarAtributos,           // Básicamente, actualizar su contenido sin intentar borrarlos
    HayExistencias : Boolean;

    FListaRegionesEspaña : TStringList;

    IdDefaulftTaxClass : Integer;

    IdCategoriaRaiz,
    IdCategoriaRaizProductos,
    IdCategoriaRaizTarifas : LongInt;

    FechaUltimaActualizacion : TDate;

    ExistenciasArticulo : IExistenciasArticulo;

    FechaFicheroMasReciente,
    FechaFicheroImagen : TDateTime;
    ImageUploaded : Boolean;
    MediaGalleryEntriesArray : TclJSONArray;

    ExisteClaseA,
    ExisteClaseB : Boolean;

    AtributoClaseA,
    AtributoClaseB : TAtributoClase;

    procedure AddStringValueToArray(JSONArray: TclJSONArray; Value: String);
    procedure AddIntegerValueToArray(JSONArray: TclJSONArray; Value: Integer );
    function ProcessExternalImages( ArticuloFields : TArticuloFields; FechaImagenRegistro : TDateTime; OnlyCheckModifications : Boolean = False; OnAddProductMedia : TAddProductMediaEvent = nil ) : Boolean;
    function EncodeDataUrlImage( const AImagesFolder, AFileName : String ) : string;
    function EncodeImage( ImageStream : TMemoryStream ) : String;
    procedure AddProductMedia( ImageFileName, ImageDescription, ImageData : String );

    function ObtenIdProvincia( Nombre : String ) : String;

    function ObtenCodigosArticulos(Filtro, Condicion: String; TamañoPagina, Pagina: SmallInt; ListaArticulos : TListaArticulos; var CodigoPrimerArticulo : String; var UltimaPagina : Boolean ): Boolean;
    function ObtenDatosAtributo( Codigo : String; out AttributeId  : Integer; AttributeOptionIds : TStringList = nil ) : Boolean;

    function ActualizaCategoria( IdCategoriaRaiz : Integer;
                                 CodigoPadre,
                                 Codigo,
                                 Nombre          : String;
                                 Activo          : Boolean = True;
                                 IncluirEnMenu   : Boolean = True ) : Boolean;

    function CreaAtributo( Codigo, Etiqueta : String; out AttributeId : Integer; InputType : String = 'select' ): Boolean;
    function ActualizaOpcionesClaseAtributo( NroClase : SmallInt; AttributeId : Integer; Codigo : String ) : Boolean;
    function BorraAtributo( AttributeId : Integer ): Boolean;
    procedure CompruebaAtributo( Codigo, Etiqueta : String; InputType : String = 'select' );

    function ActualizaArticulo( ArticuloFields            : TArticuloFields;
                                ArticuloAgrupado          : Boolean = False;
                                NoActualizarImagenes      : Boolean = False;
                                TipoArticulo              : TTipoArticuloTienda = tatSimple;
                                ConfigurableProductsLinks : TList<Integer> = nil ): Boolean;
    procedure ObtenCodigosVariantesArticulo( CodigoArticulo : String; ListaArticulos : TListaArticulos );
    function ActualizaArticuloConClases( ArticuloFields :  TArticuloFields; NoActualizarImagenes : Boolean = False ) : Boolean;
    function SuprimeArticuloSimple( Codigo : String; NotificaErrores : Boolean = True ) : Boolean;
    function SuprimeArticulo( Codigo : String ) : Boolean;
    procedure SuprimeArticulos;
    function ExisteArticulo( SKU : String ) : Boolean;
    procedure ObtenAlmacenArticulo( ArticuloFields : TArticuloFields; out TodosLosAlmacenes : Boolean; out CodigoAlmacen : String );
    function ArticuloConPrecio( ArticuloFields : TArticuloFields ) : Boolean;
    function EnlazaArticuloConfigurable( SKUPadre, SKUHijo : String ) : Boolean;
    function ActualizaArticulosRelacionados( ArticuloFields : TArticuloFields ) : Boolean;

    function ActualizaPreciosPorCliente : Boolean;
    function ActualizaDescuentosPorCategoria : Boolean;

    procedure ProcesaMensajeError;
    function ValidSKU(Value: String): Boolean;
    function ObtenPedidosPendientes( out PedidosResponse : TclJSONObject ) : Boolean;
    procedure MarcaPedidosEnviados;
    function MarcarEstadoPedido( IdPedido, NroDocumento : LongInt; NuevoEstado : String = 'processing' ): Boolean;
    function ObtenEnviosPedido( IdPedido : LongInt; out EnviosArray : TclJSONArray ) : Boolean;
    function ObtenGrupoPorId( Id : Integer ) : SmallInt;
    procedure DescargaEnviosNuevos;

    procedure ActualizaConfiguracionGlobal;
    procedure ActualizaArticulos( NoActualizarImagenes : Boolean = False; SoloArticulosRelacionados : Boolean = False );
    procedure ActualizaClientes;
    procedure ActualizaExistencias;

    // function ObtenTiposIVA : Boolean;

    procedure SuprimeExistenciasReservadas( CodigoArticulo : String );
    function ActualizaExistenciasArticulo( CodigoArticulo: String; CantidadMinima, Existencias : Decimal; HayExistencias : Boolean = False ): Boolean;

    function ActualizaCliente(ClienteFields: TClienteFields): Boolean;
    function ObtenClientes( out ClientesArray: TclJSONArray): Boolean;
    function ExisteCliente( Codigo, Nombre, EMail : String; out Id : LongInt; out AddressId1 : LongInt; out AddressId2 : LongInt; out NombreTienda : String; out NIF : String ) : Boolean;
    procedure CreaNuevoClienteGestwin( ClienteObject : TclJSONObject );
    // function EnviaEMailPasswordResetLink( Codigo, EMail : String ) : Boolean;
    function SuprimeCliente( Id : LongInt; Codigo : String ) : Boolean;
    procedure ProcesaNombreCliente( AddressObject : TclJSONObject; Field : TWideStringField );
    procedure DescargaPedidosNuevos;

    function GetDefaultTaxClassId : Integer;
    function EsUnArticuloConRelacionados( Codigo : String ) : Boolean;
    procedure ExtraeClases(var CodigoArticulo : String; var CodigoClaseA : String; var CodigoClaseB : String );

    protected

    public

    ConsultaPedidosArray : TclJSONArray;

    function ObtenArticulo( SKU : String ) : TclJSONObject;

    procedure SincronizaDatos( SoloNuevosPedidos, ActualizarArticulos, NoActualizarImagenes, SoloArticulosRelacionados, ActualizarClientes : Boolean );
  end;

function  SincronizacionTiendaMagento : TSincronizacionTiendaMagentoModule;

const CodigoFechaUltimaActualizacion = 'FUA';
      CodigoConfiguracion = 'CNF';

implementation

uses Variants,

     StrUtils,
     DateUtils,

     Vcl.Imaging.jpeg,
     dxGDIPlusClasses,

     EnterpriseDataAccess,
     SessionDataAccess,
     NexusRpcData,
     RestRpcData,
     TextConvert,

     Gdm00Dm,

     dmi_iva,
     dmi_mov,

     dm_pai,
     dm_prv,
     dm_cat,
     dm_gdc,
     dm_sub,
     dm_sdf,
     dm_iva,
     dm_cli,
     dm_alm,
     dm_mov,
     dm_fdv,
     dm_ptv,
     dm_tvr,
     dm_cls,

     a_usr,

     f_cnf207,
     f_prg;

{$R *.DFM}

resourceString

      RsMsg1  = 'No se ha podido localizar ninguna categoría raiz de nombre "%s".';
      RsMsg2  = 'No se ha podido actualizar el atributo %s, %s.';
      RsMsg3  = 'Se ha obtenido autorización para la conexión remota.';
      RsMsg4  = 'No se ha podido actualizar el artículo %s, %s.';
      RsMsg5  = 'No se ha podido actualizar la categoría %s, %s.';
      RsMsg6  = 'No se ha podido suprimir el artículo %s.';
      RsMsg7  = 'Tiempo de proceso : %s.';
      RsMgs8  = 'El código del artículo %s no es válido en Magento.';
      RsMsg9  = 'No se ha podido cambiar el estado del pedido nº %d.';
      RsMsg10 = 'No se ha podido procesar del pedido con el identificador %d.';
      RsMsg11 = 'Se ha creado el cliente %s, %s.';
      RsMsg12 = 'No se ha podido leer la tabla de tipos de I.V.A. de la tienda virtual.';
      RsMsg13 = 'Actualizando los parámetros generales de la tienda.';
      RsMsg14 = 'No se ha podido localizar el tipo impositivo del artículo %s, %s. No ha sido actualizado en la tienda.';
      RsMsg15 = 'No se han podido actualizar las existencias del artículo %s.';
      RsMsg16 = 'No ha sido actualizado en la tienda.';
      RsMsg17 = 'No se ha podido asignar un grupo al cliente %s, %s. No ha sido actualizado en la tienda.';
      RsMsg18 = 'No se ha podido actualizar el cliente %s, %s.';
      RsMsg19 = 'El cliente %s no ha introducido sus datos de facturación en la tienda. No será dado de alta hasta que los datos sean completados.';
      RsMsg20 = 'El cliente %s, %s no ha indicado su NIF en la tienda. Deberá completar esa información de forma manual en su ficha.';
      RsMsg21 = 'No se ha podido actualizar el tipo de I.V.A. %s. (%s)';
      RsMsg22 = 'No se ha podido actualizar el grupo de cliente %s.';
      RsMsg23 = 'El número de teléfono del cliente %s, %s es un campo obligatorio en la tienda. Introduzca el valor en su ficha y reintente el proceso.';
      RsMsg24 = 'No se ha podido suprimir el cliente %s.';
      RsMsg25 = 'No se le ha podido enviar el mensaje de confirmación de la cuenta al cliente %s.';
      RsMsg26 = 'Existen dos tipos de I.V.A. con la misma descripción : %s.';
      RsMsg27 = 'Magento no permite crear dos tipos de I.V.A. con la misma descripción. Modifique el registro y reintente la operación.';
      RsMsg28 = 'No se ha podido obtener el identificador de la tienda principal.';
      RsMsg29 = 'El N.I.F. del cliente %s, %s es un campo obligatorio en la tienda. Introduzca el valor en su ficha y reintente el proceso.';
      RsMsg30 = 'Se ha creado el pedido nº %s %d realizado en la tienda por el cliente %s, %s.';
      RsMsg31 = ' El cliente %s no tiene asignado el N.I.F. en su ficha de Magento.';
      RsMsg32 = 'No se ha podido comprobar la existencia del cliente con EMail %s (%s - %s).';
      RsMsg33 = 'El pedido con Id #%s del cliente %s no pertenece a este ejercicio. No ha sido procesado.';
      RsMsg34 = 'Compruebe que no haya dos clientes con el mismo EMail. Magento utiliza la dirección de correo como referencia  exclusiva de los clientes.';
      RsMsg35 = 'No se ha podido generar un código automático para un nuevo cliente';
      RsMsg36 = 'No se ha encontrado el pedido %d %s %d en la aplicación. Ha sido dado de baja del registro de sincronización con la tienda.';
      RsMsg37 = 'No se ha podido encontrar el registro de actualización del artículo %s, %s. No se podrá descargar el comentario de la línea.';
      RsMsg38 = 'El pedido %d %s %d ha sido marcado como enviado en la tienda.';
      RsMsg39 = 'No se ha podido localizar la clase de código %s.';
      RsMsg40 = 'No existen atributos definidos para la clase principal en la tienda.';
      RsMsg41 = 'No se ha podido actualizar la opción %s del atributo (clase) %s.';
      RsMsg42 = 'No se ha podido suprimir el precio por cliente con el Id %d.';
      RsMsg43 = 'Se va a reiniciar toda la información de la tienda virtual';
      RsMsg44 = '¿Está seguro de que desea suprimir todos los registros existentes y volver a sincronizar la información?';
      RsMsg45 = 'El artículo %s no tiene ninguna combinación válida de clases disponible. No ha sido actualizado.';
      RsMsg46 = 'El artículo %s no tiene existencias en ninguna de sus variantes. No ha sido creado.';

      RsCategorias = 'Categorías';
      RsSuprimiendoCategorias = 'Suprimiendo categorías';
      RsSuprimiendoClientes = 'Suprimiendo clientes';
      RsArticulos  = 'Artículos';
      RsSuprimiendoArticulos = 'Suprimiendo artículos';
      RsRelacionesArticulos = 'Relaciones de artículos';
      RsBajasArticulos = 'Comprobando bajas de artículos';
      RsExistencias = 'Actualizando existencias';
      RsBajasClientes = 'Comprobando bajas de clientes';
      RsRelacionArticulos = 'Obteniendo la relación de artículos de la tienda';
      RsArticuloEliminado = 'Se ha eliminado el artículo %s de la tienda.';
      RsClienteEliminado = 'Se ha dado de baja al cliente %s de la tienda.';
      RsClienteActualizado = 'Se ha actualizado la ficha del cliente %s (%s) en la tienda.';
      RsDireccionCorreoExistente = 'Ya existe un cliente con la dirección de correo %s (%s). No puede ser dado de alta.';
      RsNoHayNuevosPedidos = 'No hay nuevos pedidos en la tienda pendientes de descarga.';
      RsTarifasCliente = 'Actualizando las tarifas por cliente';
      RsTarifasCategoria = 'Actualizando las tarifas por categoría (familia)';
      RsLimpiandoDatosServidor = 'Limpiando datos del servidor';

      RsClientes = 'Clientes';
      RsTaxClass = ' TaxClass';
      RsTaxRate = ' TaxRate';
      RsTaxRule = 'TaxRule';
      RsRecargosDescuentos = ' Recargos o descuentos adicionales';
      RsDiscountRate = '% Descuento';
      RsPacks = 'Bultos';
      RsVolume = 'Volumen';
      RsUnitsPerBox = 'Unidades por caja';
      RsUnitsPerPallet= 'Unidades por palet';

      RsMsgInterruption = 'Se ha producido una interrupción.';

const Fld_base_shipping_amount = 'base_shipping_amount';
      Fld_default_shipping = 'default_shipping';
      Fld_company = 'company';
      Fld_taxvat = 'taxvat';
      Fld_DiscountRate = 'discount_rate';
      Fld_Packs = 'packs';
      Fld_Volume = 'volume';
      Fld_UnitsPerBox = 'units_per_box';
      Fld_UnitsPerPallet = 'units_per_pallet';

       { Valores permitidos de frontend_input :

         text: A single-line text input field.
         textarea: A multi-line text input field.
         date: A date input field.
         boolean: A yes/no toggle.
         multiselect: A multi-select list.
         select: A drop-down list.
         price: A price input field.
         media_image: An image upload field.
         gallery: A gallery of images.
         weight: A weight input field.
         weee: A field used to apply a Fixed Product Tax (FPT).
         percent: A percentage input field.
         price_validation: A field used to specify a validation rule for a price.

     }

     fitText = 'text';
     fitTextarea = 'textarea';
     fitDate = 'date';
     fitBoolean = 'boolean';
     fitMultiselect = 'multiselect';
     fitSelect = 'select';
     fitPrice = 'price';
     fitMedia_image = 'media_image';
     fitGallery = 'gallery';
     fitWeight = 'weight';
     fitWeee = 'weee';
     fitPercent = 'percent';
     fitPrice_validation = 'price_validation';

     NombreCategoriaRaizTarifas = 'Tarifas';

var  SincronizacionTiendaMagentoModule : TSincronizacionTiendaMagentoModule = nil;

function SincronizacionTiendaMagento : TSincronizacionTiendaMagentoModule;
begin
     CreateDataModule( TSincronizacionTiendaMagentoModule, SincronizacionTiendaMagentoModule );
     Result := SincronizacionTiendaMagentoModule;
end;

procedure TSincronizacionTiendaMagentoModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_SincronizacionTiendaService, ISincronizacionTiendaService, SincronizacionTiendaService );

     DmCategoriaFields := TCategoriaFields.Create( DmCategoriaTable );
     DmCategoriasArticuloFields := TCategoriasArticuloFields.Create( DmCategoriasArticuloTable );
     DmFamiliaFields := TFamiliaFields.Create( DmFamiliaTable );
     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmArticuloAuxFields := TArticuloFields.Create( DmArticuloAuxTable );
     DmArticulosRelacionadosFields := TArticulosRelacionadosFields.Create( DmArticulosRelacionadosTable );
     DmClasesArticuloFields := TClasesArticuloFields.Create( DmClasesArticuloTable );
     DmClaseFields := TClaseFields.Create( DmClaseTable );
     DmClaseAuxFields := TClaseFields.Create( DmClaseAuxTable );
     DmRegistroActualizacionFields := TRegistroActualizacionFields.Create( DmRegistroActualizacionTable );
     DmRegistroActualizacionAuxFields := TRegistroActualizacionFields.Create( DmRegistroActualizacionAuxTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoOrigenFields := TMovimientoFields.Create( DmMovimientoOrigenTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoOrigenFields := TLineaMovimientoFields.Create( DmLineaMovimientoOrigenTable );
     DmClienteFields := TClienteFields.Create( DmClienteTable );
     DmTiposIVAFields := TTiposIVAFields.Create( DmTiposIVATable );
     DmTarifaVentasFields := TTarifaVentasFields.Create( DmTarifaVentasTable );

     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
     DsGrupoClienteFields := TGrupoClienteFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );

     NivelesCategoriaTable.Database := SessionDataModule.InMemoryDatabase;

     // RegistroActualizacionFields es solo una referencia, por eso no se inicializa

     AtributoClaseA.OptionIds := TStringList.Create;
     AtributoClaseB.OptionIds := TStringList.Create;

     SincronizacionTiendaService.Inicializa( RegistroActualizacion.DmRegistroActualizacionTable.GetRemoteCursorID );   // De esta forma se asigna la intercepción de la actualización de stocks en el servidor

end;

procedure TSincronizacionTiendaMagentoModule.DataModuleDestroy(Sender: TObject);
begin
     FreeAndNil( FListaRegionesEspaña );
     AtributoClaseB.OptionIds.Free;
     AtributoClaseA.OptionIds.Free;
     SincronizacionTiendaMagentoModule := nil;
end;

{ --------- }

function TSincronizacionTiendaMagentoModule.GetDefaultTaxClassId : Integer;


var  TaxClassArray : TclJSONArray;
     TaxClassObject,
     DefaultTaxClass : TclJSONObject;
     Id : Integer;

begin
     Result := -1;
     try

       If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'taxClasses/search?searchCriteria[filter_groups][0][filters][0][field]=class_name&' +
                                                          'searchCriteria[filter_groups][0][filters][0][value]=Retail Customer&' +
                                                          'searchCriteria[filter_groups][1][filters][0][field]=class_type&' +
                                                          'searchCriteria[filter_groups][1][filters][0][value]=CUSTOMER&' +
                                                          'fields=items[class_id]' ) )
       then begin
            TaxClassObject := RestRpc.ResponseJSON as TclJSONObject;
            TaxClassArray := TaxClassObject.ArrayByName( 'items' );
            DefaultTaxClass := TaxClassArray.Objects[ 0 ];
            Id := StrToInt( DefaultTaxClass.ValueByName( 'class_id' ) );
            Result := Id;
            end;

     except on E : Exception do
       end;
end;

function TSincronizacionTiendaMagentoModule.ValidSKU( Value : String ) : Boolean;

const IllegalChars : array[ 0..7 ] of Char = ( 'Ñ', 'Á', 'É', 'Í', 'Ó', 'Ú', '/', '+' );
var   Ch : Char;

begin
     Result := False;
     Value := UpperCase( Value );
     For Ch in IllegalChars do
       If   Pos( Ch, Value )<>0
       then Exit;
     Result := True;
end;

function TSincronizacionTiendaMagentoModule.ObtenIdProvincia( Nombre : String ) : String;
begin
     // Una excepción muy molesta y algo absurda

     If   Nombre='La Coruña'
     then Nombre := 'A Coruña'
     else Nombre := StrToUNIFI( Nombre);
     Result := FListaRegionesEspaña.Values[ Nombre ];
end;

procedure TSincronizacionTiendaMagentoModule.SincronizaDatos( SoloNuevosPedidos,
                                                              ActualizarArticulos,
                                                              NoActualizarImagenes,
                                                              SoloArticulosRelacionados,
                                                              ActualizarClientes  : Boolean );

var  Inicio : TDateTime;

function ObtenRegiones( CodigoPais : String ) : TStringList;

var  CountryObject,
     Elemento : TclJSONObject;
     RegionsArray : TclJSONArray;
     Id : Integer;
     Code,
     Name : String;
     I : SmallInt;

begin
     Result := nil;
     If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'directory/countries/' + CodigoPais ) )
     then begin
          Result := TStringList.Create;
          CountryObject := RestRpc.ResponseJSON as TclJSONObject;
          RegionsArray := CountryObject.ArrayByName( 'available_regions' );
          If   RegionsArray.Count>0
          then begin
               For I := 0 to RegionsArray.Count - 1 do
                 begin
                 Elemento := RegionsArray.Objects[ I ];
                 Id := StrToInt( Elemento.ValueByName( 'id' ) );
                 Code := Elemento.ValueByName( 'code' );
                 Name := Elemento.ValueByName( 'name' );
                 // No usar Code. En A Coruña se utiliza un caracter especial que parece una c, pero no lo es.
                 Result.Values[ Name ] := IntToStr( Id );
                 end;
               end;
          end;
end;

function NroRegistrosDisponiblesClase( NroClase : SmallInt ) : Integer;
begin
     var Query := EnterpriseDataModule.OpenQuery( 'SELECT COUNT( * ) AS NroRegistros FROM Clase WHERE NroClase=' + IntToStr( NroClase ) + '  AND DisponibleTienda' );
     If   Assigned( Query )
     then try
             Result := Query.FieldValues[ 'NroRegistros' ];
          finally
            Query.Free;
            end;
end;

begin

     // Se ha tenido que obtener antes la autorización con ParametrosTiendaVirtual.GetAuthorization

     try

        // Se ha borrado el registro o no se ha completado la inicialización global

        ReinicioTienda := not RegistroActualizacion.Obten( rgaGlobal, CodigoConfiguracion );

        // Va a haber un reinicio, por lo que hay que borrar los atributos existentes

        ReiniciarAtributos := False;  // Nunca se reinician los atributos

        If   ReinicioTienda
        then If   ShowNotification( ntQuestionWarning, RsMsg43, RsMsg44 )<>mrYes
             then begin
                  ProcessFrame.Canceled := True;
                  Exit;
                  end;

        { Configuración global : tabla de tipos de IVA y grupos de clientes }

        IdDefaulftTaxClass := GetDefaultTaxClassId;

        InvalidarAtributos := not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value;

        // Es un poco extraño pero aprovecho para corregir un problema con el número de orden. Está en la reconstrucción de datos pero hay que acordarse.

        If   InvalidarAtributos
        then EnterpriseDataModule.ExecQuery( 'UPDATE Clase SET NroOrden=0 WHERE NroOrden<0' );

        If   ReinicioTienda or not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value
        then ActualizaConfiguracionGlobal;

        If   ProcessFrame.Canceled
        then Exit;

        Inicio := Now;

        If   RegistroActualizacion.Obten( rgaGlobal, CodigoFechaUltimaActualizacion )
        then FechaUltimaActualizacion := RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value
        else FechaUltimaActualizacion := LowestDateTime;

        ProcessFrame.AddMsg( ntInformation, RsMsg3 );

        If   ParametrosTiendaVirtual.MainWebSiteId=-1
        then begin
             ProcessFrame.AddMsg( ntError, RsMsg28 );
             Abort;
             end;

        try


          {
          // DEBUG
          ObtenArticulo( 'SH2017C' );
          Exit;
          }

          ExisteClaseA := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value and ( NroRegistrosDisponiblesClase( tcClaseA )>0 );
          If   ExisteClaseA
          then ExisteClaseB := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value and ( NroRegistrosDisponiblesClase( tcClaseB )>0 )
          else ExisteClaseB := False;

          // Magento redondea siempre las cuotas e importes de las lineas a 2 decimales

          FacturaVentas.UsarCalculoDecimalesMagento := True;

          If   not SoloNuevosPedidos
          then begin

               FListaRegionesEspaña := ObtenRegiones( 'ES' );

               If   ActualizarArticulos
               then ActualizaArticulos( NoActualizarImagenes, SoloArticulosRelacionados );

               If   ProcessFrame.Canceled
               then Exit;

               If   ActualizarClientes
               then ActualizaClientes;

               If   ProcessFrame.Canceled
               then Exit;

               If   { ActualizarArticulos and } ParametrosTiendaVirtual.PreciosPorCliente
               then begin
                    ActualizaPreciosPorCliente;
                    ActualizaDescuentosPorCategoria;
                    end;

               If   ProcessFrame.Canceled
               then Exit;

               ActualizaExistencias;

               end;

          // Nuevos pedidos y clientes

          DescargaPedidosNuevos;

        finally
          FacturaVentas.UsarCalculoDecimalesMagento := False;
          end;

        // Guardando la fecha de la última actualización

        RegistroActualizacion.Edita( rgaGlobal, CodigoFechaUltimaActualizacion );
        RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
        RegistroActualizacion.RegistroActualizacionFields.DatasetPost;


        ProcessFrame.AddMsg( ntInformation, Format( RsMsg7,  [ FormatDateTime( 'hh:nn:ss', Now - Inicio ) ] ) );

      except on E : Exception do
        begin
        ProcessFrame.AddMsg( ntError, RsMsgInterruption );
        If   not ( E is EAbort )
        then ProcessFrame.AddMsg( ntError, E.Message );
        end;
      end;

end;

procedure TSincronizacionTiendaMagentoModule.ExtraeClases( var CodigoArticulo : String;
                                                           var CodigoClaseA   : String;
                                                           var CodigoClaseB   : String );

function ExtraeClase : String;
begin
     Result := '';
     var I := Length( CodigoArticulo );
     While ( I>1 ) and ( CodigoArticulo[ I ]<>SeparadorClases ) do
       Dec( I );
       If   CodigoArticulo[ I ]=SeparadorClases  // Parece que lo he encontrado
       then begin
            Result := Copy( CodigoArticulo, I + 1, 255 );
            Delete( CodigoArticulo, I, 255 );
            end;
end;

begin

     // Estructura : <CodigoArticulo>SeparadorClases<CodigoClaseA>SeparadorClases<CodigoClaseB>

     CodigoClaseA := '';
     CodigoClaseB := '';
     If   ExisteClaseB
     then CodigoClaseB := ExtraeClase;
     If   ExisteClaseA
     then CodigoClaseA := ExtraeClase;

end;

procedure TSincronizacionTiendaMagentoModule.SuprimeArticulos;

var  CodigoArticulo : String;
     ListaArticulosServidor : TListaArticulos;
     NroPagina : SmallInt;
     UltimaPagina : Boolean;

begin

     ListaArticulosServidor := TListaArticulos.Create;
     try
       CodigoArticulo := '';
       NroPagina := 1;
       UltimaPagina := False;
       repeat
         If   ObtenCodigosArticulos( 'sku', 'notnull', 100, NroPagina, ListaArticulosServidor, CodigoArticulo, UltimaPagina )
         then Inc( NroPagina )
         else UltimaPagina := True;
       until UltimaPagina or ProcessFrame.Canceled;

       For CodigoArticulo in ListaArticulosServidor do
         begin
         RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'products/' + CodigoArticulo  ) );
         ProcessFrame.AddRecordMsg( CodigoArticulo );
         If   ProcessFrame.Canceled
         then Break;
         end;

     finally
       ListaArticulosServidor.Free;
       end;
end;

procedure TSincronizacionTiendaMagentoModule.ActualizaArticulos( NoActualizarImagenes      : Boolean = False;
                                                                 SoloArticulosRelacionados : Boolean = False );

var  ArticuloConRelacionados,
     ArticuloAgrupado : Boolean;
     ArticuloEspecial : TArticuloEspecial;
     ListaArticulosEspeciales : TListaArticulosEspeciales;
     TodosLosAlmacenes : Boolean;
     CodigoAlmacen : String;
     Existencias,
     CantidadMinima : Decimal;

procedure ObtenIdsCategorias;

var  DefaultCategory,
     Elemento : TclJSONObject;
     ChildrenData : TclJSONArray;
     CategoryId : Integer;
     Name : String;
     I : SmallInt;

begin

     If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'categories' ) )
     then begin
          DefaultCategory := RestRpc.ResponseJSON as TclJSONObject;
          ChildrenData := DefaultCategory.ArrayByName( 'children_data' );   // Supongo que la categoría raiz es 'Default Category'
          If   ChildrenData.Count>0
          then begin

               // Aprovecho para guardar el Id de 'Default category'

               IdCategoriaRaiz := StrToInt( DefaultCategory.ValueByName( 'id' ) );

               For I := 0 to ChildrenData.Count - 1 do
                 begin

                 // Recorro todos los elementos bajo la categoría raiz (no las hijas, claro)
                 // No importa en que posición u orden haya puesto el usuario las categorías

                 Elemento := ChildrenData.Objects[ I ];
                 Name := Elemento.ValueByName( 'name' );
                 CategoryId := StrToInt( Elemento.ValueByName( 'id' ) );
                 If   Uppercase( Name )=Uppercase( ParametrosTiendaVirtualModule.NombreCategoriaRaiz )
                 then IdCategoriaRaizProductos := CategoryId
                 else If   Name=NombreCategoriaRaizTarifas
                      then IdCategoriaRaizTarifas := CategoryId;

                 end;
               end;
          end;
end;

procedure SuprimeCategorias( IdCategoriaRaiz : Integer );

var  I : SmallInt;
     Data : TclJSONArray;
     Elemento,
     Categorias : TclJSONObject;
     CategoryId : Integer;

begin
     If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'categories?rootCategoryId=' + IntToStr( IdCategoriaRaiz ) ) )
     then begin
          Categorias := RestRpc.ResponseJSON as TclJSONObject;
          Data := Categorias.ArrayByName( 'children_data' );
          If   Data.Count>0
          then For I := 0 to Data.Count - 1 do
                 begin
                 Elemento := Data.Objects[ I ];
                 CategoryId := StrToInt( Elemento.ValueByName( 'id' ) );
                 If   CategoryId<>0
                 then RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'categories/' + IntToStr( CategoryId ) ) );
                 If   ProcessFrame.Canceled
                 then Break;
                 end;
          end;
end;

function ObtenNivelCategoria( CodigoPadre : String ) : SmallInt;

var  Nivel : SmallInt;

begin
     Nivel := 0;
     While CodigoPadre<>'' do
       If   CategoriaAuxTable.FindKey( [ CodigoPadre ] )
       then begin
            Inc( Nivel );
            CodigoPadre := CategoriaAuxTableCodigoPadre.Value;
            end
       else CodigoPadre := '';
     Result := Nivel;
end;

procedure CreaAtributoClase(     NroClase       : SmallInt;
                                 NombreAtributo : String;
                             var AtributoClase  : TAtributoClase );
begin

     With AtributoClase do
       begin

       CodigoAtributo := LowerCase( NombreAtributo );
       Nombre := NombreAtributo;

       {
       If   ReiniciarAtributos
       then If   ObtenDatosAtributo( CodigoAtributo, Id )
            then BorraAtributo( Id );
       }

       If   not ObtenDatosAtributo( CodigoAtributo, Id, OptionIds )
       then CreaAtributo( { Codigo } CodigoAtributo, { Etiqueta } NombreAtributo, Id );

       // Este proceso hay que hacerlo en dos fases porque el atributo es un TextSwatch (cosas de Magento)

       If   ActualizaOpcionesClaseAtributo( NroClase, Id, CodigoAtributo )
       then ObtenDatosAtributo( CodigoAtributo, Id, OptionIds )       // Hay que leer las lista de nuevos atributos en AttributteOptionsIdsTable
       else begin
            BorraAtributo( Id );
            Abort;
            end;

       end;

end;

begin

     { Categorías }

     IdCategoriaRaizProductos := 0;
     IdCategoriaRaizTarifas := 0;

     ObtenIdsCategorias;

     If   IdCategoriaRaizProductos=0
     then begin
          ProcessFrame.AddMsg( ntError, Format( RsMsg1, [ ParametrosTiendaVirtualModule.NombreCategoriaRaiz ] ) );
          Abort;
          end;

     ProcessFrame.AddMsg( ntInformation, RsCategorias );

     // Si no existe ningún registro de categoria actualizado es un reinicio.
     // Aprovecho para suprimir todos los registros de categorías de productos bajo la raiz.

     var ReinicioCategorias := not RegistroActualizacion.ExisteTipo( rgaCategoria );

     If   ReinicioCategorias
     then begin
          ProcessFrame.AddMsg( ntInformation, RsSuprimiendoCategorias );
          SuprimeCategorias( IdCategoriaRaizProductos );
          end;

     // Contruyo el arbol de niveles de categorias

     NivelesCategoriaTable.Open;

     try

       With DmCategoriaTable do
         begin
         IndexFieldNames := 'Codigo';
         First;
         While not Eof and not ProcessFrame.Canceled do
           begin
           NivelesCategoriaTable.Append;
           NivelesCategoriaTableCodigo.Value := DmCategoriaFields.Codigo.Value;
           NivelesCategoriaTableNivel.Value := ObtenNivelCategoria( DmCategoriaFields.CodigoPadre.Value );
           NivelesCategoriaTable.Post;
           Next;
           end;

       end;

       // Y, ahora, actualizo las categorias ordenadamente de nivel menor a mayor

       With NivelesCategoriaTable do
         begin
         IndexFieldNames := 'Nivel';
         DmCategoriaTable.IndexFieldNames := 'Codigo';
         First;
         While not Eof and not ProcessFrame.Canceled do
           begin

           If   DmCategoriaTable.FindKey( [ NivelesCategoriaTableCodigo.Value ] )
           then begin
                RegistroActualizacion.Edita( rgaCategoria, DmCategoriaFields.Codigo.Value );
                try
                  If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value
                  then begin

                       ActualizaCategoria( IdCategoriaRaizProductos,
                                           DmCategoriaFields.CodigoPadre.Value,
                                           DmCategoriaFields.Codigo.Value,
                                           DmCategoriaFields.Nombre.Value,
                                           DmCategoriaFields.Activo.Value,
                                           { IncluirEnMenu } True );

                       RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
                       ProcessFrame.AddRecordMsg( DmCategoriaFields.Nombre.Value );
                       end;
                finally
                  RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
                  end;
                end;

           Next;
           end;

       end;

     finally
       NivelesCategoriaTable.Close;
       end;

     If   ProcessFrame.Canceled
     then Exit;

     // Ahora creo, si es necesario, las categorías que se utilizan como tarifas

     If   ParametrosTiendaVirtual.PreciosPorCliente
     then begin

          If   ReinicioCategorias and ( IdCategoriaRaizTarifas<>0 )
          then begin
               ProcessFrame.AddMsg( ntInformation, RsSuprimiendoCategorias );
               SuprimeCategorias( IdCategoriaRaizTarifas );
               end;

          With DmFamiliaTable do
            begin
            First;
            While not Eof do
              begin

              RegistroActualizacion.Edita( rgaCategoria, 'FT·' + DmFamiliaFields.Codigo.Value );
                try
                  If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value
                  then begin

                       ActualizaCategoria( IdCategoriaRaizTarifas,
                                           { CodigoPadre } '',
                                           DmFamiliaFields.Codigo.Value,
                                           DmFamiliaFields.Descripcion.Value,
                                           { Activo } False,
                                           { IncluirEnMenu } False );

                       RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
                       ProcessFrame.AddRecordMsg( DmFamiliaFields.Descripcion.Value );
                       end;
                finally
                  RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
                  end;

              Next;
              end;

            end;

          end;

     ListaArticulosEspeciales := TListaArticulosEspeciales.Create;

     try

       // Si no existe ningún registro de artículo actualizado puede ser un reinicio o la primera sincronización.
       // Aprovecho para suprimir todos los registros de artículos de la tienda.

       If   not RegistroActualizacion.ExisteTipo( rgaArticulo )
       then begin
            ProcessFrame.AddMsg( ntInformation, RsSuprimiendoArticulos );
            SuprimeArticulos;
            end;

       ProcessFrame.AddMsg( ntInformation, RsArticulos );

       // Primero compruebo si existe el atributo que se corresponde con las clases A y B y, si es necesario, los creo

       { CUIDADO : La función ObtenDatosAtributo borra AttributeOptionIds y la rellena con las opciones disponible solo si el
                   el atributo en cuestión tiene opciones (habitualmente si es select o multiselect).
                   Hay que preservar la lista copiándola en otra variable.
       }


       // *** OJO : Hay que actualizarlo comprobando si se han modificado las clases

       If   ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones
       then If   ExisteClaseA
            then begin

                 CreaAtributoClase( tcClaseA,
                                    DataModule00.DmEmpresaFields.Articulo_NombreClase[ tcClaseA ].Value,
                                    AtributoClaseA );

                 If   ExisteClaseB
                 then CreaAtributoClase( tcClaseB,
                                         DataModule00.DmEmpresaFields.Articulo_NombreClase[ tcClaseB ].Value,
                                         AtributoClaseB );

                 end;

       If   ParametrosTiendaVirtualModule.CamposLibresComoAtributos and
            DataModule00.DmEmpresaFields.Articulo_CamposLibres.Value
       then For var Index := 1 to High( TArticulo_CampoLibreArray ) do
              If   DataModule00.DmEmpresaFields.Articulo_CampoLibre[ Index ].Value<>''
              then CompruebaAtributo( LowerCase( DataModule00.DmEmpresaFields.Articulo_CampoLibre[ Index ].Value ), DataModule00.DmEmpresaFields.Articulo_CampoLibre[ Index ].Value, fitText );

       If   ProcessFrame.Canceled
       then Exit;

       // % Descuento

       CompruebaAtributo( Fld_DiscountRate, RsDiscountRate, fitText );

       // Volumen

       If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
       then begin
            CompruebaAtributo( Fld_Packs, RsPacks, fitText );
            CompruebaAtributo( Fld_Volume, RsVolume, fitText );
            end;

       // Unidades por caja

       If   DataModule00.DmEmpresaFields.Articulo_Cajas.Value
       then CompruebaAtributo( Fld_UnitsPerBox, RsUnitsPerBox, fitText );

       // Unidades por pallet

       If   DataModule00.DmEmpresaFields.Articulo_Pallets.Value
       then CompruebaAtributo( Fld_UnitsPerPallet, RsUnitsPerPallet, fitText );

       If   ProcessFrame.Canceled
       then Exit;

       // Actualizando los artículos

       With DmArticuloTable do
         begin
         First;
         While not Eof and not ProcessFrame.Canceled do
           begin
           If   not DmArticuloFields.Obsoleto.Value and
                    DmArticuloFields.VisibleTienda.Value and
                ( ( ParametrosTiendaVirtualModule.SeleccionAlmacen=0 ) or
                  ( ( ParametrosTiendaVirtualModule.SeleccionAlmacen=1 ) and ( not ParametrosTiendaVirtualModule.PublicarArticulosAlmacenSeleccionado or ( DmArticuloFields.CodigoAlmacen.Value=ParametrosTiendaVirtualModule.CodigoAlmacen ) ) ) or
                  ( ( ParametrosTiendaVirtualModule.SeleccionAlmacen=2 ) and ( not ParametrosTiendaVirtualModule.PublicarArticulosAlmacenSeleccionado or ( DmArticuloFields.CodigoAlmacen.Value<>'' ) ) ) )
           then begin
                If   ValidSKU( DmArticuloFields.Codigo.Value )
                then begin

                     ArticuloConRelacionados := False;
                     ArticuloAgrupado := False;

                     If   SoloArticulosRelacionados
                     then ArticuloConRelacionados := EsUnArticuloConRelacionados( DmArticuloFields.Codigo.Value )
                     else begin

                          RegistroActualizacion.Edita( rgaArticulo, DmArticuloFields.Codigo.Value );
                          try
                            If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value or
                                 ( ParametrosTiendaVirtualModule.ImagenesExternas and ProcessExternalImages( DmArticuloFields, RegistroActualizacion.RegistroActualizacionFields.FechaImagenExterna.Value, { OnlyCheckModifications } True ) )  // Se comprueba si se ha modificado alguna imagen externa
                                 // or not ExisteArticulo( DmArticuloFields.Codigo.Value )   // De momento dejo de comprobar si existe. Si el usuario ha dado de baja el artículo que lo invalide.
                            then begin

                                 ArticuloConRelacionados := EsUnArticuloConRelacionados( DmArticuloFields.Codigo.Value );
                                 ArticuloAgrupado := Articulo.EsUnArticuloAgrupado( DmArticuloFields.Codigo.Value );

                                 // Los artículos agrupados tienen que esperar a que todos los artículos que forman parte del grupo sean creados

                                 If   not ArticuloAgrupado
                                 then If   ExisteClaseA and
                                           ( ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones ) and
                                           not DmArticuloFields.Tienda_NoPublicarClases.Value
                                      then ActualizaArticuloConClases( DmArticuloFields, NoActualizarImagenes )
                                      else If   ActualizaArticulo( DmArticuloFields, NoActualizarImagenes )
                                           then RegistroActualizacion.RegistroActualizacionFields.DatasetPost
                                           else RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;

                                 // Invalido el registro de existencias para que se actualice, aunque no hayan cambiado las existencias (cantidades mínimas y eso)

                                 RegistroActualizacion.Actualizado( rgaStock, DmArticuloFields.Codigo.Value, { Value } False );

                                 end;

                          finally
                            RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;  // Un Cancel tras un Post no tiene ningún efecto
                            end;

                          end;

                     If   ArticuloAgrupado or ArticuloConRelacionados
                     then ListaArticulosEspeciales.Add( TArticuloEspecial.Create( DmArticuloFields.Codigo.Value, ArticuloAgrupado, ArticuloConRelacionados ) );

                     end
                else ProcessFrame.AddMsg( ntWarning, Format( RsMgs8, [ DmArticuloFields.Codigo.Value ]  ) + ' ' + RsMsg16 );
                end;
           Next;
           end;

         // Procesando los articulos especiales ( agrupados o con relaciones )

         If   ProcessFrame.Canceled
         then Exit;

         ProcessFrame.AddMsg( ntInformation, RsRelacionesArticulos );

         var ProcesadoCorrectamente := False;

         For ArticuloEspecial in ListaArticulosEspeciales do
           If   FindKey( [ ArticuloEspecial.Codigo ] )
           then begin
                RegistroActualizacion.Edita( rgaArticulo, ArticuloEspecial.Codigo );
                try

                  If   ArticuloEspecial.ConRelacionados
                  then ProcesadoCorrectamente := ActualizaArticulosRelacionados( DmArticuloFields )
                  else If   ArticuloEspecial.Agrupado
                       then ProcesadoCorrectamente := ActualizaArticulo( DmArticuloFields, { ArticuloAgrupado } True );

                  If   ProcesadoCorrectamente
                  then RegistroActualizacion.RegistroActualizacionFields.DatasetPost;

                finally
                  RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
                  end;
                If   ProcessFrame.Canceled
                then Exit;
                end;

         // Comprobando las posibles bajas

         ProcessFrame.AddMsg( ntInformation, RsBajasArticulos );

         DmRegistroActualizacionTable.SetRange( [ Ord( rgaArticulo ) ] );
         try

           DmRegistroActualizacionTable.First;

           While not DmRegistroActualizacionTable.Eof and not ProcessFrame.Canceled do
             begin

             var CodigoArticulo := DmRegistroActualizacionFields.Codigo.Value;

             If   ValidSKU( CodigoArticulo )
             then begin

                  ProcessFrame.AddRecordMsg( DmRegistroActualizacionFields.Codigo.Value );

                  var ExisteRegistro := DmArticuloTable.FindKey( [ CodigoArticulo ] );
                  var PrecioValido := ExisteRegistro and ( not ParametrosTiendaVirtualModule.NoPublicarArticulosSinPrecio or ArticuloConPrecio( DmArticuloFields ) );

                  If   not ExisteRegistro or
                       DmArticuloFields.Obsoleto.Value or
                       not DmArticuloFields.VisibleTienda.Value or
                       not PrecioValido
                  then begin
                       SuprimeArticulo( CodigoArticulo ); // Si tiene variantes también se suprimen
                       DmRegistroActualizacionTable.Delete;
                       ProcessFrame.AddMsg( ntInformation, Format( RsArticuloEliminado, [ CodigoArticulo ] ) );
                       Continue;   // Evitando el Next
                       end;

                  end
             else ProcessFrame.AddMsg( ntWarning, Format( RsMgs8, [ CodigoArticulo ]  ) );

             DmRegistroActualizacionTable.Next;
             end;

         finally
           DmRegistroActualizacionTable.CancelRange;
           end;

         end;

     finally
       For ArticuloEspecial in ListaArticulosEspeciales do
         ArticuloEspecial.Free;
       ListaArticulosEspeciales.Free;
       end;


end;

procedure TSincronizacionTiendaMagentoModule.ActualizaExistencias;

var  TodosLosAlmacenes : Boolean;
     CodigoAlmacen : String;
     Existencias,
     CantidadMinima : Decimal;
     ArticuloConfigurableList : TStringList;

begin

     // Actualizando existencias

     ProcessFrame.AddMsg( ntInformation, RsExistencias );

     // TipoRegistro;Actualizado;Codigo

     ArticuloConfigurableList := TStringList.Create;

     // Solo selecciono los que no están actualizados

     DmRegistroActualizacionAuxTable.SetRange( [ Ord( rgaStock ), False ], [ Ord( rgaStock ), False ] );
     try

       DmRegistroActualizacionAuxTable.First;

       While not DmRegistroActualizacionAuxTable.Eof and not ProcessFrame.Canceled do
         begin

         var CodigoArticulo := DmRegistroActualizacionAuxFields.Codigo.Value;
         var CodigoClaseA := '';
         var CodigoClaseB := '';

         If   ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones
         then ExtraeClases( CodigoArticulo, CodigoClaseA, CodigoClaseB );      // Extrae las clase y las quita de CodigoArticulo

         ProcessFrame.AddRecordMsg( DmRegistroActualizacionAuxFields.Codigo.Value );

         RegistroActualizacion.Edita( rgaStock, DmRegistroActualizacionAuxFields.Codigo.Value );

         If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value  // El registo de stocks
         then If   DmArticuloTable.FindKey( [ CodigoArticulo ] )
              then try

                     {  Ahora solo se publican las variantes marcadas, por lo que no es necesario comprobar si hay existencias nuevas

                     // Primero compruebo que no sea un registro de existencias nuevo. En ese caso hay que volver a actualizar
                     // todas las opciones del articulo configurable en Magento

                     If   ( TiendaVirtualModule.PublicarClasesComo=pcConfiguraciones ) and
                          not DmArticuloFields.Tienda_NoPublicarClases.Value
                     then If   not DmRegistroActualizacionTable.FindKey( [ rgaArticulo, DmRegistroActualizacionAuxFields.Codigo.Value ] ) // No existe el registro de la variante del artículo
                          then begin
                               ActualizaArticuloConClases( DmArticuloFields, NoActualizarImagenes );
                               DmRegistroActualizacionAuxTable.Next;
                               Continue;   // No es necesario actualizar las existencias, ya se ha hecho al actualizar el artículo
                               end;
                     }

                     ObtenAlmacenArticulo( DmArticuloFields, TodosLosAlmacenes, CodigoAlmacen );

                     ExistenciasArticulo := StockAlmacen.ObtenStock( DmArticuloFields.Codigo.Value,
                                                                     CodigoClaseA='',
                                                                     CodigoClaseA,
                                                                     CodigoClaseB,
                                                                     '',
                                                                     True, '',
                                                                     TodosLosAlmacenes, CodigoAlmacen,
                                                                     True, '',
                                                                     True,
                                                                     ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

                     Existencias := ExistenciasArticulo.SumaExistencias.Saldo - ExistenciasArticulo.SumaExistencias.PendienteServir;
                     If   not ParametrosTiendaVirtualModule.NoIncluirPendienteRecibir
                     then Existencias := Existencias + ExistenciasArticulo.SumaExistencias.PendienteRecibir;

                     // No se admiten existencias negativas

                     If   Existencias<0.0
                     then Existencias := 0.0;

                     CantidadMinima := DmArticuloFields.CantidadMinimaVenta.Value;

                     If   ActualizaExistenciasArticulo( DmRegistroActualizacionAuxFields.Codigo.Value, CantidadMinima, Existencias )
                     then begin
                          RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
                          RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
                          RegistroActualizacion.RegistroActualizacionFields.DatasetPost;

                          // Si el artículo está incluído en uno configurable y se modifica su stock, Magento no actualiza la ficha del padre para reflejar el cambio

                          If   ( ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones ) and
                               ( CodigoClaseA<>'' ) and
                               ( ArticuloConfigurableList.IndexOf( CodigoArticulo )=-1 ) // Si ya ha sido actualizado no lo repito
                          then begin
                               ActualizaExistenciasArticulo( CodigoArticulo,   // Solo el código, no contiene las clases
                                                             { CantidadMinima } 1,
                                                             { Existencias } 0,
                                                             { HayExistencias } True );
                               ArticuloConfigurableList.Add( CodigoArticulo );
                               end;

                          end
                     else RegistroActualizacion.RegistroActualizacionFields.DatasetDelete;

                   finally
                     RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
                     end;

         DmRegistroActualizacionAuxTable.Next;
         end;

     finally
       DmRegistroActualizacionAuxTable.CancelRange;
       FreeAndNil( ArticuloConfigurableList );
       end;

end;

procedure TSincronizacionTiendaMagentoModule.ActualizaClientes;

var  AddressId1,
     AddressId2,
     IdCliente : LongInt;
     NIFCliente,
     EMailCliente,
     NombreCliente : String;
     ClientesArray : TclJSONArray;
     ClienteObject : TclJSONObject;

begin

      ProcessFrame.AddMsg( ntInformation, RsBajasClientes );

      DmRegistroActualizacionTable.SetRange( [ Ord( rgaCliente ) ] );

      try

        DmRegistroActualizacionTable.First;

        While not DmRegistroActualizacionTable.Eof and not ProcessFrame.Canceled do
          begin
          var CodigoCliente := DmRegistroActualizacionFields.Codigo.Value;
          ProcessFrame.AddRecordMsg( CodigoCliente );

          { Este proceso pretende suprimir a los clientes que existen en la tienda y que ya no existen o se han marcado
           como no pertenecientes a la tienda y, al mismo tiempo, comprobar si un cliente que se había dado de alta
           desde Gestwin ha sido dado de baja en la tienda }

          var ExisteRegistro := False;
          If   DmClienteTable.FindKey( [ CodigoCliente ] )
          then begin
               ExisteRegistro := ExisteCliente( DmClienteFields.Codigo.Value,  // Paso el código y nombre por si hay algún problema que el mensaje de error indique el origen
                                                DmClienteFields.Nombre.Value,
                                                DmClienteFields.EMail.Value,
                                                IdCliente,
                                                AddressId1,
                                                AddressId2,
                                                NombreCliente,                 // El nombre en la tienda
                                                NIFCliente );
               If   ExisteRegistro and
                    ( not DmClienteFields.TiendaVirtual.Value or DmClienteFields.Obsoleto.Value ) and
                    ( IdCliente<>0 )
               then begin
                    SuprimeCliente( IdCliente, CodigoCliente );
                    ProcessFrame.AddMsg( ntInformation, Format( RsClienteEliminado, [ CodigoCliente] ) );
                    ExisteRegistro := False;
                    end;
               end;
          If   not ExisteRegistro
          then DmRegistroActualizacionTable.Delete
          else DmRegistroActualizacionTable.Next;

          end;

      finally
        DmRegistroActualizacionTable.CancelRange;
        end;

      If   ProcessFrame.Canceled
      then Exit;

      // Clientes

      ProcessFrame.AddMsg( ntInformation, RsClientes );

      try

        DmClienteQuery.Open;

        With DmClienteQuery do
          begin
          First;
          While not Eof and not ProcessFrame.Canceled do
            begin

            RegistroActualizacion.Edita( rgaCliente, DmClienteQueryCodigo.Value );
            try
              If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value
              then If   DmClienteTable.FindKey( [ DmClienteQueryCodigo.Value ] )   // Se carga DmClienteFields
                   then begin

                        // Si se ha reiniciado el fichero de registros de la tienda los clientes siguen estando dados
                        // de alta en la tienda, por lo que compruebo primero si ya existen

                        If   ExisteCliente( DmClienteFields.Codigo.Value,
                                            DmClienteFields.Nombre.Value,
                                            DmClienteFields.EMail.Value,
                                            IdCliente,
                                            AddressId1,
                                            AddressId2,
                                            NombreCliente,
                                            NIFCliente )
                        then begin
                             RegistroActualizacion.RegistroActualizacionFields.Id.Value := IdCliente;
                             RegistroActualizacion.RegistroActualizacionFields.Id1.Value := AddressId1;
                             RegistroActualizacion.RegistroActualizacionFields.Id2.Value := AddressId2;
                             end;

                        If   ActualizaCliente( DmClienteFields )
                        then begin
                             RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
                             RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
                             try
                               RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
                               ProcessFrame.AddMsg( ntInformation, Format( RsClienteActualizado, [ DmClienteQueryCodigo.Value, DmClienteQueryEMail.Value ] ) );
                             except on E : Exception do
                               begin
                               ProcessFrame.AddMsg( ntError, Format( RsMsg18, [ DmClienteQueryCodigo.Value, DmClienteQueryNombre.Value ] ) );
                               ProcessFrame.AddMsg( ntError, RsMsg34 );
                               end;

                             end;

                             end;

                        end;
            finally
              RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
              end;

            Next;
            end;

          end;

          If   ObtenClientes( ClientesArray )
          then For var I := 0 to ClientesArray.Count - 1 do
                 begin
                 ClienteObject := ClientesArray.Objects[ I ];
                 EMailCliente := ClienteObject.ValueByName( 'email' );
                 If   not Cliente.ObtenPorEMail( EMailCliente )
                 then CreaNuevoClienteGestwin( ClienteObject );
                 end;

      finally
        DmClienteQuery.Close;
        end;

end;

procedure TSincronizacionTiendaMagentoModule.DescargaPedidosNuevos;

var  PedidosResponse : TclJSONObject;
     PedidosArray,
     LineasPedidoArray,
     StatusHistoriesArray,
     ShippingAssignmentsArray,
     BillingStreetArray,
     ShippingStreetArray : TclJSONArray;

     PedidoObject,
     BillingAddressObject,
     ExtensionAttributesObject,
     ShippingObject,
     ShippingAddressObject,
     ShippingTotalObject,
     LineaPedidoObject,
     ParentItemObject,
     PreciosLineaObject : TclJSONObject;
     IdPedido,
     IdGrupoCliente : LongInt;

     IncrementId,
     CodigoCliente,
     CodigoPostal,
     CodigoSubcuenta,
     EMailCliente,
     CodigoClaseA,
     CodigoClaseB,
     CodigoArticulo,
     TipoProducto : String;

     FechaPedido : TDateTime;

     Recargo : Double;

     IndiceGrupoCliente : SmallInt;

     Portes,
     NroCajas,
     CantidadPedida,
     CantidadCancelada,
     CantidadTotal,
     ImporteTotalPedido,
     CuotaIVAPortes,
     CuotaREPortes,
     ImporteTotal : Decimal;
     PrecioBase : Double;
     PrimerIntento,
     HayMasPedidos,
     SeHanProcesadoPedidos : Boolean;

begin

     SerieFacturacion.Obten( '',  DsSerieFacturacionFields );  // De momento la serie genérica

     PrimerIntento := True;
     SeHanProcesadoPedidos := False;

     repeat

       IdPedido := 0;
       HayMasPedidos := False;

       try

         // No es necesario crear el objecto TclJSONObject, se crea en la llamada RestRpc.Post
         // Lo que si hay que hacer es suprimirlo cuando ya no se utilice

         If   ObtenPedidosPendientes( PedidosResponse )
         then begin

              PedidosArray := PedidosResponse.ArrayByName( 'items' );

              If   Assigned( PedidosArray )
              then If   PedidosArray.Count=0
                   then begin
                        If   PrimerIntento
                        then ProcessFrame.AddMsg( ntWarning, RsNoHayNuevosPedidos );
                        end
                   else begin

                        PrimerIntento := False;
                        HayMasPedidos := True;

                        For var I := 0 to PedidosArray.Count - 1 do
                          begin

                          PedidoObject := PedidosArray.Objects[ I ];
                          IdPedido := StrtoInt( PedidoObject.ValueByName( 'entity_id' ) );
                          IncrementId := PedidoObject.ValueByName( 'increment_id' );
                          EMailCliente := PedidoObject.ValueByName( 'customer_email' );
                          IdGrupoCliente := StrToInt( PedidoObject.ValueByName( 'customer_group_id' ) );
                          IndiceGrupoCliente := ObtenGrupoPorId( IdGrupoCliente );

                          BillingAddressObject :=  PedidoObject.ObjectByName( 'billing_address' );
                          BillingStreetArray := BillingAddressObject.ArrayByName( 'street' );
                          StatusHistoriesArray := PedidoObject.ArrayByName( 'status_histories' );
                          ExtensionAttributesObject := PedidoObject.ObjectByName( 'extension_attributes' );

                          ShippingAssignmentsArray :=  ExtensionAttributesObject.ArrayByName( 'shipping_assignments' );
                          ShippingObject := ShippingAssignmentsArray.Objects[ 0 ].ObjectByName( 'shipping' );

                          // Si no existe la dirección de envío se utiliza la de facturación

                          If   ShippingObject.ValueByName( 'address' )<>''
                          then begin
                               ShippingAddressObject := ShippingObject.ObjectByName( 'address' );
                               ShippingStreetArray := ShippingAddressObject.ArrayByName( 'street' );
                               end
                          else begin
                               ShippingAddressObject := nil;
                               ShippingStreetArray := nil;
                               end;

                          ShippingTotalObject := ShippingObject.ObjectByName( 'total' );

                          FechaPedido := StrTSToDateTime( PedidoObject.ValueByName( 'created_at' ) );
                          ImporteTotalPedido := StrToDecimal( PedidoObject.ValueByName( 'total_due' ) );

                          If   EjercicioFecha( FechaPedido )<>ApplicationContainer.Ejercicio
                          then begin
                               ProcessFrame.AddMsg( ntWarning, Format( RsMsg33, [ IncrementId, EMailCliente ]  ) );
                               Continue;
                               end;

                          var StId := EnterpriseDataModule.StartTransaction( [ DmClienteTable,
                                                                               DmMovimientoTable,
                                                                               DmLineaMovimientoTable,
                                                                               RegistroActualizacion.DmRegistroActualizacionTable ] );

                          try

                            If   not Cliente.ObtenPorEMail( EMailCliente, DsClienteFields )
                            then begin

                                 CodigoCliente := DmClienteTable.GetNewAutoIncStringValue( ParametrosTiendaVirtualModule.PlantillaCodigoCliente );
                                 If   CodigoCliente=''  // No se ha podido generar un nuevo código automático
                                 then begin
                                      ProcessFrame.AddMsg( ntError, RsMsg35 );
                                      Abort;
                                      end;

                                 DmClienteTable.Append;

                                 DmClienteFields.Codigo.Value := CodigoCliente;

                                 DmClienteFields.FechaAlta.Value := ApplicationContainer.TodayDate;

                                 ProcesaNombreCliente( BillingAddressObject, DmClienteFields.Nombre );

                                 DmClienteFields.Domicilio.Value := BillingStreetArray.Items[ 0 ].ValueString;
                                 DmClienteFields.Localidad.Value := BillingAddressObject.ValueByName( 'city' );
                                 DmClienteFields.CodigoPais.Value := Pais.CodigoPorCodigoISO2( BillingAddressObject.ValueByName( 'country_id' ) );
                                 CodigoPostal := BillingAddressObject.ValueByName( 'postcode' );
                                 DmClienteFields.CodigoProvincia.Value := Copy( CodigoPostal, 1, 2 );
                                 DmClienteFields.CodigoPostal.Value := Copy( CodigoPostal, 3, 3 );
                                 DmClienteFields.Telefono.Value := BillingAddressObject.ValueByName ( 'telephone' );
                                 // NIF
                                 DmClienteFields.EMail.Value  := BillingAddressObject.ValueByName ( 'email' );
                                 CodigoSubcuenta := '4300' + DmClienteFields.Codigo.Value;
                                 Cuenta.InsertaSubcuenta( CodigoSubcuenta, DmClienteFields.Nombre.Value );
                                 DmClienteFields.Subcuenta.Value := CodigoSubcuenta;
                                 DmClienteFields.TiendaVirtual.Value := True;

                                 If   Assigned( ShippingAddressObject )
                                 then begin
                                      ProcesaNombreCliente( ShippingAddressObject, DmClienteFields.Envios_Nombre );
                                      DmClienteFields.Envios_Domicilio.Value := ShippingStreetArray.Items[ 0 ].ValueString;
                                      DmClienteFields.Envios_Localidad.Value := ShippingAddressObject.ValueByName ( 'city' );
                                      CodigoPostal := ShippingAddressObject.ValueByName( 'postcode' );
                                      DmClienteFields.Envios_CodigoProv.Value := Copy( CodigoPostal, 1, 2 );
                                      DmClienteFields.Envios_CodigoPostal.Value := Copy( CodigoPostal, 3, 3 );
                                      DmClienteFields.Envios_FormaEnvio.Value := ShippingObject.ValueByName( 'method' );
                                      end
                                 else begin
                                      DmClienteFields.Envios_Nombre.Value := DmClienteFields.Nombre.Value;
                                      DmClienteFields.Envios_Domicilio.Value := DmClienteFields.Domicilio.Value;
                                      DmClienteFields.Envios_Localidad.Value := DmClienteFields.Localidad.Value;
                                      DmClienteFields.Envios_CodigoProv.Value := DmClienteFields.CodigoProvincia.Value;
                                      DmClienteFields.Envios_CodigoPostal.Value := DmClienteFields.CodigoPostal.Value;
                                      end;

                                 // DmClienteFields.Envios_Transportista.Value :=
                                 // DmClienteFields.Envios_CodigoFormaEnvio.Value :=

                                 DmClienteFields.Factura_Moneda.Value := 0;
                                 DmClienteFields.Factura_ModeloIVA.Value := micSinRE;  // Dependerá del tipo de mayorista
                                 DmClienteFields.Factura_NroCopias.Value := 1;
                                 DmClienteFields.Factura_NroCopiasAlbaran.Value := 1;

                                 DmClienteFields.Cobro_MesNoCobro.Value := 0;
                                 DmClienteFields.Cobro_CtaEntidad.Value := '572000000';  // Por defecto. Podría ser configurable?

                                 DmClienteFields.Cobro_FormaCobro.Value := ParametrosTiendaVirtualModule.CodigoFormaCobro;

                                 DmClienteTable.Post;

                                 DsClienteFields.Update( DmClienteTable );

                                 ProcessFrame.AddMsg( ntInformation, Format( RsMsg11, [ DmClienteFields.Codigo.Value, DmClienteFields.Nombre.Value ] ) );
                                 end;

                            LineasPedidoArray := PedidoObject.ArrayByName( 'items' );

                            DmMovimientoTable.Append;

                            DmMovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                            DmMovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion;
                            DmMovimientoFields.TipoMovimiento.Value := tmPedidoVenta;
                            DmMovimientoFields.Propietario.Value := DsClienteFields.Codigo.Value;
                            If   IndiceGrupoCliente>=0
                            then DmMovimientoFields.Serie.Value := ParametrosTiendaVirtual.GrupoSerie[ IndiceGrupoCliente ]
                            else DmMovimientoFields.Serie.Value := '';
                            DmMovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( DmMovimientoFields );
                            DmMovimientoFields.Fecha.Value := FechaPedido;
                            DmMovimientoFields.FechaAplicacion.Value := FechaPedido;
                            DmMovimientoFields.Origen.Value := omTiendaVirtual;
                            DmMovimientoFields.NroDocumentoPropietario.Value := IncrementId;
                            DmMovimientoFields.CodigoTransportista.Value := DsClienteFields.Envios_Transportista.Value;
                            DmMovimientoFields.GrupoFacturacion.Value := DsClienteFields.Factura_Agrupacion.Value;
                            DmMovimientoFields.CentroCoste.Value := DsSerieFacturacionFields.CentroCoste.Value;

                            MovimientoModule.InsertaVinculosCliente( DmMovimientoFields, DsClienteFields );

                            If   ShippingTotalObject.ValueByName( Fld_base_shipping_amount )<>''
                            then Portes := StrToDecimal( ShippingTotalObject.ValueByName( Fld_base_shipping_amount ) )
                            else Portes := 0.0;

                            DmMovimientoFields.Portes.Value := Portes;

                            // Comentarios añadidos al pedido por el cliente durante la compra (módulo OrderComment)

                            var TextoAnotacion := Trim( ExtensionAttributesObject.ValueByName( 'bold_order_comment' ) );

                            // Corrigiendo un error con el módulo de comentarios original (el adaptado, Gestwin_OrderComment, funciona bien)

                            If   ( TextoAnotacion<>'null' ) and ( TextoAnotacion<>'' )
                            then DmMovimientoFields.Anotacion.Value := TextoAnotacion;

                            // Comentarios añadidos por el usuario

                            If   Assigned( StatusHistoriesArray )
                            then If   StatusHistoriesArray.Count>0
                                 then begin
                                      var HistoriesObject := StatusHistoriesArray.Objects[ 0 ];
                                      If   Assigned( HistoriesObject )
                                      then DmMovimientoFields.Anotacion.Value := DmMovimientoFields.Anotacion.Value  + #13 + HistoriesObject.ValueByName( 'comment' );
                                      end;

                            {  Si se quieren leer todos los comentarios

                            If   Assigned( StatusHistoriesArray )
                            then begin
                                 var Anotaciones := '';
                                 For var HInx := 0 to StatusHistoriesArray.Length - 1 do
                                   begin
                                   var HistoriesObject := StatusHistoriesArray.GetObjectIfExists( HInx );
                                   If   Assigned( HistoriesObject )
                                   then Anotaciones := Anotaciones + #13 + '--------------------------------------' + #13 + HistoriesObject.ValueByName( 'comment' );
                                   end;
                                 DmMovimientoFields.Anotacion.Value := Anotaciones;
                                 end;
                            }

                            DmMovimientoTable.Post;

                            Movimiento.CompruebaPrimerNroPagina( DmMovimientoFields );

                            ImporteTotal := 0.0;

                            var NroLinea := 1;

                            For var J := 0 to LineasPedidoArray.Count - 1 do
                              begin

                              LineaPedidoObject := LineasPedidoArray.Objects[ J ];

                              TipoProducto := LineaPedidoObject.ValueByName( 'product_type' );
                              CodigoArticulo := LineaPedidoObject.ValueByName( 'sku' );
                              CantidadPedida := StrToDecimal( LineaPedidoObject.ValueByName( 'qty_ordered' ) );
                              CantidadCancelada := StrToDecimal( LineaPedidoObject.ValueByName( 'qty_canceled' ) );
                              CantidadTotal := CantidadPedida - CantidadCancelada;

                              If   ( CantidadTotal>0.0 ) and ( TipoProducto<>'configurable' )
                              then begin

                                   ParentItemObject := LineaPedidoObject.ObjectByName( 'parent_item' );

                                   // Si existe ParentItemObject es porque es una opción de un artículo configurable
                                   // Por lo tanto las clases están incluídas en su código. P.e. : AR-01·XL·AZ

                                   CodigoClaseA := '';
                                   CodigoClaseB := '';

                                   If   Assigned( ParentItemObject )
                                   then ExtraeClases( CodigoArticulo, CodigoClaseA, CodigoClaseB );     // Extrae las clases y las quita de CodigoArticulo

                                   If   not Articulo.Obten( CodigoArticulo, DsArticuloFields )         // Si no existe se utiliza un registro genérico. Antes eso que perder una línea.
                                   then Articulo.CreaArticuloManual( CodigoArticulo, DsArticuloFields );

                                   If   ParametrosTiendaVirtual.UnidadesSonCajas
                                   then begin
                                        NroCajas := CantidadTotal;
                                        CantidadTotal := NroCajas * DsArticuloFields.UnidadesPorCaja.Value;
                                        end
                                   else NroCajas := 0.0;

                                   DmLineaMovimientoTable.Append;

                                   DmLineaMovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                                   DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                                   DmLineaMovimientoFields.NroPagina.Value := 0;
                                   DmLineaMovimientoFields.NroLinea.Value := NroLinea;
                                   DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                                   DmLineaMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.FechaAplicacion.Value;
                                   DmLineaMovimientoFields.UIDArticulo.AsGuid := Articulo.Identificador;

                                   If   not DsArticuloFields.Tienda_NoPublicarClases.Value and
                                        ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones
                                   then If   ExisteClaseA
                                        then begin
                                             DmLineaMovimientoFields.CodigoClaseA.Value := CodigoClaseA;
                                             If   ExisteClaseB
                                             then DmLineaMovimientoFields.CodigoClaseB.Value := CodigoClaseB;
                                             end;

                                   DmLineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;

                                   {
                                   CodigoClaseB
                                   CodigoClaseC
                                   LoteFabricacion
                                   NumeroSerie
                                   }

                                   DmLineaMovimientoFields.Descripcion.Value := DsArticuloFields.Descripcion.Value; // LineaPedidoObject.ValueByName( 'name' );

                                   If   ParametrosTiendaVirtualModule.SeleccionAlmacen in [ 0, 2 ]
                                   then DmLineaMovimientoFields.CodigoAlmacen.Value := DsArticuloFields.CodigoAlmacen.Value
                                   else DmLineaMovimientoFields.CodigoAlmacen.Value := ParametrosTiendaVirtualModule.CodigoAlmacen;

                                   DmLineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( DmLineaMovimientoFields.CodigoAlmacen.Value, DsArticuloFields );

                                   DmLineaMovimientoFields.NroCajas.Value := NroCajas;
                                   DmLineaMovimientoFields.Cantidad.Value := CantidadTotal;
                                   DmLineaMovimientoFields.CantidadAjustada.Value := DmLineaMovimientoFields.Cantidad.Value;

                                   // Si es una opción de un artículo configurable los precios y descuentos van en el parent !!?

                                   If   Assigned( ParentItemObject )
                                   then PreciosLineaObject := ParentItemObject
                                   else PreciosLineaObject := LineaPedidoObject;

                                   If   ParametrosTiendaVirtual.AplicarPreciosyDtos
                                   then Articulo.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value, DmLineaMovimientoFields, DsClienteFields.Codigo.Value )
                                   else begin
                                        FacturaVentas.ObtenTipoIVAArticulo( DmMovimientoFields.Fecha.Value,
                                                                            DsArticuloFields,
                                                                            DsTiposIVAFields,
                                                                            DsSerieFacturacionFields,
                                                                            DsClienteFields );

                                        If   DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value
                                        then begin
                                             DmLineaMovimientoFields.PrecioIVA.Value := StrToExtended( PreciosLineaObject.ValueByName( 'price_incl_tax' ) );
                                             Movimiento.ObtenPrecioVentaBase( DsTiposIVAFields,
                                                                              DmLineaMovimientoFields.Cantidad.Value,
                                                                              DmLineaMovimientoFields.PrecioIVA.Value,
                                                                              PrecioBase,
                                                                              DsClienteFields.Factura_ModeloIVA.Value=micConRE );
                                             end
                                        else PrecioBase := StrToExtended( PreciosLineaObject.ValueByName( 'price' ) );

                                        If   ParametrosTiendaVirtual.UnidadesSonCajas and ( DsArticuloFields.UnidadesPorCaja.Value<>0.0 )
                                        then PrecioBase := Redondea( PrecioBase / DsArticuloFields.UnidadesPorCaja.Value, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );

                                        DmLineaMovimientoFields.Precio.Value := PrecioBase;
                                        DmLineaMovimientoFields.Descuento.Value := StrToDecimal( PreciosLineaObject.ValueByName( 'discount_percent' ) );
                                        end;

                                   Movimiento.ActualizaCamposCalculadosLineaVenta( DmMovimientoFields, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields, DsSerieFacturacionFields, DsTiposIVAFields );

                                   DecAdd( ImporteTotal, DmLineaMovimientoFields.ImporteTotal.Value );

                                   // El registro de actualización del artículo contiene el identificador del 'option_value' en el campo Id1 (ver POS01)

                                   If   DsArticuloFields.Tienda_ComentariosClientes.Value
                                   then If   RegistroActualizacion.Obten( rgaArticulo, DsArticuloFields.Codigo.Value )
                                        then begin

                                             var LineaPedidoComentariosObject : TclJSONObject := nil;

                                             // Si es un artículo configurable los comentarios están en parent_item

                                             If   Assigned( ParentItemObject )
                                             then LineaPedidoComentariosObject := ParentItemObject
                                             else LineaPedidoComentariosObject := LineaPedidoObject;

                                             var ProductOptionObject :=  LineaPedidoComentariosObject.ObjectByName( 'product_option' );
                                             If   Assigned( ProductOptionObject )
                                             then begin
                                                  ExtensionAttributesObject := ProductOptionObject.ObjectByName( 'extension_attributes' );
                                                  If   Assigned( ExtensionAttributesObject )
                                                  then begin
                                                       var CustomOptionsArray := ExtensionAttributesObject.ArrayByName( 'custom_options' );
                                                       If   Assigned( CustomOptionsArray )
                                                       then For var Inx := 0 to CustomOptionsArray.Count - 1 do
                                                              begin
                                                              var OptionObject := CustomOptionsArray.Objects[ Inx ];
                                                              If   Assigned( OptionObject )
                                                              then If   StrToInt( OptionObject.ValueByname( 'option_id' ) )=RegistroActualizacion.RegistroActualizacionFields.Id1.Value
                                                                   then begin
                                                                        DmLineaMovimientoFields.Anotacion.Value := OptionObject.ValueByName( 'option_value' );
                                                                        Break;
                                                                        end;
                                                              end;
                                                       end;
                                                  end;
                                             end
                                        else ProcessFrame.AddMsg( ntWarning, Format( RsMsg37, [ DsArticuloFields.Codigo.Value, DsArticuloFields.Descripcion.Value ] ) );

                                   DmLineaMovimientoTable.Post;

                                   Inc( NroLinea );
                                   end;

                              end;

                            // Procesando posibles recargos o descuentos no indicados en el documento (de momento solo recargos por contra reembolsos)

                            FacturaVentas.ObtenCuotasPortes( DmMovimientoFields.Portes.Value,
                                                             DmMovimientoFields.Fecha.Value,
                                                             DsClienteFields.Factura_ModeloIVA.Value,
                                                             CuotaIVAPortes,
                                                             CuotaREPortes );

                            ImporteTotal := ImporteTotal + DmMovimientoFields.Portes.Value + CuotaIVAPortes + CuotaREPortes;


                            {
                            If   ImporteTotalPedido<>ImporteTotal
                            then begin

                                 DmLineaMovimientoTable.Append;

                                 DmLineaMovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                                 DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                                 DmLineaMovimientoFields.NroPagina.Value := 0;
                                 DmLineaMovimientoFields.NroLinea.Value := NroLinea;
                                 DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                                 DmLineaMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.FechaAplicacion.Value;
                                 DmLineaMovimientoFields.UIDArticulo.AsGuid := Articulo.Identificador;
                                 DmLineaMovimientoFields.CodigoArticulo.Value := ArticuloManual;
                                 DmLineaMovimientoFields.Descripcion.Value := RsRecargosDescuentos;
                                 DmLineaMovimientoFields.CodigoAlmacen.Value := '';
                                 DmLineaMovimientoFields.Cantidad.Value := 1;
                                 DmLineaMovimientoFields.CantidadAjustada.Value := 1;

                                 Recargo := ImporteTotalPedido - ImporteTotal;

                                 If   DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value
                                   then begin
                                        DmLineaMovimientoFields.PrecioIVA.Value := Recargo;
                                        Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                                                         DmLineaMovimientoFields.Cantidad.Value,
                                                                         DmLineaMovimientoFields.PrecioIVA.Value,
                                                                         Recargo,
                                                                         ClienteFields.Factura_ModeloIVA.Value=micConRE );
                                        end;

                                 DmLineaMovimientoFields.Precio.Value := Recargo;

                                 Articulo.Obten( DmLineaMovimientoFields.CodigoArticulo.Value , DsArticuloFields );  // Aunque es una linea manual hay que recuperar el registro con los datos por defecto

                                 Movimiento.ActualizaCamposCalculadosLineaVenta( tmPedidoVenta, DmLineaMovimientoFields, ClienteFields, DsArticuloFields, SerieFacturacionFields, TiposIVAFields );

                                 DmLineaMovimientoTable.Post;
                                 end;
                            }

                            // Al hacer esta llamada se destruye el contenido de ConsultaPedidosArray original, por eso trabajo sobre una copia del mismo

                            MarcarEstadoPedido( IdPedido, DmMovimientoFields.NroDocumento.Value );

                            // La clave del pedido = Ejercicio.NroOperacion : 2020.00000024
                            // Los registros de pedidos solo existen mientras estén pendientes de entrega. Una vez totalmente entregados se borra el registro para evitar procesos posteriores (shipment).

                            RegistroActualizacion.Edita( rgaOrder, IntToStr( DmMovimientoFields.Ejercicio.Value ) + '-' + StrIntPadded( DmMovimientoFields.NroOperacion.Value, 8 ) );

                            RegistroActualizacion.RegistroActualizacionFields.Id.Value := IdPedido;
                            RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
                            RegistroActualizacion.RegistroActualizacionFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                            RegistroActualizacion.RegistroActualizacionFields.Serie.Value := DmMovimientoFields.Serie.Value;
                            RegistroActualizacion.RegistroActualizacionFields.NroDocumento.Value := DmMovimientoFields.NroDocumento.Value;

                            try
                              RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
                            except on E : Exception do
                              begin

                              // Un error actualizando el registro no debe impedir que se descargue el pedido

                                                            RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
                              end;
                            end;

                            EnterpriseDataModule.Commit( StId );

                            ProcessFrame.AddMsg( ntInformation, Format( RsMsg30, [ DmMovimientoFields.Serie.Value, DmMovimientoFields.NroDocumento.Value, DsClienteFields.Codigo.Value, DsClienteFields.Nombre.Value ] ), False, True );

                            SeHanProcesadoPedidos := True;

                          except on E : Exception do
                            begin
                            EnterpriseDataModule.Rollback( StId );
                            ProcessFrame.AddMsg( ntError, Format( RsMsg10, [ IdPedido ] ) );
                            ProcessFrame.AddMsg( ntError, E.Message );
                            end;
                          end;

                        end;

                   end;

            end;

       finally
         FreeAndNil( PedidosResponse );
         end;

     until not HayMasPedidos;

     // Aprovecho para cambiar el estado de los pedidos a enviados si se ha exportado el pedido y se ha marcado el albarán como enviado

     If   SeHanProcesadoPedidos
     then MarcaPedidosEnviados;

end;

procedure TSincronizacionTiendaMagentoModule.MarcaPedidosEnviados;

var CodigoEstado : String;

begin

     If   ParametrosTiendaVirtual.EstadoPedidosEnviados=''
     then CodigoEstado := 'complete'
     else CodigoEstado := ParametrosTiendaVirtual.EstadoPedidosEnviados;

     // Si existe el registro del pedido es porque no está totalmente servido

     DmRegistroActualizacionTable.SetRange( [ Ord( rgaOrder ) ] );
     try
       DmRegistroActualizacionTable.First;
       While not DmRegistroActualizacionTable.Eof do
         begin

         // TipoMovimiento;Ejercicio;Serie;NroDocumento

         If   DmMovimientoTable.FindKey( [ tmPedidoVenta,
                                           DmRegistroActualizacionFields.Ejercicio.Value,
                                           DmRegistroActualizacionFields.Serie.Value,
                                           DmRegistroActualizacionFields.NroDocumento.Value ] )
         then begin

              // Solo si ha sido totalmente servido. No contemplo, de momento, la posibilidad de marcar como enviados los pedidos parcialmente servidos.

              If   DmMovimientoFields.Situacion.Value=epProcesado
              then begin

                   // TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen
                   // Ejercicio;NroOperacion

                   If   DmLineaMovimientoOrigenTable.FindEqualFirst( [ tmPedidoVenta, DmMovimientoFields.Ejercicio.Value, DmMovimientoFields.NroOperacion.Value ] )
                   then If   DmMovimientoOrigenTable.FindKey( [ DmLineaMovimientoOrigenFields.Ejercicio.Value, DmLineaMovimientoOrigenFields.NroOperacion.Value ] )
                        then If   DmMovimientoOrigenFields.Situacion.Value=epaEnviado  // Es un albarán
                             then begin
                                  MarcarEstadoPedido( DmRegistroActualizacionFields.Id.Value, DmMovimientoFields.NroDocumento.Value, CodigoEstado );
                                  With DmRegistroActualizacionFields do
                                    ProcessFrame.AddMsg( ntInformation, Format( RsMsg38, [ Ejercicio.Value, Serie.Value, NroDocumento.Value ] ) );
                                  DmRegistroActualizacionTable.Delete;
                                  Continue;  // Ya está posicionado en el siguiente
                                  end;

                   end;

              end;

         DmRegistroActualizacionTable.Next;
         end;

     finally
       DmRegistroActualizacionTable.CancelRange;
       end;

end;

// Estos procedimientos están diseñados para comprobar el envío de pedidos desde Magento.
// Si se han convertido en albaranes se intenta suprimir el registro de actualización local.
// De momento no se utiliza este enfoque.

function TSincronizacionTiendaMagentoModule.ObtenEnviosPedido(     IdPedido   : LongInt;
                                                               out EnviosArray : TclJSONArray ) : Boolean;

var EnviosResponse : TclJSONObject;

begin

     Result :=RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'shipment?searchCriteria[filter_groups][0][filters][0][field]=order_id&' +
                                                            'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                            'searchCriteria[filter_groups][0][filters][0][value]=' + IntToStr( IdPedido ) ) );
     If   Result
     then try
            EnviosResponse := RestRpc.ResponseJSON as TclJSONObject;
            // Si está vacío, items es un TElJSONValue, no un array
            EnviosArray := EnviosResponse.ArrayByName( 'items' );
          except
            Result := False;
            end
     else begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

procedure TSincronizacionTiendaMagentoModule.DescargaEnviosNuevos;  // Shipments, o albaranes de venta en Gestwin

var  EnviosArray : TclJSONArray;

begin

     // Si existe el registro del pedido es porque no está totalmente servido

     DmRegistroActualizacionTable.SetRange( [ Ord( rgaOrder ) ] );
     try
       DmRegistroActualizacionTable.First;
       While not DmRegistroActualizacionTable.Eof do
         begin

         // TipoMovimiento;Ejercicio;Serie;NroDocumento

         If   DmMovimientoTable.FindKey( [ tmPedidoVenta,
                                           DmRegistroActualizacionFields.Ejercicio.Value,
                                           DmRegistroActualizacionFields.Serie.Value,
                                           DmRegistroActualizacionFields.NroDocumento.Value ] )
         then begin
              If   ObtenEnviosPedido( DmRegistroActualizacionFields.Id.Value, EnviosArray )
              then begin


                   end;
              end
         else begin
              With DmRegistroActualizacionFields do
                ProcessFrame.AddMsg( ntInformation, Format( RsMsg36, [ Ejercicio.Value, Serie.Value, NroDocumento.Value ] ) );
              DmRegistroActualizacionTable.Delete;
              Continue;  // Ya está posicionado en el siguiente
              end;

         DmRegistroActualizacionTable.Next;
         end;

     finally
       DmRegistroActualizacionTable.CancelRange;
       end;

end;

function TSincronizacionTiendaMagentoModule.EsUnArticuloConRelacionados( Codigo : String ) : Boolean;
begin
     // Solo se comprueba si existe, al menos, un artículo en la lista de relacionados
     // El proceso de publicación se encargará de excluir a los que no están en la tienda
     Result := DmArticulosRelacionadosTable.FindEqualFirst( [ Codigo, 0 ] );
end;

procedure  TSincronizacionTiendaMagentoModule.CreaNuevoClienteGestwin( ClienteObject : TclJSONObject );

var CodigoCliente : String;
    AddressObject : TclJSONObject;
    AddressesArray,
    StreetArray : TclJSONArray;

    CodigoSubcuenta,
    CodigoPostal : String;

begin

     DmClienteTable.Cancel;   // Por si acaso

     CodigoCliente := DmClienteTable.GetNewAutoIncStringValue( ParametrosTiendaVirtualModule.PlantillaCodigoCliente );

     try

       DmClienteTable.Append;

       DmClienteFields.Codigo.Value := CodigoCliente;

       DmClienteFields.FechaAlta.Value := ApplicationContainer.TodayDate;
       DmClienteFields.Nombre.Value := ClienteObject.ValueByName ( 'firstname' ) + ' ' + ClienteObject.ValueByName ( 'lastname' );
       DmClienteFields.NIF.Value := ClienteObject.ValueByName( 'taxvat' );
       DmClienteFields.EMail.Value  := ClienteObject.ValueByName ( 'email' );

       If   DmClienteFields.NIF.Value=''
       then ProcessFrame.AddMsg( ntWarning, Format( RsMsg20, [ CodigoCliente, DmClienteFields.Nombre.Value ] ) );

       AddressesArray := ClienteObject.ArrayByName( 'addresses' );

       If   AddressesArray.Count>0
       then begin

            AddressObject := AddressesArray.Objects[ 0 ];
            StreetArray := AddressObject.ArrayByName( 'street' );

            ProcesaNombreCliente( AddressObject, DmClienteFields.Nombre );

            DmClienteFields.Domicilio.Value := StreetArray.Items[ 0 ].ValueString;
            DmClienteFields.Localidad.Value := AddressObject.ValueByName ( 'city' );
            DmClienteFields.CodigoPais.Value := Pais.CodigoPorCodigoISO2( AddressObject.ValueByName ( 'country_id' ) );
            CodigoPostal := AddressObject.ValueByName ( 'postcode' );
            DmClienteFields.CodigoProvincia.Value := Copy( CodigoPostal, 1, 2 );
            DmClienteFields.CodigoPostal.Value := Copy( CodigoPostal, 3, 3 );
            DmClienteFields.Telefono.Value := AddressObject.ValueByName ( 'telephone' );

            // Si la dirección 0 es la de envíos es porque el usuario no ha rellenado la de facturación

            If   AddressObject.BooleanByName( Fld_default_shipping )
            then begin
                 DmClienteFields.Envios_Nombre.Value := DmClienteFields.Nombre.Value;
                 DmClienteFields.Envios_Domicilio.Value := DmClienteFields.Domicilio.Value;
                 DmClienteFields.Envios_Localidad.Value := DmClienteFields.Localidad.Value;
                 DmClienteFields.Envios_CodigoProv.Value := DmClienteFields.CodigoProvincia.Value;
                 DmClienteFields.Envios_CodigoPostal.Value := DmClienteFields.CodigoPostal.Value;
                 end;

            end
       else begin
            ProcessFrame.AddMsg( ntWarning, Format( RsMsg19, [ DmClienteFields.Nombre.Value ] ) );
            Exit;
            end;

       If   AddressesArray.Count>1
       then begin

            AddressObject := AddressesArray.Objects[ 1 ];
            StreetArray := AddressObject.ArrayByName( 'street' );

            ProcesaNombreCliente( AddressObject, DmClienteFields.Envios_Nombre );

            DmClienteFields.Envios_Domicilio.Value := StreetArray.Items[ 0 ].ValueString;
            DmClienteFields.Envios_Localidad.Value := AddressObject.ValueByName ( 'city' );
            CodigoPostal := AddressObject.ValueByName ( 'postcode' );
            DmClienteFields.Envios_CodigoProv.Value := Copy( CodigoPostal, 1, 2 );
            DmClienteFields.Envios_CodigoPostal.Value := Copy( CodigoPostal, 3, 3 );
            DmClienteFields.Envios_FormaEnvio.Value := AddressObject.ValueByName( 'method' );
            // DmClienteFields.Envios_Transportista.Value :=
            // DmClienteFields.Envios_CodigoFormaEnvio.Value :=

            end;

       CodigoSubcuenta := '4300' + DmClienteFields.Codigo.Value;
       Cuenta.InsertaSubcuenta( CodigoSubcuenta, DmClienteFields.Nombre.Value );
       DmClienteFields.Subcuenta.Value := CodigoSubcuenta;
       DmClienteFields.TiendaVirtual.Value := True;

       DmClienteFields.Factura_Moneda.Value := 0;
       DmClienteFields.Factura_ModeloIVA.Value := micSinRE;  // Dependerá del tipo de mayorista
       DmClienteFields.Factura_NroCopias.Value := 1;
       DmClienteFields.Factura_NroCopiasAlbaran.Value := 1;

       DmClienteFields.Cobro_MesNoCobro.Value := 0;
       DmClienteFields.Cobro_CtaEntidad.Value := '572000000';  // Por defecto. Podría ser configurable?

       DmClienteFields.Cobro_FormaCobro.Value := ParametrosTiendaVirtualModule.CodigoFormaCobro;

       DmClienteTable.Post;

       ProcessFrame.AddMsg( ntInformation, Format( RsMsg11, [ DmClienteFields.Codigo.Value, DmClienteFields.Nombre.Value ] ) );

     finally
       DmClienteTable.Cancel;
       end;

end;

function TSincronizacionTiendaMagentoModule.ObtenDatosAtributo(     Codigo             : String;
                                                                out AttributeId        : Integer;
                                                                    AttributeOptionIds : TStringList = nil ) : Boolean;

var AttributesResponse,
    AttributeObject,
    OptionObject : TclJSONObject;
    AttributesArray,
    OptionsArray : TclJSONArray;
    RestResult : Boolean;

begin

     Result := False;

     RestResult := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'products/attributes?searchCriteria[filterGroups][0][filters][0][field]=attribute_code&' +
                                                                 'searchCriteria[filterGroups][0][filters][0][value]=' + Codigo ) );

     If   RestResult
     then try
            AttributesResponse := RestRpc.ResponseJSON as TclJSONObject;
            AttributesArray := AttributesResponse.ArrayByName( 'items' );
            If   Assigned( AttributesArray ) and
                 ( AttributesArray.Count>0 )
            then begin
                 AttributeObject := AttributesArray.Objects[ 0 ];
                 If   Assigned( AttributeObject )
                 then begin
                      Result := True;
                      AttributeId := StrToInt( AttributeObject.ValueByName( 'attribute_id' ) );
                      If   Assigned( AttributeOptionIds )
                      then begin
                           OptionsArray := AttributeObject.ArrayByName( 'options' );
                           If   OptionsArray.Count>0
                           then begin
                                AttributeOptionIds.Clear;
                                For var I := 0 to OptionsArray.Count - 1 do
                                  begin

                                  // Magento solo devuelve la descripción de la opción y su Id, pero no el código

                                  OptionObject := OptionsArray.Objects[ I ];
                                  var AttrLabel := OptionObject.ValueByName( 'label' );
                                  var AttrId := StrToIntDef( OptionObject.ValueByName( 'value' ), 0 );
                                  If   AttrId<>0
                                  then AttributeOptionIds.Values[ AttrLabel ] := IntToStr( AttrId );
                                  end;
                                end;
                           end;
                      end;
                 end;

            // Obteniendo información adicional
            {
            // Attribute set por defecto

            FHTTPResult := RestRpc.RestClient.Get( ParametrosTiendaVirtual.BaseURL( 'products/attribute-sets/4' ) );
            If   FHTTPResult=HTTP_RESULT_OK
            then AttributesResponse := RestRpc.RestClient.ResponseJSON as TclJSONObject;

            // Lista de grupos del attribute set por defecto

            FHTTPResult := RestRpc.RestClient.Get( ParametrosTiendaVirtual.BaseURL( 'products/attribute-sets/groups/list?searchCriteria[filterGroups][0][filters][0][field]=attribute_set_id&' +
                                                                          'searchCriteria[filterGroups][0][filters][0][value]=4' ) );
            If   FHTTPResult=HTTP_RESULT_OK
            then AttributesResponse := RestRpc.RestClient.ResponseJSON as TclJSONObject;
            }

          except
            Result := False;
            end;
end;

function TSincronizacionTiendaMagentoModule.ObtenCodigosArticulos(     Filtro,
                                                                       Condicion            : String;
                                                                       TamañoPagina,
                                                                       Pagina               : SmallInt;
                                                                       ListaArticulos       : TListaArticulos;
                                                                   var CodigoPrimerArticulo : String;
                                                                   var UltimaPagina         : Boolean ) : Boolean;

var ArticulosResponse,
    ArticuloObject : TclJSONObject;
    ArticulosArray : TclJSONArray;
    I : SmallInt;
    CodidoArticuloActual : String;

begin
     UltimaPagina := True;

     Result := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'products?searchCriteria[filter_groups][0][filters][0][field]=' + Filtro + '&' +
                                                             'searchCriteria[filter_groups][0][filters][0][condition_type]=' + Condicion + '&' +
                                                             'searchCriteria[pageSize]=' + IntToStr( TamañoPagina ) + '&' +
                                                             'searchCriteria[currentPage]=' + IntToStr( Pagina ) + '&' +
                                                             'fields=items[sku]' ) );
     If   Result
     then try

            ArticulosResponse := RestRpc.ResponseJSON as TclJSONObject;

            // Si está vacío items es un TclJSONValue, no un array

            ArticulosArray := ArticulosResponse.ArrayByName( 'items' );

            For I := 0 to ArticulosArray.Count - 1 do
              begin
              ArticuloObject := ArticulosArray.Objects[ I ];
              CodidoArticuloActual := ArticuloObject.ValueByName( 'sku' );
              If   I=0
              then begin
                   If   CodigoPrimerArticulo=CodidoArticuloActual  // Si coincide el tamaño de la página con el número de artículos dividido por el de páginas
                   then begin
                        UltimaPagina := True;
                        Result := False;
                        Exit;
                        end
                   else CodigoPrimerArticulo := CodidoArticuloActual;
                   end;
              ListaArticulos.Add( CodidoArticuloActual );
              end;

            UltimaPagina := ArticulosArray.Count<TamañoPagina;

          except
            Result := False;
            end;
end;

function TSincronizacionTiendaMagentoModule.ExisteArticulo( SKU : String ) : Boolean;
begin
     Result := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'products/' + SKU ) )
end;

function TSincronizacionTiendaMagentoModule.ObtenArticulo( SKU : String ) : TclJSONObject;

var ArticulosResponse : TclJSONObject;

begin
     Result := nil;
     If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'products/' + SKU ) )
     then Result := RestRpc.ResponseJSON as TclJSONObject;
end;

function TSincronizacionTiendaMagentoModule.SuprimeArticulo( Codigo : String ) : Boolean;
begin
     var ListaArticulos := TListaArticulos.Create;
     try
       ObtenCodigosVariantesArticulo( Codigo, ListaArticulos );
       For var CodigoArticulo in ListaArticulos do
         SuprimeArticuloSimple( CodigoArticulo, { NotificaErrores } False );
       SuprimeArticuloSimple( Codigo );
     finally
       ListaArticulos.Free;
       end;
end;

function TSincronizacionTiendaMagentoModule.SuprimeArticuloSimple( Codigo          : String;
                                                                   NotificaErrores : Boolean = True ) : Boolean;
begin
     Result := RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'products/' + Codigo ) );
     If   not Result and NotificaErrores
     then begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, Format( RsMsg6, [ Codigo ] ) );
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

function TSincronizacionTiendaMagentoModule.SuprimeCliente( Id     : LongInt;
                                                            Codigo : String ) : Boolean;
begin
     Result := RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'customers/' + IntToStr( Id ) ) );
     If   not Result
     then begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, Format( RsMsg24, [ Codigo ] ) );
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

function TSincronizacionTiendaMagentoModule.ObtenPedidosPendientes( out PedidosResponse : TclJSONObject ) : Boolean;

var CodigoEstado : String;

begin

     If   ParametrosTiendaVirtual.EstadoPedidosADescargar=''
     then CodigoEstado := 'pending'
     else CodigoEstado := ParametrosTiendaVirtual.EstadoPedidosADescargar;

     Result := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'orders?searchCriteria[filter_groups][0][filters][0][field]=status&' +
                                                             'searchCriteria[page_size]=10&' +
                                                             'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                             'searchCriteria[filter_groups][0][filters][0][value]=' + CodigoEstado ),
                            { PreserveResponse } True );

     If   Result
     then PedidosResponse := RestRpc.ResponseJSONObject  // Es una simple referencia a JSONResponse como TclJSONObject
     else begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

(*
function TSincronizacionTiendaMagentoModule.ObtenTiposIVA : Boolean;

var TaxRulesResponse,
    TaxRatesResponse,
    TaxRateObject,
    TaxRuleObject : TclJSONObject;
    TaxRateArray,
    TaxRulesArray,
    TaxRateIdsArray,
    ProductTaxClassIdsArray : TclJSONArray;
    I, J : SmallInt;
    TaxRateList : TDictionary<Integer,Decimal>;
    TaxRateId,
    ProductTaxClassId : Integer;
    TaxRateRate : Decimal;

procedure InicializaTablaTiposIVA;

var  I : SmallInt;

begin
     FillChar( FTiposIVATienda, SizeOf( FTiposIVATienda ) , #0 );
     For I := 1 to NroMaximoTiposIVA do
       begin
       Tasa.TipoIVA( I, Now, TiposIVAFields );
       If   TiposIVAFields.Codigo.IsNull
       then Break
       else FTiposIVATienda[ I ].FIVA := TiposIVAFields.IVARepercutido.Value;
       end
end;

begin

     InicializaTablaTiposIVA;

     FHTTPResult := RestRpc.RestClient.Get( ParametrosTiendaVirtual.BaseURL( 'taxRules/search?searchCriteria[filter_groups][0][filters][0][field]=id&' +
                                                                         'searchCriteria[filter_groups][0][filters][0][condition_type]=notnull' ) );
     Result := FHTTPResult=HTTP_RESULT_OK;
     If   Result
     then begin

          try
            TaxRulesResponse := RestRpc.RestClient.ResponseJSON as TclJSONObject;
            If   TaxRulesResponse[ 'items' ] is TclJSONArray
            then TaxRulesArray := TaxRulesResponse[ 'items' ] as TclJSONArray
            else Result := False;
          except
            Result := False;
            end;

          If   Result
          then begin
               FHTTPResult := RestRpc.RestClient.Get( ParametrosTiendaVirtual.BaseURL( 'taxRates/search?searchCriteria[filter_groups][0][filters][0][field]=tax_country_id&' +
                                                                                   'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                                                   'searchCriteria[filter_groups][0][filters][0][value]=ES' ) );
               Result := FHTTPResult=HTTP_RESULT_OK;
               If   Result
               then begin

                    try
                      TaxRatesResponse := RestRpc.RestClient.ResponseJSON as TclJSONObject;
                      If   TaxRatesResponse[ 'items' ] is TclJSONArray
                      then begin
                           TaxRateArray := TaxRatesResponse[ 'items' ] as TclJSONArray;
                           try
                             TaxRateList := TDictionary< Integer, Decimal >.Create;
                             For I := 0 to TaxRateArray.Length - 1 do
                               begin
                               TaxRateObject := TaxRateArray.GetObject( I );
                               TaxRateList.Add( TaxRateObject.GetIntegerValue( 'id' ),
                                                TaxRateObject.GetDoubleValue( 'rate' ) );
                               end;

                             For I := 0 to TaxRulesArray.Length - 1 do
                               begin
                               TaxRuleObject := TaxRulesArray.GetObject( I );
                               TaxRateIdsArray := TaxRuleObject[ 'tax_rate_ids' ] as TclJSONArray;
                               TaxRateId := TaxRateIdsArray.GetIntegerValue( 0 );
                               TaxRateRate := TaxRateList.Items[ TaxRateId ];  // Tengo el porcentaje de la tasa en la tienda
                               ProductTaxClassIdsArray := TaxRuleObject[ 'product_tax_class_ids' ] as TclJSONArray;
                               ProductTaxClassId := ProductTaxClassIdsArray.GetIntegerValue( 0 );
                               For J := 1 to NroMaximoTiposIVA do
                                 If   FTiposIVATienda[ J ].FIVA=TaxRateRate
                                 then begin
                                      FTiposIVATienda[ J ].FProductTaxClassId := ProductTaxClassId;
                                      Break;
                                      end;
                               end;

                           finally
                             TaxRateList.Free;
                             end;

                           end
                      else Result := False;
                    except
                      Result := False;
                      end;

                    end;

               end;

          end
     else begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

*)

procedure TSincronizacionTiendaMagentoModule.ActualizaConfiguracionGlobal;

var  I : Integer;
     FechaAplicacion : TDate;
     TaxClassId : Integer;
     RegistroActualizacionFields : TRegistroActualizacionFields;
     HayGrupos : Boolean;
     ListaTipos : TStringList;
     Descripcion : String;
     ResultOk : Boolean;

function ActualizaTaxClass( NroTipoImpositivo : SmallInt;
                            Descripcion,
                            ClassType         : String ) : Integer;

var TaxClassRequest,
    TaxClassResponse,
    TaxClass : TclJSONObject;
    TaxClassId : String;
    TotalCount : Integer;

begin

     Result := -1;

     RegistroActualizacionFields := RegistroActualizacion.Edita( rgaTaxClass, IntToStr( NroTipoImpositivo ) + '-' + ClassType );
     try

        TaxClassRequest := TclJSONObject.Create;

        If   RegistroActualizacionFields.Id.IsNull
        then begin

             // Primero compruebo si ya existe en la tienda

             ResultOk := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'taxClasses/search?searchCriteria[filter_groups][0][filters][0][field]=class_name&' +
                                                                       'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                                       'searchCriteria[filter_groups][0][filters][0][value]=' + Descripcion ) );
             If   ResultOk
             then try
                    TaxClassResponse := RestRpc.ResponseJSON as TclJSONObject;
                    If   Assigned( TaxClassResponse )  // A veces ocurre
                    then begin
                         TotalCount := StrToInt( TaxClassResponse.ValueByName( 'total_count' ) );
                         If   TotalCount=1
                         then begin
                              TaxClass := TaxClassResponse.ArrayByName( 'items' ).Objects[ 0 ];
                              RegistroActualizacionFields.Id.Value := StrToInt( TaxClass.ValueByname( 'class_id' ) );
                              end;
                         end;
                  except
                    // Si no se ha podido recuperar el Id mejor seguimos considerando que no existe
                    end;

             end
        else TaxClassRequest.AddValue( 'classId', IntToStr( RegistroActualizacionFields.Id.Value ) );

        TaxClassRequest.AddString( 'className', Descripcion );
        TaxClassRequest.AddString( 'classType', ClassType );

        var Parameters := TclJSONObject.Create;

        try

          Parameters.AddMember( 'taxClass', TaxClassRequest );

          If   RegistroActualizacionFields.Id.IsNull
          then ResultOk := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'taxClasses' ), Parameters )
          else ResultOk := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'taxClasses/' + IntToStr( RegistroActualizacionFields.Id.Value ) ), Parameters );

          If   ResultOk
          then begin
               TaxClassId := RestRpc.ResponseText.DeQuotedString( '"' ); // Devuelve simplemente el id como un texto
               RegistroActualizacionFields.Id.Value := StrToInt( TaxClassId );
               RegistroActualizacionFields.DatasetPost;
               Result := RegistroActualizacionFields.Id.Value;
               end
          else begin
               ProcesaMensajeError;
               ProcessFrame.AddMsg( ntError, Format( RsMsg21, [ Descripcion, RsTaxClass] ) );
               ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
               Abort;
               end;

        finally
          Parameters.Free;
          end;

     finally
       RegistroActualizacionFields.DatasetCancel;
       end;

end;

procedure ActualizaTaxRate( TiposIVAFields   : TTiposIVAFields;
                            ModeloImpositivo : TModeloIVACliente = micSinRE;
                            PaisFields       : TPaisFields = nil );

var TaxRateRequest,
    TaxRateResponse,
    TaxRate : TclJSONObject;
    CodigoISOPais,
    Descripcion : String;
    TotalCount : Integer;
    Tasa : Double;

begin

     If   Assigned( PaisFields )
     then begin
          CodigoISOPais := PaisFields.CodigoISO2.Value;
          Descripcion := PaisFields.Nombre.Value + '-' + Descripcion;
          end
     else CodigoISOPais := CodigoISOEspaña;

     var CodigoRegistro := CodigoISOPais +
                           IfThen( CodigoISOPais<>'', '-' ) +
                           IntToStr( DmTiposIVAFields.Codigo.Value ) +
                           '-' +
                           IntToStr( Ord( ModeloImpositivo ) );

     RegistroActualizacionFields := RegistroActualizacion.Edita( rgaTaxRate, CodigoRegistro );
     try

       Descripcion := TiposIVAFields.Descripcion.Value;
       Tasa := 0.0;

       If   TiposIVAFields.IVARepercutido.Value<>0.0
       then case ModeloImpositivo of
              micConRE :
                begin
                Descripcion := 'R.E. ' + Descripcion;
                Tasa := TiposIVAFields.RERepercutido.Value;
                end
              else  // micSinRE
                begin
                Descripcion := 'I.V.A. ' + Descripcion;
                Tasa := TiposIVAFields.IVARepercutido.Value;
                end;
              end;

       TaxRateRequest := TclJSONObject.Create;

       If   RegistroActualizacionFields.Id.IsNull
       then begin
            ResultOk := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'taxRates/search?searchCriteria[filter_groups][0][filters][0][field]=code&' +
                                                                      'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                                      'searchCriteria[filter_groups][0][filters][0][value]=' + Descripcion ) );
            If   ResultOk
            then try
                   TaxRateResponse := RestRpc.ResponseJSON as TclJSONObject;
                   If   Assigned( TaxRateResponse )
                   then begin
                        TotalCount := StrToInt( TaxRateResponse.ValueByName( 'total_count' ) );
                        If   TotalCount=1
                        then begin
                             TaxRate := TaxRateResponse.ArrayByName( 'items' ).Objects[ 0 ];
                             RegistroActualizacionFields.Id.Value := StrToInt( TaxRate.ValueByname( 'id' ) );
                             end;
                        end;
                 except
                   end;

            end;

       If   not RegistroActualizacionFields.Id.IsNull
       then TaxRateRequest.AddValue( 'id', IntToStr( RegistroActualizacionFields.Id.Value ) );

       TaxRateRequest.AddString( 'taxCountryId', CodigoISOPais );
       TaxRateRequest.AddString( 'taxPostcode', '*' );
       TaxRateRequest.AddString( 'code', Descripcion );
       TaxRateRequest.AddValue( 'rate', DecimalToStr( Tasa ) );

       var Parameters := TclJSONObject.Create;

       try

         Parameters.AddMember( 'taxRate', TaxRateRequest );

         ResultOk := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'taxRates' ), Parameters );

         If   ResultOk
         then begin
              TaxRateResponse := RestRpc.ResponseJSON as TclJSONObject;
              RegistroActualizacionFields.Id.Value := StrToInt( TaxRateResponse.ValueByName( 'id' ) );
              RegistroActualizacionFields.DatasetPost;
              end
         else begin
                ProcesaMensajeError;
                ProcessFrame.AddMsg( ntError, Format( RsMsg21, [ Descripcion, RsTaxRate ] ) );
                ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
                Abort;
                end;

       finally
         Parameters.Free;
         end;

     finally
       RegistroActualizacionFields.DatasetCancel;
       end;

end;

function ActualizaCustomerGroup( IndiceGrupo  : SmallInt;
                                 Nombre       : String;
                                 TaxClassId   : Integer;
                                 TaxClassName : String ) : Boolean;

var CustomerGroupRequest,
    CustomerGroupResponse,
    CustomerGroup : TclJSONObject;
    TotalCount : Integer;

begin

     RegistroActualizacionFields := RegistroActualizacion.Edita( rgaCustomerGroup, IntToStr( IndiceGrupo ) );
     try

       CustomerGroupRequest := TclJSONObject.Create;

       If   RegistroActualizacionFields.Id.IsNull
       then begin
            ResultOk := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'customerGroups/search?searchCriteria[filter_groups][0][filters][0][field]=code&' +
                                                                      'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                                      'searchCriteria[filter_groups][0][filters][0][value]=' + Nombre ) );
             If   ResultOk
             then try
                    CustomerGroupResponse := RestRpc.ResponseJSON as TclJSONObject;
                    TotalCount := StrToInt( CustomerGroupResponse.ValueByName( 'total_count' ) );
                    If   TotalCount=1
                    then begin
                         CustomerGroup := CustomerGroupResponse.ArrayByName( 'items' ).Objects[ 0 ];
                         RegistroActualizacionFields.Id.Value := StrToInt( CustomerGroup.ValueByname( 'id' ) );
                         end;
                  except
                    end;
            end;

       If   not RegistroActualizacionFields.Id.IsNull
       then CustomerGroupRequest.AddValue( 'id', IntToStr( RegistroActualizacionFields.Id.Value ) );

       CustomerGroupRequest.AddString( 'code', Nombre );
       CustomerGroupRequest.AddValue( 'taxClassId', IntToStr( TaxClassId ) );
       CustomerGroupRequest.AddString( 'taxClassName', TaxClassName );

       var Parameters := TclJSONObject.Create;

       try

         Parameters.AddMember( 'group', CustomerGroupRequest );

         If   RegistroActualizacionFields.Id.IsNull
         then Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'customerGroups' ), Parameters )
         else Result := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'customerGroups/' + IntToStr( RegistroActualizacionFields.Id.Value ) ), Parameters );

         If   Result
         then begin
              CustomerGroupResponse := RestRpc.ResponseJSON as TclJSONObject;
              RegistroActualizacionFields.Id.Value := StrToInt( CustomerGroupResponse.ValueByName( 'id' ) );
              RegistroActualizacionFields.DatasetPost;
              end
         else begin
              ProcesaMensajeError;
              ProcessFrame.AddMsg( ntError, Format( RsMsg22, [ Nombre ] ) );
              ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
              Abort;
              end;

       finally
         Parameters.Free;
         end;

     finally
       RegistroActualizacionFields.DatasetCancel;
       end;

end;

procedure ActualizaTaxRule( TiposIVAFields   : TTiposIVAFields;
                            ModeloImpositivo : TModeloIVACliente = micSinRE );

var TaxRuleRequest,
    TaxRuleResponse,
    TaxRule : TclJSONObject;
    Descripcion : String;
    CustomerTaxClassIdsArray,
    ProductTaxClassIdsArray,
    TaxRateIdsArray : TclJSONArray;
    I : SmallInt;
    CustomerTaxClassId : Integer;
    TipoExento : Boolean;
    TotalCount : Integer;

begin
     (*
     {"rule":{
       "code":"I.V.A. Normal",
       "customerTaxClassIds":[7,8,9],
       "position":0,
       "priority":0,
       "productTaxClassIds":[16],
       "taxRateIds":[9]
       }
     }
     *)

     RegistroActualizacionFields := RegistroActualizacion.Edita( rgaTaxRule, IntToStr( DmTiposIVAFields.Codigo.Value ) + '-' + IntToStr( Ord( ModeloImpositivo ) ) );
     try

       CustomerTaxClassIdsArray := TclJSONArray.Create;

       Descripcion := TiposIVAFields.Descripcion.Value;

       var Prefijo := '';

       case ModeloImpositivo of
         micConRE : Prefijo := 'R.E.';
         micSinRE : Prefijo := 'I.V.A.';
         // Añadir otros modelos
         end;

       Descripcion := Prefijo + ' ' + Descripcion;
       TipoExento := TiposIVAFields.IVARepercutido.Value=0.0;

       // Añado el TaxClass por defecto

       If   IdDefaulftTaxClass<>-1
       then If   ( ModeloImpositivo=micSinRE ) and not TipoExento
            then AddIntegerValueToArray( CustomerTaxClassIdsArray, IdDefaulftTaxClass );

       For I := 0 to LastCustomerGroupIndex do
         If   ParametrosTiendaVirtualModule.GrupoNombre[ I ]<>''
         then begin

              var AddGroup := False;

              // Lo que indica en realidad el añadir un grupo a la lista es si esta tasa le afecta o no

              If   TipoExento
              then AddGroup := ParametrosTiendaVirtualModule.GrupoModeloImpositivo[ I ]=micExento
              else If   ParametrosTiendaVirtualModule.GrupoModeloImpositivo[ I ]=micSinRE
                   then AddGroup := ModeloImpositivo=micSinRE
                   else If   ParametrosTiendaVirtualModule.GrupoModeloImpositivo[ I ]=micConRE
                        then AddGroup := ModeloImpositivo in [ micSinRE, micConRE ];

                 {  // Pendiente
                 micTipoFijo
                 micVentasOnline
                 }

              If   AddGroup
              then begin
                   CustomerTaxClassId := RegistroActualizacionTienda.ObtenTaxClassId( I, ttcCustomer );
                   AddIntegerValueToArray( CustomerTaxClassIdsArray, CustomerTaxClassId );
                   end;

              end
         else Break;

       If   CustomerTaxClassIdsArray.Count=0
       then begin
            CustomerTaxClassIdsArray.Free;
            Exit;
            end;

       TaxRuleRequest := TclJSONObject.Create;

       If   RegistroActualizacionFields.Id.IsNull
       then begin

            ResultOk := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'taxRules/search?searchCriteria[filter_groups][0][filters][0][field]=code&' +
                                                                      'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                                      'searchCriteria[filter_groups][0][filters][0][value]=' + Descripcion ) );
             If   ResultOk
             then try
                    TaxRuleResponse := RestRpc.ResponseJSON as TclJSONObject;
                    TotalCount := StrToInt( TaxRuleResponse.ValueByName( 'total_count' ) );
                    If   TotalCount=1
                    then begin
                         TaxRule := TaxRuleResponse.ArrayByName( 'items' ).Objects[ 0 ];
                         RegistroActualizacionFields.Id.Value := StrToInt( TaxRule.ValueByName( 'id' ) );
                         end;
                  except
                    end;

             end;

       If   not RegistroActualizacionFields.Id.IsNull
       then TaxRuleRequest.AddValue( 'id', IntToStr( RegistroActualizacionFields.Id.Value ) );

       TaxRuleRequest.AddString( 'code', Descripcion );
       TaxRuleRequest.AddValue( 'priority', '0' );
       TaxRuleRequest.AddValue( 'position', '0' );

       TaxRuleRequest.AddMember( 'customerTaxClassIds', CustomerTaxClassIdsArray );

       ProductTaxClassIdsArray := TclJSONArray.Create;
       AddIntegerValueToArray( ProductTaxClassIdsArray, RegistroActualizacionTienda.ObtenTaxClassId( TiposIVAFields.Codigo.Value, ttcProduct ) );
       TaxRuleRequest.AddMember( 'productTaxClassIds', ProductTaxClassIdsArray );

       TaxRateIdsArray := TclJSONArray.Create;
       AddIntegerValueToArray( TaxRateIdsArray, RegistroActualizacionTienda.ObtenTaxRateId( TiposIVAFields.Codigo.Value, ModeloImpositivo ) );
       TaxRuleRequest.AddMember( 'taxRateIds', TaxRateIdsArray );

       var Parameters := TclJSONObject.Create;

       try

         Parameters.AddMember( 'rule', TaxRuleRequest );

         ResultOk := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'taxRules' ), Parameters );

         If   ResultOk
         then begin
              TaxRuleResponse := RestRpc.ResponseJSON as TclJSONObject;
              RegistroActualizacionFields.Id.Value := StrToInt( TaxRuleResponse.ValueByName( 'id' ) );
              RegistroActualizacionFields.DatasetPost;
              end
         else begin
              ProcesaMensajeError;
              ProcessFrame.AddMsg( ntError, Format( RsMsg21, [ TiposIVAFields.Descripcion.Value, RsTaxRule ] ) );
              ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
              Abort;
              end;

       finally
       Parameters.Free;
       end;

     finally
       RegistroActualizacionFields.DatasetCancel;
       end;

end;

procedure BorraRegistros( DataName    : String;
                          KeyField    : String = 'code';
                          ExcludedIds : TIntegerArray = [] );
begin
     ResultOk := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( DataName + '/search?searchCriteria[filter_groups][0][filters][0][field]=' + KeyField + '&' +
                                                               'searchCriteria[filter_groups][0][filters][0][condition_type]=notnull' ) );
     If   ResultOk
     then try

            var SearchResponse := RestRpc.ResponseJSON as TclJSONObject;
            var TotalCount := StrToInt( SearchResponse.ValueByName( 'total_count' ) );
            If   TotalCount>0
            then begin
                 var Data := SearchResponse.ArrayByName( 'items' );
                 For var I := 0 to Data.Count - 1 do
                   begin
                   var Elemento := Data.Objects[ I ];
                   var ItemId := StrToIntDef( Elemento.ValueByName( 'id' ), -1 );
                   If   ( ItemId<>-1 ) and ( IntegerArrayIndexOf( ExcludedIds, ItemId )=-1 )
                   then try
                          RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( DataName + '/' + IntToStr( ItemId ) ) );
                        except   // Para que se pueda seguir intentado borrar el resto de los registros
                          end;
                   If   ProcessFrame.Canceled
                   then Break;
                   end;
                 end;

          except
            end;
end;


begin

     try

        ProcessFrame.AddMsg( ntInformation, RsLimpiandoDatosServidor );

        If   ReinicioTienda
        then begin
             SuprimeArticulos;                                    // Indispensable para poder suprimir las taxRules y taxRates
             BorraRegistros( 'customers', 'email' );              // Indispensable para poder suprimir los grupos de clientes
             BorraRegistros( 'taxRules' );
             BorraRegistros( 'taxRates' );
             BorraRegistros( 'customerGroups', 'code', [ 0, 1, 2, 3 ] );  // 0=NOT LOGGED IN, 1=General, 2=Wholesale y 3=Retailer
             end;

        ProcessFrame.AddMsg( ntInformation, RsMsg13 );

        // Compruebo que no hayan dos tipos con la misma descripción (Magento no lo permite)

        // TODO: Implementar los tipos de IVA por pais en la tienda

        With DmTiposIVATable do
          try

            FechaAplicacion := Tasa.UltimaFechaAplicacion( ApplicationContainer.TodayDate );
            SetRange( [ FechaAplicacion, CodigoEspaña, rgTiposIVA + 1 ], [ FechaAplicacion, CodigoEspaña, rgTiposIVA + NroMaximoTiposTasas ] );

            ListaTipos := TStringList.Create;
            ListaTipos.Duplicates := dupError;

            try
              First;
              While not Eof do
                begin
                Descripcion := Trim( DmTiposIVAFields.Descripcion.Value );
                If   ListaTipos.IndexOf( Descripcion )<>-1
                then begin
                     ProcessFrame.AddMsg( ntError, Format( RsMsg26, [ Descripcion ] ) );
                     ProcessFrame.AddMsg( ntError, RsMsg27 );
                     Abort;
                     end
                else ListaTipos.Add( Descripcion );
                Next;
                end;
            finally
              ListaTipos.Free;
              end;

            // Primera actualizo (o creo si es necesario) las TaxClasses y TaxRates

            First;
            While not Eof do
              begin
              ActualizaTaxClass( DmTiposIVAFields.Codigo.Value, Trim( DmTiposIVAFields.Descripcion.Value ), 'PRODUCT' );
              ActualizaTaxRate(  DmTiposIVAFields );
              If   DmTiposIVAFields.RERepercutido.Value<>0.0        // No necesito dos tipos exentos
              then ActualizaTaxRate( DmTiposIVAFields, micConRE );  // R.E.
              Next;
              end;

          finally
            CancelRange;
            end;

        // Grupo de cliente exento de I.V.A.

        {
        If   ExisteTipoNulo
        then begin
             TaxClassId := ActualizaTaxClass( I, TiendaVirtualModule.GrupoNombre[ I ], 'CUSTOMER' );
             end;
        }

        // Luego, los demás grupos de clientes y sus tarifas

        HayGrupos := False;
        For I := 0 to LastCustomerGroupIndex do
          If   ParametrosTiendaVirtualModule.GrupoNombre[ I ]<>''
          then begin
               TaxClassId := ActualizaTaxClass( I, ParametrosTiendaVirtualModule.GrupoNombre[ I ], 'CUSTOMER' );
               If   TaxClassId>0   // 0 es el Id del TaxClass Default
               then begin
                    ActualizaCustomerGroup( I, ParametrosTiendaVirtualModule.GrupoNombre[ I ], TaxClassId, ParametrosTiendaVirtualModule.GrupoNombre[ I ] );
                    HayGrupos := True;
                    end;
               end
          else Break;

        // Y, finalmente las TaxRules

        {
        If   HayGrupos
        then }
             With DmTiposIVATable do
               try
                 SetRange( [ FechaAplicacion, CodigoEspaña, rgTiposIVA + 1 ], [ FechaAplicacion, CodigoEspaña, rgTiposIVA + NroMaximoTiposTasas ] );
                 First;
                 While not Eof do
                   begin
                   ActualizaTaxRule( DmTiposIVAFields );
                   If   DmTiposIVAFields.RERepercutido.Value<>0.0
                   then ActualizaTaxRule( DmTiposIVAFields, micConRE );  // R.E.
                   Next;
                   end;
               finally
                 CancelRange;
                 end;

       RegistroActualizacion.Edita( rgaGlobal, CodigoConfiguracion );

       RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
       RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
       RegistroActualizacion.RegistroActualizacionFields.DatasetPost;

     finally
       RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
       end;

end;

function TSincronizacionTiendaMagentoModule.ObtenGrupoPorId( Id : Integer ) : SmallInt;
begin
     Result := -1;
     If   RegistroActualizacionTienda.ObtenCodigo( rgaCustomerGroup, Id )<>''
     then Result := StrToInt( RegistroActualizacionTienda.DmRegistroActualizacionIDFields.Codigo.Value );
end;

function TSincronizacionTiendaMagentoModule.ObtenClientes( out ClientesArray : TclJSONArray ) : Boolean;

var ClientesResponse : TclJSONObject;

begin

     ClientesArray := nil;

     // Utilizo la fecha de la última actualización para comprobar solo los clientes dados de alta más recientemente

     Result := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'customers/search?searchCriteria[filter_groups][0][filters][0][field]=updated_at&' +
                                                             'searchCriteria[filter_groups][0][filters][0][condition_type]=gteq&' +
                                                             'searchCriteria[filter_groups][0][filters][0][value]=' + FormatDateTime( 'YYYY-MM-DD', FechaUltimaActualizacion ) ) );
     If   Result
     then try
            ClientesResponse := RestRpc.ResponseJSON as TclJSONObject;
            // Si está vacío, items es un TElJSONValue, no un array
            ClientesArray := ClientesResponse.ArrayByName( 'items' );
          except
            Result := False;
            end
     else begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

function TSincronizacionTiendaMagentoModule.MarcarEstadoPedido( IdPedido,
                                                                NroDocumento : LongInt;
                                                                NuevoEstado  : String = 'processing' ) : Boolean;

var PedidoRequest : TclJSONObject;

begin
     PedidoRequest := TclJSONObject.Create;

     PedidoRequest.AddString( 'status', NuevoEstado );

     var Parameters := TclJSONObject.Create;

     try
       Parameters.AddMember( 'statusHistory', PedidoRequest );

       Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'orders/' + IntToStr( IdPedido ) + '/comments' ), Parameters );
       If   not Result
       then begin
            ProcesaMensajeError;
            ProcessFrame.AddMsg( ntError, Format( RsMsg9, [ NroDocumento ] ) );
            ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
            end;
     finally
       Parameters.Free;
       end;

end;

procedure TSincronizacionTiendaMagentoModule.ProcesaMensajeError;

var  ErrorObject : TclJSONObject;
     ErrorsArray :TclJSONArray;
     I : SmallInt;

procedure ExtractMessage( ItemObject : TclJSONObject );

var  MessageText : String;
     ParametersArray : TclJSONArray;
     ParametersObject : TclJSONObject;

procedure ApplyParameter( ParamName, ParamValue : String );
begin
     MessageText := StringReplace( MessageText, '%' + ParamName, ParamValue, [ rfReplaceAll, rfIgnoreCase ] );
end;

begin

     MessageText := ItemObject.ValueByName( 'message' );

     If   MessageText<>''
     then begin

          (*
            En 'message' se envía un texto con parámetros, por ejemplo, "%fieldName is a required field.".
            Luego en el objeto 'parameters' se incluye la relación de parametros y su valor :

            {
             "message": "One or more input exceptions have occurred.",
             "errors": [
               {
                 "message": "%fieldName is a required field.",
                 "parameters": {
                   "fieldName": "street"
                 }
               },
               {
                 "message": "%fieldName is a required field.",
                 "parameters": {
                   "fieldName": "regionId"
                 }
               }
             ]
           }

          *)

          // Puede ser un array o un único objeto con las variables

          var Processed := False;
          try
            ParametersArray := ItemObject.ArrayByName( 'parameters' );
            For var Inx := 0 to ParametersArray.Count- 1 do
              ApplyParameter( IntToStr( Inx + 1 ), ParametersArray.Items[ Inx ].ValueString );
            Processed := True;
          except
            end;

          If   not Processed
          then try
                 ParametersObject := ItemObject.ObjectByname( 'parameters' );
                 For var Inx := 0 to ParametersObject.Count - 1 do
                   begin
                   var Pn := ParametersObject.Members[ Inx ].Name;
                   ApplyParameter( Pn, ParametersObject.ValueByName( Pn ) );
                   end;
               except
                 end;

          RestRpc.ErrorMessage := MessageText;

          end
     else If   FHTTPResult<>0
          then RestRpc.ErrorMessage := 'Error HTTP nº ' + IntToStr( FHTTPResult )
          else RestRpc.ErrorMessage := '';

end;

begin

   RestRpc.ErrorMessage := '';

   try
     ErrorObject := RestRpc.ResponseJSONObject;
     If   Assigned( ErrorObject )
     then try
            RestRpc.ErrorMessage := ErrorObject.ValueByName( 'message' );
            ErrorsArray := ErrorObject.ArrayByName( 'errors' );
            If   Assigned( ErrorsArray )
            then begin
                 For I := 0 to ErrorsArray.Count - 1 do
                   ExtractMessage( ErrorsArray.Items[ I ] as TclJSONObject )
                 end
            else ExtractMessage( ErrorObject );
          except
            end
     else RestRpc.ErrorMessage := 'Mensaje de error : (' + RestRpc.ResponseText + ')';
   except
     end;

end;

procedure TSincronizacionTiendaMagentoModule.ProcesaNombreCliente(AddressObject: TclJSONObject; Field: TWideStringField);
begin
     Field.Value := AddressObject.ValueByName ( Fld_company );
     If   Field.Value=''
     then Field.Value := AddressObject.ValueByName ( 'lastname' ) + ', ' + AddressObject.ValueByName ( 'firstname' );
end;

procedure TSincronizacionTiendaMagentoModule.SuprimeExistenciasReservadas( CodigoArticulo : String );
begin
     RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'gestwin-catalog/inventory-reservation/' + CodigoArticulo  ) );
end;

function TSincronizacionTiendaMagentoModule.ActualizaExistenciasArticulo( CodigoArticulo  : String;
                                                                          CantidadMinima,
                                                                          Existencias     : Decimal;
                                                                          HayExistencias  : Boolean = False ) : Boolean;

var ExistenciasRequest : TclJSONObject;
    ConfigMinSaleQty : Integer;
    StockId : String;
    ExistenciasResponse : TclJSONObject;

begin

     StockId := '1';

     ExistenciasRequest := TclJSONObject.Create;

     ExistenciasRequest.Addvalue( 'qty', DecimalToStr( Existencias ) );
     ExistenciasRequest.AddBoolean( 'is_in_stock', HayExistencias  or ( Existencias>0.0 ) );

	    If   CantidadMinima=0.0
     then ConfigMinSaleQty := 1
     else ConfigMinSaleQty := 0;

     ExistenciasRequest.AddValue( 'use_config_min_sale_qty', IntToStr( ConfigMinSaleQty ) );
     If   CantidadMinima<>0.0
     then ExistenciasRequest.AddValue( 'min_sale_qty', DecimalToStr( CantidadMinima ) );

     var Parameters := TclJSONObject.Create;

     try

       Parameters.AddMember( 'stockItem', ExistenciasRequest );

       Result := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'products/' + CodigoArticulo + '/stockItems/' + StockId ), Parameters );

       If   Result
       then SuprimeExistenciasReservadas( CodigoArticulo )
       else begin
            ProcesaMensajeError;
            ProcessFrame.AddMsg( ntError, Format( RsMsg15, [ CodigoArticulo ] ) );
            ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
            end;

     finally
       Parameters.Free;
       end;

end;

procedure TSincronizacionTiendaMagentoModule.CompruebaAtributo( Codigo,
                                                                Etiqueta  : String;
                                                                InputType : String = 'select' );

var  AttributeId : Integer;
     ExisteAtributo : Boolean;

begin
     ExisteAtributo := ObtenDatosAtributo( Codigo, AttributeId );

     {
     If   ExisteAtributo and ReiniciarAtributos
     then begin
          BorraAtributo( AttributeId );
          ExisteAtributo := False;
          end;
     }

     // Los atributos se respetan por defecto, porque el usuario puede haber cambiado sus características
     // y es preferible conservarlas

     If   not ExisteAtributo
     then CreaAtributo( Codigo, Etiqueta, AttributeId, InputType );
end;

function TSincronizacionTiendaMagentoModule.CreaAtributo(     Codigo,
                                                              Etiqueta    : String;
                                                          out AttributeId : Integer;
                                                              InputType   : String = 'select' ): Boolean;

var AtributoRequest,
    AtributoResponse,
    OptionObject : TclJSONObject;
    OptionsArray : TclJSONArray;
    ParentId : SmallInt;
    URLKey : String;

begin

     AtributoRequest := TclJSONObject.Create;

     AtributoRequest.AddString( 'attribute_code', Codigo );
     AtributoRequest.AddBoolean( 'is_html_allowed_on_front', True );
     AtributoRequest.AddString( 'default_frontend_label', Etiqueta );
     AtributoRequest.AddBoolean( 'is_required', False );
     AtributoRequest.AddString( 'scope', 'global' );
     AtributoRequest.AddString( 'frontend_input', InputType );
     AtributoRequest.AddString( 'entity_type_id', '4' );
     AtributoRequest.AddString( 'is_unique', '0' );

     {  Se da de alta sin opciones y, una vez creado el atributo y si las tiene, hay que llamar a ActualizaOpcionesClaseAtributo }

     var Parameters := TclJSONObject.Create;

     try

       Parameters.AddMember( 'attribute', AtributoRequest );

       Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'products/attributes' ), Parameters );

       If   Result
       then begin

            AtributoResponse := RestRpc.ResponseJSON as TclJSONObject;
            AttributeId := StrToInt( AtributoResponse.ValueByName( 'attribute_id' ) );

            // Lo añado al conjunto por defecto de atributos

            Parameters.AddValue( 'attributeSetId', '4' );
            Parameters.AddValue( 'attributeGroupId', '7' );  // Product Details
            Parameters.AddValue( 'sortOrder', '10' );        // El orden que ocupa en la ficha del articulo (en este caso, detrás del peso)
            Parameters.AddString( 'attributeCode', Codigo );

            Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'products/attribute-sets/attributes' ), Parameters );

            end;

       If   not Result
       then begin
            ProcesaMensajeError;
            ProcessFrame.AddMsg( ntError, Format( RsMsg2, [ Codigo, Etiqueta ] ) );
            ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
            Abort;
            end;

     finally
       Parameters.Free;
       end;

end;

function TSincronizacionTiendaMagentoModule.BorraAtributo( AttributeId : Integer ): Boolean;
begin

     Result := RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'products/attributes/' + IntToStr( AttributeId ) ) );
     If   not Result
     then begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          end;
end;

// Hay que llamarlo justo después de ActualizaAtributo para añadir las opciones

function TSincronizacionTiendaMagentoModule.ActualizaOpcionesClaseAtributo( NroClase    : SmallInt;
                                                                            AttributeId : Integer;
                                                                            Codigo      : String ) : Boolean;

var AtributoRequest,
    AtributoResponse,
    OptionObject : TclJSONObject;
    SortOrder : Integer;

begin

     With DmClaseTable do
       begin
       SortOrder := 0;
       SetRange( [ NroClase, 0 ], [ NroClase, MaxSmallint ] );
       First;
       While not Eof and not ProcessFrame.Canceled do
         begin

         If   DmClaseFields.DisponibleTienda.Value
         then begin

              RegistroActualizacion.Edita( rgaClase, DmClaseFields.Codigo.Value + '-' + IntToStr( NroClase ) );

              try

                If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value
                then begin

                     AtributoRequest := TclJSONObject.Create;
                     OptionObject := TclJSONObject.Create;

                     OptionObject.AddString( 'value', DmClaseFields.Codigo.Value );
                     OptionObject.AddString( 'label', DmClaseFields.Descripcion .Value );

                     AtributoRequest.AddMember( 'option', OptionObject );

                     Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'products/attributes/' + IntToStr( AttributeId ) + '/options' ), AtributoRequest );

                      // Voy a considerar que si hay un error es porque ya existe.
                      // Si no es el caso, ya se revelará más adelante y habrá que reiniciar la configuración.

                     RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
                     RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;

                     RegistroActualizacion.RegistroActualizacionFields.DatasetPost;

                     If   not Result
                     then begin
                          {
                          ProcesaMensajeError;
                          ProcessFrame.AddMsg( ntError, Format( RsMsg41, [ DmClaseFields.Codigo.Value, Codigo ] ) );
                          Exit;
                          };
                          end;

                     ProcessFrame.AddRecordMsg( DataModule00.DmEmpresaFields.Articulo_NombreClase[ NroClase ].Value + ' - ' +
                                                DmClaseFields.Codigo.Value + ', ' +
                                                DmClaseFields.Descripcion.Value );
                     end;

              finally
                RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
                end;

              Inc( SortOrder );
              end;

         Next;
         end;

       Result := True;
       end;

end;

function TSincronizacionTiendaMagentoModule.ActualizaCategoria( IdCategoriaRaiz  : Integer;
                                                                CodigoPadre,
                                                                Codigo,
                                                                Nombre           : String;
                                                                Activo           : Boolean = True;
                                                                IncluirEnMenu    : Boolean = True) : Boolean;

var CategoriaRequest,
    CategoriaResponse,
    AttributeObject : TclJSONObject;
    CustomAttributesArray : TclJSONArray;
    ParentId : SmallInt;
    URLKey : String;

begin

     CategoriaRequest := TclJSONObject.Create;

     If   not RegistroActualizacion.RegistroActualizacionFields.Id.IsNull
     then CategoriaRequest.AddValue( 'id', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) );

     If   CodigoPadre=''  // Raiz
     then ParentId := IdCategoriaRaiz
     else ParentId := RegistroActualizacionTienda.ObtenId( rgaCategoria, CodigoPadre );

     CategoriaRequest.AddValue( 'parentId', IntToStr( ParentId ) );
     CategoriaRequest.AddString( 'name', Nombre );
     CategoriaRequest.AddBoolean( 'isActive', Activo );
     CategoriaRequest.AddBoolean( 'includeInMenu', IncluirEnMenu );

     // CategoriaRequest.AddString( 'path', URLKey );

     CustomAttributesArray := TclJSONArray.Create;
     AttributeObject := TclJSONObject.Create;
     URLKey := TclUrlEncoder.Encode( Nombre + '-' + Codigo, 'UTF-8' );
     AttributeObject.AddString( 'attribute_code', 'url_key' );
     AttributeObject.AddString( 'value', URLKey );
     CustomAttributesArray.Add( AttributeObject );

     AttributeObject := TclJSONObject.Create;
     AttributeObject.AddString( 'attribute_code', 'custom_use_parent_settings' );
     AttributeObject.AddString( 'value', '1' );
     CustomAttributesArray.Add( AttributeObject );

     CategoriaRequest.AddMember( 'custom_attributes', CustomAttributesArray );

     var Parameters := TclJSONObject.Create;

     try

     Parameters.AddMember( 'category', CategoriaRequest );

     If   RegistroActualizacion.RegistroActualizacionFields.Id.IsNull
     then Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'categories' ), Parameters )
     else Result := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'categories/' + IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) ), Parameters );

     If   Result
     then begin
          CategoriaResponse := RestRpc.ResponseJSON as TclJSONObject;
          RegistroActualizacion.RegistroActualizacionFields.Id.Value := StrToInt( CategoriaResponse.ValueByName( 'id' ) );
          RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
          RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
          end
     else begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntError, Format( RsMsg5, [ Codigo, Nombre ] ) );
          ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
          Abort;
          end;

     finally
       Parameters.Free;
       end;

end;

procedure TSincronizacionTiendaMagentoModule.AddStringValueToArray( JSONArray : TclJSONArray;
                                                                    Value     : String );
begin
     JSONArray.Add( TclJSONString.Create( Value ) );
end;

procedure TSincronizacionTiendaMagentoModule.AddIntegerValueToArray( JSONArray : TclJSONArray;
                                                                     Value     : Integer );
begin
     JSONArray.Add( TclJSONValue.Create( IntToStr( Value ) ) );
end;

function TSincronizacionTiendaMagentoModule.EncodeDataUrlImage( const AImagesFolder,
                                                                      AFileName       : String ) : String;
var  FileName : String;
     Src : TStream;

begin

     FileName := Trim( AFileName );
     If   ( Pos( 'data:', LowerCase( FileName ) )=1 )
     then begin
          Result := FileName;
          Exit;
          end;

     If   ExtractFilePath( FileName )=''
     then FileName := IncludeTrailingBackSlash( AImagesFolder ) + FileName;

     Src := TFileStream.Create( FileName, fmOpenRead );
     try
       Src.Position := 0;
       Result := Encoder.Encode( Src );
     finally
       Src.Free;
       end;

end;

function TSincronizacionTiendaMagentoModule.EncodeImage( ImageStream : TMemoryStream ) : String;
begin
     ImageStream.Position := 0;
     Result := Encoder.Encode( ImageStream );
end;

function TSincronizacionTiendaMagentoModule.ProcessExternalImages( ArticuloFields         : TArticuloFields;
                                                                   FechaImagenRegistro    : TDateTime;
                                                                   OnlyCheckModifications : Boolean = False;
                                                                   OnAddProductMedia      : TAddProductMediaEvent = nil ) : Boolean;

var ImageName,
    ImageFileName,
    ImageFileNameWE : String;
    SearchRec : TSearchRec;
    NeedsToBeUploaded : Boolean;

    CreationDateTime,
    LastWriteDateTime : TDateTime;

    ImageDirectory,
    ImageFilePath : String;
    ImageStream : TMemoryStream;

    CodigoArticulo,
    CodigoClaseA,
    CodigoClaseB : String;

begin

     Result := False;

     ImageDirectory := AddPathDelim( ParametrosTiendaVirtualModule.DirectorioImagenes );
     ImageName := ArticuloFields.Tienda_NombreImagen.Value;
     If   ImageName=''
     then ImageName := ArticuloFields.Codigo.Value  // Si es un artículo con clases, el código ya las contiene, pero el nombre de la imagen no.
     else begin
          CodigoArticulo := ArticuloFields.Codigo.Value;
          ExtraeClases( CodigoArticulo, CodigoClaseA, CodigoClaseB );
          If   CodigoClaseA<>''
          then begin
               ImageName := ImageName + SeparadorClases + CodigoClaseA;
               If   CodigoClaseB<>''
               then ImageName := ImageName + SeparadorClases + CodigoClaseB;
               end;
          end;

     { TODO : Como no tiene sentido subir imagenes para todas las combinaciones de clases (si hay más de una)
              habrá que pensar en determinar cual es la que puede tener variantes. Por ejemplo, si existen tallas
              y colores solo el color debe tener una imagen diferente. }

     If   FindFirst( ImageDirectory + ImageName + '*.' + ParametrosTiendaVirtualModule.FormatoImagenes, faArchive, SearchRec )=0
     then try
            repeat
              ImageFileName := SearchRec.Name;
              ImageFileNameWE := ExtractFileNameWithoutExtension( ImageFileName );
              If   ( Length( ImageFileNameWE )=Length( ImageName ) ) or
                   ( Copy( ImageFileNameWE, Length( ImageName ) + 1, 1 ) ='=' )
              then begin
                   ImageFilePath := ImageDirectory + SearchRec.Name;
                   If   FileExists( ImageFilePath )
                   then begin

                        If   not OnlyCheckModifications
                        then Result := True;  // ImageChecked

                        // Cualquier fecha -de creación, modificación o escritura- que se haya modificado, la utilizo como fecha de la imagen

                        CreationDateTime := FileTimeToDateTime( SearchRec.FindData.ftCreationTime );
                        LastWriteDateTime := FileTimeToDateTime( SearchRec.FindData.ftLastWriteTime );

                        FechaFicheroImagen := CreationDateTime;
                        If   LastWriteDateTime>FechaFicheroImagen
                        then FechaFicheroImagen := LastWriteDateTime;

                        // Si se está creando el registro hay que subir todas las imágenes sí o sí

                        NeedsToBeUploaded := FechaFicheroImagen>FechaImagenRegistro;

                        If   OnlyCheckModifications
                        then begin
                             Result := NeedsToBeUploaded;
                             Exit;
                             end
                        else If   Assigned( OnAddProductMedia )
                             then OnAddProductMedia( ImageFileName,
                                                     ArticuloFields.Descripcion.Value,
                                                     EncodeDataUrlImage( ImageDirectory, ImageFilePath ) );

                        end;
                   end;
            until ( SysUtils.FindNext( SearchRec )<>0 );
          finally
            SysUtils.FindClose( SearchRec );
            end;
end;

procedure TSincronizacionTiendaMagentoModule.AddProductMedia( ImageFileName,     // Nombre completo con extensión
                                                              ImageDescription,
                                                              ImageData          : String );

var  MediaGalleryContentObject,
     MediaGalleryEntryObject : TclJSONObject;
     TypesArray : TclJSONArray;
     ImageMimeType : String;

begin

     If   FechaFicheroMasReciente<FechaFicheroImagen
     then FechaFicheroMasReciente := FechaFicheroImagen;

     If   ParametrosTiendaVirtualModule.FormatoImagenes='jpg'
     then ImageMimeType := 'jpeg'
     else ImageMimeType := 'png';

     ImageMimeType := 'image/' + ImageMimeType;
     ImageFileName := LowerCase( ImageFileName );

     ImageUploaded := True;

     MediaGalleryEntryObject := TclJSONObject.Create;

     MediaGalleryEntryObject.AddString( 'media_type', 'image' );
     MediaGalleryEntryObject.AddString( 'label', ImageDescription );
     MediaGalleryEntryObject.AddValue( 'position', IntToStr( MediaGalleryEntriesArray.Count + 1 ) );
     MediaGalleryEntryObject.AddBoolean( 'disabled', False );

     TypesArray := TclJSONArray.Create;

     If   MediaGalleryEntriesArray.Count=0   // Es la imagen principal
     then begin
          AddStringValueToArray( TypesArray, 'image' );
          AddStringValueToArray( TypesArray, 'small_image' );
          AddStringValueToArray( TypesArray, 'thumbnail' );
          end
     else AddStringValueToArray( TypesArray, 'swatch_image' );

     MediaGalleryEntryObject.AddMember( 'types', TypesArray );

     MediaGalleryContentObject := TclJSONObject.Create;
     MediaGalleryContentObject.AddString( 'base64EncodedData', ImageData );
     MediaGalleryContentObject.AddString( 'type', ImageMimeType );
     MediaGalleryContentObject.AddString( 'name', ImageFileName );

     MediaGalleryEntryObject.AddMember( 'content', MediaGalleryContentObject );

     MediaGalleryEntriesArray.Add( MediaGalleryEntryObject );

end;

procedure TSincronizacionTiendaMagentoModule.ObtenAlmacenArticulo(     ArticuloFields    : TArticuloFields;
                                                                   out TodosLosAlmacenes : Boolean;
                                                                   out CodigoAlmacen     : String );
begin
     TodosLosAlmacenes := ParametrosTiendaVirtualModule.SeleccionAlmacen=0;
     If   ParametrosTiendaVirtualModule.SeleccionAlmacen=1
     then CodigoAlmacen := ParametrosTiendaVirtualModule.CodigoAlmacen
     else CodigoAlmacen := ArticuloFields.CodigoAlmacen.Value;
end;

function TSincronizacionTiendaMagentoModule.ArticuloConPrecio( ArticuloFields : TArticuloFields ) : Boolean;

var  Precio : Double;
     Cantidad,
     Recargo,
     Descuento : Decimal;

begin
     Result := ArticuloFields.Precio_Venta.Value<>0.0;
     If   not Result
     then With ParametrosTiendaVirtualModule do
            If   GrupoNombre[ 0 ]<>''
            then For var GroupIndex := 0 to LastCustomerGroupIndex do
                   If   GrupoNombre[ GroupIndex ]<>''
                   then begin
                        Cantidad := -1.0;  // Para que se aplique siempre la tarifa
                        Precio := 0.0;
                        Recargo := 0.0;
                        Descuento := 0.0;
                        Articulo.ObtenPrecioVentaPorTarifa( ArticuloFields.Codigo.Value, '', GrupoCodigoTarifa[ GroupIndex ], Cantidad, Precio, Recargo, Descuento, { ObtenerCantidadMinima } True );
                        If   Precio<>0.0
                        then begin
                             Result := True;
                             Break;
                             end;
                        end
                   else Break;
end;

function TSincronizacionTiendaMagentoModule.EnlazaArticuloConfigurable( SKUPadre,
                                                                        SKUHijo : String ) : Boolean;
begin
     // Primero quito cualquier enlace anterior

     var Parameters := TclJSONObject.Create;

     try

       Result := RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'configurable-products/' + SKUPadre + '/children/' + SKUHijo ) );

       // No importa mucho el resultado. Puede no estar enlazado.

       Parameters := TclJSONObject.Create;
       Parameters.AddString( 'childSku', SKUHijo );
       Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'configurable-products/' + SKUPadre + '/child' ), Parameters );
       If   not Result
       then begin
            ProcesaMensajeError;
            ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
            // Abort;
            end;

     finally
       Parameters.Free;
       end;
end;

function TSincronizacionTiendaMagentoModule.ActualizaArticulosRelacionados( ArticuloFields : TArticuloFields ) : Boolean;

var   ProductLinksArray : TclJSONArray;
      Parameters,
      ProductElementObject : TclJSONObject;

      ListaElementos : TListaArticulos;

      ProductPosition : SmallInt;
      CodigoElemento : String;

begin

     ProcessFrame.AddRecordMsg( ArticuloFields.Codigo.Value + ', ' + ArticuloFields.Descripcion.Value );

     With DmArticulosRelacionadosTable do
       begin

       Parameters := TclJSONObject.Create;
       ProductLinksArray := TclJSONArray.Create;

       try

         SetRange( [ ArticuloFields.Codigo.Value, 0 ] );
         ProductPosition := 1;
         First;
         While not Eof do
           begin

           If   DmArticuloAuxTable.FindKey( [ DmArticulosRelacionadosFields.CodigoArticuloRelacionado.Value ] )
           then If   not DmArticuloAuxFields.Obsoleto.Value and DmArticuloAuxFields.VisibleTienda.Value
                then begin
                     ProductElementObject := TclJSONObject.Create;
                     ProductElementObject.AddString( 'sku', ArticuloFields.Codigo.Value );
                     ProductElementObject.AddString( 'link_type', 'related' );
                     ProductElementObject.AddString( 'linked_product_sku', DmArticulosRelacionadosFields.CodigoArticuloRelacionado.Value );
                     // ProductElementObject.AddString( 'linked_product_type', 'simple' );
                     ProductElementObject.AddValue( 'position', IntToStr( ProductPosition ) );

                     ProductLinksArray.Add( ProductElementObject );

                     Inc( ProductPosition );
                     end;

           Next;
           end;

         If   ProductPosition>1
         then begin

              Parameters.AddMember( 'items', ProductLinksArray );

              Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'products/' + ArticuloFields.Codigo.Value + '/links' ), Parameters );
              If   not Result
              then begin
                   ProcesaMensajeError;
                   ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
                   // Abort;
                   end;

              end;

       finally
         ProductLinksArray.Free;
         CancelRange;
         end;

       end;


end;

function TSincronizacionTiendaMagentoModule.ActualizaDescuentosPorCategoria : Boolean;

var  CodigoClienteActual : String;
     DescuentosRequest : TclJSONObject;

     IdCliente,
     IdCategoria,
     IdTarifaCliente : Integer;

procedure EnviaPreciosClienteActual;
begin

     DescuentosRequest := TclJSONObject.Create;

     try

       // Primero suprimo todos los registros existentes en la tarifa del cliente

       If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'gestwin-customerprice/categoryprice/search?searchCriteria[filter_groups][0][filters][0][field]=customer_id&' +
                                                          'searchCriteria[filter_groups][0][filters][0][value]=' + IntToStr( IdCliente ) ) )
       then begin

            var ResponseObject := RestRpc.ResponseJSON as TclJSONObject;
            var ItemsArray := ResponseObject.ArrayByName( 'items' );

            For var Index := 0 to ItemsArray.Count -1 do
              begin
              var ItemObject := ItemsArray.Objects[ Index ];
              var Id := StrToInt( ItemObject.ValueByName( 'categoryprice_id' ) );
              If   not RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'gestwin-customerprice/categoryprice/' + IntToStr( Id ) ) )
              then begin
                   ProcessFrame.AddMsg( ntError, Format( RsMsg42, [ Id ] ) );
                   Abort;
                   end;
              end;

            end;

       // Y luego subo los nuevos descuentos

       While not DmTarifaVentasTable.Eof and
             ( CodigoClienteActual=DmTarifaVentasFields.CodigoTarifa.Value ) and
             not ProcessFrame.Canceled do
         begin

         IdCategoria := RegistroActualizacionTienda.ObtenId( rgaCategoria, 'FT·' + DmTarifaVentasFields.CodigoArticulo.Value );  // Es la familia
         If   IdCategoria>0
         then begin

              ProcessFrame.AddRecordMsg( CodigoClienteActual + '->' + DmTarifaVentasFields.CodigoArticulo.Value );

              var RequestObject := TclJSONObject.Create;
              var CategoryPriceObject := TclJSONObject.Create;
              var DiscountStr := StrFormat( DmTarifaVentasFields.Descuento.Value, DataModule00.DmEmpresaFields.Ventas_DecDto.Value, False, True );

              CategoryPriceObject.AddValue( 'category_id', IntToStr( IdCategoria ) );
              CategoryPriceObject.AddValue( 'customer_id', IntToStr( IdCliente ) );
              CategoryPriceObject.AddValue( 'discount', DiscountStr );

              RequestObject.AddMember( 'categoryprice', CategoryPriceObject );

              var ResultOk := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'gestwin-customerprice/categoryprice' ), RequestObject );

              If   not ResultOk
              then begin
                   ProcesaMensajeError;
                   ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
                   Exit;
                   end;

              RequestObject.Free;

              end;

         DmTarifaVentasTable.Next;
         end;

       If   not ProcessFrame.Canceled
       then begin
            RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
            RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
            end;

     finally
       FreeAndNil( DescuentosRequest );
       RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
       end;

end;


begin

     ProcessFrame.AddMsg( ntInformation, RsTarifasCategoria );

     With DmTarifaVentasTable do
       try

         IndexFieldNames := 'Tipo;CodigoTarifa;CodigoArticulo';   // CodigoTarifa=CodigoCliente, CodigoArticulo=CodigoFamilia
         SetRange( [ rtvClienteFamilia, '', '' ], [ rtvClienteFamilia, HighStrCode, HighStrCode ] );
         CodigoClienteActual := '';
         First;
         While not Eof and not ProcessFrame.Canceled do
           begin

           If   CodigoClienteActual<>DmTarifaVentasFields.CodigoTarifa.Value
           then begin

                CodigoClienteActual :=  DmTarifaVentasFields.CodigoTarifa.Value;

                IdCliente := RegistroActualizacionTienda.ObtenId( rgaCliente, CodigoClienteActual );
                If   IdCliente>0
                then begin

                     RegistroActualizacion.Edita( rgaTarifaFamilia, CodigoClienteActual );

                     // Compruebo si se ha modificado la tarifa o si, simplemente, no ha sido nunca actualizada

                     If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value
                     then begin
                          EnviaPreciosClienteActual;
                          Continue;
                          end;

                     end;

                end;

           Next;
           end;

       finally
         RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
         end;

end;

function TSincronizacionTiendaMagentoModule.ActualizaPreciosPorCliente : Boolean;

var  CodigoClienteActual : String;

     IdCliente,
     IdTarifaCliente : Integer;

     PreciosRequest : TclJSONObject;

procedure EnviaPreciosClienteActual;

procedure ActualizaTarifa( CodigoArticulo : String;
                           TipoRegistro   : Word );
begin

     var IdArticulo := RegistroActualizacionTienda.ObtenId( TipoRegistro, CodigoArticulo );

     If   IdArticulo>0
     then begin

          ProcessFrame.AddRecordMsg( CodigoClienteActual + '->' + CodigoArticulo );

          var RequestObject := TclJSONObject.Create;

          try

            var CustomerPriceObject := TclJSONObject.Create;
            var PriceStr := StrFormat( DmTarifaVentasFields.Precio.Value, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value, False, True );

            CustomerPriceObject.AddValue( 'customer_id', IntToStr( IdCliente ) );
            CustomerPriceObject.AddValue( 'product_id', IntToStr( IdArticulo ) );
            CustomerPriceObject.AddValue( 'log_price', priceStr );
            CustomerPriceObject.AddValue( 'new_price', priceStr );
            CustomerPriceObject.AddValue( 'qty', '1' );

            RequestObject.AddMember( 'customerprice', CustomerPriceObject );

            var ResultOk := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'gestwin-customerprice/customerprice' ), RequestObject );

            If   not ResultOk
            then begin
                 ProcesaMensajeError;
                 ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
                 end;

          finally
            RequestObject.Free;
            end;

          end;

end;

begin

     // Primero suprimo todos los registros existentes de la tarifa del cliente

     If   RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'gestwin-customerprice/customerprice/search?searchCriteria[filter_groups][0][filters][0][field]=customer_id&' +
                                                        'searchCriteria[filter_groups][0][filters][0][value]=' + IntToStr( IdCliente ) ) )
     then begin
          var ResponseObject := RestRpc.ResponseJSON as TclJSONObject;
          var ItemsArray := ResponseObject.ArrayByName( 'items' );

          For var Index := 0 to ItemsArray.Count -1 do
            begin
            var ItemObject := ItemsArray.Objects[ Index ];
            var Id := StrToInt( ItemObject.ValueByName( 'customerprice_id' ) );
            If   not RestRpc.Delete( ParametrosTiendaVirtual.BaseURL( 'gestwin-customerprice/customerprice/' + IntToStr( Id ) ) )
            then begin
                 ProcessFrame.AddMsg( ntError, Format( RsMsg42, [ Id ] ) );
                 Abort;
                 end;
            end;

          end;

     // Y luego subo los nuevos precios

     While not DmTarifaVentasTable.Eof and ( CodigoClienteActual=DmTarifaVentasFields.CodigoTarifa.Value ) do
       begin

       If   DmArticuloTable.FindKey( [ DmTarifaVentasFields.CodigoArticulo.Value ] )
       then begin

            // Si existen clases, éstas se suben como configuraciones y se han fijado los precios por cliente y artículo en la tarifa
            // de ventas, hay que poner el mismo precio en todas las variantes

            If   ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones and
                 not DmArticuloFields.Tienda_NoPublicarClases.Value
            then With DmClaseTable do
                   begin

                   // NroClase;NroOrden

                   SetRange( [ tcClaseA, 0 ], [ tcClaseA, MaxSmallint ] );
                   First;
                   While not Eof do
                     begin
                     If   DmClaseFields.DisponibleTienda.Value and
                          DmClasesArticuloTable.FindKey( [ DmArticuloFields.Codigo.Value, tcClaseA, DmClaseFields.Codigo.Value ] )
                     then begin

                          var CodigoArticuloClaseA := DmArticuloFields.Codigo.Value + SeparadorClases + DmClaseFields.Codigo.Value;

                          If   ExisteClaseB
                          then begin

                               With DmClaseAuxTable do
                                 begin
                                 SetRange( [ tcClaseB, 0 ], [ tcClaseB, MaxSmallint ] );
                                 First;
                                 While not Eof do
                                   begin

                                   If   DmClaseAuxFields.DisponibleTienda.Value and
                                        DmClasesArticuloTable.FindKey( [ DmArticuloFields.Codigo.Value, tcClaseB, DmClaseAuxFields.Codigo.Value ] )
                                   then ActualizaTarifa( CodigoArticuloClaseA + SeparadorClases + DmClaseAuxFields.Codigo.Value, rgaVarianteArticulo );

                                   Next;
                                   end;

                                 end;

                               end
                          else ActualizaTarifa( CodigoArticuloClaseA, rgaVarianteArticulo );
                          end;

                     Next;
                     end;

                   end
            else ActualizaTarifa( DmArticuloFields.Codigo.Value, rgaArticulo );

            end;

       DmTarifaVentasTable.Next;
       end;

     RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
     RegistroActualizacion.RegistroActualizacionFields.DatasetPost;

end;


begin

     ProcessFrame.AddMsg( ntInformation, RsTarifasCliente );

     With DmTarifaVentasTable do
       try

         IndexFieldNames := 'Tipo;CodigoTarifa;CodigoArticulo';
         SetRange( [ rtvClienteArticulo, '', '' ], [ rtvClienteArticulo, HighStrCode, HighStrCode ] );
         CodigoClienteActual := '';
         First;
         While not Eof do
           begin

           If   CodigoClienteActual<>DmTarifaVentasFields.CodigoTarifa.Value
           then begin

                CodigoClienteActual :=  DmTarifaVentasFields.CodigoTarifa.Value;

                RegistroActualizacion.Edita( rgaTarifaCliente, CodigoClienteActual );

                // Compruebo si se ha modificado la tarifa o si, simplemente, no ha sido nunca actualizada

                If   not RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value and
                     DmClienteTable.FindKey( [ CodigoClienteActual ] )
                then begin
                     IdCliente := RegistroActualizacionTienda.ObtenId( rgaCliente, CodigoClienteActual );
                     If   IdCliente>0
                     then begin
                          EnviaPreciosClienteActual;
                          Continue;
                          end;

                     end;

                end;

           Next;
           end;

       finally
         RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
         end;
end;

procedure TSincronizacionTiendaMagentoModule.ObtenCodigosVariantesArticulo( CodigoArticulo : String; ListaArticulos : TListaArticulos );

var  CodigoClaseA,
     CodigoClaseB,
     CodigoArticuloClaseA,
     CodigoArticuloConClases : String;

begin


     If   ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones
     then begin

          // Cada clase es un articulo virtual en la tienda

          With DmClaseTable do
             begin

             // NroClase;NroOrden

             SetRange( [ tcClaseA, 0 ], [ tcClaseA, MaxSmallint ] );
             First;
             While not Eof do
               begin

               If   DmClaseFields.DisponibleTienda.Value and
                    DmClasesArticuloTable.FindKey( [ CodigoArticulo, tcClaseA, DmClaseFields.Codigo.Value ] )
               then begin

                    CodigoClaseA := DmClaseFields.Codigo.Value;
                    CodigoClaseB := '';
                    CodigoArticuloClaseA := CodigoArticulo + SeparadorClases + CodigoClaseA;

                    If   ExisteClaseB
                    then begin

                         With DmClaseAuxTable do
                           begin
                           SetRange( [ tcClaseB, 0 ], [ tcClaseB, MaxSmallint ] );
                           First;
                           While not Eof do
                             begin

                             If   DmClaseAuxFields.DisponibleTienda.Value and
                                  DmClasesArticuloTable.FindKey( [ CodigoArticulo, tcClaseB, DmClaseAuxFields.Codigo.Value ] )
                             then begin
                                  CodigoClaseB := DmClaseAuxFields.Codigo.Value;
                                  CodigoArticuloConClases := CodigoArticuloClaseA + SeparadorClases + CodigoClaseB;
                                  ListaArticulos.Add( CodigoArticuloConClases );
                                  end;

                             Next;
                             end;

                           end;

                         end
                    else begin
                         CodigoArticuloConClases := CodigoArticuloClaseA;
                         ListaArticulos.Add( CodigoArticuloConClases );
                         end;

                    end;

              Next;
              end;

            end;

          end;

end;

function TSincronizacionTiendaMagentoModule.ActualizaArticuloConClases( ArticuloFields       : TArticuloFields;
                                                                        NoActualizarImagenes : Boolean = False ) : Boolean;

var  TodosLosAlmacenes : Boolean;
     CodigoPadre,
     CodigoAlmacen : String;
     Precio : Double;
     PuntoVerde,
     Recargo,
     Descuento : Decimal;
     EsUnaOferta : Boolean;

     DpArticuloFields : TArticuloFields;
     ConfigurableProductsLinks : TList<Integer>;

     CodigoArticuloClaseA,
     DescripcionArticuloClaseA,
     CodigoArticuloConClases,
     DescripcionArticuloConClases,
     CodigoClaseA,
     CodigoClaseB {,
     NombreImagen } : String;

     IdArticuloPrincipal : Integer;

     ExisteClaseArticulo : Array[ tcClaseA..tcClaseB ] of Boolean;

     ArticuloNuevo,
     Error : Boolean;

procedure ActualizaVarianteArticulo;
begin
     Articulo.ObtenPrecioyDtoVenta(  tmVenta,
                                     { CodigoCliente } '',
                                     ArticuloFields.Codigo.Value,
                                     CodigoClaseA,
                                     CodigoClaseB,
                                     '',
                                     { Cantidad } 1.0,
                                     Precio,
                                     PuntoVerde,
                                     Recargo,
                                     Descuento,
                                     EsUnaOferta,
                                     { CodigoTarifa } '',
                                     { Inicializar } True );

     DpArticuloFields.Codigo.Value := CodigoArticuloConClases;
     DpArticuloFields.Descripcion.Value := DescripcionArticuloConClases;
     DpArticuloFields.Precio_Venta.Value := Precio;
     DpArticuloFields.Dto_Venta.Value := Descuento;

     RegistroActualizacion.Edita( rgaVarianteArticulo, DpArticuloFields.Codigo.Value );

     try

       Error := not ActualizaArticulo( DpArticuloFields, { ArticuloAgrupado } False, NoActualizarImagenes, tatVariacionConfigurable );
       If   not Error
       then begin
            EnlazaArticuloConfigurable( ArticuloFields.Codigo.Value, DpArticuloFields.Codigo.Value );
            // Lo guardo porque necesito el Id de la variante del artículo
            RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
            end;

     finally
       RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
       end;

     // Se han actualizado las existencias al actualizar el registro
     If   not Error
     then RegistroActualizacion.Actualizado( rgaStock, ArticuloFields.Codigo.Value, { Value } True );

end;

procedure ActualizaVariantes( SoloComprobarExistencias : Boolean );

function CompruebaExistencias( CodigoArticulo, CodigoClaseA, CodigoClaseB : String ) : Boolean;

var  Existencias : Decimal;

begin
     If   ParametrosTiendaVirtualModule.PublicarArticulosSinExistencias
     then Result := True
     else begin
          ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                          CodigoClaseA='',
                                                          CodigoClaseA,
                                                          CodigoClaseB,
                                                          '',
                                                          True, '',
                                                          TodosLosAlmacenes, CodigoAlmacen,
                                                          True, '',
                                                          True,
                                                          ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

          Existencias := ExistenciasArticulo.SumaExistencias.Saldo - ExistenciasArticulo.SumaExistencias.PendienteServir;
          If   not ParametrosTiendaVirtualModule.NoIncluirPendienteRecibir
          then Existencias := Existencias + ExistenciasArticulo.SumaExistencias.PendienteRecibir;

          Result := Existencias>0.0;
          end;
end;


begin

     Result := False;
     HayExistencias := False;

     ObtenAlmacenArticulo( ArticuloFields, { out } TodosLosAlmacenes, { out } CodigoAlmacen );

       // Cada clase es un articulo virtual en la tienda

       With DmClaseTable do
          begin

          // NroClase;NroOrden

          SetRange( [ tcClaseA, 0 ], [ tcClaseA, MaxSmallint ] );
          First;
          While not Eof and not Error and not ProcessFrame.Canceled do
            begin

            If   DmClaseFields.DisponibleTienda.Value and
                 DmClasesArticuloTable.FindKey( [ ArticuloFields.Codigo.Value, tcClaseA, DmClaseFields.Codigo.Value ] )
            then begin

                 CodigoClaseA := DmClaseFields.Codigo.Value;
                 CodigoClaseB := '';

                 CodigoArticuloClaseA := ArticuloFields.Codigo.Value + SeparadorClases + CodigoClaseA;
                 DescripcionArticuloClaseA := ArticuloFields.Descripcion.Value + ' - ' + DmClaseFields.Descripcion.Value;

                 If   ExisteClaseB
                 then begin

                      With DmClaseAuxTable do
                        begin
                        SetRange( [ tcClaseB, 0 ], [ tcClaseB, MaxSmallint ] );
                        First;
                        While not Eof and not Error and not ProcessFrame.Canceled do
                          begin

                          If   DmClaseAuxFields.DisponibleTienda.Value and
                               DmClasesArticuloTable.FindKey( [ ArticuloFields.Codigo.Value, tcClaseB, DmClaseAuxFields.Codigo.Value ] )
                          then begin
                               CodigoClaseB := DmClaseAuxFields.Codigo.Value;
                               CodigoArticuloConClases := CodigoArticuloClaseA + SeparadorClases + CodigoClaseB;
                               DescripcionArticuloConClases := DescripcionArticuloClaseA + ' - ' + DmClaseAuxFields.Descripcion.Value;
                               If   SoloComprobarExistencias
                               then begin
                                    If   CompruebaExistencias( ArticuloFields.Codigo.Value, CodigoClaseA, CodigoClaseB )
                                    then begin
                                         HayExistencias := True;
                                         Exit;
                                         end;
                                    end
                               else try

                                      // La variable HayExistencias se actualiza en la llamada a la función ActualizaArticulo,
                                      // dentro de ActualizaVarianteArticulo

                                      ActualizaVarianteArticulo;
                                    except
                                      Error := True;
                                      end;
                               end;

                          Next;
                          end;

                        end;

                      end
                 else begin
                      CodigoArticuloConClases := CodigoArticuloClaseA;
                      DescripcionArticuloConClases := DescripcionArticuloClaseA;
                      If   SoloComprobarExistencias
                      then begin
                           If   CompruebaExistencias( ArticuloFields.Codigo.Value, CodigoClaseA, '' )
                           then begin
                                HayExistencias := True;
                                Exit;
                                end;
                           end
                      else try
                             ActualizaVarianteArticulo;
                           except
                             Error := True;
                             end;
                      end;

                 end;

           Next;
           end;

         end;

end;

begin

     ArticuloNuevo := RegistroActualizacion.RegistroActualizacionFields.Id.IsNull;
     Error := False;

    // Comprobando si existe, al menos, una ClaseA o ClaseB disponible

     With DmClaseTable do
       try
         For var NroClase := tcClaseA to tcClaseB do
           begin
           ExisteClaseArticulo[ NroClase ] := False;
           SetRange( [ NroClase, 0 ], [ NroClase, MaxSmallint ] );
           First;
           While not Eof do
             begin
             If   DmClaseFields.DisponibleTienda.Value and
                  DmClasesArticuloTable.FindKey( [ ArticuloFields.Codigo.Value, NroClase, DmClaseFields.Codigo.Value ] )
             then begin
                  ExisteClaseArticulo[ NroClase ] := True;
                  Break;
                  end;
             Next;
             end;
           end;
       finally
         CancelRange;
         end;

     If   ( ExisteClaseA and not ExisteClaseArticulo[ tcClaseA ] ) or
          ( ExisteClaseB and not ExisteClaseArticulo[ tcClaseB ] )
     then begin
          ProcessFrame.AddMsg( ntWarning, Format( RsMsg45, [ ArticuloFields.Codigo.Value ] ) );
          Exit;
          end;

     // Comprobando que hay, por lo menos, una variante con existencias

     HayExistencias := False;

     ActualizaVariantes( { SoloComprobarExistencias } True );

     If   not HayExistencias and ArticuloNuevo
     then begin
          ProcessFrame.AddMsg( ntWarning, Format( RsMsg46, [ ArticuloFields.Codigo.Value ] ) );
          Exit;
          end;

     ConfigurableProductsLinks := TList<Integer>.Create;

     try

       // El artículo principal

       IdArticuloPrincipal := 0;
       CodigoPadre := ArticuloFields.Codigo.Value;

       try
          If   ActualizaArticulo( ArticuloFields, { ArticuloAgrupado } False, NoActualizarImagenes, tatConfigurable )
          then begin
               RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
               IdArticuloPrincipal := RegistroActualizacion.RegistroActualizacionFields.Id.Value;
               end
          else Exit;
       finally
          RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
          end;

       DpArticuloFields := TArticuloFields.Create( Self );
       DpArticuloFields.Update( ArticuloFields.Table );
       try
         HayExistencias := False;
         ActualizaVariantes( { SoloComprobarExistencias } False );
       finally
         DpArticuloFields.Free;
         end;

     finally
       ConfigurableProductsLinks.Free;
       end;

     If   not ( Error or ProcessFrame.Canceled )
     then begin

          // Si alguno de los hijos tiene existencias hay que indicar en el padre que hay stock, porque Magento no cambia su estado

          If   HayExistencias
          then ActualizaExistenciasArticulo( CodigoPadre, 0.0, 0.0, { HayExistencias } True );

          end
     else SuprimeArticulo( CodigoPadre ); // RegistroActualizacion.Actualizado( rgaArticulo, ArticuloFields.Codigo.Value, { Actualizado } False );

end;

function TSincronizacionTiendaMagentoModule.ActualizaArticulo( ArticuloFields            : TArticuloFields;
                                                               ArticuloAgrupado          : Boolean = False;
                                                               NoActualizarImagenes      : Boolean = False;
                                                               TipoArticulo              : TTipoArticuloTienda = tatSimple;
                                                               ConfigurableProductsLinks : TList<Integer> = nil ) : Boolean;

var ArticuloRequest,
    ArticuloResponse,
    ExtensionAttributesObject,
    StockItemObject,
    OptionsObject,
    OptionValueObject,
    ProductElementObject : TclJSONObject;

    TierPricesArray,
    CustomAttributesArray,
    CategoryIdsArray,
    OptionsArray,
    OptionsValuesArray,
    ProductLinksArray : TclJSONArray;

    ListaElementos : TListaArticulos;

    ArrayValue : TclJsonValue;

    CodigoArticulo,
    CodigoArticuloBase,
    CodigoAlmacen,
    CodigoGrupoTarifa : String;
    ImageStream : TMemoryStream;
    JpegImage : TJpegImage;
    ImageBitmap : TBitmap;
    SmartImage : TdxSmartImage;

    NroOpcion,
    GroupIndex,
    ProductPosition,
    VisibilityValue : SmallInt;

    Precio,
    PrecioVenta,
    PrecioTarifa : Double;

    PuntoVerde,
    PorcentajeTipoIVA,
    Cantidad,
    Recargo,
    Descuento,
    DescuentoVenta,
    DescuentoTarifa,
    Existencias : Decimal;
    EsUnaOferta : Boolean;

    ImageChecked,
    TodosLosAlmacenes : Boolean;

    CodigoClaseA,
    CodigoClaseB,
    CodigoElemento,
    TextoTipoArticulo,
    DescripcionClaseA,
    DescripcionClaseB,
    DescripcionArticulo : String;

    TaxClassId,
    GroupId : Integer;



procedure AddTierPrice( IdGrupoCliente : SmallInt;
                        Cantidad       : Decimal;
                        Precio         : Double;
                        Descuento      : Decimal );

var  TarifaPrecios,
     ExtensionAttributes : TclJSONObject;

begin
     TarifaPrecios := TclJSONObject.Create;
     TarifaPrecios.AddValue( 'customerGroupId', IntToStr( IdgrupoCliente ) );
     TarifaPrecios.AddValue( 'qty', IntToStr( Trunc( Cantidad ) ) );

     If   not ParametrosTiendaVirtualModule.PreciosConDescuentoPrevio and ( Descuento<>0.0 )
     then begin
          ExtensionAttributes := TclJSONObject.Create;
          ExtensionAttributes.AddValue( 'percentage_value', DecimalToStr( Descuento ) );
          TarifaPrecios.AddMember( 'extension_attributes', ExtensionAttributes );
          end
     else begin
	        If   ParametrosTiendaVirtualModule.PreciosConDescuentoPrevio
          then Articulo.AplicaDescuentoPrevio( Precio, Descuento );
	        TarifaPrecios.AddValue( 'value', ExtendedToStr( Precio ) );
		      end;

     TierPricesArray.Add( TarifaPrecios );
end;

procedure AddCustomAttribute( AttributeCode, Value : String ); overload;

var  CustomAttribute : TclJSONObject;

begin
     CustomAttribute := TclJSONObject.Create;
     CustomAttribute.AddString( 'attributeCode', AttributeCode );
     CustomAttribute.AddString( 'value', Value);
     CustomAttributesArray.Add( CustomAttribute );
end;

procedure AddCustomAttribute( AttributeCode : String; DataArray : TclJSONArray ); overload;

var  CustomAttribute : TclJSONObject;

begin
     CustomAttribute := TclJSONObject.Create;
     CustomAttribute.AddString( 'attributeCode', AttributeCode );
     CustomAttribute.AddMember( 'value', DataArray );
     CustomAttributesArray.Add( CustomAttribute );
end;

procedure AddAtributeClaseOptions(     OptionsArray  : TclJSONArray;
                                   var AtributoClase : TAtributoClase );
begin

     var AttributeObject := TclJSONObject.Create;
     var ValuesArray := TclJSONArray.Create;

     With AtributoClase do
       begin

       AttributeObject.AddString( 'attribute_id', IntToStr( Id ) );
       AttributeObject.AddString( 'label', Name );
       AttributeObject.AddValue( 'position', '0' );

       For var Inx := 1 to OptionIds.Count - 1 do
         begin
         var ValueIndexObject := TclJSONObject.Create;
         ValueIndexObject.AddValue( 'value_index', OptionIds.ValueFromIndex[ Inx ] );
         ValuesArray.Add( ValueIndexObject );
         end;

       end;

     AttributeObject.AddMember( 'values', ValuesArray );

     OptionsArray.Add( AttributeObject );
end;

procedure AddAttributeClase(     DescripcionClase : String;
                             var AtributoClase    : TAtributoClase );
begin
     var OptionId := AtributoClase.OptionIds.Values[ DescripcionClase ];   // No se puede utilizar el código
     If   OptionId<>''
		   then AddCustomAttribute( AtributoClase.CodigoAtributo, OptionId )
     else begin
          ProcessFrame.AddMsg( ntError, Format( RsMsg39, [ DescripcionClase ] ) );
          Abort;
          end;
end;

begin

     Result := False;

     TaxClassId :=  RegistroActualizacionTienda.ObtenTaxClassId( FacturaVentas.ObtenTipoIVAArticulo( ApplicationContainer.TodayDate, ArticuloFields ), ttcProduct );
     If   TaxClassId<0
     then begin
          ProcessFrame.AddMsg( ntError, Format( RsMsg14, [ ArticuloFields.Codigo.Value, ArticuloFields.Descripcion.Value ] ) );
          Exit;
          end;

     If   ParametrosTiendaVirtualModule.NoPublicarArticulosSinPrecio and not ArticuloConPrecio( DmArticuloFields )
     then Exit;

     ProcessFrame.AddRecordMsg( ArticuloFields.Codigo.Value + ', ' + ArticuloFields.Descripcion.Value );

     CodigoArticulo := ArticuloFields.Codigo.Value;
     CodigoClaseA := '';
     CodigoClaseB := '';
     DescripcionClaseA := '';
     DescripcionClaseB := '';

     CodigoArticuloBase := CodigoArticulo;  // Si es un articulo incluído en uno configurable contiene los códigos de las clases (ver ActualizaArticuloConClases y TipoArticulo=tatVariacionConfigurable )
     If   TipoArticulo=tatVariacionConfigurable
     then begin
          ExtraeClases( CodigoArticuloBase, CodigoClaseA, CodigoClaseB );
          DescripcionClaseA := Clase.Descripcion( tcClaseA, CodigoClaseA );
          If   CodigoClaseB<>''
          then DescripcionClaseB := Clase.Descripcion( tcClaseB, CodigoClaseB );
          end;

     ArticuloRequest := TclJSONObject.Create;

     If   not RegistroActualizacion.RegistroActualizacionFields.Id.IsNull
     then ArticuloRequest.AddValue( 'id', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) );

     ArticuloRequest.AddString( 'sku', CodigoArticulo );
     ArticuloRequest.AddString( 'name', ArticuloFields.Descripcion.Value );
     ArticuloRequest.AddValue( 'attributeSetId', '4' ); // Importante

     case TipoArticulo of
       tatConfigurable :
         TextoTipoArticulo := 'configurable';
       tatVirtual :
         TextoTipoArticulo := 'virtual';
       else
         TextoTipoArticulo := 'simple';
       end;

     ArticuloRequest.AddString( 'type_id', TextoTipoArticulo );

      // 1 = No visible, 2 = Catálogo, 3 = Búsqueda y 4 = Catalogo y búsqueda

     VisibilityValue := 4;
     If   ( TipoArticulo in [ tatVariacionConfigurable, tatVirtual ] ) or
          ( ( ArticuloFields.Tienda_CodigoArticuloAgrupado.Value<>'' ) and not ArticuloFields.Tienda_VisibleIndividualmente.Value )
     then VisibilityValue := 1;

     ArticuloRequest.AddValue( 'visibility', IntToStr( VisibilityValue ) );
     ArticuloRequest.AddValue( 'weight', DecimalToStr( ArticuloFields.Kilos.Value ) );

     // ExtensionAttributes

     ObtenAlmacenArticulo( DmArticuloFields, { out } TodosLosAlmacenes, { out } CodigoAlmacen );

     ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                     CodigoClaseA='',
                                                     CodigoClaseA,
                                                     CodigoClaseB,
                                                     '',
                                                     True, '',
                                                     TodosLosAlmacenes, CodigoAlmacen,
                                                     True, '',
                                                     True,
                                                     ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

     Existencias := ExistenciasArticulo.SumaExistencias.Saldo - ExistenciasArticulo.SumaExistencias.PendienteServir;
     If   not ParametrosTiendaVirtualModule.NoIncluirPendienteRecibir
     then Existencias := Existencias + ExistenciasArticulo.SumaExistencias.PendienteRecibir;

     If   Existencias<0.0
     then Existencias := 0.0;

     ExtensionAttributesObject := TclJSONObject.Create;
     StockItemObject := TclJSONObject.Create;
     StockItemObject.AddValue( 'qty', IntToStr( Trunc( Existencias ) ) );
     // Para que se puedan comprar los articulos incluidos en un articulo agrupado tiene que tener stock
     HayExistencias := HayExistencias or ( Trunc( Existencias )>0 );  // Se utiliza para comprobar si algún artículo tiene existencias (Poner a false y luego subir los artículos)
     StockItemObject.AddBoolean( 'is_in_stock', ( Trunc( Existencias )>0 ) or ArticuloAgrupado );
     {
     StockItemObject.AddBoolean( 'manage_stock', True );
     StockItemObject.AddBoolean( 'use_config_manage_stock', True );
     }

     ExtensionAttributesObject.AddMember( 'stock_item', StockItemObject );

     If   ( TipoArticulo=tatconfigurable ) { and  // Es un articulo configurable y se debe incluir la lista de los articulos virtuales asociados
          Assigned( ConfigurableProductsLinks ) }
     then If   ExisteClaseA
          then begin

               var ConfigurableProductOptionsArray := TclJSONArray.Create;

               AddAtributeClaseOptions( ConfigurableProductOptionsArray, AtributoClaseA );

               If   ExisteClaseB
               then AddAtributeClaseOptions( ConfigurableProductOptionsArray, AtributoClaseB );

               ExtensionAttributesObject.AddMember( 'configurable_product_options', ConfigurableProductOptionsArray );
               {
               var ConfigurableProductsLinksArray := TclJSONArray.Create;

               For var Inx := 0 to ConfigurableProductsLinks.Count - 1 do
                 ConfigurableProductsLinksArray.Append( ConfigurableProductsLinks[ Inx ] );

               ExtensionAttributesObject[ 'configurable_product_links' ] := ConfigurableProductsLinksArray;
               }
               end;

     ArticuloRequest.AddMember( 'extensionAttributes', ExtensionAttributesObject );

     (*

     //--- Options.  De momento solo la clase A.  //** 24.07.2023  Esta opción ya no está disponible

     OptionsArray := nil;

     If   ( ParametrosTiendaVirtualModule.PublicarClasesComo=pcOpcionesPersonalizadas ) and  // Opciones personalizadas
          (  not DmArticuloFields.Tienda_NoPublicarClases.Value ) and
          ExisteClaseA  // Al menos debe existir una
     then begin

          // Cada clase es una opción en la tienda (de momento solo utilizo la Clase A)

          OptionsArray := TclJSONArray.Create;

          // CodigoArticulo;CodigoClaseA

          OptionsObject := TclJSONObject.Create;

          OptionsObject.AddString( 'product_sku', CodigoArticulo );
          OptionsObject.AddString( 'title', DataModule00.DmEmpresaFields.Articulo_NombreClase[ tcClaseA ].Value );
          OptionsObject.AddString( 'type', 'radio' );
          OptionsObject.AddValue( 'sort_order', '1' );
          OptionsObject.AddBoolean( 'is_require', true );

          OptionsValuesArray := TclJSONArray.Create;

          var PrecioClase : Double := 0.0;
          NroOpcion := 1;

          With DmClaseTable do
            begin

            // NroClase;NroOrden

            SetRange( [ tcClaseA, 0 ], [ tcClaseA, MaxSmallint ] );

            First;
            While not Eof do
              begin

              If   DmClasesArticuloTable.FindKey( [ CodigoArticulo, tcClaseA, DmClaseFields.Codigo.Value ] )
              then begin

                   {  De momento no subo precios por clase

                   Articulo.ObtenPrecioyDtoVenta( tmPedidoVenta,
                                                  '', // CodigoCliente
                                                  ArticuloFields.Codigo.Value,
                                                  DmClaseFields.Codigo.Value,
                                                  '',
                                                  '',
                                                  1,
                                                  PrecioClase,
                                                  PuntoVerde,
                                                  Recargo,
                                                  Descuento,
                                                  EsUnaOferta,

                                                  CodigoTarifa,
                                                  Inicializar,
                                                  Fecha );
                   }

                   OptionValueObject := TclJSONObject.Create;
                   OptionValueObject.AddString( 'title', DmClaseFields.Codigo.Value + IfThen( DmClaseFields.Descripcion.Value='', '',  ' - ' + DmClaseFields.Descripcion.Value ) ) ;
                   OptionValueObject.AddValue('sort_order', IntToStr( NroOpcion ) );
                   OptionValueObject.AddValue( 'price', ExtendedToStr( PrecioClase ) );
                   OptionValueObject.AddString( 'price_type', 'fixed' );
                   OptionValueObject.AddString( 'sku', ArticuloFields.Codigo.Value + SeparadorClases + DmClaseFields.Codigo.Value );

                   OptionsValuesArray.Add( OptionValueObject );

                   Inc( NroOpcion );

                   end;

              Next;
              end;

            end;

          OptionsObject.AddMember( 'values', OptionsValuesArray );
          OptionsArray.Add( OptionsObject );
          end;

     // -----

     *)

     If   ArticuloFields.Tienda_ComentariosClientes.Value
     then begin

          If   not Assigned( OptionsArray )
          then OptionsArray := TclJSONArray.Create;

          OptionsObject := TclJSONObject.Create;

          OptionsObject.AddString( 'product_sku', ArticuloFields.Codigo.Value );
          OptionsObject.AddString( 'title', 'Comentarios' );
          OptionsObject.AddString( 'type', 'area' );
          OptionsObject.AddValue( 'sort_order', '1' );
          OptionsObject.AddBoolean( 'is_require', False );
          OptionsObject.AddValue( 'price', '0' );
          OptionsObject.AddString( 'price_type', 'fixed' );
          OptionsObject.AddValue( 'max_characters', '0' );

          OptionsArray.Add( OptionsObject );
          end;

     If   Assigned( OptionsArray )
     then ArticuloRequest.AddMember( 'options', OptionsArray );

     // MediaGalleryEntries

     If   not NoActualizarImagenes
     then begin

          ImageUploaded := False;
          ImageChecked := False;

          FechaFicheroMasReciente := LowestDateTime;

          MediaGalleryEntriesArray := TclJSONArray.Create;

          If   ParametrosTiendaVirtualModule.ImagenesExternas
          then ImageChecked := ProcessExternalImages( ArticuloFields,
                                                      RegistroActualizacion.RegistroActualizacionFields.FechaImagenExterna.Value,
                                                      { OnlyCheckModifications } False,
                                                      AddProductMedia )
          else If   not ArticuloFields.Imagen.IsNull
               then begin
                    ImageChecked := True;
                    If   not RegistroActualizacion.RegistroActualizacionFields.ImagenActualizada.Value
                    then begin
                         ImageStream := TMemoryStream.Create;
                         try
                           SmartImage := TdxSmartImage.Create;
                           try
                             var ImageExt := ParametrosTiendaVirtualModule.FormatoImagenes;
                             SmartImage.LoadFromFieldValue( ArticuloFields.Imagen.Value );
                             If   ( ( SmartImage.ImageDataFormat=dxImageJpeg ) and ( ImageExt='jpg' ) ) or
                                  ( ( SmartImage.ImageDataFormat=dxImagePng )  and ( ImageExt='png' ) )
                             then begin
                                  SmartImage.SaveToStreamByCodec( ImageStream, SmartImage.ImageDataFormat );
                                  AddProductMedia( ArticuloFields.Codigo.Value + '.' + ImageExt,
                                                   ArticuloFields.Descripcion.Value,
                                                   EncodeImage( ImageStream ) );
                                  end;

                           finally
                             SmartImage.Free;
                             end;

                         finally
                           ImageStream.Free;
                           end;
                         end;
                    end;

          If   ImageUploaded
          then begin
               ArticuloRequest.AddMember( 'mediaGalleryEntries', MediaGalleryEntriesArray );
               RegistroActualizacion.RegistroActualizacionFields.ImagenActualizada.Value := True;
               If   ParametrosTiendaVirtualModule.ImagenesExternas
               then RegistroActualizacion.RegistroActualizacionFields.FechaImagenExterna.Value := FechaFicheroMasReciente;
               end
          else begin
               MediaGalleryEntriesArray.Free;
               If   not ImageChecked and ParametrosTiendaVirtualModule.NoPublicarArticulosSinImagen
               then Exit;
               end;

          end;

     // TierPrices

     If   ParametrosTiendaVirtualModule.PreciosConIVAIncluido
     then begin
          FacturaVentas.ObtenTipoIVAArticulo( ApplicationContainer.TodayDate, ArticuloFields, DsTiposIVAFields );
          PrecioVenta := Redondea( ArticuloFields.Precio_Venta.Value + ( ArticuloFields.Precio_Venta.Value  * DsTiposIVAFields.IVARepercutido.Value / 100.0 ) );
          end
     else PrecioVenta := Redondea( ArticuloFields.Precio_Venta.Value );

     DescuentoVenta := ArticuloFields.Dto_Venta.Value;

     CodigoGrupoTarifa := '';

     If   not ArticuloAgrupado and ( TipoArticulo<>tatConfigurable )
     then With ParametrosTiendaVirtualModule do
            begin

            If   GrupoNombre[ 0 ]<>''
            then begin
                 TierPricesArray := TclJSONArray.Create;
                 For GroupIndex := 0 to LastCustomerGroupIndex do
                   If   GrupoNombre[ GroupIndex ]<>''
                   then begin
                        GroupId := TiendaVirtualModule.ObtenGroupId( GroupIndex );
                        If   GroupId<>-1
                        then If   GrupoCodigoTarifa[ GroupIndex ]<>''
                             then If   PublicarClasesComoConfiguraciones
                                  then begin

                                       If   ArticulosPorGrupoCliente
                                       then begin

                                            { Esta opción es (de momento) exclusivamente para Hilaturas : si no existe la tarifa del artículo no se sube.
                                              Este es el método que utiliza el módulo FilterPrice en Magento para saber qué artículos mostrar dependiendo
                                              del grupo al que pertenece el cliente.
                                              La cantidad mínima es 1000000 para evitar que se utilice el precio de la tarifa. Siempre se
                                              usará el precio indicado en la ficha del artículo.
                                            }

                                            If   Articulo.TarifaVentaArticuloDisponible( CodigoArticuloBase, GrupoCodigoTarifa[ GroupIndex ], PrecioTarifa, DescuentoTarifa )
                                            then AddTierPrice( GroupId, 1000000, PrecioTarifa, DescuentoTarifa );

                                            // Como los precios por tarifa no se utilizan, no vale la pena comprobar PrecioVenta

                                            end
                                       else begin

                                            Articulo.ObtenPrecioyDtoVenta(  tmVenta,
                                                                            { CodigoCliente } '',
                                                                            DmArticuloFields.Codigo.Value,
                                                                            CodigoClaseA,
                                                                            CodigoClaseB,
                                                                            '',
                                                                            { Cantidad } 1.0,
                                                                            PrecioTarifa,
                                                                            PuntoVerde,
                                                                            Recargo,
                                                                            DescuentoTarifa,
                                                                            EsUnaOferta,
                                                                            GrupoCodigoTarifa[ GroupIndex ],
                                                                            { Inicializar } True );

                                            {
                                            If   ArticuloFields.CantidadMinimaVenta.Value=0.0
                                            then Cantidad := 1.0
                                            else Cantidad := ArticuloFields.CantidadMinimaVenta.Value;
                                            }

                                            If   PrecioTarifa<>0.0
                                            then begin
                                                 AddTierPrice( GroupId, 1.0 { Cantidad }, PrecioTarifa, DescuentoTarifa );
                                                 If   PrecioTarifa>PrecioVenta
                                                 then PrecioVenta := PrecioTarifa;
                                                 end;

                                            end;

                                       end
                                  else begin

                                       Cantidad := -1.0;  // Para que se aplique siempre la tarifa
                                       Precio := 0.0;
                                       Recargo := 0.0;
                                       Descuento := 0.0;
                                       PrecioTarifa := 0.0;
                                       DescuentoTarifa := 0.0;
                                       Articulo.ObtenPrecioVentaPorTarifa( ArticuloFields.Codigo.Value,
                                                                           '',
                                                                           GrupoCodigoTarifa[ GroupIndex ],
                                                                           Cantidad,
                                                                           Precio,
                                                                           Recargo,
                                                                           Descuento,
                                                                           { ObtenerCantidadMinima } True );

                                       DescuentoTarifa := Descuento;

                                       If   Precio<>0.0
                                       then If   PreciosConIVAIncluido
                                            then begin
                                                 FacturaVentas.ObtenTipoIVAArticulo( ApplicationContainer.TodayDate, ArticuloFields, DsTiposIVAFields );
                                                 Tasa.TipoIVA( ApplicationContainer.TodayDate, ArticuloFields.TipoIVA.Value, DsTiposIVAFields );
                                                 PorcentajeTipoIVA := DsTiposIVAFields.IVARepercutido.Value;
                                                 {
                                                 If   GrupoConRE[ GroupIndex ]
                                                 then PorcentajeTipoIVA := PorcentajeTipoIVA + DsTiposIVAFields.RERepercutido.Value;
                                                 }
                                                 PrecioTarifa := Redondea( Precio + ( Precio * PorcentajeTipoIVA / 100.0 ) );
                                                 end
                                            else PrecioTarifa := Precio;

                                       If   ( DescuentoTarifa<>0.0 ) or
                                            ( PrecioTarifa<>0.0 )
                                       then begin

                                            If   Cantidad<=0.0
                                            then begin
                                                 Cantidad := ArticuloFields.CantidadMinimaVenta.Value;
                                                 If   Cantidad<=0.0
                                                 then Cantidad := 1.0;
                                                 end;

                                            AddTierPrice( GroupId, Cantidad, PrecioTarifa, DescuentoTarifa );
                                            CodigoGrupoTarifa := CodigoGrupoTarifa + '[' + GrupoCodigoTarifa[ GroupIndex ] + ']';

                                            // Magento solo aplica los precios de tarifa si el precio de la ficha es mayor o igual al de la tarifa

                                            If   PrecioTarifa>PrecioVenta
                                            then PrecioVenta := PrecioTarifa;

                                            end;

                                       end;

                        end
                   else Break;
                 ArticuloRequest.AddMember( 'tierPrices', TierPricesArray );
                 end;

            end;

     // Precio de la ficha

     If   ParametrosTiendaVirtualModule.PreciosConDescuentoPrevio
     then Articulo.AplicaDescuentoPrevio( PrecioVenta, DescuentoVenta );

     ArticuloRequest.AddValue( 'price', ExtendedToStr( PrecioVenta ) );

     // productos agrupados

     ProductLinksArray := TclJSONArray.Create;
     var TieneArticulosAgrupados := False;

     If   ArticuloAgrupado
     then begin

          // Si el articulo ya existe hay que suprimirlo y volverlo a crear

          If   RegistroActualizacion.RegistroActualizacionFields.Id.Value<>0   // Ya existe
          then SuprimeArticuloSimple( ArticuloFields.Codigo.Value );

          ArticuloRequest.AddString( 'type_id', 'grouped' );

          ListaElementos := TListaArticulos.Create;
          try
            If   Articulo.ObtenGrupoArticulos( ArticuloFields.Codigo.Value, ListaElementos )
            then begin
                 ProductPosition := 1;

                 For CodigoElemento in ListaElementos do
                   begin

                   ProductElementObject := TclJSONObject.Create;
                   ProductElementObject.AddString( 'sku', ArticuloFields.Codigo.Value );
                   ProductElementObject.AddString( 'link_type', 'associated' );
                   ProductElementObject.AddString( 'linked_product_sku', CodigoElemento );
                   ProductElementObject.AddString( 'linked_product_type', 'simple' );
                   ProductElementObject.AddValue( 'position', IntToStr( ProductPosition ) );

                   {
                   ExtensionAttributesObject := TclJSONObject.Create;
                   ExtensionAttributesObject.AddValue( 'qty', 0 );
                   ProductElementObject[ 'extensionAttributes' ] := ExtensionAttributesObject;
                   }

                   ProductLinksArray.Add( ProductElementObject );
                   Inc( ProductPosition );

                   TieneArticulosAgrupados := True;
                   end;

                 end;

          finally
            ListaElementos.Free;
            end;

          end;

     // Si no tiene artículos agrupados se sube vacío para que se borren los existentes (incluidos los relacionados, que se subirán más tarde)

     ArticuloRequest.AddMember( 'productLinks', ProductLinksArray );

     // Categorias

     CategoryIdsArray := TclJSONArray.Create;

     // CodigoArticulo;NroOrden;CodigoCategoria

     With DmCategoriasArticuloTable do
       begin
       SetRange( [ DmArticuloFields.Codigo.Value ] );
       First;
       While not Eof do
         begin
         AddStringValueToArray( CategoryIdsArray, IntToStr( RegistroActualizacionTienda.ObtenId( rgaCategoria, DmCategoriasArticuloFields.CodigoCategoria.Value ) ) );
         If   ParametrosTiendaVirtual.PreciosPorCliente and
              ( DmArticuloFields.Familia.Value<>'' )
         then AddStringValueToArray( CategoryIdsArray, IntToStr( RegistroActualizacionTienda.ObtenId( rgaCategoria, 'FT·' + DmArticuloFields.Familia.Value ) ) );

         Next;
         end;
       end;

    // CustomAttributes

     CustomAttributesArray := TclJSONArray.Create;
     AddCustomAttribute( 'tax_class_id', IntToStr( TaxClassId ) );
     AddCustomAttribute( 'category_ids', CategoryIdsArray );
     // AddCustomAttribute( 'url_key', URLEncode( ArticuloFields.Codigo.Value ) );
     DescripcionArticulo := ArticuloFields.Anotacion.AsAnsiString;
     If   DescripcionArticulo<>''
     then begin
          DescripcionArticulo := TextConverter.ToPlainText( DescripcionArticulo );
          AddCustomAttribute( 'description', DescripcionArticulo );
          AddCustomAttribute( 'short_description', DescripcionArticulo );
          end;

     // Campos libres como atributos del artículo

     If   ParametrosTiendaVirtualModule.CamposLibresComoAtributos and
          DataModule00.DmEmpresaFields.Articulo_CamposLibres.Value
     then With ArticuloFields do
            begin

            var CamposLibresArray := [ CampoLibre1,  CampoLibre2,  CampoLibre3,  CampoLibre4 , CampoLibre5,
                                       CampoLibre6,  CampoLibre7,  CampoLibre8,  CampoLibre9,  CampoLibre10,
                                       CampoLibre11, CampoLibre12, CampoLibre13, CampoLibre14, CampoLibre15 ];

            For var Index := 1 to High( CamposLibresArray ) do
              If   DataModule00.DmEmpresaFields.Articulo_CampoLibre[ Index ].Value<>''
              then begin
                   var Value := TField( CamposLibresArray[ Index - 1 ] ).AsString;
                   If   Value<>''
                   then AddCustomAttribute( LowerCase( DataModule00.DmEmpresaFields.Articulo_CampoLibre[ Index ].Value ), Value );
                   end;

            end;

     // Clase como atributo en artículos virtuales

     If   TipoArticulo=tatVariacionConfigurable
     then If   ExisteClaseA
          then begin
               AddAttributeClase( DescripcionClaseA, AtributoClaseA );
               If   ExisteClaseB
               then AddAttributeClase( DescripcionClaseB, AtributoClaseB );
               end;

     {
     else If   TipoArticulo=tatconfigurable
          then AddCustomAttribute( LowerCase( DataModule00.DmEmpresaFields.Articulo_NombreClase[ tcClaseA ].Value ), IntToStr( FirstAttributeId ) );
     }

     // % Descuento

     {
     If   TiendaVirtualModule.PreciosConDescuentoPrevio
     then }
     AddCustomAttribute( Fld_DiscountRate, StrDecimal( DescuentoVenta, 2 ) );

     // Volumen

     If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
     then begin
          AddCustomAttribute( Fld_Packs, StrFormat( ArticuloFields.Bultos.Value, 2, False, { InvariantFormat } True ) );
          AddCustomAttribute( Fld_Volume, StrFormat( ArticuloFields.Volumen.Value, 2, False, { InvariantFormat } True ) );
          end;

     // Unidades por caja

     If   DataModule00.DmEmpresaFields.Articulo_Cajas.Value
     then AddCustomAttribute( Fld_UnitsPerBox, StrFormat( ArticuloFields.UnidadesPorCaja.Value, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value, False, { InvariantFormat } True ) );

     // Unidades por pallet

     If   DataModule00.DmEmpresaFields.Articulo_Pallets.Value
     then AddCustomAttribute( Fld_UnitsPerPallet, StrFormat( ArticuloFields.UnidadesPorPallet.Value, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value, False, { InvariantFormat } True ) );

     // Códigos de tarifa

     If   CodigoGrupoTarifa<>''
     then AddCustomAttribute( 'tier_codes', CodigoGrupoTarifa );

     ArticuloRequest.AddMember( 'customAttributes', CustomAttributesArray );

     // ------------

     var Parameters := TclJSONObject.Create;

     try

       Parameters.AddMember( 'product', ArticuloRequest );

       Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'products' ), Parameters );

       If   Result
       then begin
            ArticuloResponse := RestRpc.ResponseJSON as TclJSONObject;
            RegistroActualizacion.RegistroActualizacionFields.Id.Value := StrToInt( ArticuloResponse.ValueByname( 'id' ) );
            RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
            RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;

            SuprimeExistenciasReservadas( CodigoArticulo );

            // POS01 : Aprovecho para recuperar el id del comentario

            If   ArticuloFields.Tienda_ComentariosClientes.Value
            then try
                 OptionsArray := ArticuloResponse.ArrayByName( 'options' );
                 For var Inx := 0 to OptionsArray.Count - 1 do
                   begin
                   try
                     OptionsObject := OptionsArray.Objects[ Inx ];
                     If   OptionsObject.ValueByName( 'title' )='Comentarios'
                     then begin
                          RegistroActualizacion.RegistroActualizacionFields.Id1.Value := StrToInt( OptionsObject.ValueByName( 'option_id' ) );
                          Break;
                          end;
                   except
                     end;
                   end;
                 except
                   end;

            end
       else begin
            ProcesaMensajeError;
            ProcessFrame.AddMsg( ntError, Format( RsMsg4, [ ArticuloFields.Codigo.Value, ArticuloFields.Descripcion.Value ] ) );
            ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
            Result := False;
            end;

     finally
       Parameters.Free;
       end;

end;

function TSincronizacionTiendaMagentoModule.ExisteCliente(     Codigo,
                                                               Nombre,
                                                               EMail        : String;
                                                           out Id           : LongInt;
                                                           out AddressId1   : LongInt;
                                                           out AddressId2   : LongInt;
                                                           out NombreTienda : String;
                                                           out NIF          : String ) : Boolean;

var  MessageResponse,
     CustomerResponse : TclJSONObject;
     AddressObject : TclJSONObject;
     AddressesArray : TclJSONArray;

begin

     Id := 0;
     AddressId1 := 0;
     AddressId2 := 0;
     NombreTienda := '';
     NIF := '';

     Result := RestRpc.Get( ParametrosTiendaVirtual.BaseURL( 'customers/search?searchCriteria[filter_groups][0][filters][0][field]=email&' +
                                                             'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&' +
                                                             'searchCriteria[filter_groups][0][filters][0][value]=' + EMail ) );
     If   Result
     then begin
          Result := False;
          If   Assigned( RestRpc.ResponseJSON ) and ( RestRpc.ResponseJSON is TclJSONObject )
          then begin
               MessageResponse := RestRpc.ResponseJSON as TclJSONObject;
               If   Assigned( MessageResponse )
               then begin
                    Result := StrToInt( MessageResponse.ValueByName( 'total_count' ) )>0;
                    If   Result
                    then begin
                         CustomerResponse := MessageResponse.ArrayByName( 'items' ).Objects[ 0 ];
                         Id := StrToInt( CustomerResponse.ValueByname( 'id' ) );
                         NombreTienda := CustomerResponse.ValueByName( 'firstname' );
                         try
                           CustomerResponse.ValueByName( Fld_taxvat );
                           NIF := CustomerResponse.ValueByName( Fld_taxvat )
                         except
                           ProcessFrame.AddMsg( ntWarning, Format( RsMsg31, [ NombreTienda ] ) );
                           end;
                         AddressesArray := CustomerResponse.ArrayByName( 'addresses' );
                         If   Assigned( AddressesArray ) and ( AddressesArray.Count>0 )
                         then begin
                              AddressObject := AddressesArray.Objects[ 0 ];
                              If   Assigned( AddressObject )
                              then begin
                                   AddressId1 := StrToInt( AddressObject.ValueByName( 'id' ) );
                                   If   AddressesArray.Count>1
                                   then begin
                                        AddressObject := AddressesArray.Objects[ 1 ];
                                        AddressId2 := StrToInt( AddressObject.ValueByname( 'id' ) );
                                        end;
                                   end;
                              end;
                         end;
                    end;
               end
          else ProcessFrame.AddMsg( ntError, Format( RsMsg32, [ EMail, Codigo, Nombre ] ) );

          end;

end;

function TSincronizacionTiendaMagentoModule.ActualizaCliente( ClienteFields : TClienteFields ) : Boolean;

var NuevoRegistro : Boolean;
    PasswordValue : TclJsonString;
    ClienteRequest,
    ClienteResponse,
    AddressObject : TclJSONObject;
    StreetArray,
    AddressesArray : TclJSONArray;
    GroupId : Integer;

procedure AddRegionObject( AddressObject : TclJSONObject;
                           CountryISO2,
                           RegionName    : String );

var  RegionObject : TclJSONObject;

begin

     RegionObject := TclJSONObject.Create;
     RegionObject.AddString( 'regionCode', RegionName );
     RegionObject.AddString( 'region', RegionName );

     // De momento el regionId solo funciona con España

     If   CountryISO2='ES'
     then begin
          var RegionId := ObtenIdProvincia( RegionName );
          If   RegionId<>''
          then RegionObject.AddValue( 'regionId', RegionId );
          end;

     AddressObject.AddMember( 'region', RegionObject );
end;


begin

     Result := False;

     GroupId := TiendaVirtualModule.ObtenGroupId( ClienteFields.Factura_Tarifa.Value, ClienteFields.Factura_ModeloIVA.Value );

     //** 19.04.2017 Los clientes pueden no pertenecer a un grupo

     {
     If   GroupId<0
     then begin
          ProcessFrame.AddMsg( ntError, Format( RsMsg17, [ ClienteFields.Codigo.Value, ClienteFields.Nombre.Value ] ) );
          Exit;
          end;
     }

     If   ClienteFields.NIF.Value=''
     then begin
          ProcessFrame.AddMsg( ntWarning, Format( RsMsg29, [ ClienteFields.Codigo.Value, ClienteFields.Nombre.Value ] ) );
          Exit;
          end;

     If   ClienteFields.Telefono.Value=''
     then begin
          ProcessFrame.AddMsg( ntWarning, Format( RsMsg23, [ ClienteFields.Codigo.Value, ClienteFields.Nombre.Value ] ) );
          Exit;
          end;

     ClienteRequest := TclJSONObject.Create;

     NuevoRegistro := RegistroActualizacion.RegistroActualizacionFields.Id.IsNull;

     If   not NuevoRegistro
     then ClienteRequest.AddValue( 'id', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) );

     If   GroupId<>-1
     then ClienteRequest.AddValue( 'groupId', IntToStr( GroupId ) );

     ClienteRequest.AddValue( 'websiteId', IntToStr( ParametrosTiendaVirtual.MainWebSiteId ) );  // Solo existe una tienda. Al menos de momento.
     ClienteRequest.AddString( 'email', ClienteFields.EMail.Value );
     ClienteRequest.AddString( 'firstname', ClienteFields.Nombre.Value );
     ClienteRequest.AddString( 'lastname', '.' );
     ClienteRequest.AddString( 'taxvat', ClienteFields.NIF.Value );
     ClienteRequest.AddValue( 'disableAutoGroupChange', '1' );

     AddressesArray := TclJSONArray.Create;

     // Dirección administrativa

     AddressObject := TclJSONObject.Create;
     StreetArray := TclJSONArray.Create;

     var CountryISO2 := Pais.CodigoISO2( ClienteFields.CodigoPais.Value );

     AddressObject.AddValue( 'id', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id1.Value ) );
     AddressObject.AddValue( 'customerId', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) );
     AddressObject.AddString( 'countryId', CountryISO2 );
     AddressObject.AddString( 'firstname', ClienteFields.Nombre.Value );
     AddressObject.AddString( 'lastname', '.' );
     AddressObject.AddString( 'company', ClienteFields.Nombre.Value );
     AddStringValueToArray( StreetArray, ClienteFields.Domicilio.Value );

     AddressObject.AddMember( 'street', StreetArray );

     AddressObject.AddString( 'city', ClienteFields.Localidad.Value );
     AddressObject.AddString( 'postcode', ClienteFields.CodigoProvincia.Value + ClienteFields.CodigoPostal.Value );
     AddressObject.AddString( 'region', Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value ) );
     AddressObject.AddString( 'telephone', ClienteFields.Telefono.Value );
     AddressObject.AddBoolean( 'defaultBilling', True );

     AddRegionObject( AddressObject, CountryISO2, Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value ) );

     AddressesArray.Add( AddressObject );

     // Dirección de envíos

     If   ClienteFields.Envios_Nombre.Value<>''
     then begin

          AddressObject := TclJSONObject.Create;
          StreetArray := TclJSONArray.Create;

          AddressObject.AddValue( 'id', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id2.Value ) );
          AddressObject.AddValue( 'customerId', IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) );
          AddressObject.AddString( 'countryId', CountryISO2 );
          AddressObject.AddString( 'firstname', ClienteFields.Envios_Nombre.Value );
          AddressObject.AddString( 'lastname', '.' );
          AddressObject.AddString( 'company', ClienteFields.Envios_Nombre.Value );
          AddStringValueToArray( StreetArray, ClienteFields.Envios_Domicilio.Value );
          AddressObject.AddMember( 'street', StreetArray );

          AddressObject.AddString( 'city', ClienteFields.Envios_Localidad.Value );
          AddressObject.AddString( 'postcode', ClienteFields.Envios_CodigoProv.Value + ClienteFields.Envios_CodigoPostal.Value );
          AddressObject.AddString( 'region', Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.Envios_CodigoProv.Value ) );
          AddressObject.AddString( 'telephone', ClienteFields.Telefono.Value );
          AddressObject.AddBoolean( 'defaultShipping', True );

          AddRegionObject( AddressObject, CountryISO2, Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.Envios_CodigoProv.Value ) );

          AddressesArray.Add( AddressObject );

          end;

     ClienteRequest.AddMember( 'addresses', AddressesArray );

     var Parameters := TclJSONObject.Create;

     try

       Parameters.AddMember( 'customer', ClienteRequest );

       If   NuevoRegistro
       then begin

            If   ClienteFields.NIF.Value<>''
            then begin
                 PasswordValue := TclJsonString.Create( ClienteFields.NIF.Value );
                 Parameters.AddMember( 'password', PasswordValue );
                 end;

            Result := RestRpc.Post( ParametrosTiendaVirtual.BaseURL( 'customers' ), Parameters );
            end
       else Result := RestRpc.Put( ParametrosTiendaVirtual.BaseURL( 'customers/' + IntToStr( RegistroActualizacion.RegistroActualizacionFields.Id.Value ) ), Parameters );

       If   Result
       then begin
            ClienteResponse := RestRpc.ResponseJSON as TclJSONObject;

            RegistroActualizacion.RegistroActualizacionFields.Id.Value := StrToInt( ClienteResponse.ValueByName( 'id' ) );
            AddressesArray := ClienteResponse.ArrayByName( 'addresses' );
            AddressObject := AddressesArray.Objects[ 0 ];
            RegistroActualizacion.RegistroActualizacionFields.Id1.Value := StrToInt( AddressObject.ValueByname( 'id' ) );
            If   AddressesArray.Count>1
            then begin
                 AddressObject := AddressesArray.Objects[ 1 ];
                 RegistroActualizacion.RegistroActualizacionFields.Id2.Value := StrToInt( AddressObject.ValueByname( 'id' ) );
                 end;

            RegistroActualizacion.RegistroActualizacionFields.FechaActualizacion.Value := Now;
            RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;

            // Se envía un mensaje de cambio de contraseña al usuario

            {
            If   NuevoRegistro and ( ClienteFields.NIF.Value='' )
            then EnviaEMailPasswordResetLink( ClienteFields.Codigo.Value, ClienteFields.EMail.Value );
            }

            end
       else begin
            ProcesaMensajeError;
            ProcessFrame.AddMsg( ntError, Format( RsMsg18, [ ClienteFields.Codigo.Value, ClienteFields.Nombre.Value ] ) );
            ProcessFrame.AddMsg( ntError, RestRpc.ErrorMessage );
            Result := False;
            end;

     finally
       Parameters.Free;
       end;
end;

{
function TSincronizacionTiendaMagentoModule.EnviaEMailPasswordResetLink( Codigo, EMail  : String ) : Boolean;

var  EMailRequest,
     EMailResponse : TclJSONObject;

begin

     EMailRequest := TclJSONObject.Create;

     EMailRequest.AddString( 'email', EMail );
     EMailRequest.AddValue( 'websiteId', TiendaVirtual.MainWebSiteId );

     FHTTPResult := RestRpc.RestClient.Post( ParametrosTiendaVirtual.BaseURL( 'customers/confirm' ), EMailRequest );
     Result := FHTTPResult=HTTP_RESULT_OK;
     If   Result
     then EMailResponse := RestRpc.RestClient.ResponseJSON as TclJSONObject
     else begin
          ProcesaMensajeError;
          ProcessFrame.AddMsg( ntInformation, Format( RsMsg25, [ Codigo ] ) );
          end;
end;
}

{ TArticuloEspecial }

constructor TArticuloEspecial.Create(Codigo: String; Agrupado, ConRelacionados: Boolean);
begin
     inherited Create;
     Self.Codigo := Codigo;
     Self.Agrupado := Agrupado;
     Self.ConRelacionados := ConRelacionados;
end;

procedure InicializaSincronizacionTienda;
begin
     SincronizacionTiendaMagento;
end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InicializaSincronizacionTienda );

end.

