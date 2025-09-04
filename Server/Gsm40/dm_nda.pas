
unit dm_nda;

interface

uses
  Windows, Messages, SysUtils, Classes,

  nxllTransport,
  nxptBasePooledTransport,
  nxllSimpleSession,
  nxllComponent,
  nxllPluginBase,
  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginClient,

  DataManager,
  ServerDataModule,
  SessionIntf,

  DB,
  nxdb,
  nxsdTypes,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim40Fields,

  dmi_nda;

type

  TAprovisionamientoService = class( TSessionModule, IAprovisionamientoService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    function SeleccionaArticulosBajoMinimos( TipoSeleccion : TTipoSeleccionBajoMinimos; CodigoAlmacenOrigen, CodigoAlmacenDestino : String; ExistenciasVirtuales : Boolean = False; CodigoProveedor : String = ''; TodosLosAlmacenes  : Boolean = False ) : String;
    procedure GeneraPedidosCompra( Serie : String; Fecha : TDate; NombreTabla : String );
    procedure GeneraTraspasoAlmacen( Fecha : TDate; NombreTabla : String );
  end;

  TAprovisionamientoModule = class(TServerDataModule)
    DmExistenciasArticuloTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmGrupoLineaMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    DmExistenciasArticuloFields : TExistenciasArticuloFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;

    DsProveedorFields : TProveedorFields;
    DsArticuloFields : TArticuloFields;
    DsTiposIVAFields : TTiposIVAFields;

  public
     function SeleccionaArticulosBajoMinimos( TipoSeleccion            : TTipoSeleccionBajoMinimos;
                                              CodigoAlmacenOrigen,
                                              CodigoAlmacenDestino     : String;
                                              ExistenciasVirtuales     : Boolean = False;
                                              CodigoProveedor          : String = '';
                                              TodosLosAlmacenes        : Boolean = False ) : String;

     procedure GeneraPedidosCompra( Serie : String; Fecha : TDate; NombreTabla : String );
     procedure GeneraTraspasoAlmacen( Fecha : TDate; NombreTabla : String );

  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   Variants,
       Math,

       nxrdClass,
       nxrbTypes,

       LibUtils,

       dmi_sto,
       dmi_mov,

       AppManager,
       SessionData,

       MainData,

       dm_art,
       dm_mov,
       dm_fdc;

resourceString
    RsMsg1 = 'Ha ocurrido un error durante el proceso de generación del documento. No ha podido ser creado.';
    RsMsg2 = 'Se ha creado el pedido de compra %s %d del proveedor %s, %s.';
    RsMsg3 = 'Ha ocurrido un error en el proceso de generación de pedidos de compra.';
    RsMsg4 = 'Se ha creado el movimiento de salida de almacén nº %d.';
    RsMsg5 = 'No se ha creado ningún movimiento de salida.';

procedure TAprovisionamientoModule.ServerDataModuleCreate( Sender: TObject);
begin
     DMExistenciasArticuloFields := TExistenciasArticuloFields.Create( DmExistenciasArticuloTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );

     DsProveedorFields := TProveedorFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
end;

procedure TAprovisionamientoModule.ServerDataModuleDestroy(Sender: TObject);
begin
     // ..
     SessionDataModule.Dm40.AprovisionamientoModule := nil;
end;

procedure TAprovisionamientoModule.GeneraPedidosCompra( Serie       : String;
                                                        Fecha       : TDate;
                                                        NombreTabla : String );

var  AprovisionamientoTable : TnxeTable;
     AprovisionamientoFields : TAprovisionamientoFields;

     CodigoProveedorActual : String;

function GeneraPedidoCompra : LongInt;

var   UltimoNroLinea,
      NroLineaActual,
      EjercicioActual : SmallInt;
      Index : SmallInt;
      NroOperacionActual,
      NroRegistroOrigen : LongInt;

begin

     Result := 0;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmLineaMovimientoTable ] );

     try

       SessionDataModule.Dm10.ProveedorModule.Obten( CodigoProveedorActual, DsProveedorFields );

       DmMovimientoTable.Append;

       DmMovimientoFields.TipoMovimiento.Value := tmPedidoCompra;
       DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       DmMovimientoFields.Serie.Value := Serie;
       DmMovimientoFields.Propietario.Value := CodigoProveedorActual;
       DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
       DmMovimientoFields.NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( DmMovimientoFields );
       DmMovimientoFields.Fecha.Value := Fecha;
       DmMovimientoFields.Situacion.Value := epPendiente;
       DmMovimientoFields.Origen.Value := omAprovisionamiento;

       DmMovimientoTable.Post;

       NroLineaActual := 1;
       NroOperacionActual := 0;

       While not AprovisionamientoTable.Eof and ( AprovisionamientoFields.CodigoProveedor.Value=CodigoProveedorActual ) do
         begin

         If   AprovisionamientoFields.Seleccionada.Value
         then begin

              DmLineaMovimientoTable.Append;

              DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
              DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
              DmLineaMovimientoFields.NroPagina.Value := 0;
              DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;
              DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
              DmLineaMovimientoFields.UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;

              DmLineaMovimientoFields.CodigoArticulo.Value := AprovisionamientoFields.CodigoArticulo.Value;
              DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
              DmLineaMovimientoFields.CodigoAlmacen.Value := AprovisionamientoFields.CodigoAlmacenDestino.Value;
              DmLineaMovimientoFields.Ubicacion.Value := SessionDataModule.Dm30.AlmacenModule.UbicacionPorDefecto( DmLineaMovimientoFields.CodigoAlmacen.Value, DsArticuloFields );
              DmLineaMovimientoFields.Cantidad.Value := AprovisionamientoFields.Reposicion.Value;
              DmLineaMovimientoFields.CantidadProcesada.Value := 0.0;

              SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, True );

              // El registro DsTiposIVAFields se obtiene en la misma función CalculaImportesIVA

              SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, DsTiposIVAFields );

              SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );

              DmLineaMovimientoTable.Post;

              Inc( NroLineaActual );

              end;

         AprovisionamientoTable.Next;
         end;

       SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( DmMovimientoFields );

       TransactionTag.Commit;

       SessionDataModule.SendNotification( ntInformation, Format( RsMsg2, [ DmMovimientoFields.Serie.Value,
                                                                            DmMovimientoFields.NroDocumento.Value,
                                                                            DsProveedorFields.Codigo.Value,
                                                                            DsProveedorFields.Nombre.Value ] ) );

       Result := DmMovimientoFields.NroDocumento.Value;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendDatabaseError( nil, E );
       SessionDataModule.SendNotification( ntStop, RsMsg1 );
       Abort;
       end;
     end;

