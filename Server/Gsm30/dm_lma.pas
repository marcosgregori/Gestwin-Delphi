
unit dm_lma;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  AppManager,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,

  dmi_lma,

  MovimientoIntf,
  LineaMovimientoIntf;

type

  TListaMaterialesService = class( TSessionModule, IListaMaterialesService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure AplicarDesglose( Movimiento : IMovimiento; LineaMovimiento : ILineaMovimiento );
    end;

   TListaMaterialesModule = class(TServerDataModule)
    DmListaMaterialesTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    DmListaMaterialesFields : TListaMaterialesFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;

    SerieFacturacionFields : TSerieFacturacionFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;
    ProveedorFields : TProveedorFields;
    ClienteFields : TClienteFields;

    Desglosar : Boolean;

  public
    procedure AplicarDesglose( Movimiento : IMovimiento; LineaMovimiento : ILineaMovimiento );
  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     nxllBde,
     nxrdClass,
     nxrbTypes,

     SessionData,

     Gim00Fields,

     dmi_mov,

     dm_sdf,
     dm_alm,
     dm_pro,
     dm_cli,
     dm_mov;

{$R *.DFM}

resourceString
    RsMsg1  = 'El componente [%s], incluido en esta lista de materiales, ha sido dado de baja.';
    RsMsg2  = 'No será incluido en el desglose.';

procedure TListaMaterialesModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmListaMaterialesFields := TListaMaterialesFields.Create( DmListaMaterialesTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );

     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
end;

procedure TListaMaterialesModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.ListaMaterialesModule := nil
end;

procedure TListaMaterialesModule.AplicarDesglose( Movimiento      : IMovimiento;
                                                  LineaMovimiento : ILineaMovimiento );

var   ArticuloDesglose : String;
      ClaseADesglose,
      ClaseBDesglose,
      ClaseCDesglose : String;
      CantidadDesglose : Decimal;
      CodigoAlmacenDesglose : String;
      NroLineaActual,
      NroPaginaActual,
      NroLineaInsercion : SmallInt;
      DescuentoBase : Decimal;
      MovimientoEntrada : Boolean;

function EsUnMovimientoDeEntrada( TipoMovimiento : TTipoMovimiento ) : Boolean;
begin
     Result := TipoMovimiento in [ tmInventario, tmEntrada, tmFabricacion, tmRegularizacion, tmDespiece, tmOferta, tmPedidoCompra, tmCompra ];
end;

begin
     With SessionDataModule, Dm30 do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable ] );

       try

         If   DmMovimientoTable.FindKey( [ Movimiento.Ejercicio, Movimiento.NroOperacion ] )
         then begin

              Dm10.SerieFacturacionModule.Obten( DmMovimientoFields.Serie.Value, SerieFacturacionFields );

              ArticuloDesglose := LineaMovimiento.CodigoArticulo;
              ClaseADesglose := LineaMovimiento.CodigoClaseA;
              ClaseBDesglose := LineaMovimiento.CodigoClaseB;
              ClaseCDesglose := LineaMovimiento.CodigoClaseC;
              CantidadDesglose := LineaMovimiento.Cantidad;
              CodigoAlmacenDesglose := LineaMovimiento.CodigoAlmacen;

              DescuentoBase := LineaMovimiento.Descuento;

              NroLineaActual := LineaMovimiento.NroLinea;
              NroPaginaActual := LineaMovimiento.NroPagina;
              MovimientoEntrada := EsUnMovimientoDeEntrada( DmMovimientoFields.TipoMovimiento.Value );

              If   EmpresaFields.Stock_IncluirPrecioComponentes.Value
              then If   DmLineaMovimientoTable.FindKey( [ LineaMovimiento.Ejercicio, LineaMovimiento.NroOperacion, LineaMovimiento.NroPagina, LineaMovimiento.NroLinea ] )
                   then try
                          DmLineaMovimientoTable.Edit;
                          MovimientoModule.LimpiaImportesLinea( DmLineaMovimientoFields );
                          DmLineaMovimientoTable.Post;
                        except
                          DmLineaMovimientoTable.Cancel;
                          raise;
                          end;

              With DmLineaMovimientoTable do
                try
                  SetRange( [ LineaMovimiento.Ejercicio, LineaMovimiento.NroOperacion, LineaMovimiento.NroPagina ] );
                  Last;   // Veamos si no es la última línea. En ese caso habrá que dejar sitio
                  If   DmLineaMovimientoFields.NroLinea.Value<>NroLineaActual
                  then begin
                       NroLineaInsercion := DmLineaMovimientoFields.NroLinea.Value + DmListaMaterialesTable.RecordCount;
                       While not Bof and ( DmLineaMovimientoFields.NroLinea.Value<>NroLineaActual ) do
                         begin
                         try
                           Edit;
                           DmLineaMovimientoFields.NroLinea.Value := NroLineaInsercion;
                           DmLineaMovimientoTable.Post;
                         except
                           DmLineaMovimientoTable.Cancel;
                           raise;
                           end;
                         Dec( NroLineaInsercion );
                         Prior;
                         end;
                       end;
                finally
                  CancelRange;
                  end;

              With DmListaMaterialesTable do
                try

                  SetRange( [ ArticuloDesglose, ClaseADesglose, ClaseBDesglose, ClaseCDesglose, 1 ],
                            [ ArticuloDesglose, ClaseADesglose, ClaseBDesglose, ClaseCDesglose, MaxSmallInt ] );

                  First;
                  While not Eof do
                    begin

                    If   ArticuloModule.Obten( DmListaMaterialesFields.CodigoComponente.Value, ArticuloFields )
                    then begin

                         Inc( NroLineaActual );

                         DmLineaMovimientoTable.Append;

                         DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                         DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                         DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                         DmLineaMovimientoFields.FechaAplicacion.Value := MovimientoModule.ObtenFechaAplicacion( DmMovimientoFields.TipoMovimiento.Value, DmMovimientoFields.FechaAplicacion.Value, LineaMovimiento.FechaAplicacion  );
                         DmLineaMovimientoFields.NroPagina.Value := NroPaginaActual;
                         DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;

                         DmLineaMovimientoFields.AsignacionOrigen.Value := aomListaMateriales;
                         DmLineaMovimientoFields.CodigoArticulo.Value := DmListaMaterialesFields.CodigoComponente.Value;
                         DmLineaMovimientoFields.UIDArticulo.AsGUID := ArticuloModule.Identificador;
                         DmLineaMovimientoFields.CodigoClaseA.Value := DmListaMaterialesFields.ClaseAComponente.Value;
                         DmLineaMovimientoFields.CodigoClaseB.Value := DmListaMaterialesFields.ClaseBComponente.Value;
                         DmLineaMovimientoFields.CodigoClaseC.Value := DmListaMaterialesFields.ClaseCComponente.Value;
                         DmLineaMovimientoFields.Descripcion.Value := ArticuloFields.Descripcion.Value;
                         DmLineaMovimientoFields.Cantidad.Value := CantidadDesglose * DmListaMaterialesFields.Cantidad.Value;

                         case DmMovimientoFields.TipoMovimiento.Value of
                           tmPresupuesto,
                           tmPedidoVenta : DmLineaMovimientoFields.CantidadAjustada.Value := DmLineaMovimientoFields.Cantidad.Value;
                           tmVenta       : DmLineaMovimientoFields.CantidadAjustada.Value := -DmLineaMovimientoFields.Cantidad.Value;
                           end;

                         If   DmMovimientoFields.TipoMovimiento.Value in [ tmDespiece, tmFabricacion ]
                         then begin
                              DmLineaMovimientoFields.Cantidad.Value := -DmLineaMovimientoFields.Cantidad.Value;
                              DmLineaMovimientoFields.CodigoAlmacen.Value := AlmacenModule.AlmacenPorDefecto( scAmbas, ArticuloFields );
                              DmLineaMovimientoFields.Ubicacion.Value := ArticuloFields.Ubicacion.Value;
                              end
                         else DmLineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacenDesglose;

                         If   EmpresaFields.Stock_IncluirPrecioComponentes.Value
                         then begin
                              DmLineaMovimientoFields.Descuento.Value := DescuentoBase;
                              If   MovimientoEntrada
                              then begin
                                   If   Dm10.ProveedorModule.Obten( DmMovimientoFields.Propietario.Value, ProveedorFields )
                                   then ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, ProveedorFields, ArticuloFields )
                                   else DmLineaMovimientoFields.Precio.Value := ArticuloFields.Precio_Compra.Value;
                                   FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields, ProveedorFields, ArticuloFields, TiposIVAFields );
                                   end
                              else begin
                                   If   Dm10.ClienteModule.Obten( DmMovimientoFields.Propietario.Value, ClienteFields )
                                   then ArticuloModule.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value, DmLineaMovimientoFields, ClienteFields, ArticuloFields )
                                   else DmLineaMovimientoFields.Precio.Value := ArticuloFields.Precio_Venta.Value;
                                   FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, DmMovimientoFields.IVAIncluido.Value );
                                   end;
                              end;

                         StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );

                         DmLineaMovimientoTable.Post;

                         end
                    else SendNotification( ntWarning, Format( RsMsg1, [ DmListaMaterialesFields.CodigoComponente.Value ] ), RsMsg2 );

                    Next;
                    end;

                finally
                  CancelRange;
                  DmMovimientoTable.Cancel;
                  DmLineaMovimientoTable.Cancel;
                  end;

              end;

           TransactionTag.Commit;

         except on E : Exception do
           begin
           TransactionTag.Rollback;
           SendNotification( ntError, RsProcesoInterrumpido );
           Abort;
           end;
         end;

       end;
end;

{ TListaMaterialesService }

procedure TListaMaterialesService.AplicarDesglose( Movimiento      : IMovimiento;
                                                   LineaMovimiento : ILineaMovimiento );
begin
    SessionDataModule.Dm30.ListaMaterialesModule.AplicarDesglose( Movimiento, LineaMovimiento );
end;

procedure TListaMaterialesService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

var  ListaMaterialesControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_ListaMaterialesService, TListaMaterialesService, ListaMaterialesControl );

end.
