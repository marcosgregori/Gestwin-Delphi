
unit dm_art;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  Spring,
  LibUtils,
  DataManager,
  ServerDataModule,
  SessionIntf,

  // ScroogeXHTML,
  sgcJSON,

  BaseSessionData,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dm_mov,

  dmi_mov,

  dmi_art;

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

       TArticuloPedidosOnline = class
         Codigo,
         NombreImagen,
         Nombre,
         Descripcion : String;
         PrecioVenta : Double;
         Existencias : Decimal;
         end;


       TObtenPrecioVentaEvent = procedure (     TipoMovimiento  : TTipoMovimiento;
                                                ClienteFields   : TClienteFields;
                                                ArticuloFields  : TArticuloFields;
                                                CodigoClaseA,
                                                CodigoClaseB,
                                                CodigoClaseC    : String;
                                                Cantidad        : Decimal;
                                            var Precio          : Double ) of object;

       TArticuloService = class( TSessionModule, IArticuloService )

       protected

       procedure AssignSession( const SessionID : Integer ); override;

       public

       procedure ObtenPrecioyDtoCompra(     CodigoProveedor,
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

       TArticuloModule = class(TServerDataModule)
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
         DmClienteTable: TnxeTable;
         DmProveedorTable: TnxeTable;
         DmArticuloAuxTable: TnxeTable;
         DmClasesArticuloTable: TnxeTable;
         DmClaseTable: TnxeTable;
         procedure ServerDataModuleCreate(Sender: TObject);
         procedure ServerDataModuleDestroy(Sender: TObject);

       private

         FOnObtenPrecioVenta : Event< TObtenPrecioVentaEvent >;

       public

         DmArticuloFields,
         DmArticuloAuxFields : TArticuloFields;
         DmArticuloDatEconFields : TArticuloDatEconFields;
         DmClienteFields : TClienteFields;
         DmProveedorFields : TProveedorFields;
         DmTarifaComprasFields : TTarifaComprasFields;
         DmTarifaVentasFields : TTarifaVentasFields;
         DmListaMaterialesFields : TListaMaterialesFields;
         DmTarifaCantidadVentaFields : TTarifaCantidadVentaFields;
         DmTarifaClaseFields : TTarifaClaseFields;
         DmCodigoBarrasFields : TCodigoBarrasFields;
         DmClaseFields : TClaseFields;
         DmClasesArticuloFields : TClasesArticuloFields;

         function  Obten( Codigo : String; ArticuloFields : TArticuloFields = nil ) : Boolean;
         function  Descripcion( Codigo : String; ArticuloFields : TArticuloFields = nil ) : String;
         function  EstaEnOferta( ArticuloFields : TArticuloFields; Fecha : TDateTime ) : Boolean;

         procedure ObtenPrecioyDtoCompra( LineaMovimientoFields : TLineaMovimientoFields;
                                          ProveedorFields       : TProveedorFields;
                                          ArticuloFields        : TArticuloFields;
                                          Inicializar           : Boolean = False ); overload;

         procedure ObtenPrecioyDtoCompra(     CodigoProveedor,
                                              CodigoArticulo,
                                              CodigoClaseA,
                                              CodigoClaseB,
                                              CodigoClaseC    : String;
                                              Cantidad        : Decimal;
                                          var Precio          : Double;
                                          var PuntoVerde      : Decimal;
                                          var Descuento       : Decimal;
                                              Inicializar     : Boolean = False;
                                              Fecha           : TDateTime = 0 ); overload;

         procedure ObtenPrecioyDtoCompra(     ProveedorFields : TProveedorFields;
                                              ArticuloFields  : TArticuloFields;
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
                                         ClienteFields         : TClienteFields;
                                         ArticuloFields        : TArticuloFields;
                                         Inicializar           : Boolean = False ); overload;

         procedure ObtenPrecioyDtoVenta(     TipoMovimiento : TTipoMovimiento;
                                             CodigoCliente,
                                             CodigoArticulo,
                                             CodigoClaseA,
                                             CodigoClaseB,
                                             CodigoClaseC   : String;
                                             Cantidad       : Decimal;
                                         var Precio         : Double;
                                         var PuntoVerde     : Decimal;
                                         var Recargo        : Decimal;
                                         var Descuento      : Decimal;
                                         out EsUnaOferta    : Boolean;
                                             CodigoTarifa   : String = '';
                                             Inicializar     : Boolean = False;
                                             Fecha           : TDateTime = 0 ); overload;

         procedure ObtenPrecioyDtoVenta(     TipoMovimiento  : TTipoMovimiento;
                                             ClienteFields   : TClienteFields;
                                             ArticuloFields  : TArticuloFields;
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
                                             Fecha           : TDateTime = 0 ); overload;

         procedure ObtenPrecioVentaPorTarifa(     CodigoArticulo,
                                                  CodigoFamilia,
                                                  CodigoTarifa          : String;
                                              var Cantidad              : Decimal;
                                              var Precio                : Double;
                                              var Recargo               : Decimal;
                                              var Descuento             : Decimal;
                                                  ObtenerCantidadMinima : Boolean = False );

         (*
         function CalculaPrecioDesgloseCompra( ProveedorFields : TProveedorFields;
                                               CodigoArticulo  : String;
                                               CodigoClaseA,
                                               CodigoClaseB,
                                               CodigoClaseC    : String ) : Decimal;

         function CalculaPrecioDesgloseVenta( TipoMovimiento  : TTipoMovimiento;
                                              ClienteFields   : TClienteFields;
                                              CodigoArticulo  : String;
                                              CodigoClaseA,
                                              CodigoClaseB,
                                              CodigoClaseC    : String;
                                              Fecha           : TDateTime = 0 ) : Decimal;
         *)

         procedure AltaDatosEconomicos( UnEjercicio : SmallInt; UnCodigoArticulo : String; UnCodigoClaseA, UnCodigoClaseB, UnCodigoClaseC : String; UnCodigoAlmacen : String; ArticuloDatEconTable : TnxeTable = nil );

         (*
         function  ReferenciaProveedor( CodigoProveedor : String; CodigoArticulo : String; CodigoInterno : Boolean ) : String;

         function  ReferenciaCliente( CodigoCliente : String; CodigoArticulo : String ) : String;



         procedure CalculaAcumulados(     ArticuloDatEconFields : TArticuloDatEconFields;
                                      var AcumuladoArticulo     : TAcumuladoArticulo;
                                          Ejercicio,
                                          MesInicial,
                                          MesFinal              : SmallInt;
                                          Limpiar               : Boolean ); overload;


         procedure CalculaResultados(     CodigoArticulo         : String;
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
                                      var AcumuladoArticulo      : TAcumuladoArticulo );

         procedure CalculaConsumoCompras(     ConsumoComprasFields  : TConsumoComprasFields;
                                              MesInicial,
                                              MesFinal             : SmallInt;
                                          var SumaUnidades         : Decimal;
                                          var SumaImporte          : Decimal );

         procedure CalculaConsumoVentas(     ConsumoVentasFields  : TConsumoVentasFields;
                                             MesInicial,
                                             MesFinal             : SmallInt;
                                         var SumaUnidades         : Decimal;
                                         var SumaImporte          : Decimal );
         *)

         function  CodigoBarras( var CodigoArticulo : String;
                                 out CodigoClaseA   : String;
                                 out CodigoClaseB   : String;
                                 out CodigoClaseC   : String;
                                 out FijarClases    : Boolean;
                                     ArticuloFields : TArticuloFields  = nil ) : Boolean;

         function Identificador : TGuid;
         function ObtenNroRegistros : LongInt;

         property OnObtenPrecioVenta : Event< TObtenPrecioVentaEvent > read FOnObtenPrecioVenta write FOnObtenPrecioVenta;

         // WebService

         class function ObtenListaArticulosWs( SessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;

         function ObtenListaArticulos( DataIn, DataOut : IsgcJSON ) : Boolean;
end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,

     SessionData,
     ServerContainer,
     ServerUtils,
     WebService,

     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsdServerEngine,

     Gsm00Dm,

     dmi_cls,
     dmi_iva,

     dm_pai,
     dm_iva,
     dm_cls;

{$R *.DFM}

procedure TArticuloModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmArticuloAuxFields := TArticuloFields.Create( DmArticuloAuxTable );
     DmArticuloDatEconFields := TArticuloDatEconFields.Create( DmArticuloDatEconTable );
     DmClienteFields := TClienteFields.Create( DmClienteTable );
     DmProveedorFields := TProveedorFields.Create( DmProveedorTable );
     DmListaMaterialesFields := TListaMaterialesFields.Create( DmListaMaterialesTable );
     DmTarifaComprasFields := TTarifaComprasFields.Create( DmTarifaComprasTable );
     DmTarifaVentasFields := TTarifaVentasFields.Create( DmTarifaVentasTable );
     DmTarifaCantidadVentaFields := TTarifaCantidadVentaFields.Create( DmTarifaCantidadVentaTable );
     DmTarifaClaseFields := TTarifaClaseFields.Create( DmTarifaClaseTable );
     DmCodigoBarrasFields := TCodigoBarrasFields.Create( DmCodigoBarrasTable );
     DmClaseFields := TClaseFields.Create( DmClaseTable );
     DmClasesArticuloFields := TClasesArticuloFields.Create( DmClasesArticuloTable );
end;

procedure TArticuloModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.ArticuloModule := nil
end;

function TArticuloModule.Obten( Codigo         : String;
                                ArticuloFields : TArticuloFields = nil ) : Boolean;
begin
     Result := DmArticuloTable.FindKey( [ Codigo ] );
     If   not Result
     then With DmArticuloTable do
            try
              Append;
              DmArticuloFields.Codigo.Value := Codigo;
              DmArticuloFields.TipoIVA.Value := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( SessionDataModule.FechaHoy, rgTipoIVAManual );
            finally
              Browse;
              Result := Codigo=ArticuloManual;
              end;
     If   Assigned( ArticuloFields )
     then ArticuloFields.Update( DmArticuloTable );
end;

function TArticuloModule.CodigoBarras( var CodigoArticulo : String;
                                       out CodigoClaseA,
                                           CodigoClaseB,
                                           CodigoClaseC   : String;
                                       out FijarClases    : Boolean;
                                           ArticuloFields : TArticuloFields  = nil ) : Boolean;
begin
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
               Result := Obten( CodigoArticulo, ArticuloFields );
               end
          else With DmArticuloAuxTable do
                 try
                   If   FindKey( [ CodigoArticulo ] )
                   then begin
                        CodigoArticulo := DmArticuloAuxFields.Codigo.Value;
                        Result := True;
                        end;
                 finally
                   If   Assigned( ArticuloFields )
                   then ArticuloFields.Update( DmArticuloAuxTable );
                   end;
end;

function TArticuloModule.Descripcion( Codigo         : String;
                                      ArticuloFields : TArticuloFields = nil ) : String;
begin
     Result := '';
     If   Codigo<>ArticuloManual
     then If   DmArticuloTable.FindKey( [ Codigo ] )
          then Result := DmArticuloFields.Descripcion.Value;
     If   Assigned( ArticuloFields )
     then ArticuloFields.Update( DmArticuloTable );
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
                                                 ProveedorFields       : TProveedorFields;
                                                 ArticuloFields        : TArticuloFields;
                                                 Inicializar           : Boolean = False );

var  PrecioLinea : Double;
     PuntoVerdeLinea,
     DescuentoLinea : Decimal;

begin

     If   LineaMovimientoFields.CodigoArticulo.Value=ArticuloManual
     then Exit;

     PrecioLinea := LineaMovimientoFields.Precio.Value;
     PuntoVerdeLinea := LineaMovimientoFields.PuntoVerde.Value;
     DescuentoLinea := LineaMovimientoFields.Descuento.Value;

     ObtenPrecioyDtoCompra( ProveedorFields,
                            ArticuloFields,
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

var ProveedorFields : TProveedorFields;

begin
     If   CodigoArticulo<>ArticuloManual
     then If   DmArticuloTable.FindKey( [ CodigoArticulo ] )
          then begin

               ProveedorFields := nil;

               If   CodigoProveedor<>''
               then If   DmProveedorTable.FindKey( [ CodigoProveedor ] )
                    then ProveedorFields := DmProveedorFields;

               ObtenPrecioyDtoCompra( ProveedorFields,
                                      DmArticuloFields,
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
end;

procedure TArticuloModule.ObtenPrecioyDtoCompra(    ProveedorFields : TProveedorFields;
                                                    ArticuloFields  : TArticuloFields;
                                                    CodigoClaseA,
                                                    CodigoClaseB,
                                                    CodigoClaseC    : String;
                                                    Cantidad        : Decimal;
                                                var Precio          : Double;
                                                var PuntoVerde      : Decimal;
                                                var Descuento       : Decimal;
                                                    Inicializar     : Boolean = False;
                                                    Fecha           : TDateTime = 0 );

var CodigoProveedor,
    CodigoArticulo : String;

procedure FijaPrecioDescuentoPorTarifa( Seccion : SmallInt;
                                        Codigo  : String );  // Tarifa o proveedor

procedure FijaValores;
begin
     If   Precio=0.0
     then Precio := DmTarifaClaseFields.Precio.Value;
     If   Descuento=0.0
     then Descuento := DmTarifaClaseFields.Descuento.Value;
end;

begin
     If   DmTarifaClaseTable.FindKey( [ Seccion, Codigo, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC ] )
     then FijaValores;
     If   Precio=0.0
     then If   DmTarifaClaseTable.FindKey( [ Seccion, Codigo, CodigoArticulo, CodigoClaseA, CodigoClaseB, '' ] )
          then FijaValores;
     If   Precio=0.0
     then If   DmTarifaClaseTable.FindKey( [ Seccion, Codigo, CodigoArticulo, CodigoClaseA, '', '' ] )
          then FijaValores;
end;

begin

     CodigoArticulo := ArticuloFields.Codigo.Value;

     If   CodigoArticulo<>ArticuloManual
     then begin

          If   Assigned( ProveedorFields )
          then CodigoProveedor := ProveedorFields.Codigo.Value
          else CodigoProveedor := '';

          If   Inicializar
          then begin
               Precio := 0.0;
               PuntoVerde := 0.0;
               Descuento  := 0.0;
               end;

          // Primero, comprobar las posibles ofertas vigentes

          If   CodigoProveedor<>''
          then begin

               If   SessionDataModule.EmpresaFields.Compras_UtilizarPrecioOfertas.Value
               then With PrecioOfertaQuery do
                      try

                        Close;

                        If   Fecha=0
                        then Fecha := SessionDataModule.FechaHoy;

                        SQL.Text := 'SELECT TOP 1 * ' +
                                    'FROM ( SELECT Movimiento.Ejercicio, Movimiento.NroOperacion, Movimiento.Propietario, Lineas.Precio, Lineas.Descuento ' +
                                    'FROM ( SELECT Ejercicio, NroOperacion, Precio, Descuento ' +
                                    '       FROM LineaMovimiento ' +
                                    '       WHERE LineaMovimiento.CodigoArticulo=' + QuotedStr( CodigoArticulo ) + ' AND ';

                        If   CodigoClaseA=''
                        then SQL.Add( '( LineaMovimiento.CodigoClaseA IS NULL OR LineaMovimiento.CodigoClaseA='''' )' )
                        else SQL.Add( '( LineaMovimiento.CodigoClaseA=' + QuotedStr( CodigoClaseA ) + ')' );

                        SQL.Add( ' AND ' );

                        If   CodigoClaseB=''
                        then SQL.Add( '( LineaMovimiento.CodigoClaseB IS NULL OR LineaMovimiento.CodigoClaseB='''' )' )
                        else SQL.Add( '( LineaMovimiento.CodigoClaseB=' + QuotedStr( CodigoClaseB )  + ')' );

                        SQL.Add( ' AND ' );

                        If   CodigoClaseC=''
                        then SQL.Add( '( LineaMovimiento.CodigoClaseC IS NULL OR LineaMovimiento.CodigoClaseC='''' )' )
                        else SQL.Add( '( LineaMovimiento.CodigoClaseC=' + QuotedStr( CodigoClaseC )  + ')' );

                        SQL.Add( '  ) AS Lineas LEFT JOIN Movimiento ON ( Lineas.Ejercicio=Movimiento.Ejercicio AND Lineas.NroOperacion=Movimiento.NroOperacion ) ' +
                                 ' WHERE Movimiento.TipoMovimiento=10 AND ' +
                                 '       Movimiento.Fecha>=' + SQLDateString( Fecha ) + ' AND ' +
                                 '      ( Movimiento.FechaAplicacion IS NULL OR Movimiento.FechaAplicacion<=' + SQLDateString( Fecha ) + ' ) ' +
                                 'ORDER BY Propietario, Fecha DESC, NroDocumento DESC ) AS Oferta ' +
                                 'WHERE Oferta.Propietario=' + QuotedStr( CodigoProveedor ) );

                        Open;

                        Precio := PrecioOfertaQueryPrecio.Value;   // Si no existe será nulo
                        Descuento := PrecioOfertaQueryDescuento.Value;

                      finally
                        Close
                        end;

               If   SessionDataModule.EmpresaFields.Articulo_TarifaClase.Value
               then begin

                    // Primero el proveedor en cuestión, y si no existe el genérico, que los engloba a todos

                    FijaPrecioDescuentoPorTarifa( rtclComprasProveedor, CodigoProveedor );
                    If   Precio=0.0
                    then FijaPrecioDescuentoPorTarifa( rtclComprasProveedor, '' );

                    end;

               If   Precio=0.0
               then With DmTarifaComprasTable do
                      begin
                      IndexFieldNames := 'Tipo;CodigoProveedor;CodigoArticulo';
                      If   FindKey( [ rtcProveedorArticulo, CodigoProveedor, CodigoArticulo ] )
                      then begin
                           If   Precio=0.0
                           then Precio := DmTarifaComprasFields.Precio.Value;
                           If   Descuento=0.0
                           then Descuento := DmTarifaComprasFields.Descuento.Value;
                           end;
                      end;

               end;

          If   Precio=0.0
          then begin
               If   Precio=0.0
               then Precio := ArticuloFields.Precio_Compra.Value;
               If   Descuento=0.0
               then Descuento := ArticuloFields.Dto_Compra.Value;
               end;

          If   Assigned( ProveedorFields ) and ( SessionDataModule.EmpresaFields.Articulo_PuntoVerde.Value ) and ( ProveedorFields.CodigoPais.Value=CodigoEspaña ) and ( PuntoVerde=0.0 )
          then PuntoVerde := DmArticuloFields.PuntoVerde.Value;

          end;

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
                                                ClienteFields         : TClienteFields;
                                                ArticuloFields        : TArticuloFields;
                                                Inicializar           : Boolean = False );

var  PrecioLinea : Double;
     CantidadLinea,
     PuntoVerdeLinea,
     RecargoLinea,
     DescuentoLinea : Decimal;
     FechaLinea : TDateTime;
     EsUnaOferta : Boolean;

begin

     If   LineaMovimientoFields.CodigoArticulo.Value=ArticuloManual
     then Exit;

     PrecioLinea := LineaMovimientoFields.Precio.Value;

     If   Assigned( LineaMovimientoFields.PuntoVerde )
     then PuntoVerdeLinea := LineaMovimientoFields.PuntoVerde.Value
     else PuntoVerdeLinea := 0.0;

     RecargoLinea := LineaMovimientoFields.Recargo.Value;
     DescuentoLinea := LineaMovimientoFields.Descuento.Value;

     If   Assigned( LineaMovimientoFields.Fecha )
     then FechaLinea := LineaMovimientoFields.Fecha.Value
     else FechaLinea := SessionDataModule.FechaHoy;

     If   TipoMovimiento=tmVenta
     then CantidadLinea := LineaMovimientoFields.CantidadAjustada.Value
     else CantidadLinea := LineaMovimientoFields.Cantidad.Value;

     ObtenPrecioyDtoVenta( TipoMovimiento,
                           ClienteFields,
                           ArticuloFields,
                           LineaMovimientoFields.CodigoClaseA.Value,
                           LineaMovimientoFields.CodigoClaseB.Value,
                           LineaMovimientoFields.CodigoClaseC.Value,
                           CantidadLinea,
                           PrecioLinea,
                           PuntoVerdeLinea,
                           RecargoLinea,
                           DescuentoLinea,
                           EsUnaOferta,
                           '',                       // Se utilizará la tarifa de la ficha del cliente
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

// Esta variante de la función se utiliza sobre todo desde el servicio

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

var ClienteFields : TClienteFields;

begin
     If   CodigoArticulo<>ArticuloManual
     then If   DmArticuloTable.FindKey( [ CodigoArticulo ] )
          then begin

               ClienteFields := nil;

               If   CodigoCliente<>''
               then If   DmClienteTable.FindKey( [ CodigoCliente ] )
                    then ClienteFields := DmClienteFields;

               ObtenPrecioyDtoVenta( TipoMovimiento,
                                     ClienteFields,    // puede ser nil
                                     DmArticuloFields,
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

end;

procedure TArticuloModule.ObtenPrecioyDtoVenta(     TipoMovimiento  : TTipoMovimiento;
                                                    ClienteFields   : TClienteFields;
                                                    ArticuloFields  : TArticuloFields;
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

var   CodigoCliente,
      CodigoArticulo : String;
      PrecioOriginal : Decimal;

procedure AplicaDescuentoPrevio;
begin
     If   SessionDataModule.EmpresaFields.Ventas_DtoPrevio.Value
     then begin
          Precio := Precio - ( Precio * Descuento / 100.0 );
          Descuento := 0.0;
          end;
end;

function TarifaConsumo( CodigoCliente : String ) : Boolean;

var  _CodigoClaseA,
     _CodigoClaseB,
     _CodigoClaseC   : String;
     Nivel : ShortInt;
     Consumo : Decimal;

begin
     //* 03.03.2002  Modificado para que las tarifas por consumo también se apliquen
     //              cuando la Clase no está definida, considerando ese caso como
     //              Una tarifa genérica para toda la Clase o subclase

     Result := False;

     _CodigoClaseA := CodigoClaseA;
     _CodigoClaseB := CodigoClaseB;
     _CodigoClaseC := CodigoClaseC;

     Consumo := Cantidad;

     Nivel := 3;
     If   CodigoClaseC=''
     then begin
          Nivel := 2;
          If   CodigoClaseB=''
          then begin
               Nivel := 1;
               If   CodigoClaseA=''
               then Nivel := 0;
               end;
          end;

     With DmTarifaCantidadVentaTable do
       repeat
         FindSmallerOrEqual( [ CodigoCliente, CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, Consumo ] );
         If   not Eof
         then If   ( DmTarifaCantidadVentaFields.CodigoCliente.Value=CodigoCliente ) and
                   ( DmTarifaCantidadVentaFields.CodigoArticulo.Value=CodigoArticulo ) and
                   ( ( DmTarifaCantidadVentaFields.CodigoClaseA.Value=_CodigoClaseA ) or ValueIsEmpty( DmTarifaCantidadVentaFields.CodigoClaseA.Value ) ) and
                   ( ( DmTarifaCantidadVentaFields.CodigoClaseB.Value=_CodigoClaseB ) or ValueIsEmpty( DmTarifaCantidadVentaFields.CodigoClaseB.Value ) ) and
                   ( ( DmTarifaCantidadVentaFields.CodigoClaseC.Value=_CodigoClaseC ) or ValueIsEmpty( DmTarifaCantidadVentaFields.CodigoClaseC.Value ) ) and
                   ( DmTarifaCantidadVentaFields.CantidadMinima.Value<=Consumo ) and
                   ( DmTarifaCantidadVentaFields.CantidadMaxima.Value>=Consumo )
              then begin
                   If   Precio=0.0
                   then Precio := DmTarifaCantidadVentaFields.Precio.Value;
                   If   Descuento=0.0
                   then Descuento := DmTarifaCantidadVentaFields.Descuento.Value;
                   Result := True;
                   end
              else begin
                   case Nivel of
                     3 : _CodigoClaseC := '';
                     2 : _CodigoClaseB := '';
                     1 : _CodigoClaseA := '';
                     end;
                   Dec( Nivel );
                   end;
       until Result or ( Nivel<0 ) or Eof or
             ( DmTarifaCantidadVentaFields.CodigoCliente.Value<>CodigoCliente ) or
             ( DmTarifaCantidadVentaFields.CodigoArticulo.Value<>CodigoArticulo );
end;

{ Cuando se fija el precio a partir de la tarifa por clases y, en el registro en cuestión, no se ha fijado el precio
  pero sí el descuento, se sigue buscando un precio válido en las combinaciones de articulo/clase de menor nivel.

  Por ejemplo : Si existe el registro de tarifa por clases A00-C1-T2  ( Artículo-ClaseA-ClaseB ) y su contenido es
                0.00-10.00  (Precio-Descuento) se sigue buscando en A00-C1 un registro con un precio válido.
                Si existe el siguiente registro : A00-C1 y su contenido es 1000.00-5.00 los valores resultantes
                para el precio y descuento serán 1000.00-10.00.
}

procedure FijaPrecioDescuentoPorTarifa( Seccion : SmallInt;
                                        Codigo  : String );  // Código de cliente o de tarifa

procedure FijaValores;
begin
     If   Precio=0.0
     then Precio := DmTarifaClaseFields.Precio.Value;
     If   Descuento=0.0
     then Descuento := DmTarifaClaseFields.Descuento.Value;
end;

begin
     If   DmTarifaClaseTable.FindKey( [ Seccion, Codigo, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC ] )
     then FijaValores;
     If   Precio=0.0
     then If   DmTarifaClaseTable.FindKey( [ Seccion, Codigo, CodigoArticulo, CodigoClaseA, CodigoClaseB, '' ] )
          then FijaValores;
     If   Precio=0.0
     then If   DmTarifaClaseTable.FindKey( [ Seccion, Codigo, CodigoArticulo, CodigoClaseA, '', '' ] )
          then FijaValores;
end;

begin

     CodigoArticulo := ArticuloFields.Codigo.Value;

     If   CodigoArticulo<>ArticuloManual
     then begin

          If   Assigned( ClienteFields )
          then begin
               CodigoCliente := ClienteFields.Codigo.Value;
               If   CodigoTarifa=''
               then CodigoTarifa := ClienteFields.Factura_Tarifa.Value;
               end
          else CodigoCliente := '';

          If   Inicializar
          then begin
               Precio := 0.0;
               PuntoVerde := 0.0;
               Recargo := 0.0;
               Descuento := 0.0;
               end;

          PrecioOriginal := Precio;
          EsUnaOferta := False;

          If   ( CodigoCliente<>'' ) and
               ( SessionDataModule.EmpresaFields.Articulo_PuntoVerde.Value ) and
               ( ClienteFields.CodigoPais.Value=CodigoEspaña ) and
               ( PuntoVerde=0.0 )
          then PuntoVerde := ArticuloFields.PuntoVerde.Value;

          If   ( Assigned( ClienteFields ) and not ClienteFields.Factura_NoAplicarOfertas.Value ) and
               EstaEnOferta( ArticuloFields, Fecha )
          then begin
               Precio := ArticuloFields.OfertaPrecioVenta.Value;
               Descuento := ArticuloFields.OfertaDescuento.Value;
               EsUnaOferta := True;
               Exit;
               end;

          If   ( CodigoCliente<>'' ) and
               SessionDataModule.EmpresaFields.Cliente_TarConsumo.Value and
               not ClienteFields.Factura_SinDtosConsumo.Value
          then begin
               Precio := 0.0;
               Descuento := 0.0;
               TarifaConsumo( CodigoCliente );
               If   Precio=0.0
               then TarifaConsumo( '' );
               end;

          // Comprobando el tipo de movimiento porque en ocasiones llamo a la función para obtener un precio de venta sin querer que se utilice el cliente ( TipoMovimiento=tmNoDefinido )

          If   TipoMovimiento<>tmNoDefinido
          then begin

               If   ( ( ( Precio=0.0 ) or SessionDataModule.EmpresaFields.Cliente_DtosTarifas.Value ) and
                    SessionDataModule.EmpresaFields.Articulo_TarifaClase.Value )
               then begin

                    // Primero el cliente en cuestión, y si no existe el genérico, que los engloba a todos

                    If   CodigoCliente<>''
                    then FijaPrecioDescuentoPorTarifa( rtclVentasCliente, CodigoCliente );
                    If   Precio=0.0
                    then FijaPrecioDescuentoPorTarifa( rtclVentasCliente, '' );

                    // Y por fin, por código de tarifa

                    If   ( CodigoTarifa<>'' ) and ( Precio=0.0 )
                    then FijaPrecioDescuentoPorTarifa( rtclVentasCodigoTarifa, CodigoTarifa );

                    end;

               If   ( ( Precio=0.0 ) or SessionDataModule.EmpresaFields.Cliente_DtosTarifas.Value ) and
                    SessionDataModule.EmpresaFields.Cliente_Referencias.Value
               then begin

                    If   DmTarifaVentasTable.FindKey( [ rtvClienteArticulo, CodigoCliente, CodigoArticulo ] )
                    then begin
                         If   Precio=0.0
                         then Precio := DmTarifaVentasFields.Precio.Value;
                         If   Recargo=0.0
                         then Recargo := DmTarifaVentasFields.Recargo.Value;
                         If   Descuento=0.0
                         then Descuento := DmTarifaVentasFields.Descuento.Value;
                         end;

                    If   ( Descuento=0.0 )  and
                         ( ( Precio=0.0 ) or SessionDataModule.EmpresaFields.Cliente_DtosTarifas.Value ) and
                         not ValueIsEmpty( ArticuloFields.Familia.Value ) and
                         ( CodigoCliente<>'' )
                    then If   DmTarifaVentasTable.FindKey( [ rtvClienteFamilia, CodigoCliente, ArticuloFields.Familia.Value ] )
                         then If   Descuento=0.0
                              then Descuento := DmTarifaVentasFields.Descuento.Value;
                    end;

               end;

          If   not ( ( CodigoCliente='' ) and ( CodigoTarifa='' ) ) and
               ( ( Precio=0.0 ) or SessionDataModule.EmpresaFields.Cliente_DtosTarifas.Value ) and
               SessionDataModule.EmpresaFields.Cliente_TarCodigo.Value
          then begin
               If   ( CodigoTarifa='' ) and Assigned( ClienteFields )
               then CodigoTarifa := ClienteFields.Factura_Tarifa.Value;
               If   CodigoTarifa<>''
               then ObtenPrecioVentaPorTarifa( CodigoArticulo, ArticuloFields.Familia.Value, CodigoTarifa, Cantidad, Precio, Recargo, Descuento );
               end;

          If   Precio=0.0
          then Precio := ArticuloFields.Precio_Venta.Value;
          If   Recargo=0.0
          then Recargo := ArticuloFields.Recargo_Venta.Value;
          If   Descuento=0.0
          then Descuento := ArticuloFields.Dto_Venta.Value;

          If   PrecioOriginal<>Precio
          then AplicaDescuentoPrevio;

          If   FOnObtenPrecioVenta.CanInvoke
          then FOnObtenPrecioVenta.Invoke( TipoMovimiento,
                                           ClienteFields,
                                           ArticuloFields,
                                           CodigoClaseA,
                                           CodigoClaseB,
                                           CodigoClaseC,
                                           Cantidad,
                                           Precio );

          end;

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

    // Utilizo el valor absoluto de la cantidad para que se apliquen las mismas condiciones en los abonos o devoluciones

    If   Cantidad<>0
    then begin

         {  Se supone que si no se permiten salidas por debajo de la cantidad  mínima de la tarifa las
            devoluciones o abonos no deben tener en cuenta la cantidad mínima }

         If   DmTarifaVentasTable.FindKey( [ rtvTarifaArticulo, CodigoTarifa, CodigoArticulo ] )
         then If   ( DmTarifaVentasFields.CantidadMinima.Value=0.0 ) or
                   ( Abs( Cantidad )>=DmTarifaVentasFields.CantidadMinima.Value ) or
                   ( Cantidad<0.0 )
              then begin
                   If   Precio=0.0
                   then Precio := DmTarifaVentasFields.Precio.Value;
                   If   Recargo=0.0
                   then Recargo := DmTarifaVentasFields.Recargo.Value;
                   If   Descuento=0.0
                   then Descuento := DmTarifaVentasFields.Descuento.Value;

                   If   ObtenerCantidadMinima
                   then Cantidad := DmTarifaVentasFields.CantidadMinima.Value;

                   end;

         If   ( Descuento=0.0 ) and
              ( ( Precio=0.0 ) or SessionDataModule.EmpresaFields.Cliente_DtosTarifas.Value ) and
              ( CodigoFamilia<>'' )
         then If   DmTarifaVentasTable.FindKey( [ rtvTarifaFamilia, CodigoTarifa, CodigoFamilia ] )
              then If   ( DmTarifaVentasFields.CantidadMinima.Value=0.0 ) or
                        ( Abs( Cantidad )>=DmTarifaVentasFields.CantidadMinima.Value ) or
                        ( Cantidad<0.0 )
                   then Descuento := DmTarifaVentasFields.Descuento.Value;

         end;

end;

{
 A diferencia de la versión previa este procedimiento no comprueba si el artículo tiene activado el valor 'calcularPrecios'
 que deberá ser comprobado antes de llamar a la función

     If   ArticuloFields.CalcularPrecios
     then ...

}
(*
function TArticuloModule.CalculaPrecioDesgloseVenta( TipoMovimiento  : TTipoMovimiento;
                                                     ClienteFields   : TClienteFields;
                                                     CodigoArticulo  : String;
                                                     CodigoClaseA,
                                                     CodigoClaseB,
                                                     CodigoClaseC    : String;
                                                     Fecha           : TDateTime = 0 ) : Decimal;
var ImporteBruto,
    DescuentoArticulo,
    ImporteNeto : Decimal;
    PrecioVenta : Double;
    PuntoVerde,
    RecargoVenta,
    DescuentoVenta : Decimal;
    EsUnaOferta : Boolean;

begin
     With DmListaMaterialesTable do
       try
         Result := 0.0;
         SetRange( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 1 ],
                   [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, MaxSmallInt ] );
         First;
         While not Eof do
           begin

           With DmListaMaterialesFields do
             begin
             PrecioVenta := 0.0;
             PuntoVerde := 0.0;
             RecargoVenta := 0.0;
             DescuentoVenta := 0.0;
             EsUnaOferta := False;

             ObtenPrecioyDtoVenta( TipoMovimiento, ClienteFields, CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, Cantidad.Value, PrecioVenta, PuntoVerde, RecargoVenta, DescuentoVenta, EsUnaOferta, Fecha, True );

             SessionDataModule.Dm30.FacturaVentasModule.CalculaImportes( Cantidad.Value,
                                                                         DmArticuloFields.UnidadesPrecioVenta.Value,
                                                                         PrecioVenta,
                                                                         PuntoVerde,
                                                                         RecargoVenta,
                                                                         DescuentoVenta,
                                                                         ImporteBruto,
                                                                         DescuentoArticulo,
                                                                         ImporteNeto );

             DecAdd( Result, ImporteNeto );
             end;

           Next;
           end;
       finally
         CancelRange
         end;
end;

function TArticuloModule.CalculaPrecioDesgloseCompra( ProveedorFields : TProveedorFields;
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
                   [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, MaxSmallInt ] );
         First;
         While not Eof do
           begin

           With DmListaMaterialesFields do
             begin
             ObtenPrecioyDtoCompra( ProveedorFields, CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, Cantidad.Value, PrecioCompra, PuntoVerdeCompra, DescuentoCompra, True );
             FacturaCompras.CalculaImportes( Cantidad.Value,
                                             DmArticuloFields.UnidadesPrecioCompra.Value,  // Obtenido en ObtenPrecioyDtoCompra
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
*)

procedure TArticuloModule.AltaDatosEconomicos( UnEjercicio          : SmallInt;
                                               UnCodigoArticulo     : String;
                                               UnCodigoClaseA,
                                               UnCodigoClaseB,
                                               UnCodigoClaseC       : String;
                                               UnCodigoAlmacen      : String;
                                               ArticuloDatEconTable : TnxeTable = nil );
begin
     With DmArticuloDatEconTable do
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

function TArticuloModule.Identificador : TGuid;
begin
     CreateGUID( Result );
end;

{ TArticuloService }

procedure TArticuloService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TArticuloService.ObtenPrecioyDtoCompra(      CodigoProveedor,
                                                       CodigoArticulo,
                                                       CodigoClaseA,
                                                       CodigoClaseB,
                                                       CodigoClaseC   : String;
                                                       Cantidad       : Decimal;
                                                   var Precio         : Double;
                                                   var PuntoVerde,
                                                       Descuento      : Decimal;
                                                       Inicializar    : Boolean = False;
                                                       Fecha          : TDateTime = 0 );
begin
     SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( CodigoProveedor,
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

procedure TArticuloService.ObtenPrecioyDtoVenta(     TipoMovimiento  : TTipoMovimiento;
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
     SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( TipoMovimiento,
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

procedure TArticuloService.ObtenPrecioVentaPorTarifa(     CodigoArticulo,
                                                          CodigoFamilia,
                                                          CodigoTarifa          : String;
                                                      var Cantidad              : Decimal;
                                                      var Precio                : Double;
                                                      var Recargo               : Decimal;
                                                      var Descuento             : Decimal;
                                                          ObtenerCantidadMinima : Boolean = False );
begin
     SessionDataModule.Dm30.ArticuloModule.ObtenPrecioVentaPorTarifa( CodigoArticulo,
                                                                      CodigoFamilia,
                                                                      CodigoTarifa,
                                                                      Cantidad,
                                                                      Precio,
                                                                      Recargo,
                                                                      Descuento,
                                                                      ObtenerCantidadMinima );
end;

// WebService

class function TArticuloModule.ObtenListaArticulosWs( SessionDataModule : TBaseSessionDataModule;
                                                      DataIn,
                                                      DataOut           : IsgcJSON ) : Boolean;
begin
     If   Assigned( SessionDataModule )
     then Result := TSessionDataModule( SessionDataModule ).Dm30.ArticuloModule.ObtenListaArticulos( DataIn, DataOut )
     else Result := False;
end;

function TArticuloModule.ObtenListaArticulos( DataIn,
                                              DataOut     : IsgcJSON ) : Boolean;

var  PageSize,
     Page : Integer;
     CodigoInicial,
     // CodigoFinal,
     Direccion,
     SearchText : String;
     CategoriasArray : IsgcJSON;
     ArticulosConExistencias : Boolean;
     ListaCategorias,
     OrdenacionArticulos : String;

     SelectCommand,
     FilterCommand,
     OrderCommand : String;
     Query : TnxQuery;

     FieldCodigo  : TField;

     CodigoCliente,
     CodigoTarifa : String;

     PrecioVenta : Double;
     Existencias,
     PuntoVerde,
     Recargo,
     Descuento : Decimal;
     EsUnaOferta  : Boolean;

procedure AddFilterCommand( Command : String );
begin
     If   FilterCommand<>''
     then StrAdd( FilterCommand, ' AND ' );
     StrAdd( FilterCommand, Command );
end;

procedure DesgloseClase( ProductoObject : TsgcJSON;
                         NroClase       : SmallInt );
begin

     If   SessionDataModule.EmpresaFields.Articulo_ExisteClase[ NroClase ].Value
     then With DmClaseTable do
            try

              var ClaseArrayIndex := 0;
              var ClasesAArray := TsgcJSON.Create( nil );
              ClasesAArray.IsArray := True;

              // NroClase;NroOrden
              SetRange( [ NroClase, 0 ], [ NroClase, MaxSmallInt ] );
              First;
              While not Eof do
                begin

                If   DmClasesArticuloTable.FindKey( [ FieldCodigo.Value, NroClase, DmClaseFields.Codigo.Value ] )  // CodigoArticulo;NroClase;CodigoClase
                then begin

                     var ClaseObject := TsgcJSON.Create( nil );

                     ClaseObject.AddPair( 'codigo', DmClasesArticuloFields.CodigoClase.Value );
                     ClaseObject.AddPair( 'descripcion', SessionDataModule.Dm30.ClaseModule.Descripcion( NroClase, DmClasesArticuloFields.CodigoClase.Value ) );
                     // ClaseObject.AddPair( 'cantidad', 1 );

                     Existencias := 0.0;
                     PrecioVenta := 0.0;

                     If   NroClase=tcClaseA  // De momento solo precios y existencias de la primera clase. Si se hiciera también de la segunda habría que incluir las combinaciones.
                     then begin

                          SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( tmVenta,
                                                                                      SessionDataModule.ClienteTiendaFields,
                                                                                      DmArticuloFields,
                                                                                      DmClasesArticuloFields.CodigoClase.Value,
                                                                                      '',
                                                                                      '',
                                                                                      { Cantidad } 1.0,
                                                                                      PrecioVenta,
                                                                                      PuntoVerde,
                                                                                      Recargo,
                                                                                      Descuento,
                                                                                      EsUnaOferta,
                                                                                      CodigoTarifa,
                                                                                      { Inicializar } True );

                          Existencias := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( DmClasesArticuloFields.CodigoArticulo.Value,
                                                                                               { TodasLasClases } False,
                                                                                               DmClasesArticuloFields.CodigoClase.Value,
                                                                                               '',
                                                                                               '',
                                                                                               { TodosLosLotes } True,
                                                                                               '',
                                                                                               { TodosLosAlmacenes } True,
                                                                                               '',
                                                                                               { TodasLasUbicaciones } True,
                                                                                               '',
                                                                                               { ObtenCoste } False,
                                                                                               SessionDataModule.Ejercicio,
                                                                                               0,
                                                                                               12 ).SumaExistencias.Saldo;
                          If   Existencias<0.0
                          then Existencias := 0.0;
                          end;

                     ClaseObject.AddPair( 'existencias', Existencias );
                     ClaseObject.AddPair( 'precio', PrecioVenta );

                     ClasesAArray.AddObject( IntToStr( ClaseArrayIndex ) ).JSONObject := ClaseObject;

                     Inc( ClaseArrayIndex );
                     end;

                Next;

                end;

              ProductoObject.AddObject( 'clase' + AnsiChar( 64 + Ord( NroClase ) ) ).JSONObject := ClasesAArray;

            finally
              CancelRange;
              end;
end;

procedure SeleccionaRegistros( CodigoInicial, Direccion : String );
begin

      SelectCommand := 'SELECT ';  // TOP ' + IntToStr( PageSize ) + ',' + IntToStr( ( PageSize * Page ) + 1 )

      var FieldList := ' Articulo.Codigo '; // , Articulo.Descripcion, Articulo.Precio_Venta, Articulo.Tienda_NombreImagen, Articulo.Anotacion ';
      var TableList := ' FROM Articulo ';

      FilterCommand := ' Articulo.codigo ';
      OrderCommand := ' ORDER BY Articulo.codigo ';

      If   Direccion='none'
      then StrAdd( FilterCommand, '>' )
      else If   Direccion='asc'
           then StrAdd( FilterCommand, '>' )
           else If   Direccion='desc'
                then begin
                     StrAdd( FilterCommand, '<' );
                     StrAdd( OrderCommand, ' DESC ' );
                     end;

      StrAdd( FilterCommand, QuotedStr( CodigoInicial ) );

      If   SearchText<>''
      then AddFilterCommand( ' Articulo.Descripcion LIKE ''%' + SearchText + '%'' IGNORE CASE ' );

      If   ListaCategorias<>''
      then begin
           StrAdd( FieldList, ', Categoria.Codigo AS CodigoCategoria ' );
           StrAdd( TableList, ' INNER JOIN CategoriasArticulo ON ( CategoriasArticulo.CodigoArticulo=Articulo.Codigo ) ' +
                              ' INNER JOIN Categoria ON ( Categoria.Codigo=CategoriasArticulo.CodigoCategoria ) ' );
           AddFilterCommand(  ' Categoria.Codigo IN ( ' + ListaCategorias + ' ) ' );
           end;

      If   CodigoTarifa<>''
      then begin
           StrAdd( FieldList, ', TarifaVentas.CodigoArticulo ' );
           StrAdd( TableList, ' INNER JOIN TarifaVentas ON ( Tipo=0 AND TarifaVentas.CodigoTarifa=' + QuotedStr( CodigoTarifa ) + ' AND TarifaVentas.CodigoArticulo=Articulo.Codigo ) ' );
           AddFilterCommand(  ' TarifaVentas.CodigoArticulo IS NOT NULL ' );
           end;

      If   FilterCommand<>''
      then FilterCommand := ' WHERE ' + FilterCommand;

      SelectCommand := SelectCommand + FieldList + TableList + FilterCommand + OrderCommand;

      Query := SectionDataModule.OpenQuery( SelectCommand, { RaiseError } True, { Notify } False );

      try

        var RecordsRead := 0;

        FieldCodigo := Query.FieldByName( 'Codigo' );

        var DataArray : IsgcJSON := TsgcJSON.Create( nil );
        DataArray.IsArray := True;

        var ArticulosList := TStringList.Create;

        ArticulosList.OwnsObjects := True;  // De este modo se eliminan los objetos de la lista al destruirla

        If   Assigned( Query ) and ( Query.RecordCount>0 )
        then begin

             Query.First;

             While not Query.Eof and ( RecordsRead<PageSize ) do
               begin

               var CodigoArticulo := FieldCodigo.AsString;

               If   Obten( CodigoArticulo )
               then begin

                    SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( tmVenta,
                                                                                SessionDataModule.ClienteTiendaFields,
                                                                                DmArticuloFields,
                                                                                '',
                                                                                '',
                                                                                '',
                                                                                { Cantidad } 1.0,
                                                                                PrecioVenta,
                                                                                PuntoVerde,
                                                                                Recargo,
                                                                                Descuento,
                                                                                EsUnaOferta,
                                                                                CodigoTarifa,
                                                                                { Inicializar } True );

                    Existencias := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( FieldCodigo.AsString,
                                                                                         { TodasLasClases } True,
                                                                                         '',
                                                                                         '',
                                                                                         '',
                                                                                         { TodosLosLotes } True,
                                                                                         '',
                                                                                         { TodosLosAlmacenes } True,
                                                                                         '',
                                                                                         { TodasLasUbicaciones } True,
                                                                                         '',
                                                                                         { ObtenCoste } False,
                                                                                         SessionDataModule.Ejercicio,
                                                                                         0,
                                                                                         12 ).SumaExistencias.Saldo;

                    If   Existencias<0.0
                    then Existencias := 0.0;

                    If   not ( SessionDataModule.NoPublicarArticulosSinPrecio and ( PrecioVenta=0.0 ) ) and
                         not ( ArticulosConExistencias and ( Existencias=0.0 ) )
                    then begin

                         var ArticuloPedidosOnline := TArticuloPedidosOnline.Create;

                         ArticuloPedidosOnline.Codigo := CodigoArticulo;
                         ArticuloPedidosOnline.NombreImagen := DmArticuloFields.Tienda_NombreImagen.Value;
                         ArticuloPedidosOnline.Nombre := DmArticuloFields.Descripcion.Value;
                         ArticuloPedidosOnline.Descripcion := SessionDataModule.RTFToPlainText( DmArticuloFields.Anotacion.AsString, { JSONText } True );

                         ArticuloPedidosOnline.PrecioVenta := PrecioVenta;
                         ArticuloPedidosOnline.Existencias := Existencias;

                         ArticulosList.AddObject( CodigoArticulo, ArticuloPedidosOnline );

                         Inc( RecordsRead );
                         end;

                    end;

               Query.Next;
               end;

             ArticulosList.Sort;

             { Si se está recorriendo la lista hacia atrás y no se completa el tamaño de la página es porque se
               ha llegado al principio. Habrá que intentar rellenar la página.
               De igual modo, si se intenta ir hacia adelante y no hay más registros (en la última página) se
               vuelve sin más.
             }

             If   ( Direccion='desc' ) and ( RecordsRead>0 ) and ( RecordsRead<PageSize )
             then begin
                  SeleccionaRegistros( ArticulosList.Names[ 0 ], 'asc' );
                  Exit;
                  end
             else If   ( Direccion='asc' ) and ( RecordsRead=0 )
                  then Exit;

             var ArrayIndex := 0;

             For var Index := 0 to ArticulosList.Count - 1 do
               begin

               var ArticuloPedidosOnline := ArticulosList.Objects[ Index ] as TArticuloPedidosOnline;

               var ProductoObject := TsgcJSON.Create( nil );

               ProductoObject.AddPair( 'codigo', ArticuloPedidosOnline.Codigo );
               ProductoObject.AddPair( 'imagen', ArticuloPedidosOnline.NombreImagen );
               ProductoObject.AddPair( 'nombre', ArticuloPedidosOnline.Nombre );
               ProductoObject.AddPair( 'descripcion', ArticuloPedidosOnline.Descripcion );
               // ProductoObject.AddPair( 'cantidad', 1 );
               ProductoObject.AddPair( 'precio', ArticuloPedidosOnline.PrecioVenta );
               ProductoObject.AddPair( 'existencias', ArticuloPedidosOnline.Existencias );

               If   SessionDataModule.EmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value
               then begin
                    DesgloseClase( ProductoObject, tcClaseA );
                    If   SessionDataModule.EmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value
                    then DesgloseClase( ProductoObject, tcClaseB );
                    end;

               If   SessionDataModule.EmpresaFields.Articulo_CamposLibres.Value
               then With DmArticuloFields do
                      begin

                      var CamposLibresArray := TsgcJSON.Create( nil );
                      CamposLibresArray.IsArray := True;

                      var FieldsArray := [ CampoLibre1,  CampoLibre2,  CampoLibre3,  CampoLibre4 , CampoLibre5,
                                           CampoLibre6,  CampoLibre7,  CampoLibre8,  CampoLibre9,  CampoLibre10,
                                           CampoLibre11, CampoLibre12, CampoLibre13, CampoLibre14, CampoLibre15 ];

                      For var FldIndex := 1 to High( FieldsArray ) do
                        If   SessionDataModule.EmpresaFields.Articulo_CampoLibre[ FldIndex ].Value<>''
                        then begin
                             var Value := TField( FieldsArray[ FldIndex - 1 ] ).AsString;
                             {
                             If   Value<>''
                             then begin
                             }
                                  var CampoLibreObject := TsgcJSON.Create( nil );
                                  CampoLibreObject.AddPair( 'nombre', SessionDataModule.EmpresaFields.Articulo_CampoLibre[ FldIndex ].Value );
                                  CampoLibreObject.AddPair( 'valor', Value );
                                  CamposLibresArray.AddObject( IntToStr( FldIndex ) ).JSONObject := CampoLibreObject;
                             {
                                  end;
                             }
                             end;

                      ProductoObject.AddObject( 'campoLibre' ).JSONObject := CamposLibresArray;
                      end;

               DataArray.AddObject( IntToStr( ArrayIndex ) ).JSONObject := ProductoObject;

               Inc( ArrayIndex );

               end;

             Result := True;
             end;

        DataOut.AddObject( 'loadout' ).JSONObject := DataArray;

        DataOut.AddPair( 'recordsRead', RecordsRead );



      finally
        Query.Close;
        end;
end;

begin

     {
       categorias    : [ 'AA', 'BB' ... ]    // Vacío = todas
     }

     Result := False;

     try

       var ParametersData := GetNodeObject( DataIn, 'parameters' );
       If   Assigned( ParametersData )
       then begin

            PageSize := StrToIntDef( ParametersData.Node[ 'pageSize' ].Value, 20 );
            Page := StrToIntDef( ParametersData.Node[ 'page' ].Value, 0 );
            CodigoInicial := ParametersData.Node[ 'articuloInicial' ].Value;
            // CodigoFinal := ParametersData.Node[ 'articuloFinal' ].Value;
            Direccion := ParametersData.Node[ 'direccion' ].Value;
            SearchText := ParametersData.Node[ 'textoBusqueda' ].Value;
            CategoriasArray := GetNodeObject( ParametersData, 'categorias' );
            ArticulosConExistencias := StrToBoolDef( ParametersData.Node[ 'articuloConExistencias' ].Value, False );
            OrdenacionArticulos := ParametersData.Node[ 'ordenacionArticulos' ].Value; // Nombre y Precio

            If   Assigned( CategoriasArray )
            then begin

                 CodigoCliente := SessionDataModule.ClienteTiendaFields.Codigo.Value;
                 CodigoTarifa := SessionDataModule.ClienteTiendaFields.Factura_Tarifa.Value;

                 ListaCategorias := GetListFromJSONArray( CategoriasArray );  // Es un array de códigos

                 SeleccionaRegistros( CodigoInicial, Direccion );
                 end;

            end;

     except
       end;

end;

procedure InitializeWebServices;
begin
     ServerContainerModule.AddWebServiceFunction( 'Articulo.ObtenLista', TArticuloModule.ObtenListaArticulosWs );
end;


var ArticuloControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_ArticuloService, TArticuloService, ArticuloControl );

   AddProcedure( imStartup, 0, InitializeWebServices );

end.