end;

begin
     AprovisionamientoTable := TnxeTable.Create( Self );
     try

       try

       With AprovisionamientoTable do
         begin
          Database := SessionDataModule.TemporalDatabase;
          PreserveTemporalTableName := True;
          TableName := NombreTabla;
          TableType := ttTemporal;
          Open;
          end;

       AprovisionamientoFields := TAprovisionamientoFields.Create( AprovisionamientoTable );

         With AprovisionamientoTable do
           begin
           First;
           While not Eof do
             begin
             If   AprovisionamientoFields.Seleccionada.Value
             then begin
                  CodigoProveedorActual := AprovisionamientoFields.CodigoProveedor.Value;
                  GeneraPedidoCompra;
                  end
             else Next;
             end;

           end;

         except on E : Exception do
           begin
           SessionDataModule.SendNotification( ntStop, RsMsg3, ExceptionMessage( E ) );
           raise;
           end;
         end;

     finally
       FreeAndNil( AprovisionamientoTable );
       end;
end;

procedure TAprovisionamientoModule.GeneraTraspasoAlmacen( Fecha       : TDate;
                                                          NombreTabla : String );

var  AprovisionamientoTable : TnxeTable;
     AprovisionamientoFields : TAprovisionamientoFields;

     CabeceraPendiente : Boolean;

     UltimoNroLinea,
     NroLineaActual,
     EjercicioActual : SmallInt;
     Index : SmallInt;
     NroOperacionActual,
     NroRegistroOrigen : LongInt;

begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmLineaMovimientoTable ] );

     try

       try

         AprovisionamientoTable := TnxeTable.Create( Self );

         With AprovisionamientoTable do
           begin
            Database := SessionDataModule.TemporalDatabase;
            PreserveTemporalTableName := True;
            TableName := NombreTabla;
            TableType := ttTemporal;
            Open;
            end;

         AprovisionamientoFields := TAprovisionamientoFields.Create( AprovisionamientoTable );

         CabeceraPendiente := True;

         AprovisionamientoTable.First;
         While not AprovisionamientoTable.Eof do
           begin
           If   AprovisionamientoFields.Seleccionada.Value
           then begin

                If   CabeceraPendiente
                then begin

                     DmMovimientoTable.Append;

                     DmMovimientoFields.TipoMovimiento.Value := tmSalida;
                     DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
                     DmMovimientoFields.Fecha.Value := Fecha;
                     DmMovimientoFields.Origen.Value := omAprovisionamiento;

                     DmMovimientoTable.Post;

                     NroLineaActual := 1;
                     NroOperacionActual := 0;

                     CabeceraPendiente := False;
                     end;


                DmLineaMovimientoTable.Append;

                DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                DmLineaMovimientoFields.NroPagina.Value := 0;
                DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;
                DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                DmLineaMovimientoFields.UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;

                DmLineaMovimientoFields.CodigoArticulo.Value := AprovisionamientoFields.CodigoArticulo.Value;
                DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
                DmLineaMovimientoFields.CodigoAlmacen.Value := AprovisionamientoFields.CodigoAlmacenOrigen.Value;
                DmLineaMovimientoFields.Ubicacion.Value := SessionDataModule.Dm30.AlmacenModule.UbicacionPorDefecto( DmLineaMovimientoFields.CodigoAlmacen.Value, DsArticuloFields );
                DmLineaMovimientoFields.Cantidad.Value := -AprovisionamientoFields.Reposicion.Value;

                SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, nil, DsArticuloFields, True );
                SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );
                SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );

                DmLineaMovimientoTable.Post;

                Inc( NroLineaActual );

                end;

           AprovisionamientoTable.Next;
           end;

         SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( DmMovimientoFields );

         TransactionTag.Commit;

         If   CabeceraPendiente
         then SessionDataModule.SendNotification( ntStop, RsMsg5 )
         else SessionDataModule.SendNotification( ntInformation, Format( RsMsg4, [ DmMovimientoFields.NroOperacion.Value ] ) );

       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendDatabaseError( nil, E );
         SessionDataModule.SendNotification( ntStop, RsMsg1 );
         Abort;
         end;
       end;


     finally
       FreeAndNil( AprovisionamientoTable );
       end;

end;

function TAprovisionamientoModule.SeleccionaArticulosBajoMinimos( TipoSeleccion            : TTipoSeleccionBajoMinimos;
                                                                  CodigoAlmacenOrigen,
                                                                  CodigoAlmacenDestino     : String;
                                                                  ExistenciasVirtuales     : Boolean = False;
                                                                  CodigoProveedor          : String = '';
                                                                  TodosLosAlmacenes        : Boolean = False ) : String;

var  SQLCommand,
     SQLSeleccionAlmacen,
     SQLSeleccionProveedor,
     SQLOrderBy : String;
     AprovisionamientoTable : TnxeTable;
     ExistenciasOrigen,
     ExistenciasDestino : IExistenciasArticulo;
     AprovisionamientoFields : TAprovisionamientoFields;
     StockMinimoAlmacenOrigen,
     StockMaximoAlmacenOrigen,
     DisponibleEnOrigen,
     NecesidadEnDestino,
     PendienteRecibir,
     PendienteServir,
     Reposicion : Decimal;

     Precio : Double;
     PuntoVerde,
     Descuento,
     ImporteBruto,
     DescuentoArticulo,
     ImporteNeto : Decimal;

