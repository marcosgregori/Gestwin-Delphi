
unit dm_pve;

interface

uses
  Windows, Messages, SysUtils, Classes,


  Gim10Fields,
  Gim30Fields,

  DataManager,
  ServerDataModule,

  DB,
  nxdb,

  LibUtils,
  SessionIntf,

  dmi_pve;

type

  TPreventaService = class( TSessionModule, IPreventaService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure GeneraConsumos( ClienteInicial, ClienteFinal : String; FechaInicial, FechaFinal : TDate; UltimoPrecioDefecto, UltimoDescuentoDefecto : Boolean; Maximo : SmallInt; CantidadMinima : Decimal; Ordenacion : SmallInt );

    end;

  TPreventaModule = class(TServerDataModule)
    DmEfectoCobrarTable: TnxeTable;
    DmConsumosClienteTable: TnxeTable;
    DmVendedorTable: TnxeTable;
    DmEquipoMovilTable: TnxeTable;
    DmLineaRutaTable: TnxeTable;
    DmRutaTable: TnxeTable;
    DmClienteTable: TnxeTable;
    DmDireccionContactoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmFacturaVentasTable: TnxeTable;
    DmEfectoTable: TnxeTable;
    DmRutasEquipoMovilTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    DmClienteFields : TClienteFields;
    DmDireccionContactoFields : TDireccionContactoFields;
    DmRutaFields : TRutaFields;
    DmLineaRutaFields : TlineaRutaFields;
    DmConsumosClienteFields : TConsumosClienteFields;
    DmEquipoMovilFields : TEquipoMovilFields;
    DmRutasEquipoMovilFields : TRutasEquipoMovilFields;
    DmEfectoCobrarFields : TEfectoCobrarFields;
    DmVendedorFields : TVendedorFields;

    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmEfectoFields : TEfectoFields;
    DmFacturaVentasFields : TFacturaVentasFields;

    DsArticuloFields : TArticuloFields;

    procedure GeneraConsumos( ClienteInicial, ClienteFinal : String; FechaInicial, FechaFinal : TDate; UltimoPrecioDefecto, UltimoDescuentoDefecto : Boolean; Maximo : SmallInt; CantidadMinima : Decimal; Ordenacion : SmallInt );

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Files,
     nxrbTypes,
     nxrdClass,

     AppManager,

     EnterpriseData,
     SessionData,

     nxsdConst,

     dmi_art,
     dmi_mov,

     dm_art,
     dm_mov;

{$R *.DFM}

resourceString
     RsMsg1  = 'Ha ocurrido un error durante el proceso de generación de consumos.';
     RsMsg2  = 'Se han cancelado todos los cambios.'#13'El fichero ha quedado tal y como estaba antes de intentar realizar el proceso.';
     RsMsg3  = 'Operacion nº %d.';

{ TPreventaModule }

procedure TPreventaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmClienteFields := TClienteFields.Create( DmClienteTable );
     DmDireccionContactoFields := TDireccionContactoFields.Create( DmDireccionContactoTable );
     DmRutaFields := TRutaFields.Create( DmRutaTable );
     DmLineaRutaFields := TLineaRutaFields.Create( DmLineaRutaTable );
     DmConsumosClienteFields := TConsumosClienteFields.Create( DmConsumosClienteTable );
     DmEquipoMovilFields := TEquipoMovilFields.Create( DmEquipoMovilTable );
     DmRutasEquipoMovilFields := TRutasEquipoMovilFields.Create( DmRutasEquipoMovilTable );
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmVendedorFields := TVendedorFields.Create( DmVendedorTable );

     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmEfectoFields := TEfectoFields.Create( DmEfectoTable );
     DmFacturaVentasFields := TFacturaVentasFields.Create( DmFacturaVentasTable );

     DsArticuloFields := TArticuloFields.Create( Self );

end;

procedure TPreventaModule.DataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.PreventaModule := nil
end;

procedure TPreventaModule.GeneraConsumos( ClienteInicial, ClienteFinal : String;
                                          FechaInicial, FechaFinal     : TDate;
                                          UltimoPrecioDefecto,
                                          UltimoDescuentoDefecto       : Boolean;
                                          Maximo                       : SmallInt;
                                          CantidadMinima               : Decimal;
                                          Ordenacion                   : SmallInt );

var   Contador,
      ContadorArticulos : SmallInt;
      MostrarCliente : Boolean;
      FPrecio : Double;
      FPuntoVerde,
      FRecargo,
      FDescuento : Decimal;
      EsUnaOferta : Boolean;

      CarteraArticulosTable : TnxeTable;
      CarteraArticulosFields : TCarteraArticulosFields;

      ProcesoCancelado : Boolean;

begin

  try

     ProcesoCancelado := False;

     CarteraArticulosTable := SessionDataModule.CreateEmptyTable( Self, 'CarteraArticulos', SessionDataModule.Dm30.GetSQL( 'CarteraArticulos' ) );
     CarteraArticulosFields := TCarteraArticulosFields.Create( CarteraArticulosTable );

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmConsumosClienteTable ] );

     try

       With DmClienteTable do
         begin
         SetRange( [ ClienteInicial ], [ ClienteFinal ] );
         First;
         While not Eof do
           begin

           ContadorArticulos := 0;

           CarteraArticulosTable.DeleteRecords( True );   // No usar EmptyTable, produce errores esporádicos
           CarteraArticulosTable.IndexFieldNames := 'CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Tipo';

           MostrarCliente := True;

           With DmMovimientoTable do
             begin
             IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
             SetRange( [ tmVenta, DmClienteFields.Codigo, FechaInicial ], [ tmVenta, DmClienteFields.Codigo, FechaFinal ] );
             First;
             While not Eof and ( ContadorArticulos<Maximo ) and not ProcesoCancelado do
               begin

               If   MostrarCliente
               then begin
                    SessionDataModule.SendNotification( ntInformation, DmClienteFields.Codigo.Value + ', ' + DmClienteFields.Nombre.Value );
                    MostrarCliente := False;
                    end;

               ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, Format( RsMsg3, [ DmMovimientoFields.NroOperacion.Value ] ) );

               With DmLineaMovimientoTable do
                 begin

                 With DmMovimientoFields do
                   SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

                 First;

                 While not Eof and ( ContadorArticulos<Maximo ) do
                   begin

                   With DmLineaMovimientoFields do
                     If   CodigoArticulo.Value<>ArticuloManual
                     then If   Cantidad.Value<0.0
                          then If   SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, DsArticuloFields )
                               then If   not DsArticuloFields.Obsoleto.Value
                                    then try
                                           If   CarteraArticulosTable.FindKey( [ '', CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 0 ] )
                                           then begin

                                                CarteraArticulosTable.Edit;

                                                CarteraArticulosFields.Cantidad.Value := -Cantidad.Value;
                                                CarteraArticulosFields.Precio.Value := Precio.Value;
                                                CarteraArticulosFields.Ecotasa.Value := PuntoVerde.Value;
                                                CarteraArticulosFields.Descuento.Value := Descuento.Value;
                                                CarteraArticulosFields.NroCajas.Value := NroCajas.Value;
                                                CarteraArticulosFields.Recargo.Value := Recargo.Value;

                                                // Estoy calculado los valores medios. La media de los precios es la de los valores habituales, no el precio medio ponderado

                                                CarteraArticulosFields.Cantidad2.Value := ( CarteraArticulosFields.Cantidad.Value - Cantidad.Value  ) / 2;
                                                CarteraArticulosFields.Precio2.Value := ( CarteraArticulosFields.Precio.Value + Precio.Value ) / 2;
                                                //.. La ecotasa no se promedia
                                                CarteraArticulosFields.Descuento2.Value := ( CarteraArticulosFields.Descuento.Value + Descuento.Value ) / 2;
                                                CarteraArticulosFields.NroCajas2.Value := ( CarteraArticulosFields.NroCajas.Value + NroCajas.Value ) / 2;
                                                CarteraArticulosFields.Recargo2.Value := ( CarteraArticulosFields.Recargo.Value + Recargo.Value ) / 2;

                                                If   Fecha.Value>CarteraArticulosFields.Fecha.Value
                                                then CarteraArticulosFields.Fecha.Value := Fecha.Value;

                                                CarteraArticulosTable.Post;
                                                end
                                           else begin

                                                CarteraArticulosTable.Append;

                                                CarteraArticulosFields.CodigoAlmacen.Value := '';  // No se utiliza
                                                CarteraArticulosFields.CodigoArticulo.Value := CodigoArticulo.Value;
                                                CarteraArticulosFields.CodigoClaseA.Value := CodigoClaseA.Value;
                                                CarteraArticulosFields.CodigoClaseB.Value := CodigoClaseB.Value;
                                                CarteraArticulosFields.CodigoClaseC.Value := CodigoClaseC.Value;
                                                CarteraArticulosFields.Descripcion.Value := DsArticuloFields.Descripcion.Value;

                                                CarteraArticulosFields.Cantidad.Value := -Cantidad.Value;
                                                CarteraArticulosFields.Precio.Value := Precio.Value;
                                                CarteraArticulosFields.Ecotasa.Value := PuntoVerde.Value;
                                                CarteraArticulosFields.Descuento.Value := Descuento.Value;
                                                CarteraArticulosFields.NroCajas.Value := NroCajas.Value;
                                                CarteraArticulosFields.Recargo.Value := Recargo.Value;

                                                CarteraArticulosFields.Fecha.Value := Fecha.Value;

                                                CarteraArticulosTable.Post;

                                                Inc( ContadorArticulos );
                                                end;

                                         except
                                           CarteraArticulosTable.Cancel;
                                           raise;
                                           end;

                   Next;
                   end;

                 end;

               Next;
               end;

             end;


           If   ProcesoCancelado
           then Abort;

           EnterpriseDataModule.ExecSQLCommand( SQLFieldsFormat( 'DELETE FROM ConsumosCliente WHERE CodigoCliente=?', [ DmClienteFields.Codigo ] ) );

           With CarteraArticulosTable do
             begin

             Contador := 1;

             case  Ordenacion of
               0 : IndexName := 'Index2';  // Es descendente y, como siempre con NexusDB, no se puede utilizar IndexFieldNames
               1 : IndexFieldNames := 'CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Tipo';
               2 : IndexFieldNames := 'Descripcion';
               end;

             First;
             While not Eof do
               begin

               If   ( CarteraArticulosFields.Cantidad.Value<>0.0 ) and
                    ( CarteraArticulosFields.Cantidad.Value>=CantidadMinima )
               then begin

                    If   Contador=1   // Creo una cabecera que resulta útil en el mantenimiento de consumos habituales
                    then begin
                         DmConsumosClienteTable.Append;
                         DmConsumosClienteFields.CodigoCliente.Value := DmClienteFields.Codigo.Value;
                         DmConsumosClienteFields.NroOrden.Value := 0;
                         DmConsumosClienteTable.Post;
                         end;

                    DmConsumosClienteTable.Append;

                    With DmConsumosClienteFields do
                      begin

                      CodigoCliente.Value := DmClienteFields.Codigo.Value;
                      NroOrden.Value := Contador;
                      CodigoArticulo.Value := CarteraArticulosFields.CodigoArticulo.Value;
                      CodigoClaseA.Value := CarteraArticulosFields.CodigoClaseA.Value;
                      CodigoClaseB.Value := CarteraArticulosFields.CodigoClaseB.Value;
                      CodigoClaseC.Value := CarteraArticulosFields.CodigoClaseC.Value;
                      Fecha.Value := CarteraArticulosFields.Fecha.Value;

                      Cajas.Value := CarteraArticulosFields.NroCajas.Value;
                      Cantidad.Value := CarteraArticulosFields.Cantidad.Value;
                      UltimoPrecio.Value := CarteraArticulosFields.Precio.Value;
                      UltimoDescuento.Value := CarteraArticulosFields.Descuento.Value;
                      UltimoRecargo.Value := CarteraArticulosFields.Recargo.Value;
                      UltimoPuntoVerde.Value := CarteraArticulosFields.Ecotasa.Value;

                      FPrecio := 0.0;
                      FPuntoVerde := 0.0;
                      FRecargo := 0.0;
                      FDescuento := 0.0;
                      EsUnaOferta := False;

                      SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( tmVenta,
                                                                                  DmClienteFields.Codigo.Value,
                                                                                  CarteraArticulosFields.CodigoArticulo.Value,
                                                                                  CarteraArticulosFields.CodigoClaseA.Value,
                                                                                  CarteraArticulosFields.CodigoClaseB.Value,
                                                                                  CarteraArticulosFields.CodigoClaseC.Value,
                                                                                  Cantidad.Value,
                                                                                  FPrecio,
                                                                                  FPuntoVerde,
                                                                                  FRecargo,
                                                                                  FDescuento,
                                                                                  EsUnaOferta,
                                                                                  '',
                                                                                  True,
                                                                                  FechaFinal );



                      PuntoVerde.Value := FPuntoVerde;
                      Recargo.Value := FRecargo;
                      PrecioActual.Value := FPrecio;
                      DescuentoActual.Value := FDescuento;

                      If   UltimoPrecioDefecto
                      then Precio.Value := UltimoPrecio.Value
                      else Precio.Value := PrecioActual.Value;

                      If   UltimoDescuentoDefecto
                      then Descuento.Value := UltimoDescuento.Value
                      else Descuento.Value := DescuentoActual.Value;

                      PrecioMedio.Value := CarteraArticulosFields.Precio2.Value;
                      RecargoMedio.Value := CarteraArticulosFields.Recargo2.Value;
                      DescuentoMedio.Value := CarteraArticulosFields.Descuento2.Value;

                      end;

                    DmConsumosClienteTable.Post;
                    Inc( Contador );
                    end;

               Next;
               end;

             end;

           Next;
           end;

         end;

       TransactionTag.Commit;

     except on e : Exception do
       begin
       TransactionTag.Rollback;
       If   not ProcesoCancelado
       then With SessionDataModule do
              begin
              SendNotification( ntError, ExceptionMessage( E ) );
              SendNotification( ntError, RsMsg1 );
              SendNotification( ntError, RsMsg2 );
              end;
       end;
     end;

  finally
    end;

end;

{ TPreventaService }

procedure TPreventaService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TPreventaService.GeneraConsumos( ClienteInicial, ClienteFinal : String; FechaInicial, FechaFinal : TDate; UltimoPrecioDefecto, UltimoDescuentoDefecto : Boolean; Maximo : SmallInt; CantidadMinima : Decimal; Ordenacion : SmallInt );
begin
     SessionDataModule.Dm30.PreventaModule.GeneraConsumos( ClienteInicial, ClienteFinal, FechaInicial, FechaFinal, UltimoPrecioDefecto, UltimoDescuentoDefecto, Maximo, CantidadMinima, Ordenacion );
end;

var PreventaControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_PreventaService, TPreventaService, PreventaControl );

end.

