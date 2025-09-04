
unit dm_art;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  Generics.Collections,

  Spring,
  LibUtils,
  AppManager,
  AppContainer,
  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim10Fields,
  Gim30Fields,

  dmi_mov,
  dmi_sto,
  dmi_art,

  dm_mov;

const  ArticuloManual      = '.';
       ArticuloManualProx  = '..';

       tcFamilia           = 1;   // Tipos de registro de consumo ...
       tcArticulo          = 2;

       rtvTarifaArticulo   = 0;   // Tipos de relaciones de tarifas de ventas
       rtvClienteArticulo  = 1;
       rtvTarifaFamilia    = 2;
       rtvClienteFamilia   = 3;

       rtcProveedorArticulo = 0;  // Tipos de relaciones de tarifas de compras
       rtcGrupoArticulo     = 1;

       rtcoVendedorArticulo = 0;  // Tipos de relaciones de la tabla de comisiones
       rtcoVendedorFamilia  = 1;

       traRelacionados      = 0;  // Tipo de relacion de los artículos
       traEquivalentes      = 1;

type   TAcumuladoArticulo = record
         UnidadesComprasMes,
         ImporteComprasMes,
         ImporteDescuentosComprasMes,
         UnidadesVentasMes,
         ImporteVentasMes,
         ImporteDescuentosVentasMes : array[ 1..12 ] of Decimal;

         TotalUnidadesCompras,
         TotalImporteCompras,
         TotalImporteDescuentosCompras,
         TotalUnidadesVentas,
         TotalImporteVentas,
         TotalImporteDescuentosVentas : Decimal;

         DtosCompras,
         DtosVentas,
         PrecioMedioCompra,
         PrecioMedioVenta,
         MargenMedio : Decimal;
         end;

       TConsumoAcumulado = record
         Unidades,
         Importe : array[ 1..12 ] of Decimal;
         end;

       TListaArticulos = TList<String>;

  TArticuloModule = class(TDataModule)
    DmArticuloTable: TnxeTable;
    DmTarifaComprasTable: TnxeTable;
    DmTarifaVentasTable: TnxeTable;
    DmListaMaterialesTable: TnxeTable;
    DmArticuloDatEconTable: TnxeTable;
    DmTarifaClaseTable: TnxeTable;
    DmTablaComisionTable: TnxeTable;
    DmTarifaCantidadVentaTable: TnxeTable;
    DmCodigoBarrasTable: TnxeTable;
    PrecioOfertaQuery: TnxeQuery;
    PrecioOfertaQueryDescuento: TBCDField;
    PrecioOfertaQueryPrecio: TFloatField;
    DmArticulosRelacionadosTable: TnxeTable;
    procedure ArticuloModuleCreate(Sender: TObject);
    procedure ArticuloModuleDestroy(Sender: TObject);
  private

    ArticuloService : IArticuloService;

    DmArticuloFields : TArticuloFields;
    DmArticuloDatEconFields : TArticuloDatEconFields;
    DmTarifaComprasFields : TTarifaComprasFields;
    DmTarifaVentasFields : TTarifaVentasFields;
    DmListaMaterialesFields : TListaMaterialesFields;
    DmTarifaCantidadVentaFields : TTarifaCantidadVentaFields;
    DmTarifaClaseFields : TTarifaClaseFields;
    DmCodigoBarrasFields : TCodigoBarrasFields;
    DmArticulosRelacionadosFields : TArticulosRelacionadosFields;

    ArticuloFields : TArticuloFields;

    FOnSuprimeReferenciasArticulo : Event<TStringEvent>;

  public

    function Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; ArticuloFields : TArticuloFields = nil; IsInfoControl : Boolean = False ) : String;
    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True; ArticuloFields : TArticuloFields = nil ) : String;
    function Obten( Codigo : String; ArticuloFields : TArticuloFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function EstaEnOferta( ArticuloFields : TArticuloFields; Fecha : TDateTime ) : Boolean;
    function Existe( Codigo : String ) : Boolean;
    procedure CreaArticuloManual( Codigo : String; ArticuloFields : TArticuloFields = nil );

    procedure ObtenPrecioyDtoCompra( LineaMovimientoFields : TLineaMovimientoFields;
                                     CodigoProveedor       : String;
                                     Inicializar           : Boolean = False ); overload;

    procedure ObtenPrecioyDtoCompra(     CodigoProveedor,
                                         CodigoArticulo        : String;
                                         CodigoClaseA,
                                         CodigoClaseB,
                                         CodigoClaseC    : String;
                                         Cantidad        : Decimal;
                                     var Precio          : Double;
                                     var PuntoVerde      : Decimal;
                                     var Descuento       : Decimal;
                                         Inicializar     : Boolean = False;
                                         Fecha           : TDateTime = 0 ); overload;

    procedure ObtenPrecioyDtoVenta( TipoMovimiento        : TTipoMovimiento;
                                    LineaMovimientoFields : TLineaMovimientoFields;
                                    CodigoCliente         : String;
                                    Inicializar           : Boolean = False ); overload;

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

                                        CodigoTarifa   : String = '';
                                        Inicializar    : Boolean = False;
                                        Fecha          : TDateTime = 0 ); overload;

    procedure ObtenPrecioVentaPorTarifa(     CodigoArticulo,
                                             CodigoFamilia,
                                             CodigoTarifa          : String;
                                         var Cantidad              : Decimal;
                                         var Precio                : Double;
                                         var Recargo,
                                             Descuento             : Decimal;
                                             ObtenerCantidadMinima : Boolean = False );

    function CalculaPrecioDesgloseCompra( CodigoProveedor,
                                          CodigoArticulo  : String;
                                          CodigoClaseA,
                                          CodigoClaseB,
                                          CodigoClaseC    : String ) : Decimal;

    function CalculaPrecioDesgloseVenta( TipoMovimiento  : TTipoMovimiento;
                                         CodigoCliente,
                                         CodigoArticulo,
                                         CodigoClaseA,
                                         CodigoClaseB,
                                         CodigoClaseC    : String;
                                         Fecha           : TDateTime = 0 ) : Decimal;

    procedure AltaDatosEconomicos( UnEjercicio : SmallInt; UnCodigoArticulo : String; UnCodigoClaseA, UnCodigoClaseB, UnCodigoClaseC : String; UnCodigoAlmacen : String; ArticuloDatEconTable : TnxeTable );
    function  ReferenciaProveedor( CodigoProveedor : String; CodigoArticulo : String; CodigoInterno : Boolean ) : String;

    function  CodigoBarras( var CodigoArticulo : String;
                            out CodigoClaseA   : String;
                            out CodigoClaseB   : String;
                            out CodigoClaseC   : String;
                            out FijarClases    : Boolean;
                                ArticuloFields : TArticuloFields = nil) : Boolean;

    function  CompruebaEAN13( Codigo : String; EditControl : TWinControl = nil ) : String;
    function  ReferenciaCliente( CodigoCliente : String; CodigoArticulo : String ) : String;
    procedure SuprimeReferencias( CodigoArticulo : String );
    
    procedure CalculaAcumulados(     ArticuloDatEconFields : TArticuloDatEconFields;
                                 var AcumuladoArticulo     : TAcumuladoArticulo;
                                     MesInicial,
                                     MesFinal              : SmallInt;
                                     Limpiar               : Boolean ); overload;

    procedure CalculaAcumulados(     AcumuladoArticulo : TAcumuladoArticulo;
                                 var AcumuladoTotal    : TAcumuladoArticulo;
                                     MesInicial,
                                     MesFinal          : SmallInt ); overload;

    function CalculaResultados(      CodigoArticulo         : String;
                                     TodasLasClases         : Boolean;
                                     CodigoClaseA,
                                     CodigoClaseB,
                                     CodigoClaseC           : String;
                                     CodigoAlmacen          : String;
                                     Ejercicio,
                                     MesInicial,
                                     MesFinal               : SmallInt;
                                     todosLosAlmacenes,
                                     CalculaAcumulado       : Boolean;
                                 var AcumuladoArticulo      : TAcumuladoArticulo ) : IExistenciasArticulo;

    procedure CalculaConsumoCompras(     ConsumoComprasFields  : TConsumoComprasFields;
                                         MesInicial,
                                         MesFinal             : SmallInt;
                                     var SumaUnidades         : Decimal;
                                     var SumaImporte          : Decimal;
                                     var SumaDescuentos       : Decimal );

    procedure CalculaConsumoVentas(     ConsumoVentasFields  : TConsumoVentasFields;
                                        MesInicial,
                                        MesFinal             : SmallInt;
                                    var SumaUnidades         : Decimal;
                                    var SumaImporte          : Decimal;
                                    var SumaDescuentos       : Decimal );


    procedure AplicaDescuentoPrevio( var Precio    : Double;
                                         Descuento : Decimal );

    function Identificador : TGuid;
    function ObtenNroRegistros : LongInt;

    function EsUnArticuloAgrupado( Codigo : String ) : Boolean;
    function ObtenGrupoArticulos( Codigo: String; ListaElementos: TListaArticulos ) : Boolean;
    function ObtenArticuloRelacionado( CodigoArticulo : String; Tipo : SmallInt; NroOrden : SmallInt; ArticuloFields : TArticuloFields = nil ) : Boolean;
    function CalculaPrecioSobreMargenCompra( PrecioCompra : Double; DescuentoCompra, Margen : Decimal ) : Double;
    function TarifaVentaArticuloDisponible( CodigoArticulo, CodigoTarifa : String; out PrecioVenta : Double; out Descuento : Decimal ) : Boolean;

    property OnSuprimeReferenciasArticulo : Event<TStringEvent> read FOnSuprimeReferenciasArticulo write FOnSuprimeReferenciasArticulo;
  end;

