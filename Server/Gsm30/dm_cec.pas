
unit dm_cec;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim30Fields,

  dmi_cec;

type

    TCierreComercialService = class( TSessionModule, ICierreComercialService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( NoGenerarMovimientos : Boolean; PrecioValoracion : TPrecioValoracion; FechaInventario : TDate );
    end;

  TCierreComercialModule = class(TServerDataModule)
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    StockTable: TnxeTable;
    NuevoStockTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    MovimientoFields  : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    NuevoStockFields,
    StockFields : TStockFields;
    ArticuloFields : TArticuloFields;

  public

    procedure EjecutaProceso( NoGenerarMovimientos : Boolean; PrecioValoracion : TPrecioValoracion; FechaInventario : TDate );
    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     dmi_mov,
     dmi_sto,

     dm_mov,
     dm_sto;

{$R *.DFM}

resourceString

     RsMsg2  = 'Inventario inicial.';
     RsMsg3  = 'Artículo';
     RsMsg4  = 'Puede revisar los movimientos realizados y los datos cambiando de Ejercicio activo.';

     RsMsg6  = 'El proceso ha sido interrumpido.';
     RsMsg7  = 'Si no tiene activado el sistema de TRANSACCIONES debería revisar el estado de sus ficheros.';
     RsMsg8  = 'El artículo [%s] ha sido dado de baja.';
     RsMsg9  = 'Uno o más artículos han sido dados de baja. Es posible que el inventario inicial no refleje el estado real de sus existencias.';
     RsMsg10 = 'No se ha creado ningún movimiento de inventario.';

procedure TCierreComercialModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.CierreComercialModule := nil
end;

procedure TCierreComercialModule.ServerDataModuleCreate(Sender: TObject);
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     StockFields := TStockFields.Create( StockTable );
     NuevoStockFields := TStockFields.Create( NuevoStockTable );
     ArticuloFields := TArticuloFields.Create( Self );
end;



{ TCierreComercialService }

procedure TCierreComercialService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TCierreComercialService.EjecutaProceso( NoGenerarMovimientos : Boolean; PrecioValoracion : TPrecioValoracion; FechaInventario : TDate );
begin
     SessionDataModule.Dm30.CierreComercialModule.EjecutaProceso( NoGenerarMovimientos, PrecioValoracion, FechaInventario );
end;

procedure TCierreComercialModule.EjecutaProceso( NoGenerarMovimientos : Boolean;
                                                 PrecioValoracion     : TPrecioValoracion;
                                                 FechaInventario      : TDate );

var   SaveEjercicio : SmallInt;
      ArticuloSuprimido : Boolean;
      FieldValuesArray : TFieldValuesArray;
      RegistroCreado : Boolean;
      Hora : TDateTime;
      NroOperacionActual : LongInt;
      NroLineaActual : SmallInt;
      ProcesoCancelado : Boolean;
      ExistenciasArticulo : IExistenciasArticulo;

begin

     try

       ProcesoCancelado := False;
       Hora := Now;
       ArticuloSuprimido := False;
       SaveEjercicio := SessionDataModule.Ejercicio;
       SessionDataModule.Ejercicio := SessionDataModule.Ejercicio  + 1;

       var TransactionTag := SessionDataModule.StartTransaction;

       try

         SessionDataModule.SendNotification( ntInformation, RsMsg3 );

         NroOperacionActual := 0;
         RegistroCreado := False;

         With StockTable do
           try
             SetRange( [ SessionDataModule.Ejercicio - 1, '',         '',         '',         '',         '',         '',         ''         ],
                       [ SessionDataModule.Ejercicio - 1, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode ] );

             First;
             While not Eof and not ProcesoCancelado do
               begin

               If   not NoGenerarMovimientos
               then begin

                    If   NroOperacionActual=0
                    then begin

                         NroOperacionActual := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

                         MovimientoTable.Append;

                         With MovimientoFields do
                           begin
                           Ejercicio.Value := SessionDataModule.Ejercicio;
                           NroOperacion.Value := NroOperacionActual;
                           Fecha.Value := FechaInventario;
                           TipoMovimiento.Value := tmInventario;
                           DescripcionMovimiento.Value := RsMsg2;
                           end;

                         NroLineaActual := 1;
                         end
                    else If   NroLineaActual>250
                         then begin
                              Inc( NroOperacionActual );
                              FieldValuesArray := MovimientoTable.GetFieldValues;
                              MovimientoTable.Post;
                              MovimientoTable.Append;
                              MovimientoTable.SetFieldValues( FieldValuesArray );
                              MovimientoFields.NroOperacion.Value := NroOperacionActual;
                              NroLineaActual := 1;
                              RegistroCreado := True;
                              end;

                    end;

               ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, StockFields.CodigoArticulo.Value );

               If   SessionDataModule.Dm30.ArticuloModule.Obten( StockFields.CodigoArticulo.Value, ArticuloFields )
               then begin

                    If   not ArticuloFields.NoAfectarStock.Value
                    then begin

                         With StockFields do
                           ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( ArticuloFields,
                                                                                                        False,
                                                                                                        CodigoClaseA.Value,
                                                                                                        CodigoClaseB.Value,
                                                                                                        CodigoClaseC.Value,
                                                                                                        False,
                                                                                                        LoteFabricacion.Value,
                                                                                                        False,
                                                                                                        CodigoAlmacen.Value,
                                                                                                        False,
                                                                                                        Ubicacion.Value,
                                                                                                        True,
                                                                                                        SessionDataModule.Ejercicio - 1,
                                                                                                        0,
                                                                                                        SessionDataModule.NroMesFinal );

                         If   not NoGenerarMovimientos
                         then If   ExistenciasArticulo.SumaExistencias.Saldo<>0.0
                              then With LineaMovimientoFields do
                                     begin

                                     LineaMovimientoTable.Append;

                                     Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                                     NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                                     NroLinea.Value := NroLineaActual;
                                     Fecha.Value := MovimientoFields.Fecha.Value;
                                     CodigoArticulo.Value := StockFields.CodigoArticulo.Value;
                                     CodigoClaseA.Value := StockFields.CodigoClaseA.Value;
                                     CodigoClaseB.Value := StockFields.CodigoClaseB.Value;
                                     CodigoClaseC.Value := StockFields.CodigoClaseC.Value;
                                     LoteFabricacion.Value := StockFields.LoteFabricacion.Value;
                                     FechaCaducidad.Value := StockFields.FechaCaducidad.Value;
                                     UIDArticulo.AsGuid := StockFields.UIDArticulo.AsGuid;
                                     Descripcion.Value := ArticuloFields.Descripcion.Value;
                                     CodigoAlmacen.Value := StockFields.CodigoAlmacen.Value;
                                     Ubicacion.Value := StockFields.Ubicacion.Value;
                                     Cantidad.Value := ExistenciasArticulo.SumaExistencias.Saldo;

                                     case PrecioValoracion of
                                       pvCosteMedio   : Precio.Value := ExistenciasArticulo.CosteMedio;
                                       pvUltimoCoste  : Precio.Value := ExistenciasArticulo.CosteUltEntrada;
                                       pvCoste        : Precio.Value := ExistenciasArticulo.Coste;
                                       pvPrecioCompra : Precio.Value := ArticuloFields.Precio_Compra.Value;
                                       end;

                                     SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( LineaMovimientoFields, ArticuloFields );

                                     SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                                     LineaMovimientoTable.Post;

                                     Inc( NroLineaActual );
                                     end;

                         With StockFields do
                           If   NuevoStockTable.FindKey( [ SessionDataModule.Ejercicio, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, LoteFabricacion.Value, Ubicacion.Value, CodigoAlmacen.Value ] )
                           then NuevoStockTable.Edit
                           else With NuevoStockFields do
                                  begin
                                  NuevoStockTable.Append;
                                  Ejercicio.Value := SessionDataModule.Ejercicio;
                                  CodigoArticulo.Value := StockFields.CodigoArticulo.Value;
                                  CodigoClaseA.Value := StockFields.CodigoClaseA.Value;
                                  CodigoClaseB.Value := StockFields.CodigoClaseB.Value;
                                  CodigoClaseC.Value := StockFields.CodigoClaseC.Value;
                                  LoteFabricacion.Value := StockFields.LoteFabricacion.Value;
                                  Ubicacion.Value := StockFields.Ubicacion.Value;
                                  CodigoAlmacen.Value := StockFields.CodigoAlmacen.Value;
                                  FechaUltEntrada.Value := StockFields.FechaUltEntrada.Value;
                                  FechaUltSalida.Value := StockFields.FechaUltSalida.Value;
                                  CosteUltEntrada.Value := StockFields.CosteUltEntrada.Value;
                                  Coste_Medio.Value := StockFields.Coste_Medio.Value;
                                  PrecioUltSalida.Value := StockFields.PrecioUltSalida.Value;
                                  end;

                         With NuevoStockFields do
                           begin
                           PendienteRecibir[ 0 ].Value := StockFields.PendienteRecibir[ 1 ].Value;
                           PendienteServir[ 0 ].Value := StockFields.PendienteServir[ 1 ].Value;
                           end;

                         NuevoStockTable.Post;

                         end;

                    end
               else begin
                    ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, Format( RsMsg8, [ StockFields.CodigoArticulo.Value ] ) );
                    ArticuloSuprimido := True;
                    end;

               Next;
               end;

             With MovimientoTable do
               If   ( NroLineaActual>1 ) and Modified
               then Post
               else begin
                    Cancel;
                    If   not RegistroCreado and not NoGenerarMovimientos
                    then ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, RsMsg10 );
                    end;

           finally
             CancelRange;
             end;

         TransactionTag.Commit;

         If   ArticuloSuprimido
         then ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, RsMsg9 );

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg4 );

       except on e : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendException( E, Self );
         SessionDataModule.SendNotification( ntError, RsMsg6 + #13 + RsMsg7 );
         end;
       end;

     finally
       SessionDataModule.Ejercicio := SaveEjercicio;
       end;

     ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, 'El proceso ha durado  : ' + FormatDateTime( 'HH:MM:SS:mm', Now - Hora ) );

end;

var CierreComercialControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_CierreComercialService, TCierreComercialService, CierreComercialControl );

end.
