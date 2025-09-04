
unit CapturadorServiceUnit;

{$I kbmMW.inc}

interface

uses
  SysUtils,
{$ifdef LEVEL6}
  Variants,
{$else}
  VCL.Forms,
{$endif}
  Classes,
  TypInfo,
  Rtti,
  kbmMWSecurity,
  kbmMWServer,
  kbmMWServiceUtils,
  kbmMWGlobal,
  kbmMemTable,
  kbmMWStreamFormat,
  kbmMWBinaryStreamFormat,
  Data.DB,
  kbmMWCustomConnectionPool,
  kbmMWCustomDataset,
  kbmMWNexusDB,
  kbmMWQueryService,
  kbmMWJSONStreamFormat,
  kbmMWJSON;

type
  TCapturadorService = class(TkbmMWQueryService)
    procedure kbmMWQueryServiceCreate(Sender: TObject);
    procedure kbmMWQueryServiceDestroy(Sender: TObject);
  private

    JSONStreamer :TkbmMWJSONStreamer;

    ClientID,
    CodigoEmpresa,
    NroCapturador  : String;
    
    procedure ExtractArgs( const Args: array of Variant );

  protected

    function ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant; override;

    function CierraSesion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

    function ObtenSeriesFacturacion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenAlmacenes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenUbicaciones(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenArticulos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenCodigoBarras(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenClases(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenClientes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function ObtenProveedores(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
    function EnviaMovimientos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

  public
     { Public declarations }
     class function GetPrefServiceName:string; override;
     class function GetFlags:TkbmMWServiceFlags; override;
     class function GetVersion:string; override;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses kbmMWObject,
     kbmMWExceptions,
     kbmMWObjectNotation,

     nxDB,

     DateUtils,
     LibUtils,

     AppManager,
     DataManager,
     MainData,
     EnterpriseData,
     BaseSessionData,
     SessionData,
     ServerContainer,

     Gsm30Dm,

     Gim10Fields,
     Gim30Fields,

     dmi_mov,
     dmi_sto,

     dm_mov,
     dm_sto;

{$R *.dfm}


const  ServiceName = 'Capturador';
       NullString = #0;

// Service definitions.
//---------------------

class function TCapturadorService.GetPrefServiceName:string;
begin
     Result := ServiceName;
end;

class function TCapturadorService.GetFlags:TkbmMWServiceFlags;
begin
     Result:=[mwsfListed];
end;

class function TCapturadorService.GetVersion:string;
begin
     Result:='1.0';
end;

procedure TCapturadorService.kbmMWQueryServiceCreate(Sender: TObject);
begin
     BoundTransport := ServerContainerModule.ServerTransport;
     TransportStreamFormat := ServerContainerModule.JSONStreamFormat;

     JSONStreamer := TkbmMWJSONStreamer.Create;
end;

procedure TCapturadorService.kbmMWQueryServiceDestroy(Sender: TObject);
begin
     JSONStreamer.Free;
end;

function TCapturadorService.ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
var
   AFunc:string;
begin
     AFunc:=UpperCase(Func);
     if AFunc='OBTENSERIESFACTURACION' then
        Result:=ObtenSeriesFacturacion(ClientIdent,Args)
	    else if AFunc='OBTENALMACENES' then
        Result:=ObtenAlmacenes(ClientIdent,Args)
     else if AFunc='OBTENUBICACIONES' then
        Result:=ObtenUbicaciones(ClientIdent,Args)
     else if AFunc='OBTENARTICULOS' then
        Result:=ObtenArticulos(ClientIdent,Args)
     else if AFunc='OBTENCODIGOBARRAS' then
        Result:=ObtenCodigoBarras(ClientIdent,Args)
     else if AFunc='OBTENCLASES' then
        Result:=ObtenClases(ClientIdent,Args)
     else if AFunc='OBTENCLIENTES' then
        Result:=ObtenClientes(ClientIdent,Args)
     else if AFunc='OBTENPROVEEDORES' then
        Result:=ObtenProveedores(ClientIdent,Args)
     else if AFunc='ENVIAMOVIMIENTOS' then
        Result:=EnviaMovimientos(ClientIdent,Args)
     else if AFunc='CIERRASESION' then
        Result:=CierraSesion(ClientIdent,Args)
     else
        Result:=inherited ProcessRequest(Func,ClientIdent,Args);
end;

procedure TCapturadorService.ExtractArgs( const Args  : array of Variant );
begin
     ClientID := Args[ 0 ];
     CodigoEmpresa := Args[ 1 ];
     NroCapturador := Args[ 2 ];
end;

function TCapturadorService.CierraSesion(        ClientIdent : TkbmMWClientIdentity;
                                           const Args        : array of Variant ) : Variant;

var   SessionDataModule : TSessionDataModule;

begin
     ExtractArgs( Args );
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, '', CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then SessionDataModule.Free;
     Result := VarNull;
end;

function TCapturadorService.EnviaMovimientos(       ClientIdent : TkbmMWClientIdentity;
                                              const Args        : array of Variant ) : Variant;


var SessionDataModule : TSessionDataModule;
    IdMovimientoActual,
    IdMovimientoASaltar : LongInt;
    I : SmallInt;
    NroLineaActual : SmallInt;
    CantidadLinea,
    Existencias,
    CosteMedioLinea : Decimal;
    ExistenciasArticulo : IExistenciasArticulo;
    Datos : String;
    JSONObjectData : TkbmMWONCustomObject;
    JSONObject : TkbmMWJSONObject;
    JSONArray : TkbmMWJSONArray;
   LineaMovimientoFieldValuesArray : TFieldValuesArray;

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields,
    LineaMovimientoAuxFields : TLineaMovimientoFields;

    ClienteFields : TClienteFields;
    ProveedorFields : TProveedorFields;
    ArticuloFields : TArticuloFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    TiposIVAFields : TTiposIVAFields;

    ActualizaDocumento : Boolean;

    // Registro

    IdRegistro,
    TipoMovimiento : Integer;
    FechaMovimiento,
    FechaCaducidad : TDate;
    UUID,
    CodigoPropietario,
    Serie,
    SerieFacturacion : String;
    NroDocumento : Integer;
    CodigoArticulo,
    ClaseA,
    ClaseB,
    ClaseC,
    NumeroSerie,
    Lote,
    CodigoAlmacenOrigen,
    CodigoAlmacenDestino,
    CodigoUbicacionOrigen,
    CodigoUbicacionDestino : String;
    Cajas : Boolean;
    NroBultos,
    Cantidad : Decimal;
    Anotacion : String;

    //

    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC : String;
    FijarClases : Boolean;

procedure CompletaVinculosCliente;
begin
     With SessionDataModule, Dm30, EmpresaFields do
       begin

       If   Cliente_GruposFac.Value
       then MovimientoFields.GrupoFacturacion.Value := ClienteFields.Factura_Agrupacion.Value;

       If   Ventas_PagosPedido.Value
       then MovimientoFields.CodigoFormaCobro.Value := ClienteFields.Cobro_FormaCobro.Value;

       MovimientoFields.CodigoVendedor.Value := VendedorModule.VendedorPorDefecto( ClienteFields );

       {
       If   Ventas_Transportista.Value
       then TransportistaCtrl.PostEditValue( ClienteFields.Envios_Transportista.Value );

       If   Ventas_FormaEnvio.Value
       then FormaEnvioCtrl.PostEditValue( ClienteFields.Envios_CodigoFormaEnvio.Value );
       }

       end;
end;

function ExisteRegistroArticulo( Ejercicio : SmallInt;
                                 NroOperacion : LongInt;
                                 CodigoArticulo,
                                 CodigoClaseA,
                                 CodigoClaseB,
                                 CodigoClaseC : String ) : Boolean;
begin
     Result := False;
     try
       var Query := SessionDataModule.EnterpriseDataModule.OpenQuery( 'SELECT TOP 1 NroRegistro FROM LineaMovimiento ' +
                                                                      'WHERE Ejercicio=' + IntToStr( Ejercicio ) + ' AND ' +
                                                                      '      NroOperacion=' + IntToStr( NroOperacion ) +' AND ' +
                                                                      '      CodigoArticulo=' + QuotedStr( CodigoArticulo ) + ' AND ' +
                                                                      '      CodigoClaseA=' + QuotedStr( CodigoClaseA ) + ' AND ' +
                                                                      '      CodigoClaseB=' + QuotedStr( CodigoClaseB ) + ' AND ' +
                                                                      '      CodigoClaseC=' + QuotedStr( CodigoClaseC ) );
       Result := Query.RecordCount>0;
     finally
       Query.Free;
       end;

end;

begin
     Result := False;
     ExtractArgs( Args );
     Datos := Args[ 3 ];
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule, Dm30 do
            begin

            ClienteFields := TClienteFields.Create( nil );
            ProveedorFields := TProveedorFields.Create( nil );
            ArticuloFields := TArticuloFields.Create( nil );
            SerieFacturacionFields := TSerieFacturacionFields.Create( nil );
            TiposIVAFields := TTiposIVAFields.Create( nil );

            MovimientoFields := TMovimientoFields.Create( MovimientoModule.DmMovimientoTable );
            LineaMovimientoFields := TLineaMovimientoFields.Create( MovimientoModule.DmLineaMovimientoTable );
            LineaMovimientoAuxFields := TLineaMovimientoFields.Create( MovimientoModule.DmLineaMovimientoAuxTable );

            MovimientoModule.DmLineaMovimientoAuxTable.IndexFieldNames := 'CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';

            try

              var TransactionTag := SessionDataModule.StartTransactionWith( [ MovimientoModule.DmMovimientoTable,
                                                                              MovimientoModule.DmLineaMovimientoTable ] );

              try

                JSONObjectData := TkbmMWJSONObject( JSONStreamer.LoadFromUTF8String( TkbmMWPlatformMarshal.UTF8Encode( Datos ) ) );
                If   JSONObjectData is TkbmMWJSONArray
                then begin

                     JSONArray := JSONObjectData as TkbmMWJSONArray;

                     IdMovimientoActual := -1;
                     IdMovimientoASaltar := -1;

                     For I := 0 to JSONArray.Count - 1 do
                       begin

                       JSONObject := JSONArray.AsObject[ I ] as TkbmMWJSONObject;

                       // Los campos que se comprueba que existen es porque no existían en la versión anterior a la 11.0.12

                       IdRegistro := JSONObject.AsInteger[ 'Id' ];
                       UUID := '{' + JSONObject.AsString[ 'UUID' ] + '}';
                       TipoMovimiento := JSONObject.AsInteger[ 'TipoMovimiento' ];
                       FechaMovimiento := LibUtils.StrToDate( JSONObject.AsString[ 'Fecha' ] );
                       CodigoPropietario := JSONObject.AsString[ 'CodigoPropietario' ];
                       Serie := JSONObject.AsString[ 'Serie' ];
                       SerieFacturacion := JSONObject.AsString[ 'SerieFacturacion' ];
                       NroDocumento := JSONObject.AsInteger[ 'NroDocumento' ];
                       CodigoArticulo := JSONObject.AsString[ 'CodigoArticulo' ];

                       If   JSONObject.PropertyExists( 'ClaseA' )
                       then ClaseA := JSONObject.AsString[ 'ClaseA' ]
                       else ClaseA := '';

                       If   JSONObject.PropertyExists( 'ClaseB' )
                       then ClaseB := JSONObject.AsString[ 'ClaseB' ]
                       else ClaseB := '';

                       If   JSONObject.PropertyExists( 'ClaseC' )
                       then ClaseC := JSONObject.AsString[ 'ClaseC' ]
                       else ClaseC := '';

                       If   JSONObject.PropertyExists( 'FechaCaducidad' )
                       then FechaCaducidad := LibUtils.StrToDate( JSONObject.AsString[ 'FechaCaducidad' ] )
                       else FechaCaducidad := 0;

                       Lote := JSONObject.AsString[ 'Lote' ];
                       NumeroSerie := JSONObject.AsString[ 'NumeroSerie' ];
                       CodigoAlmacenOrigen := JSONObject.AsString[ 'CodigoAlmacenOrigen' ];
                       CodigoAlmacenDestino := JSONObject.AsString[ 'CodigoAlmacenDestino' ];

                       // Los códigos de almacen y ubicación destino son obligatorios cuando el tipo de operacion es una reubicación (el único caso en los que se usan),
                       // por lo que no se contempla que puedan ser nulos.

                       If   JSONObject.PropertyExists( 'CodigoUbicacionOrigen' )
                       then CodigoUbicacionOrigen := JSONObject.AsString[ 'CodigoUbicacionOrigen' ]
                       else CodigoUbicacionOrigen := NullString;

                       If   JSONObject.PropertyExists( 'CodigoUbicacionDestino' )
                       then CodigoUbicacionDestino := JSONObject.AsString[ 'CodigoUbicacionDestino' ]
                       else CodigoUbicacionDestino := '';

                       Cajas := JSONObject.AsBoolean[ 'Cajas' ];
                       NroBultos := JSONObject.AsDouble[ 'Bultos' ];
                       Cantidad := JSONObject.AsDouble[ 'Cantidad' ];
                       Anotacion := JSONObject.AsString[ 'Anotacion' ];

                       If   IdMovimientoASaltar<>idRegistro
                       then begin

                            IdMovimientoASaltar := -1;

                            If   Ejercicio<>YearOf( FechaMovimiento )
                            then Continue;

                            // Se espera el código del artículo, pero si no se encuentra se comprueba si es un código de barras

                            If   not ArticuloModule.Obten( CodigoArticulo, ArticuloFields )
                            then ArticuloModule.CodigoBarras( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, FijarClases, ArticuloFields );

                            If   CodigoAlmacenOrigen=NullString
                            then CodigoAlmacenOrigen := ArticuloFields.CodigoAlmacen.Value;

                            If   CodigoUbicacionOrigen=NullString
                            then CodigoUbicacionOrigen := SessionDataModule.Dm30.AlmacenModule.UbicacionPorDefecto( CodigoAlmacenOrigen, ArticuloFields ); // ArticuloFields.Ubicacion.Value;

                            If   IdMovimientoActual<>IdRegistro // Un nuevo movimiento
                            then begin

                                 IdMovimientoActual := IdRegistro;
                                 ActualizaDocumento := False;

                                // Puede que el usuario no tenga activada la conservación de documentos en el capturador y que introduzca un albarán de compra
                                // del mismo proveedor y con el mismo número con la intención de actualizar el que ya había enviado

                                If   TipoMovimiento=0
                                then If   MovimientoModule.Obten( tmCompra, Ejercicio, CodigoPropietario, Serie, NroDocumento, MovimientoFields )
                                     then If   MovimientoFields.Facturado.Value
                                          then begin
                                               IdMovimientoASaltar := IdRegistro;
                                               Continue;
                                               end
                                          else begin
                                               MovimientoModule.SuprimeMovimiento( MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, True );
                                               ActualizaDocumento := True;
                                               end;

                                If   not ActualizaDocumento and MovimientoModule.ObtenPorUUID( UUID, MovimientoFields )  // El movimiento ya existe
                                then begin

                                     If   ( ( TipoMovimiento in [ 0, 1 ] ) and not MovimientoFields.Facturado.Value ) or  // Compras y ventas
                                          ( ( TipoMovimiento in [ 2, 3, 4 ] ) )                                           // Regularizacion, inventario y reubicación
                                     then begin
                                          MovimientoModule.SuprimeMovimiento( MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, True );
                                          ActualizaDocumento := True;
                                          end;

                                     If   not ActualizaDocumento
                                     then begin
                                          IdMovimientoASaltar := IdRegistro;
                                          Continue;
                                          end;
                                     end;

                                 If   ActualizaDocumento
                                 then MovimientoModule.DmMovimientoTable.Edit
                                 else begin
                                      MovimientoModule.DmMovimientoTable.Append;
                                      MovimientoFields.Ejercicio.Value := Ejercicio;
                                      MovimientoFields.NroOperacion.Value := MovimientoModule.ProximaOperacion;
                                      MovimientoFields.UUID.AsString := UUID;
                                      end;

                                 case TipoMovimiento of
                                   0 : begin
                                       MovimientoFields.TipoMovimiento.Value := tmCompra;
                                       Dm10.ProveedorModule.Obten( CodigoPropietario, ProveedorFields );
                                       MovimientoFields.Serie.Value := Serie;
                                       MovimientoFields.NroDocumento.Value := NroDocumento;
                                       end;
                                   1 : begin
                                       MovimientoFields.TipoMovimiento.Value := tmVenta;
                                       Dm10.ClienteModule.Obten( CodigoPropietario, ClienteFields );
                                       MovimientoFields.Serie.Value := SerieFacturacion;
                                       Dm10.SerieFacturacionModule.Obten( SerieFacturacion, SerieFacturacionFields );
                                       MovimientoFields.NroDocumento.Value := MovimientoModule.ProximoDocumento( MovimientoFields );
                                       CompletaVinculosCliente;
                                       end;
                                   2 : begin
                                       MovimientoFields.TipoMovimiento.Value := tmRegularizacion;
                                       MovimientoFields.DescripcionMovimiento.Value := 'Regularización capturador';
                                       end;
                                   3 : begin
                                       MovimientoFields.TipoMovimiento.Value := tmInventario;
                                       MovimientoFields.DescripcionMovimiento.Value := 'Inventario capturador';
                                       end;
                                   4 : begin
                                       MovimientoFields.TipoMovimiento.Value := tmReubicacionCarga;
                                       MovimientoFields.DescripcionMovimiento.Value := 'Reubicación';
                                       end;
                                   end;

                                 MovimientoFields.Fecha.Value := FechaMovimiento;
                                 MovimientoFields.Propietario.Value := CodigoPropietario;
                                 MovimientoFields.Origen.Value := omCapturador;

                                 MovimientoModule.DmMovimientoTable.Post;

                                 MovimientoModule.RetiraDocumento( MovimientoFields, False );

                                 MovimientoModule.CompruebaPrimerNroPagina( MovimientoFields );

                                 NroLineaActual := 1;
                                 end;

                            CosteMedioLinea := 0.0;
                            ExistenciasArticulo := nil;

                            If   MovimientoFields.TipoMovimiento.Value in [ tmRegularizacion,  tmInventario, tmReubicacionCarga ]
                            then begin

                                 ExistenciasArticulo := StockAlmacenModule.ObtenStock( CodigoArticulo,
                                                                                       ClaseA='', ClaseA, ClaseB, ClaseC,
                                                                                       Lote='', Lote,
                                                                                       False, CodigoAlmacenOrigen,
                                                                                       CodigoUbicacionOrigen='', CodigoUbicacionOrigen,
                                                                                       True,
                                                                                       Ejercicio,
                                                                                       0,
                                                                                       12 );

                                 If   Assigned( ExistenciasArticulo ) and ( ExistenciasArticulo.SumaExistencias.Saldo<>0.0 )
                                 then begin
                                      Existencias := ExistenciasArticulo.SumaExistencias.Saldo;
                                      CosteMedioLinea := ExistenciasArticulo.CosteMedio;  // Lo guardo para la línea de entrada
                                      end;

                                 end;

                            If   MovimientoFields.TipoMovimiento.Value=tmRegularizacion
                            then begin

                                 // Hay que generar un movimiento de salida de todas las existencias actuales

                                 // Primero compruebo que no se haya introducido previamente una línea con el mismo código de artículo

                                 If   not ExisteRegistroArticulo( MovimientoFields.Ejercicio.Value,
                                                                  MovimientoFields.NroOperacion.Value,
                                                                  CodigoArticulo,
                                                                  ClaseA,
                                                                  ClaseB,
                                                                  ClaseC )
                                 then If   Assigned( ExistenciasArticulo ) and ( ExistenciasArticulo.SumaExistencias.Saldo<>0.0 )
                                      then begin

                                           MovimientoModule.DmLineaMovimientoTable.Append;

                                           LineaMovimientoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                                           LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                                           LineaMovimientoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                                           LineaMovimientoFields.NroPagina.Value := 0;
                                           LineaMovimientoFields.NroLinea.Value := NroLineaActual;
                                           LineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;
                                           LineaMovimientoFields.CodigoClaseA.Value := ClaseA;
                                           LineaMovimientoFields.CodigoClaseB.Value := ClaseB;
                                           LineaMovimientoFields.CodigoClaseC.Value := ClaseC;
                                           LineaMovimientoFields.UIDArticulo.AsGuid := ArticuloModule.Identificador;
                                           LineaMovimientoFields.LoteFabricacion.Value := Lote;

                                           If   FechaCaducidad<>0
                                           then LineaMovimientoFields.FechaCaducidad.Value := FechaCaducidad;

                                           LineaMovimientoFields.Descripcion.Value := ArticuloFields.Descripcion.Value;

                                           LineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacenOrigen; // Almacen.AlmacenPorDefecto( scVentas, Articulo.DmArticuloFields );
                                           LineaMovimientoFields.Ubicacion.Value := CodigoUbicacionOrigen;

                                           LineaMovimientoFields.Cantidad.Value := -Existencias;
                                           LineaMovimientoFields.CantidadAjustada.Value := -Existencias;
                                           LineaMovimientoFields.Precio.Value := CosteMedioLinea;

                                           FacturaComprasModule.CalculaImportesIVA( LineaMovimientoFields, nil, ArticuloFields, TiposIVAFields );

                                           StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields );
                                           MovimientoModule.DmLineaMovimientoTable.Post;

                                           Inc( NroLineaActual );
                                           end;

                                 end;

                            MovimientoModule.DmLineaMovimientoTable.Append;

                            LineaMovimientoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                            LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                            LineaMovimientoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                            LineaMovimientoFields.NroPagina.Value := 0;
                            LineaMovimientoFields.NroLinea.Value := NroLineaActual;
                            LineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;
                            LineaMovimientoFields.CodigoClaseA.Value := ClaseA;
                            LineaMovimientoFields.CodigoClaseB.Value := ClaseB;
                            LineaMovimientoFields.CodigoClaseC.Value := ClaseC;
                            LineaMovimientoFields.UIDArticulo.AsGuid := ArticuloModule.Identificador;
                            LineaMovimientoFields.NumeroSerie.Value := NumeroSerie;
                            LineaMovimientoFields.LoteFabricacion.Value := Lote;

                            If   FechaCaducidad<>0
                            then LineaMovimientoFields.FechaCaducidad.Value := FechaCaducidad;

                            LineaMovimientoFields.Descripcion.Value := ArticuloModule.Descripcion( CodigoArticulo );

                            LineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacenOrigen;

                            LineaMovimientoFields.Ubicacion.Value := CodigoUbicacionOrigen; // ArticuloFields.Ubicacion.Value;

                            If   Cajas
                            then begin
                                 LineaMovimientoFields.NroCajas.Value := Cantidad;
                                 CantidadLinea := Cantidad * ArticuloFields.UnidadesPorCaja.Value;
                                 end
                            else CantidadLinea := Cantidad;

                            LineaMovimientoFields.Bultos.Value := NroBultos;

                            If   MovimientoFields.TipoMovimiento.Value in [ tmReubicacionCarga, tmVenta ]
                            then LineaMovimientoFields.Cantidad.Value := -CantidadLinea
                            else LineaMovimientoFields.Cantidad.Value := CantidadLinea;

                            LineaMovimientoFields.CantidadAjustada.Value := CantidadLinea;

                            ArticuloModule.Obten( CodigoArticulo, ArticuloFields );

                            case MovimientoFields.TipoMovimiento.Value of
                              tmRegularizacion,
                              tmInventario,
                              tmReubicacionCarga :
                                begin
                                LineaMovimientoFields.Precio.Value := CosteMedioLinea;
                                FacturaComprasModule.CalculaImportesIVA( LineaMovimientoFields, nil, ArticuloFields, TiposIVAFields );
                                end;
                              tmCompra:
                                begin
                                ArticuloModule.ObtenPrecioyDtoCompra( LineaMovimientoFields, ProveedorFields, ArticuloFields );
                                FacturaComprasModule.CalculaImportesIVA( LineaMovimientoFields, ProveedorFields, ArticuloFields, TiposIVAFields );
                                end;
                              tmVenta:
                                begin
                                ArticuloModule.ObtenPrecioyDtoVenta( MovimientoFields.TipoMovimiento.Value, LineaMovimientoFields, ClienteFields, ArticuloFields );
                                FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, MovimientoFields.IVAIncluido.Value );
                                end;
                              end;

                            If   Anotacion<>''
                            then LineaMovimientoFields.Anotacion.Value := Anotacion;

                            StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields );

                            LineaMovimientoFieldValuesArray := MovimientoModule.DmLineaMovimientoTable.GetFieldValues;

                            MovimientoModule.DmLineaMovimientoTable.Post;

                            Inc( NroLineaActual );

                            If   MovimientoFields.TipoMovimiento.Value=tmReubicacionCarga
                            then begin

                                 // Ahora la entrada en la nueva ubicación

                                 MovimientoModule.DmLineaMovimientoTable.Append;

                                 MovimientoModule.DmLineaMovimientoTable.SetFieldValues( LineaMovimientoFieldValuesArray );

                                 LineaMovimientoFields.NroLinea.Value := NroLineaActual;
                                 LineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacenDestino;
                                 LineaMovimientoFields.Ubicacion.Value := CodigoUbicacionDestino;
                                 LineaMovimientoFields.Cantidad.Value := -LineaMovimientoFields.Cantidad.Value;

                                 FacturaComprasModule.CalculaImportesIVA( LineaMovimientoFields, nil, ArticuloFields, TiposIVAFields );

                                 StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields );

                                 MovimientoModule.DmLineaMovimientoTable.Post;

                                 Inc( NroLineaActual );
                                 end;
                            end;

                       end;

                    TransactionTag.Commit;
                    Result := True;

                    end;

              except
                TransactionTag.Rollback;
                raise;
                end;

            finally

              MovimientoFields.Free;
              LineaMovimientoFields.Free;

              ClienteFields.Free;
              ProveedorFields.Free;
              ArticuloFields.Free;
              SerieFacturacionFields.Free;
              TiposIVAFields.Free;
              end;

            end;