var
  ArticuloModule: TArticuloModule = nil;


function Articulo : TArticuloModule;

resourceString
     RsMsg1  = 'El artículo de código [%s] no existe.';
     RsMsg2  = 'Este artículo ha sido marcado como OBSOLETO (no puede ser utilizado).';
     RsMsg3  = 'El código contiene caracteres no válidos. Solo se permiten valores numéricos (0 a 9).';
     RsMsg4  = 'Formato EAN13 incorrecto';
     RsMsg5  = 'Utilice 12 dígitos (numéricos) seguidos de un asterisco para generar el dígito de control.'#13'Como por ejemplo : 001122334455*.';
     RsMsg6  = 'Código EAN 13 incorrecto.';
     RsMsg7  = 'No está permitido el uso de artículos sin codificar o líneas manuales.';
     RsMsg8  = 'El artículo %s tiene asociado el siguiente aviso';
     
     fmtCajas        = 'FmtCajas';
     fmtComponentes  = 'FmtComponentes';

implementation

uses EnterpriseDataAccess,
     NexusRpcData,

     Gdm00Dm,
     Gim00Fields,

     b_msg,

     dmi_iva,

     dm_pai,
     dm_cnd,
     dm_iva,
     dm_sto,
     dm_sec,
     dm_lma,
     dm_fdc,
     dm_fdv,
     dm_ven;

{$R *.DFM}

function Articulo : TArticuloModule;
begin
     CreateDataModule( TArticuloModule, ArticuloModule );
     Result := ArticuloModule;
end;

procedure TArticuloModule.AplicaDescuentoPrevio( var Precio: Double; Descuento : Decimal );
begin
     Precio := Precio - ( Precio * Descuento / 100.0 );
end;