begin

     AprovisionamientoTable := TnxeTable.Create( Self );
     try

       AprovisionamientoTable.TableName := 'Aprovisionamiento';

       SQLSeleccionAlmacen := '';
       SQLSeleccionProveedor := '';

       If   ( TipoSeleccion=tsTraspasoAlmacenes ) or not TodosLosAlmacenes
       then SQLSeleccionAlmacen := 'ExistenciasArticulo.CodigoAlmacen=' + QuotedStr( CodigoAlmacenDestino ) +  ' AND ';

       case TipoSeleccion of
         tsTraspasoAlmacenes :
           begin
           SQLOrderBy := 'ORDER BY ExistenciasArticulo.CodigoAlmacen, ExistenciasArticulo.CodigoArticulo';
           end;
         tsPedidosCompra :
           begin
           SQLOrderBy := 'ORDER BY Articulo.CodigoProveedor, ExistenciasArticulo.CodigoArticulo, ExistenciasArticulo.CodigoAlmacen';
           // Los artículos que no tienen proveedor asignado no se deben seleccionar
           If   CodigoProveedor=''
           then SQLSeleccionProveedor := '( NOT Articulo.CodigoProveedor IS NULL OR Articulo.CodigoProveedor<>'''' ) AND '
           else SQLSeleccionProveedor := 'Articulo.CodigoProveedor=' + QuotedStr( CodigoProveedor ) + ' AND ';
           end;
         end;

       SQLCommand := 'SELECT CAST( 0 AS AUTOINC ) AS NroRegistro, ' +
                     '       ExistenciasArticulo.CodigoArticulo, ' +
                     '       Articulo.Descripcion, ' +
                      '      Articulo.CodigoProveedor, ' +
                     '       CAST( '''' AS NVarChar( 2 ) ) AS CodigoAlmacenOrigen, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS StockMinimoOrigen, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS StockMaximoOrigen, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS ExistenciasOrigen, ' +
                     '       ExistenciasArticulo.StockMinimo AS StockMinimoDestino, ' +
                     '       ExistenciasArticulo.StockMaximo AS StockMaximoDestino, ' +
                     '       ExistenciasArticulo.CodigoAlmacen AS CodigoAlmacenDestino, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS ExistenciasDestino, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS DisponibleEnOrigen, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS NecesidadEnDestino, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS PendienteRecibir, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS PendienteServir, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS Reposicion, ' +
                     '       CAST ( 0.0 AS BCD(16,4) ) AS ImporteNeto, ' +
                     '       False AS Seleccionada, ' +
                     '       False AS NoCubierto ' +
                     'INTO   <TableName> ' +
                     'FROM   ExistenciasArticulo LEFT JOIN Articulo ON ( Articulo.Codigo=ExistenciasArticulo.CodigoArticulo )' +
                     'WHERE  ' + SQLSeleccionAlmacen
                               + SQLSeleccionProveedor +
                             ' ExistenciasArticulo.StockMinimo>0 AND ' +
                             ' NOT Articulo.Obsoleto ' +
                     SQLOrderBy;


       // Es ttTemporal para que no se autodestruya al cerrarse, por lo que será responsabilidad del cliente el borrar la tabla

       Result := SessionDataModule.CreateTemporalSQLTable( AprovisionamientoTable, SQLCommand, ttTemporal );

       AprovisionamientoFields := TAprovisionamientoFields.Create( AprovisionamientoTable );

       With AprovisionamientoTable do
         begin
         First;
         While not Eof do
           begin

           ExistenciasDestino := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( AprovisionamientoFields.CodigoArticulo.Value,
                                                                                       True, '', '', '', True, '',
                                                                                       False, AprovisionamientoFields.CodigoAlmacenDestino.Value,
                                                                                       True, '', True, SessionDataModule.Ejercicio, 0, 12 );

           If   ExistenciasDestino.SumaExistencias.Saldo < AprovisionamientoFields.StockMinimoDestino.Value
           then begin

                // CodigoArticulo;CodigoAlmacen

                If   DmExistenciasArticuloTable.FindKey( [ AprovisionamientoFields.CodigoArticulo.Value, CodigoAlmacenOrigen ] )
                then begin
                     StockMinimoAlmacenOrigen := DmExistenciasArticuloFields.StockMinimo.Value;
                     StockMaximoAlmacenOrigen := DmExistenciasArticuloFields.StockMaximo.Value;
                     end
                else begin
                     StockMinimoAlmacenOrigen := 0.0;
                     StockMaximoAlmacenOrigen := 0.0;
                     end;

                AprovisionamientoTable.Edit;
                try

                  AprovisionamientoFields.StockMinimoOrigen.Value := StockMinimoAlmacenOrigen;
                  AprovisionamientoFields.StockMaximoOrigen.Value := StockMaximoAlmacenOrigen;

                  If   TipoSeleccion=tsTraspasoAlmacenes
                  then begin
                       ExistenciasOrigen := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( AprovisionamientoFields.CodigoArticulo.Value,
                                                                                                  True, '', '', '', True, '',
                                                                                                  False, CodigoAlmacenOrigen,
                                                                                                  True, '', True, SessionDataModule.Ejercicio, 0, 12 );

                       DisponibleEnOrigen := ExistenciasOrigen.SumaExistencias.Saldo - AprovisionamientoFields.StockMinimoOrigen.Value;
                       If   DisponibleEnOrigen<0.0
                       then DisponibleEnOrigen := 0.0;

                       AprovisionamientoFields.ExistenciasOrigen.Value := ExistenciasOrigen.SumaExistencias.Saldo;
                       end
                  else DisponibleEnOrigen := 0.0;

                  NecesidadEnDestino := AprovisionamientoFields.StockMaximoDestino.Value - ExistenciasDestino.SumaExistencias.Saldo;
                  If   NecesidadEnDestino<0.0
                  then NecesidadEnDestino := 0.0;

                  PendienteRecibir := ExistenciasDestino.SumaExistencias.PendienteRecibir;
                  PendienteServir := ExistenciasDestino.SumaExistencias.PendienteServir;

                  If   ExistenciasVirtuales
                  then NecesidadEnDestino := NecesidadEnDestino + PendienteServir - PendienteRecibir;

                  If   TipoSeleccion=tsTraspasoAlmacenes
                  then begin

                       If   NecesidadEnDestino>DisponibleEnOrigen
                       then Reposicion := DisponibleEnOrigen
                       else Reposicion := NecesidadEnDestino;

                       end
                  else begin // La reposición es sobre el stock máximo. Si fuera sobre el mínimo, se quedaría enseguida de nuevo sin existencias.
                       Reposicion := AprovisionamientoFields.StockMaximoDestino.Value - ExistenciasDestino.SumaExistencias.Saldo;
                       If   ExistenciasVirtuales
                       then Reposicion := Reposicion + PendienteServir - PendienteRecibir;
                       end;

                  If   Reposicion<0.0
                  then Reposicion := 0.0;

                  AprovisionamientoFields.CodigoAlmacenOrigen.Value := CodigoAlmacenOrigen;
                  AprovisionamientoFields.DisponibleEnOrigen.Value := DisponibleEnOrigen;
                  AprovisionamientoFields.NecesidadEnDestino.Value := NecesidadEnDestino;
                  AprovisionamientoFields.ExistenciasDestino.Value := ExistenciasDestino.SumaExistencias.Saldo;
                  AprovisionamientoFields.PendienteRecibir.Value := PendienteRecibir;
                  AprovisionamientoFields.PendienteServir.Value := PendienteServir;
                  AprovisionamientoFields.Reposicion.Value := Reposicion;
                  AprovisionamientoFields.NoCubierto.Value := ( NecesidadEnDestino - Reposicion )>0.0;

                  If   TipoSeleccion=tsPedidosCompra
                  then If   SessionDataModule.Dm30.ArticuloModule.Obten( AprovisionamientoFields.CodigoArticulo.Value, DsArticuloFields )
                       then begin
                            SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( AprovisionamientoFields.CodigoProveedor.Value,
                                                                                         AprovisionamientoFields.CodigoArticulo.Value,
                                                                                         '',
                                                                                         '',
                                                                                         '',
                                                                                         AprovisionamientoFields.Reposicion.Value,
                                                                                         Precio,
                                                                                         PuntoVerde,
                                                                                         Descuento,
                                                                                         True );

                            SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( AprovisionamientoFields.Reposicion.Value,
                                                                                         DsArticuloFields.UnidadesPrecioCompra.Value,
                                                                                         Precio,
                                                                                         PuntoVerde,
                                                                                         Descuento,
                                                                                         ImporteBruto,
                                                                                         DescuentoArticulo,
                                                                                         ImporteNeto );
                            AprovisionamientoFields.ImporteNeto.Value := ImporteNeto;
                            end;


                  If   Reposicion=0.0
                  then AprovisionamientoFields.Seleccionada.Clear;   // Si es null se muestra en la rejilla como indeterminada

                  AprovisionamientoTable.Post;

                except
                  AprovisionamientoTable.Cancel;
                  raise;
                  end;

                Next;
                end
           else Delete;

           end;
       end;

     finally
       FreeAndNil( AprovisionamientoTable );
       end;