end;

function TCapturadorService.ObtenSeriesFacturacion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      
begin
     ExtractArgs( Args );
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin
          Query := SessionDataModule.EnterpriseQuery;
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT * FROM SerieFacturacion';
          SessionDataModule.EnterpriseQuery.Open;
          Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TCapturadorService.ObtenAlmacenes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      
begin
     ExtractArgs( Args );
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin
          Query := SessionDataModule.EnterpriseQuery;
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT Codigo, Nombre FROM Almacen';
          SessionDataModule.EnterpriseQuery.Open;
          Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TCapturadorService.ObtenUbicaciones(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;

begin
     ExtractArgs( Args );
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin
          Query := SessionDataModule.EnterpriseQuery;
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT CodigoAlmacen, Codigo, Descripcion FROM Ubicacion';
          SessionDataModule.EnterpriseQuery.Open;
          Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TCapturadorService.ObtenArticulos(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      CB : String;
      FijarClases : Boolean;

begin
     ExtractArgs( Args );
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin

          {

          Query := SessionDataModule.EnterpriseQuery;

          var RecordsRange := '';

          If   NroMaximoRegistros<>0
          then begin
               RecordsRange := 'TOP ' + IntToStr( NroMaximoRegistros );
               If   PrimerRegistro<>0
               then RecordsRange := RecordsRange + ',' + IntToStr( PrimerRegistro ) + ' ';
               end;
          }

          {
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT ' + RecordsRange +
                                                        'Articulo.Codigo, ( CASE WHEN CodigoBarras.CodigoBarras IS NULL THEN Articulo.CodigoBarras ELSE CodigoBarras.CodigoBarras END ) AS CodigoBarras, ' +
                                                        'Articulo.Descripcion, ( CASE WHEN Articulo.Precio_Venta IS NULL THEN 0.0 ELSE Articulo.Precio_Venta END ) AS Precio_Venta ' +
                                                        'FROM Articulo LEFT JOIN CodigoBarras ON ( Articulo.Codigo=CodigoBarras.CodigoArticulo ) ' +
                                                        'WHERE ( ( NOT CodigoBarras.CodigoBarras IS NULL AND CodigoBarras.CodigoBarras<>'''' ) OR ( NOT Articulo.CodigoBarras IS NULL AND Articulo.CodigoBarras<>'''') )';
          SessionDataModule.EnterpriseQuery.Open;
            Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );

          }


          With SessionDataModule do
            begin

            DmCapturador.ArticuloTable.Open;

            With Dm30.ArticuloModule do
              try

                // DmCodigoBarrasTable.IndexFieldNames := 'CodigoArticulo';
                DmArticuloTable.CancelRange;
                DmArticuloTable.First;
                While not DmArticuloTable.Eof do
                  begin

                  If   not DmArticuloFields.Obsoleto.Value
                  then begin

                        {
                        If   DmCodigoBarrasTable.FindKey( [ DmArticuloFields.Codigo.Value ] )
                        then CB := DmCodigoBarrasFields.CodigoBarras.Value
                        else CB := DmArticuloFields.CodigoBarras.Value;
                        }

                        DmCapturador.ArticuloTable.Append;

                        DmCapturador.ArticuloTableCodigo.Value := StrToJSONText( DmArticuloFields.Codigo.Value );
                        DmCapturador.ArticuloTableCodigoBarras.Value := StrToJSONText( DmArticuloFields.CodigoBarras.Value );
                        DmCapturador.ArticuloTableDescripcion.Value := StrToJSONText( DmArticuloFields.Descripcion.Value );
                        DmCapturador.ArticuloTablePrecio_Venta.Value := DmArticuloFields.Precio_venta.Value;
                        DmCapturador.ArticuloTableUbicacion.Value := DmArticuloFields.Ubicacion.Value;

                        DmCapturador.ArticuloTable.Post;
                        end;

                  DmArticuloTable.Next;
                  end;

              finally
                // DmCodigoBarrasTable.IndexFieldNames := 'CodigoBarras';
                end;

            Result := ReturnDataset(  DmCapturador.ArticuloTable, True, True, True, '', MaxInt, mwdpsAll );
            end;

          end;
end;

function TCapturadorService.ObtenCodigoBarras(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;

begin
     ExtractArgs( Args );
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin
          Query := SessionDataModule.EnterpriseQuery;
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT CodigoBarras, CodigoArticulo, ClaseA, ClaseB, ClaseC FROM CodigoBarras';
          SessionDataModule.EnterpriseQuery.Open;
          Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TCapturadorService.ObtenClases(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;

begin
     ExtractArgs ( Args );
     Result := VarNull;

     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then With SessionDataModule do
            try

              DmCapturador.ClaseTable.Open;

              With SessionDataModule.Dm30.ClaseModule do
                begin

                DmClaseTable.First;
                While not DmClaseTable.Eof do
                  begin

                  DmCapturador.ClaseTable.Append;

                  DmCapturador.ClaseTableNroClase.Value := DmClaseFields.NroClase.Value;
                  DmCapturador.ClaseTableCodigo.Value := DmClaseFields.Codigo.Value;
                  DmCapturador.ClaseTableDescripcion.Value := DmClaseFields.Descripcion.Value;

                  DmCapturador.ClaseTable.Post;

                  DmClaseTable.Next;
                  end;

                end;

              Result := ReturnDataset( DmCapturador.ClaseTable, True, True, True, '', MaxInt, mwdpsAll );

            finally
              DmCapturador.ClaseTable.Close;
              end;
end;

function TCapturadorService.ObtenClientes(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      CodigoInicial : String;

begin
     ExtractArgs( Args );
     CodigoInicial:= Args[ 2 ];
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin
          Query := SessionDataModule.EnterpriseQuery;
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT Codigo, Nombre FROM Cliente';
          SessionDataModule.EnterpriseQuery.Open;
          Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

function TCapturadorService.ObtenProveedores(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var   SessionDataModule : TSessionDataModule;
      CodigoInicial : String;
      
begin
     ExtractArgs( Args );
     CodigoInicial:= Args[ 2 ];
     Result := VarNull;
     SessionDataModule := GetSessionDataModuleExt( ctRPC, ClientID, ServiceName, NroCapturador, CodigoEmpresa );
     If   Assigned( SessionDataModule )
     then begin
          Query := SessionDataModule.EnterpriseQuery;
          SessionDataModule.EnterpriseQuery.SQL.Text := 'SELECT Codigo, Nombre FROM Proveedor';
          SessionDataModule.EnterpriseQuery.Open;
          Result := ReturnDataset( SessionDataModule.EnterpriseQuery, True, True, True, '', MaxInt, mwdpsAll );
          end;
end;

end.