procedure TArticuloModule.ArticuloModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_ArticuloService, IArticuloService, ArticuloService );

     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmArticuloDatEconFields := TArticuloDatEconFields.Create( DmArticuloDatEconTable );
     DmListaMaterialesFields := TListaMaterialesFields.Create( DmListaMaterialesTable );
     DmTarifaComprasFields := TTarifaComprasFields.Create( DmTarifaComprasTable );
     DmTarifaVentasFields := TTarifaVentasFields.Create( DmTarifaVentasTable );
     DmTarifaCantidadVentaFields := TTarifaCantidadVentaFields.Create( DmTarifaCantidadVentaTable );
     DmTarifaClaseFields := TTarifaClaseFields.Create( DmTarifaClaseTable );
     DmCodigoBarrasFields := TCodigoBarrasFields.Create( DmCodigoBarrasTable );
     DmArticulosRelacionadosFields := TArticulosRelacionadosFields.Create( DmArticulosRelacionadosTable );

     ArticuloFields := TArticuloFields.Create( Self );

     ExecComponentProcedures( idArtModule, imOnCreateComponent );
end;

procedure TArticuloModule.ArticuloModuleDestroy(Sender: TObject);
begin
     ArticuloModule := nil;
end;

function TArticuloModule.Valida(     EditControl    : TcxCustomEdit;
                                 var DisplayValue   : Variant;
                                 var ErrorText      : TCaption;
                                 var Error          : Boolean;
                                     ArticuloFields : TArticuloFields = nil;
                                     IsInfoControl  : Boolean = False ) : String;

begin
     DmArticuloTable.IndexFieldNames := 'Codigo';
     var WasEditModified := Assigned( EditControl ) and EditControl.ModifiedAfterEnter;
     Result := ValidateRelationEx( EditControl, DmArticuloTable, [ DisplayValue ], DisplayValue, ErrorText, Error, ArticuloFields, RsDescripcion, IsInfoControl );

     If   Error
     then If   DisplayValue=ArticuloManual
          then If   Assigned( EditControl ) and EditControl.Editing and DataModule00.DmEmpresaFields.Articulo_SoloCodificados.Value
               then ErrorText := RsMsg7
               else If   Assigned( ArticuloFields )
                    then With ArticuloFields do
                           try
                             DatasetAppend;
                             TipoIVA.Value := Tasa.TipoIVAGlobal( ApplicationContainer.TodayDate, rgTipoIVAManual );
                           finally
                             DatasetBrowse;
                             Error := False;
                             end;

     If   not Error and
          not ValueIsEmpty( DisplayValue ) and
          not IsInfoControl
     then If   DmArticuloFields.Obsoleto.Value
          then begin
               Error := True;
               ErrorText := RsMsg2;
               end
          else If   WasEditModified and DmArticuloFields.MostrarAviso.Value
               then ApplicationContainer.ShowAlert( Format( RsMsg8, [ DmArticuloFields.Descripcion.Value ] ), DmArticuloFields.Aviso.AsString, atArticulo );

end;

function TArticuloModule.Descripcion( Codigo             : String;
                                      NotificaSiNoExiste : Boolean = True;
                                      ArticuloFields     : TArticuloFields = nil ) : String;