end;

var AprovisionamientoControl : InxClassFactoryControl;

{ TAprovisionamientoService }

procedure TAprovisionamientoService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TAprovisionamientoService.GeneraPedidosCompra(Serie: String; Fecha: TDate; NombreTabla: String);
begin
     SessionDataModule.Dm40.AprovisionamientoModule.GeneraPedidosCompra( Serie, Fecha, NombreTabla );
end;

procedure TAprovisionamientoService.GeneraTraspasoAlmacen( Fecha: TDate; NombreTabla: String);
begin
     SessionDataModule.Dm40.AprovisionamientoModule.GeneraTraspasoAlmacen( Fecha, NombreTabla );
end;

function TAprovisionamientoService.SeleccionaArticulosBajoMinimos( TipoSeleccion        : TTipoSeleccionBajoMinimos;
                                                                   CodigoAlmacenOrigen,
                                                                   CodigoAlmacenDestino : String;
                                                                   ExistenciasVirtuales : Boolean = False;
                                                                   CodigoProveedor      : String = '';
                                                                   TodosLosAlmacenes    : Boolean = False ) : String;
begin
     Result := SessionDataModule.Dm40.AprovisionamientoModule.SeleccionaArticulosBajoMinimos( TipoSeleccion, CodigoAlmacenOrigen, CodigoAlmacenDestino, ExistenciasVirtuales, CodigoProveedor, TodosLosAlmacenes );
end;

initialization
   TnxClassFactory.RegisterClass( CLSID_AprovisionamientoService, TAprovisionamientoService, AprovisionamientoControl );

end.