begin
     Result := '';
     If   ( Codigo<>ArticuloManual ) and
          ( Codigo<>'' )
     then If   Assigned( ArticuloFields )
          then begin
               If   DmArticuloTable.FindKey( [ Codigo ] )
               then Result := DmArticuloFields.Descripcion.Value
               else If   NotificaSiNoExiste
                    then Result := RsRegistroInexistente;
               If   Assigned( ArticuloFields )
               then ArticuloFields.Update( DmArticuloTable );
               end
          else GetRelationDescription( DmArticuloTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

procedure TArticuloModule.CreaArticuloManual( Codigo         : String;
                                              ArticuloFields : TArticuloFields = nil );
begin
     With DmArticuloTable do
       try
         Append;
         DmArticuloFields.Codigo.Value := Codigo;
         DmArticuloFields.TipoIVA.Value := Tasa.TipoIVAGlobal( ApplicationContainer.TodayDate, rgTipoIVAManual );
       finally
         Browse;
         end;
     If   Assigned( ArticuloFields )
     then ArticuloFields.Update( DmArticuloTable );
end;

function TArticuloModule.Obten( Codigo             : String;
                                ArticuloFields     : TArticuloFields = nil;
                                NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmArticuloTable.FindKey( [ Codigo ] );

     If   not Result
     then If   Codigo=ArticuloManual
          then begin
               CreaArticuloManual( Codigo, ArticuloFields );
               Result := True;
               end
          else If   NotificaSiNoExiste
               then begin
                    ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
                    Abort;
                    end;

     If   Assigned( ArticuloFields )
     then ArticuloFields.Update( DmArticuloTable );

end;

function TArticuloModule.Existe( Codigo : String ) : Boolean;
begin
     Result := RecordExists( DmArticuloTable, [ Codigo ] );
end;

function TArticuloModule.ObtenNroRegistros: LongInt;
begin
     With DmArticuloTable do
       begin
       CancelRange;
       Result := RecordCount;
       end;
end;

procedure TArticuloModule.ObtenPrecioyDtoCompra( LineaMovimientoFields : TLineaMovimientoFields;
                                                 CodigoProveedor       : String;
                                                 Inicializar           : Boolean = False );

var  PrecioLinea : Double;
     PuntoVerdeLinea,
     DescuentoLinea : Decimal;

begin

     PrecioLinea := LineaMovimientoFields.Precio.Value;
     PuntoVerdeLinea := LineaMovimientoFields.PuntoVerde.Value;
     DescuentoLinea := LineaMovimientoFields.Descuento.Value;

     ObtenPrecioyDtoCompra( CodigoProveedor,
                            LineaMovimientoFields.CodigoArticulo.Value,
                            LineaMovimientoFields.CodigoClaseA.Value,
                            LineaMovimientoFields.CodigoClaseB.Value,
                            LineaMovimientoFields.CodigoClaseC.Value,
                            LineaMovimientoFields.Cantidad.Value,
                            PrecioLinea,
                            PuntoVerdeLinea,
                            DescuentoLinea,
                            Inicializar  );

     LineaMovimientoFields.Precio.Value := PrecioLinea;
     LineaMovimientoFields.PuntoVerde.Value := PuntoVerdeLinea;
     LineaMovimientoFields.Descuento.Value := DescuentoLinea;

end;

procedure TArticuloModule.ObtenPrecioyDtoCompra(    CodigoProveedor,
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

begin
     ArticuloService.ObtenPrecioyDtoCompra( CodigoProveedor,
                                            CodigoArticulo,
                                            CodigoClaseA,
                                            CodigoClaseB,
                                            CodigoClaseC,
                                            Cantidad,
                                            Precio,
                                            PuntoVerde,
                                            Descuento,
                                            Inicializar,
                                            Fecha );
end;

function TArticuloModule.EstaEnOferta( ArticuloFields : TArticuloFields;
                                       Fecha          : TDateTime ) : Boolean;
begin
     Result := False;
     If   ( ArticuloFields.Oferta.Value ) and ( Fecha<>0 )
     then Result := ( Fecha>=ArticuloFields.OfertaFechaInicial.Value ) and ( Fecha<=ArticuloFields.OfertaFechaFinal.Value );
end;

procedure TArticuloModule.ObtenPrecioyDtoVenta( TipoMovimiento        : TTipoMovimiento;
                                                LineaMovimientoFields : TLineaMovimientoFields;
                                                CodigoCliente         : String;
                                                Inicializar           : Boolean = False );

var  PrecioLinea : Double;
     CantidadLinea,
     PuntoVerdeLinea,
     RecargoLinea,
     DescuentoLinea : Decimal;
     FechaLinea : TDateTime;
     EsUnaOferta : Boolean;

begin

     PrecioLinea := LineaMovimientoFields.Precio.Value;

     If   Assigned( LineaMovimientoFields.PuntoVerde )
     then PuntoVerdeLinea := LineaMovimientoFields.PuntoVerde.Value
     else PuntoVerdeLinea := 0.0;

     RecargoLinea := LineaMovimientoFields.Recargo.Value;
     DescuentoLinea := LineaMovimientoFields.Descuento.Value;

     If   Assigned( LineaMovimientoFields.Fecha )
     then FechaLinea := LineaMovimientoFields.Fecha.Value
     else FechaLinea := ApplicationContainer.TodayDate;

     If   TipoMovimiento=tmVenta
     then CantidadLinea := LineaMovimientoFields.CantidadAjustada.Value
     else CantidadLinea := LineaMovimientoFields.Cantidad.Value;

     ObtenPrecioyDtoVenta( TipoMovimiento,
                           CodigoCliente,
                           LineaMovimientoFields.CodigoArticulo.Value,
                           LineaMovimientoFields.CodigoClaseA.Value,
                           LineaMovimientoFields.CodigoClaseB.Value,
                           LineaMovimientoFields.CodigoClaseC.Value,
                           CantidadLinea,
                           PrecioLinea,
                           PuntoVerdeLinea,
                           RecargoLinea,
                           DescuentoLinea,
                           EsUnaOferta,
                           '',
                           Inicializar,
                           FechaLinea  );

     LineaMovimientoFields.Precio.Value := PrecioLinea;

     If   Assigned( LineaMovimientoFields.PuntoVerde )
     then LineaMovimientoFields.PuntoVerde.Value := PuntoVerdeLinea;

     LineaMovimientoFields.Recargo.Value := RecargoLinea;
     LineaMovimientoFields.Descuento.Value := DescuentoLinea;

     If   Assigned( LineaMovimientoFields.Oferta )
     then LineaMovimientoFields.Oferta.Value := EsUnaOferta;

end;

procedure TArticuloModule.ObtenPrecioyDtoVenta(     TipoMovimiento  : TTipoMovimiento;
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
begin
     ArticuloService.ObtenPrecioyDtoVenta(  TipoMovimiento,
                                            CodigoCliente,
                                            CodigoArticulo,
                                            CodigoClaseA,
                                            CodigoClaseB,
                                            CodigoClaseC,
                                            Cantidad,
                                            Precio,
                                            PuntoVerde,
                                            Recargo,
                                            Descuento,
                                            EsUnaOferta,
                                            CodigoTarifa,
                                            Inicializar,
                                            Fecha );
end;

procedure TArticuloModule.ObtenPrecioVentaPorTarifa(     CodigoArticulo,
                                                         CodigoFamilia,
                                                         CodigoTarifa          : String;
                                                     var Cantidad              : Decimal;
                                                     var Precio                : Double;
                                                     var Recargo               : Decimal;
                                                     var Descuento             : Decimal;
                                                         ObtenerCantidadMinima : Boolean = False );
begin

     ArticuloService.ObtenPrecioVentaPorTarifa( CodigoArticulo,
                                                CodigoFamilia,
                                                CodigoTarifa,
                                                Cantidad,
                                                Precio,
                                                Recargo,
                                                Descuento,
                                                ObtenerCantidadMinima );
end;

{
 A diferencia de la versión previa este procedimiento no comprueba si el artículo tiene activado el valor 'calcularPrecios'
 que deberá ser comprobado antes de llamar a la función

     If   ArticuloFields.CalcularPrecios
     then ...

}

function TArticuloModule.CalculaPrecioDesgloseVenta( TipoMovimiento  : TTipoMovimiento;
                                                     CodigoCliente,
                                                     CodigoArticulo,
                                                     CodigoClaseA,
                                                     CodigoClaseB,
                                                     CodigoClaseC    : String;
                                                     Fecha           : TDateTime = 0 ) : Decimal;
var ImporteBruto,
    DescuentoArticulo,
    ImporteNeto : Decimal;
    PrecioVenta : Double;
    PuntoVerde,
    ContribucionRAP,
    RecargoVenta,
    DescuentoVenta : Decimal;
    EsUnaOferta : Boolean;

begin
     With DmListaMaterialesTable do
       try
         Result := 0.0;
         SetRange( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 1 ],
                   [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, MaxSmallint ] );
         First;
         While not Eof do
           begin

           With DmListaMaterialesFields do
             begin

             PrecioVenta := 0.0;
             PuntoVerde := 0.0;
             ContribucionRAP := 0.0;
             RecargoVenta := 0.0;
             DescuentoVenta := 0.0;
             EsUnaOferta := False;

             If   Obten( CodigoComponente.Value, ArticuloFields )
             then begin
                  ObtenPrecioyDtoVenta( TipoMovimiento, CodigoCliente, CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, Cantidad.Value, PrecioVenta, PuntoVerde, RecargoVenta, DescuentoVenta, EsUnaOferta, '', True, Fecha );
                  FacturaVentas.CalculaImportes( Cantidad.Value,
                                                 ArticuloFields.UnidadesPrecioVenta.Value,
                                                 PrecioVenta,
                                                 PuntoVerde,
                                                 ContribucionRAP,
                                                 RecargoVenta,
                                                 DescuentoVenta,
                                                 ImporteBruto,
                                                 DescuentoArticulo,
                                                 ImporteNeto );
                  DecAdd( Result, ImporteNeto );
                  end;

             end;

           Next;
           end;
       finally
         CancelRange
         end;
end;

function TArticuloModule.CalculaPrecioSobreMargenCompra( PrecioCompra     : Double;
                                                         DescuentoCompra,
                                                         Margen           : Decimal ) : Double;
begin
     If   DataModule00.DmEmpresaFields.Articulo_DtosCompraEnMargenes.Value
     then PrecioCompra := PrecioCompra - ( ( PrecioCompra * DescuentoCompra ) / 100.0 );
     Result := PrecioCompra;
     If   Margen<>0.0
     then If   DataModule00.DmEmpresaFields.Articulo_MargenSobrePrecioCompra.Value
          then Result := RedondeaExt( PrecioCompra + ( ( PrecioCompra * Margen ) / 100.0 ), DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value )
          else If   Margen<100.0
               then Result := RedondeaExt( PrecioCompra / ( 1 - ( Margen / 100.0 ) ), DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );
end;

function TArticuloModule.CalculaPrecioDesgloseCompra( CodigoProveedor,
                                                      CodigoArticulo  : String;
                                                      CodigoClaseA,
                                                      CodigoClaseB,
                                                      CodigoClaseC    : String ) : Decimal;
var ImporteBruto,
    descuentoArticulo,
    ImporteNeto : Decimal;
    PrecioCompra : Double;
    PuntoVerdeCompra,
    DescuentoCompra : Decimal;

begin
     With DmListaMaterialesTable do
       try
         Result := 0.0;
         SetRange( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 1 ],
                   [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, MaxSmallint ] );
         First;
         While not Eof do
           begin

           With DmListaMaterialesFields do
             If   Obten( CodigoComponente.Value, ArticuloFields )
             then begin
                  ObtenPrecioyDtoCompra( CodigoProveedor,
                                         CodigoComponente.Value,
                                         ClaseAComponente.Value,
                                         ClaseBComponente.Value,
                                         ClaseCComponente.Value,
                                         Cantidad.Value,
                                         PrecioCompra,
                                         PuntoVerdeCompra,
                                         DescuentoCompra,
                                         True );

                  FacturaCompras.CalculaImportes( Cantidad.Value,
                                                  ArticuloFields.UnidadesPrecioCompra.Value,
                                                  PrecioCompra,
                                                  PuntoVerdeCompra,
                                                  DescuentoCompra,
                                                  ImporteBruto,
                                                  DescuentoArticulo,
                                                  ImporteNeto );

                  DecAdd( Result, ImporteNeto );
                  end;

           Next;
           end;

       finally
         CancelRange;
         end;
end;

procedure TArticuloModule.AltaDatosEconomicos( UnEjercicio          : SmallInt;
                                               UnCodigoArticulo     : String;
                                               UnCodigoClaseA,
                                               UnCodigoClaseB,
                                               UnCodigoClaseC       : String;
                                               UnCodigoAlmacen      : String;
                                               ArticuloDatEconTable : TnxeTable );
begin
    with DmArticuloDatEconTable do
      begin
      Append;
      With DmArticuloDatEconFields do
        begin
        Ejercicio.Value := UnEjercicio;
        Codigo.Value := UnCodigoArticulo;
        CodigoClaseA.Value := UnCodigoClaseA;
        CodigoClaseB.Value := UnCodigoClaseB;
        CodigoClaseC.Value := UnCodigoClaseC;
        CodigoAlmacen.Value := UnCodigoAlmacen;
        end;
      Post;
      If   Assigned( ArticuloDatEconTable )
      then ArticuloDatEconTable.GotoCurrent( DmArticuloDatEconTable );
      end;
end;

function TArticuloModule.ReferenciaProveedor( CodigoProveedor : String;
                                              CodigoArticulo  : String;
                                              CodigoInterno   : Boolean ) : String;
begin
     Result := CodigoArticulo;
     If   CodigoArticulo<>ArticuloManual
     then With DmTarifaComprasTable do
            try
              If   CodigoInterno
              then IndexFieldNames := 'Tipo;CodigoProveedor;CodigoArticulo'
              else IndexFieldNames := 'Tipo;CodigoProveedor;Referencia';
              If   FindKey( [ rtcProveedorArticulo, CodigoProveedor, CodigoArticulo ] )
              then begin
                   If   CodigoInterno
                   then Result := DmTarifaComprasFields.Referencia.Value
                   else Result := DmTarifaComprasFields.CodigoArticulo.Value;
                   end;
            finally
              IndexFieldNames := 'Tipo;CodigoProveedor;CodigoArticulo';
              end;
end;

// Se pasa el código de barras y se devuelve el del artículo, si existe

function  TArticuloModule.CodigoBarras( var CodigoArticulo : String;
                                        out CodigoClaseA   : String;
                                        out CodigoClaseB   : String;
                                        out CodigoClaseC   : String;
                                        out FijarClases    : Boolean;
                                            ArticuloFields : TArticuloFields  = nil ) : Boolean;
begin
     //* 16.05.2002 Añadida la gestión del fichero de códigos de barras
     Result := False;
     FijarClases := False;
     If   CodigoArticulo<>ArticuloManual
     then If   DmCodigoBarrasTable.FindKey( [ CodigoArticulo ] )
          then begin
               CodigoArticulo := DmCodigoBarrasFields.CodigoArticulo.Value;
               CodigoClaseA := DmCodigoBarrasFields.ClaseA.Value;
               CodigoClaseB := DmCodigoBarrasFields.ClaseB.Value;
               CodigoClaseC := DmCodigoBarrasFields.ClaseC.Value;
               FijarClases := True;
               If   Assigned( ArticuloFields )
               then Result := Obten( CodigoArticulo, ArticuloFields )
               else Result := True;
               end
          else With DmArticuloTable do
                 try
                   IndexFieldNames := 'CodigoBarras';
                   If   FindKey( [ CodigoArticulo ] )
                   then begin
                        CodigoArticulo := DmArticuloFields.Codigo.Value;
                        Result := True;
                        end;
                 finally
                   IndexFieldNames := 'Codigo';
                   If   Assigned( ArticuloFields )
                   then ArticuloFields.Update( DmArticuloTable );
                   end;
end;

function TArticuloModule.CompruebaEAN13( Codigo      : String;
                                         EditControl : TWinControl = nil ) : String;

var   Generacion : Boolean;
      Index,
      SumaPar,
      SumaImpar,
      Resultado,
      Dc : SmallInt;

begin
     try
       If   Length( Codigo )=13
       then begin

            Generacion := Codigo[ 13 ]='*';

            // Comprobando si son todos numéricos

            For Index := 1 to 12 do
              If   not CharInSet( Codigo[ Index ], [ '0'..'9' ] )
              then begin
                   ShowHintMsg( RsMsg3, '', EditControl );
                   Exit;
                   end;

            // Calculando la Suma de las posiciones pares

            SumaPar := 0;
            Index := 2;
            repeat
              SumaPar := SumaPar + ( Ord( Codigo[ Index ] ) - 48 );
              inc( Index, 2 );
            until ( Index>12 );

            SumaPar := SumaPar * 3;

            // Calculando la Suma de las posiciones impares

            SumaImpar := 0;
            Index := 1;
            repeat
              SumaImpar := SumaImpar + ( Ord( Codigo[ Index ] ) - 48 );
              Inc( Index, 2 );
            until ( Index>12 );

            Resultado := SumaPar + SumaImpar;
            Dc := 0;

            For Index := 0 to 9 do
              If   ( ( Resultado + Index ) mod 10 )=0
              then begin
                   Dc := Index;
                   Break;
                   end;

            If   Generacion
            then Codigo[ 13 ] := Char( 48 + Dc )
            else If   Ord( Codigo[ 13 ] ) - 48<>Dc
                 then ShowHintMsg( RsMsg6, '', EditControl );

            end
       else ShowHintMsg( RsMsg4, RsMsg5, EditControl );

     finally
       Result := Codigo;
       end;
end;

function  TArticuloModule.ReferenciaCliente( CodigoCliente  : String;
                                             CodigoArticulo : String ) : String;
begin
     Result := CodigoArticulo;
     With DmTarifaVentasTable do
       If   FindKey( [ rtvClienteArticulo, CodigoCliente, CodigoArticulo ] )
       then If   not ValueIsEmpty( DmTarifaVentasFields.Referencia.Value )
            then Result := DmTarifaVentasFields.Referencia.Value;
end;

function  TArticuloModule.TarifaVentaArticuloDisponible(     CodigoArticulo,
                                                             CodigoTarifa    : String;
                                                         out PrecioVenta     : Double;
                                                         out Descuento       : Decimal ) : Boolean;
begin
     Result := False;
     PrecioVenta := 0.0;
     Descuento := 0.0;
     With DmTarifaVentasTable do
       If   FindKey( [ rtvTarifaArticulo, CodigoTarifa, CodigoArticulo ] )
       then begin
            PrecioVenta := DmTarifaVentasFields.Precio.Value;
            Descuento := DmTarifaVentasFields.Descuento.Value;
            Result := DmTarifaVentasFields.Disponible.Value;
            end;
end;

procedure TArticuloModule.SuprimeReferencias( CodigoArticulo : String );

var  QuotedCodigoArticulo : String;

begin
     try

       QuotedCodigoArticulo := QuotedStr( CodigoArticulo );

       With EnterpriseDataModule do
         begin

         ExecQuery( 'DELETE FROM ArticuloDatEcon WHERE Codigo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM TablaComision WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM TarifaClase WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM TarifaCompras WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM TarifaVentas WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM TarifaCantidadVenta WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM Stock WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM ExistenciasArticulo WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         ExecQuery( 'DELETE FROM ClasesArticulo WHERE CodigoArticulo=' + QuotedCodigoArticulo );

         // Los posibles bloqueos temporales de los registros de Stock requieren que se supriman de forma individual

         // StockAlmacen.SuprimeReferenciasArticulo( CodigoArticulo );

         OnSuprimeReferenciasArticulo.Invoke( CodigoArticulo );

         end;

     except on E : Exception do
       ShowException( E, Self );
       end;
end;

procedure TArticuloModule.CalculaAcumulados(     ArticuloDatEconFields : TArticuloDatEconFields;
                                             var AcumuladoArticulo     : TAcumuladoArticulo;
                                                 MesInicial,
                                                 MesFinal              : SmallInt;
                                                 Limpiar               : Boolean );
begin

     With ArticuloDatEconFields, AcumuladoArticulo do
       begin

       If   Limpiar
       then FillChar( AcumuladoArticulo, SizeOf( AcumuladoArticulo ), #0 );

       If   MesInicial=0
       then MesInicial := ApplicationContainer.NroMesInicial;
       If   MesFinal=0
       then MesFinal := ApplicationContainer.NroMesFinal;

       SecuenciaMes.Reset( MesInicial, MesFinal );

       try

         With SecuenciaMes do
           repeat

             DecAdd( UnidadesComprasMes[ FMesActual ], UnidadesCompras[ FMesActual ].Value );
             DecAdd( ImporteComprasMes[ FMesActual ], ImporteCompras[ FMesActual ].Value );
             DecAdd( ImporteDescuentosComprasMes[ FMesActual ], ImporteDescuentosCompras[ FMesActual ].Value );
             DecAdd( UnidadesVentasMes[ FMesActual ], UnidadesVentas[ FMesActual ].Value );
             DecAdd( ImporteVentasMes[ FMesActual ], ImporteVentas[ FMesActual ].Value );
             DecAdd( ImporteDescuentosVentasMes[ FMesActual ], ImporteDescuentosVentas[ FMesActual ].Value );

             DecAdd( TotalUnidadesCompras, UnidadesCompras[ FMesActual ].Value );
             DecAdd( TotalImporteCompras, ImporteCompras[ FMesActual ].Value );
             DecAdd( TotalImporteDescuentosCompras, ImporteDescuentosCompras[ FMesActual ].Value );
             DecAdd( TotalUnidadesVentas, UnidadesVentas[ FMesActual ].Value );
             DecAdd( TotalImporteVentas, ImporteVentas[ FMesActual ].Value );
             DecAdd( TotalImporteDescuentosVentas, ImporteDescuentosVentas[ FMesActual ].Value );

           until FinSecuencia;

       finally
         SecuenciaMes.free;
         end;

       end;
end;

procedure TArticuloModule.CalculaAcumulados(     AcumuladoArticulo : TAcumuladoArticulo;
                                             var AcumuladoTotal    : TAcumuladoArticulo;
                                                 MesInicial,
                                                 MesFinal          : SmallInt );
begin

       If   MesInicial=0
       then MesInicial := ApplicationContainer.NroMesInicial;
       If   MesFinal=0
       then MesFinal := ApplicationContainer.NroMesFinal;

       SecuenciaMes.Reset( MesInicial, MesFinal );

       try

         With SecuenciaMes do
           repeat

             DecAdd( AcumuladoTotal.UnidadesComprasMes[ FMesActual ], AcumuladoArticulo.UnidadesComprasMes[ FMesActual ]);
             DecAdd( AcumuladoTotal.ImporteComprasMes[ FMesActual ], AcumuladoArticulo.ImporteComprasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.ImporteDescuentosComprasMes[ FMesActual ], AcumuladoArticulo.ImporteDescuentosComprasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.UnidadesVentasMes[ FMesActual ], AcumuladoArticulo.UnidadesVentasMes[ FMesActual ]);
             DecAdd( AcumuladoTotal.ImporteVentasMes[ FMesActual ], AcumuladoArticulo.ImporteVentasMes[ FMesActual ]);
             DecAdd( AcumuladoTotal.ImporteDescuentosVentasMes[ FMesActual ], AcumuladoArticulo.ImporteDescuentosVentasMes[ FMesActual ] );

             DecAdd( AcumuladoTotal.TotalUnidadesCompras, AcumuladoArticulo.UnidadesComprasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.TotalImporteCompras, AcumuladoArticulo.ImporteComprasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.TotalImporteDescuentosCompras, AcumuladoArticulo.ImporteDescuentosComprasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.TotalUnidadesVentas, AcumuladoArticulo.UnidadesVentasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.TotalImporteVentas, AcumuladoArticulo.ImporteVentasMes[ FMesActual ] );
             DecAdd( AcumuladoTotal.TotalImporteDescuentosVentas, AcumuladoArticulo.ImporteDescuentosVentasMes[ FMesActual ] );

           until FinSecuencia;

       finally
         SecuenciaMes.free;
         end;

end;

function TArticuloModule.CalculaResultados(      CodigoArticulo         : String;
                                                 TodasLasClases         : Boolean;
                                                 CodigoClaseA,
                                                 CodigoClaseB,
                                                 CodigoClaseC           : String;
                                                 CodigoAlmacen          : String;
                                                 Ejercicio,
                                                 MesInicial,
                                                 MesFinal               : SmallInt;
                                                 TodosLosAlmacenes,
                                                 CalculaAcumulado       : Boolean;
                                             var AcumuladoArticulo      : TAcumuladoArticulo ) : IExistenciasArticulo;

var  ExistenciasArticulo : IExistenciasArticulo;

begin

     CalculaAcumulado := CalculaAcumulado and ( CodigoClaseA='' ) and ( CodigoClaseB='' ) and ( CodigoClaseC='' );

     ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                     TodasLasClases,
                                                     CodigoClaseA,
                                                     CodigoClaseB,
                                                     CodigoClaseC,
                                                     True,
                                                     '',
                                                     TodosLosAlmacenes,
                                                     CodigoAlmacen,
                                                     True,
                                                     '',
                                                     True,
                                                     Ejercicio,
                                                     MesInicial,
                                                     MesFinal );

     With DmArticuloDatEconTable do
       try

         FillChar( AcumuladoArticulo, SizeOf( AcumuladoArticulo ), #0 );

         If   TodosLosAlmacenes
         then begin
              If   CalculaAcumulado
              then SetRange( [ Ejercicio, CodigoArticulo, '', '', '', '' ],
                             [ Ejercicio, CodigoArticulo, HighStrCode, HighStrCode, HighStrCode, HighStrCode ] )

              else SetRange( [ Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, '' ],
                             [ Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, HighStrCode ] );

              end
         else If   CalculaAcumulado
              then SetRange( [ Ejercicio, CodigoArticulo, '', '', '', CodigoAlmacen ],
                             [ Ejercicio, CodigoArticulo, HighStrCode, HighStrCode, HighStrCode, CodigoAlmacen ] )
              else SetRange( [ Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CodigoAlmacen ],
                             [ Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CodigoAlmacen ] );

         First;
         While not Eof do
           begin
           CalculaAcumulados( DmArticuloDatEconFields, AcumuladoArticulo, MesInicial, MesFinal, False );
           Next;
           end;

       finally
         CancelRange;
         end;

     With AcumuladoArticulo do
       begin

       If   TotalUnidadesCompras<>0
       then PrecioMedioCompra := TotalImporteCompras / TotalUnidadesCompras
       else PrecioMedioCompra := 0.0;

       If   TotalUnidadesVentas<>0
       then PrecioMedioVenta := TotalImporteVentas / TotalUnidadesVentas
       else PrecioMedioVenta := 0.0;

       If   ( TotalImporteCompras + TotalImporteDescuentosCompras )<>0.0
       then DtosCompras := ( TotalImporteDescuentosCompras * 100.0 ) / ( TotalImporteCompras + TotalImporteDescuentosCompras )
       else DtosCompras := 0.0;

       If   ( TotalImporteVentas + TotalImporteDescuentosVentas )<>0.0
       then DtosVentas := ( TotalImporteDescuentosVentas * 100.0 ) / ( TotalImporteVentas + TotalImporteDescuentosVentas )
       else DtosVentas := 0.0;

       // El margen medio se calcula sobre el coste medio (y no sobre el precio medio de compra) para que las altas por fabricación o cualquier otra entrada que afecte a coste
       // se vean reflejadas.

       MargenMedio := 0.0;
       If   PrecioMedioVenta<>0.0
       then MargenMedio := ( 100 * ( PrecioMedioVenta - ExistenciasArticulo.CosteMedio ) ) / PrecioMedioVenta;

       end;

     Result := ExistenciasArticulo;

end;

procedure TArticuloModule.CalculaConsumoCompras(    ConsumoComprasFields  : TConsumoComprasFields;
                                                    MesInicial,
                                                    MesFinal             : SmallInt;
                                                var SumaUnidades         : Decimal;
                                                var SumaImporte          : Decimal;
                                                var SumaDescuentos       : Decimal );
begin
     SumaImporte  := 0.0;
     SumaUnidades := 0.0;

    With SecuenciaMes, ConsumoComprasFields do
      begin
      Reset( MesInicial, MesFinal );
      repeat
        DecAdd( SumaUnidades, Unidades[ FMesActual ].Value );
        DecAdd( SumaImporte,  Importe[ FMesActual ].Value );
        DecAdd( SumaDescuentos, ImporteDescuentos[ FMesActual ].Value );
      until FinSecuencia;
      end;

end;

procedure TArticuloModule.CalculaConsumoVentas(     ConsumoVentasFields  : TConsumoVentasFields;
                                                    MesInicial,
                                                    MesFinal             : SmallInt;
                                                var SumaUnidades         : Decimal;
                                                var SumaImporte          : Decimal;
                                                var SumaDescuentos       : Decimal );
begin
     SumaImporte  := 0.0;
     SumaUnidades := 0.0;

    With SecuenciaMes, ConsumoVentasFields do
      begin
      Reset( MesInicial, MesFinal );
      repeat
        DecAdd( SumaUnidades, Unidades[ FMesActual ].Value );
        DecAdd( SumaImporte, Importe[ FMesActual ].Value );
        DecAdd( SumaDescuentos, ImporteDescuentos[ FMesActual ].Value );
      until FinSecuencia;
      end;

end;

function TArticuloModule.Identificador : TGuid;
begin
     CreateGUID( Result );
end;

function TArticuloModule.EsUnArticuloAgrupado( Codigo : String ) : Boolean;
begin
     Result := False;
     With DmArticuloTable do
       try
         IndexFieldNames := 'Tienda_CodigoArticuloAgrupado';
         // Compruebo si existe, al menos, un artículo agrupado visible en la tienda y no obsoleto
         // Los compruebo todos porque se ha dado el caso de artículos previamente incluídos en un grupo y marcados luego como no visibles en la tienda.
         SetRange( [ Codigo ] );
         First;
         While not Eof do
           begin
           If   DmArticuloFields.VisibleTienda.Value and
                not DmArticuloFields.Obsoleto.Value  // Se puede desactivar, pero el código sigue presente
           then begin
                Result := True;
                Break;
                end;
           Next;
           end;
       finally
         IndexFieldNames := 'Codigo';
         end;
end;

function TArticuloModule.ObtenGrupoArticulos( Codigo         : String;
                                              ListaElementos : TListaArticulos ) : Boolean;
begin
     Result := False;
     With DmArticuloTable do
       try
         ListaElementos.Clear;
         IndexFieldNames := 'Tienda_CodigoArticuloAgrupado';
         SetRange( [ Codigo ] );
         First;
         While not Eof do
           begin
           If   DmArticuloFields.VisibleTienda.Value and
                not DmArticuloFields.Obsoleto.Value
           then ListaElementos.Add( DmArticuloFields.Codigo.Value );
           Next;
           end;
         Result := ListaElementos.Count>0;
       finally
         IndexFieldNames := 'Codigo';
         end;
end;

function TArticuloModule.ObtenArticuloRelacionado( CodigoArticulo : String;
                                                   Tipo           : SmallInt; // traRelacionados= 0, traEquivalentes = 1
                                                   NroOrden       : SmallInt; // 1..
                                                   ArticuloFields : TArticuloFields = nil ) : Boolean;
begin
     Result := DmArticulosRelacionadosTable.FindKey( [ CodigoArticulo, Tipo, NroOrden ] );
     If   Assigned( ArticuloFields )
     then If   Result
          then Obten( DmArticulosRelacionadosFields.CodigoArticuloRelacionado.Value, ArticuloFields )
          else ArticuloFields.Clear;
end;

end.

