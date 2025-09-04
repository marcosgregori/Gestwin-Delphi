
unit dm_ccf;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,
  LibUtils,
  SessionIntf,

  Spring,

  Gim10Fields,
  Gim30Fields,
  Gim40Fields,
  Gim70Fields,

  dmi_ccf;

type

   TCierreCicloFabricacionService = class( TSessionModule, ICierreCicloFabricacionService )
     protected

     procedure AssignSession( const SessionID : Integer ); override;

     procedure Realizar( FechaInicial, FechaFinal : TDate; ProcesarAltasPorFabricacion, GenerarAlbaranesDeSalida : Boolean );
     end;

   TReasignacionNroRegistroEvent = procedure( NroRegistroAnterior, NroRegistroActual : LongWord ) of object;

   TCierreCicloFabricacionModule = class(TServerDataModule)
    DmOperacionTable: TnxeTable;
    DmOrdenFabricacionTable: TnxeTable;
    DmDefectoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaOFOperacionTable: TnxeTable;
    DmInformeFabricacionTable: TnxeTable;
    DmInformeFabricacionPrevTable: TnxeTable;
    DmDefectoInformeFabricacionTable: TnxeTable;
    DmMovimientoOrigenTable: TnxeTable;
    DmHojaCargaTable: TnxeTable;
    DmLineaHojaCargaTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmLineaMovimientoOrigenTable: TnxeTable;
    DmLineaOFComponenteTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    DmMovimientoFields,
    DmMovimientoOrigenFields : TMovimientoFields;
    DmLineaMovimientoFields,
    DmLineaMovimientoOrigenFields : TLineaMovimientoFields;
    DmOrdenFabricacionFields : TOrdenFabricacionFields;
    DmHojaCargaFields : THojaCargaFields;
    DmLineaHojaCargaFields : TLineaHojaCargaFields;
    DmLineaOFComponenteFields : TLineaOFComponenteFields;
    DmLineaOFOperacionFields : TLineaOFOperacionFields;
    DmOperacionFields : TOperacionFields;
    DmDefectoFields : TDefectoFields;
    DmInformeFabricacionFields : TInformeFabricacionFields;
    DmDefectoInformeFabricacionFields : TDefectoInformeFabricacionFields;

    DsArticuloFields : TArticuloFields;
    DsClienteFields : TClienteFields;

    UnidadesConsumidas : Decimal;
    NroProcesoActual,
    NroRegistroActual : SmallInt;
    ClienteActual : String;

  public
    procedure Realizar( FechaInicial, FechaFinal : TDate; ProcesarAltasPorFabricacion, GenerarAlbaranesDeSalida : Boolean );
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     nxllTypes,
     DateUtils,

     nxrdClass,
     nxrbTypes,

     dmi_cpr,
     dmi_odf,
     dmi_sto,
     dmi_mov,

     AppManager,
     EnterpriseData,
     SessionData;

{$R *.DFM}

resourceString
     RsMsg1   = 'Orden de fabricación nº %d.';
     RsMsg2   = 'Hoja de carga nº %d';
     RsMsg3   = 'El proceso de cierre ha finalizado satisfactoriamente.';
     RsMsg4   = 'El proceso de cierre ha sido cancelado.';
     RsMsg5   = 'Todos los cambios que se hayan producido antes de la aparición del error han sido CANCELADOS. Sus ficheros están en el mismo estado que antes de intentar realizar el proceso.';
     RsMsg6   = 'Se ha creado el movimiento de almacén de fabricación nº %d.';
     RsMsg7   = 'La hoja de carga nº %d ha generado el movimiento de almacén nº %d, documento (albarán de venta) : %s %d.';
     RsMsg8   = 'Se ha creado el movimiento de almacén de producto defectuoso nº %d.';
     RsMsg9   = 'Se ha creado el movimiento de ajuste de componentes dispuestos para fabricación nº %d.';
     RsMsg10  = 'Se ha creado el movimiento de almacén de producto extraido o incorporado nº %d.';
     RsMsg11  = 'La fecha del sistema no coincide con la del Ejercicio activo.';
     RsMsg12  = 'Ajuste la fecha o cambie de Ejercicio de trabajo antes de realizar el cierre.';

procedure TCierreCicloFabricacionModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoOrigenFields := TMovimientoFields.Create( DmMovimientoOrigenTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoOrigenFields := TLineaMovimientoFields.Create( DmLineaMovimientoOrigenTable );
     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
     DmHojaCargaFields := THojaCargaFields.Create( DmHojaCargaTable );
     DmLineaHojaCargaFields := TLineaHojaCargaFields.Create( DmLineaHojaCargaTable );
     DmLineaOFComponenteFields := TLineaOFComponenteFields.Create( DmLineaOFComponenteTable );
     DmLineaOFOperacionFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionTable );
     DmOperacionFields := TOperacionFields.Create( DmOperacionTable );
     DmDefectoFields := TDefectoFields.Create( DmDefectoTable );
     DmInformeFabricacionFields := TInformeFabricacionFields.Create( DmInformeFabricacionTable );
     DmDefectoInformeFabricacionFields := TDefectoInformeFabricacionFields.Create( DmDefectoInformeFabricacionTable );

     DsArticuloFields := TArticuloFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );

end;

procedure TCierreCicloFabricacionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.CierreCicloFabricacionModule := nil;
end;

procedure TCierreCicloFabricacionModule.Realizar( FechaInicial,
                                                  FechaFinal           : TDate;
                                                  ProcesarAltasPorFabricacion,
                                                  GenerarAlbaranesDeSalida    : Boolean );

var  ExistenciasContenedor : IExistenciasContenedor;
     ExistenciasArticulo : IExistenciasArticulo;

procedure AltasPorFabricacion;

procedure ProcesaLineasOrden;

var  AlmacenProdAcabado  : String;

begin

     DmMovimientoTable.Append;

     DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
     DmMovimientoFields.TipoMovimiento.Value:= tmFabricacion;
     DmMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
     DmMovimientoFields.NroDocumento.Value  := DmOrdenFabricacionFields.NroOrden.Value;
     DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg1, [ DmOrdenFabricacionFields.NroOrden.Value ] );
     DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

     DmMovimientoTable.Post;

     SessionDataModule.SendNotification( ntInformation, Format( RsMsg6, [ DmMovimientoFields.NroOperacion.Value ] ) );

     DmOrdenFabricacionTable.Edit;
     DmOrdenFabricacionFields.mFabricacion.Value := DmMovimientoFields.NroOperacion.Value;

     AlmacenProdAcabado := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AlmacenProdAcabado;
     try
       DmLineaOFOperacionTable.SetRange( [ DmOrdenFabricacionFields.Ejercicio.Value, moOrden, DmOrdenFabricacionFields.NroOrden.Value ] );
       DmLineaOFOperacionTable.Last;
       If   not DmLineaOFOperacionTable.Bof  // Found?
       then If   DmOperacionTable.FindKey( [ DmLineaOFOperacionFields.CodigoOperacion.Value ] )
            then If   DmOperacionFields.AlmacenProdAcabado.Value<>''
                 then AlmacenProdAcabado := DmOperacionFields.AlmacenProdAcabado.Value;
     finally
       DmLineaOFOperacionTable.CancelRange;
       end;

     try

       DmLineaMovimientoTable.Append;

       DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
       DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
       DmLineaMovimientoFields.NroLinea.Value := 1;
       DmLineaMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
       DmLineaMovimientoFields.CodigoArticulo.Value := DmOrdenFabricacionFields.CodigoArticulo.Value;
       If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 1 )
       then DmLineaMovimientoFields.CodigoClaseA.Value := DmOrdenFabricacionFields.CodigoClaseA.Value;
       If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 2 )
       then DmLineaMovimientoFields.CodigoClaseB.Value := DmOrdenFabricacionFields.CodigoClaseB.Value;
       If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 3 )
       then DmLineaMovimientoFields.CodigoClaseC.Value := DmOrdenFabricacionFields.CodigoClaseC.Value;
       DmLineaMovimientoFields.LoteFabricacion.Value := DmOrdenFabricacionFields.Lote.Value;
       DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
       DmLineaMovimientoFields.CodigoAlmacen.Value := AlmacenProdAcabado;
       DmLineaMovimientoFields.Cantidad.Value := SessionDataModule.Dm70.ContenedorModule.UnidadesCorrectas( DmOrdenFabricacionFields.EjercicioLanzamiento.Value, DmOrdenFabricacionFields.NroOrden.Value );

       {  0 = Coste neto calculado por la aplicación
          1 = Coste neto + Incremento porcentual fijo
          2 = Precio de compra de la ficha  }

       If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.MetodoCalculoCoste in [ 0..1 ]
       then DmLineaMovimientoFields.Precio.Value := SessionDataModule.Dm70.InformeFabricacionModule.CalculaCosteArticulo( DmOrdenFabricacionFields );

       case SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.MetodoCalculoCoste of
         0 : ;
         1 : DmLineaMovimientoFields.Precio.Value := DmLineaMovimientoFields.Precio.Value + ( ( DmLineaMovimientoFields.Precio.Value * SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.IncrementoPorcentualCoste ) / 100.0 );
         2 : SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, nil, DsArticuloFields ); // DmLineaMovimientoFields.Precio.Value := DsArticuloFields.Precio_Compra.Value
         end;

       DmLineaMovimientoFields.Precio.Value := Redondea( DmLineaMovimientoFields.Precio.Value, SessionDataModule.EmpresaFields.Compras_DecPrecio.Value );

       SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

       SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, False );

       DmLineaMovimientoTable.Post;

     except
       DmLineaMovimientoTable.Cancel;
       raise;
       end;

end;

procedure ProcesaProductoDefectuoso;

var   NroRegistroActual : SmallInt;

procedure ProcesaInformes;

procedure InsertaLinea( UnaCantidad : Decimal );
begin

     DmLineaMovimientoTable.Append;

     DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
     DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
     DmLineaMovimientoFields.NroLinea.Value := NroRegistroActual;
     DmLineaMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
     DmLineaMovimientoFields.CodigoArticulo.Value := DmOrdenFabricacionFields.CodigoArticulo.Value;
     If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 1 )
     then If   DmDefectoFields.CodigoClaseA.Value<>''
          then DmLineaMovimientoFields.CodigoClaseA.Value := DmDefectoFields.CodigoClaseA.Value
          else DmLineaMovimientoFields.CodigoClaseA.Value := DmOrdenFabricacionFields.CodigoClaseA.Value;
     If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 2 )
     then If   DmDefectoFields.CodigoClaseB.Value<>''
          then DmLineaMovimientoFields.CodigoClaseB.Value := DmDefectoFields.CodigoClaseB.Value
          else DmLineaMovimientoFields.CodigoClaseB.Value := DmOrdenFabricacionFields.CodigoClaseB.Value;
     If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 3 )
     then If   DmDefectoFields.CodigoClaseC.Value<>''
          then DmLineaMovimientoFields.CodigoClaseC.Value := DmDefectoFields.CodigoClaseC.Value
          else DmLineaMovimientoFields.CodigoClaseC.Value := DmOrdenFabricacionFields.CodigoClaseC.Value;
     DmLineaMovimientoFields.LoteFabricacion.Value := DmOrdenFabricacionFields.Lote.Value;
     DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
     DmLineaMovimientoFields.CodigoAlmacen.Value := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AlmacenProdDefectuoso;
     DmLineaMovimientoFields.Cantidad.Value := UnaCantidad;

     SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

     Inc( NroRegistroActual );

     SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, False );

     DmLineaMovimientoTable.Post;
end;

begin

     With DmInformeFabricacionTable do
       begin

       SetRange( [ DmOrdenFabricacionFields.EjercicioLanzamiento.Value, DmOrdenFabricacionFields.NroOrden.Value,1, LowestDateTime, 0 ],
                 [ DmOrdenFabricacionFields.EjercicioLanzamiento.Value, DmOrdenFabricacionFields.NroOrden.Value, MaxSmallInt, HighestDateTime, MaxSmallInt ] );
       First;

       While not Eof do
         begin

         If   DmInformeFabricacionFields.Defectuosas.Value<>0.0
         then begin

              With DmDefectoInformeFabricacionTable do
                begin

                With DmInformeFabricacionFields do
                  SetRange( [ Ejercicio.Value, NroOrden.Value, nroProceso.Value, Fecha.Value, Turno.Value, 0 ],
                            [ Ejercicio.Value, NroOrden.Value, NroProceso.Value, Fecha.Value, Turno.Value, MaxSmallInt ] );

                First;

                If   not Eof
                then While not Eof do
                       begin
                       If   DmDefectoTable.FindKey( [ DmDefectoInformeFabricacionFields.CodigoDefecto.Value ] )
                       then InsertaLinea( DmDefectoInformeFabricacionFields.Unidades.Value );
                       Next;
                       end
                else If   DmDefectoTable.FindKey( [ DmInformeFabricacionFields.CodigoDefecto.Value ] )
                     then InsertaLinea( DmInformeFabricacionFields.Defectuosas.Value );

                end;

              end;

         Next;
         end;

       end;

end;

begin
     If   SessionDataModule.Dm70.ContenedorModule.UnidadesDefectuosas( DmOrdenFabricacionFields.EjercicioLanzamiento.Value, DmOrdenFabricacionFields.NroOrden.Value )<>0.0
     then begin

          DmMovimientoTable.Append;

          DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmMovimientoFields.TipoMovimiento.Value := tmFabricacionDefectuosa;
          DmMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
          DmMovimientoFields.NroDocumento.Value := DmOrdenFabricacionFields.NroOrden.Value;
          DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg1, [ DmOrdenFabricacionFields.NroOrden.Value ] );
          DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

          DmMovimientoTable.Post;

          SessionDataModule.SendNotification( ntInformation, Format( RsMsg8, [ DmMovimientoFields.NroOperacion.Value ] ) );

          DmOrdenFabricacionFields.mFabricDefectuosa.Value := DmMovimientoFields.NroOperacion.Value;

          NroRegistroActual := 1;

          ProcesaInformes;

          end;
end;

// Producto incorporado y extraído

procedure ProcesaProductoIncorporadoExtraido;

var   NroRegistroActual : SmallInt;

procedure ProcesaInformes;
begin
     With DmInformeFabricacionTable do
       begin

       DmInformeFabricacionTable.Append;

       With DmOrdenFabricacionFields do
         SetRange( [ EjercicioLanzamiento.Value, NroOrden.Value, 1, LowestDateTime, 0 ],
                   [ EjercicioLanzamiento.Value, NroOrden.Value, MaxSmallInt, HighestDateTime, MaxSmallInt ] );

       First;

       While not Eof do
         begin

         If   DmInformeFabricacionFields.IncorpExtraidas.Value<>0.0
         then begin

              DmLineaMovimientoTable.Append;

              DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
              DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
              DmLineaMovimientoFields.NroLinea.Value := NroRegistroActual;
              DmLineaMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
              DmLineaMovimientoFields.CodigoArticulo.Value := DmOrdenFabricacionFields.CodigoArticulo.Value;

              If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 1 )
              then If   DmInformeFabricacionFields.IncExtClaseA.Value<>''
                   then DmLineaMovimientoFields.CodigoClaseA.Value := DmInformeFabricacionFields.IncExtClaseA.Value
                   else DmLineaMovimientoFields.CodigoClaseA.Value := DmOrdenFabricacionFields.CodigoClaseA.Value;

              If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 2 )
              then If   DmInformeFabricacionFields.IncExtClaseB.Value<>'' // De momento no se puede introducir en el informe
                   then DmLineaMovimientoFields.codigoClaseB.Value := DmInformeFabricacionFields.IncExtClaseB.Value
                   else DmLineaMovimientoFields.CodigoClaseB.Value := DmOrdenFabricacionFields.CodigoClaseB.Value;

              If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 3 )
              then If   DmInformeFabricacionFields.IncExtClaseC.Value<>'' // De momento no se puede introducir en el informe
                   then DmLineaMovimientoFields.CodigoClaseC.Value := DmInformeFabricacionFields.IncExtClaseC.Value
                   else DmLineaMovimientoFields.CodigoClaseC.Value := DmOrdenFabricacionFields.CodigoClaseC.Value;

              DmLineaMovimientoFields.LoteFabricacion.Value := DmOrdenFabricacionFields.Lote.Value;
              DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
              DmLineaMovimientoFields.CodigoAlmacen.Value := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AlmacenExtracciones;
              DmLineaMovimientoFields.Cantidad.Value := -DmInformeFabricacionFields.IncorpExtraidas.Value;

              SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

              SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, false );

              DmLineaMovimientoTable.Post;

              Inc( NroRegistroActual );

              end;

         Next;
         end;

       end;

end;

begin

     // Puesto que las cantidades extraidas e incorporadas no se registran como tales en los contenedores habrá
     // que comprobar siempre si las hay en los informes

     try

       DmMovimientoTable.Append;

       DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       DmMovimientoFields.TipoMovimiento.Value := tmFabricacion;
       DmMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
       DmMovimientoFields.NroDocumento.Value := DmOrdenFabricacionFields.NroOrden.Value;
       DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg1, [ DmOrdenFabricacionFields.NroOrden.Value ] );
       DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

       DmMovimientoTable.Post;

       DmOrdenFabricacionFields.mExtraidoIncorporado.Value := DmMovimientoFields.NroOperacion.Value;

       NroRegistroActual := 1;

       ProcesaInformes;

       If   NroRegistroActual=1
       then DmMovimientoTable.Delete
       else SessionDataModule.SendNotification( ntInformation, Format( RsMsg10, [ DmMovimientoFields.NroOperacion.Value ] ) );

     finally
       DmMovimientoTable.Cancel;
       end;

end;

procedure ProcesaComponentes;
begin

     NroRegistroActual := 1;
     NroProcesoActual  := 0;

     With DmLineaOFComponenteTable do
       begin

       SetRange( [ DmOrdenFabricacionFields.Ejercicio.Value, moOrden, DmOrdenFabricacionFields.NroOrden.Value, 1, 1 ],
                 [ DmOrdenFabricacionFields.Ejercicio.Value, moOrden, DmOrdenFabricacionFields.NroOrden.Value, MaxSmallInt, MaxSmallInt ] );

       First;
       While not Eof do
         begin

         If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AjusteAutomaticoConsumos
         then begin
              ExistenciasContenedor := SessionDataModule.Dm70.ContenedorModule.ContenidoProceso( DmOrdenFabricacionFields.Ejercicio.Value, DmOrdenFabricacionFields.NroOrden.Value, DmLineaOFComponenteFields.NroProceso.Value, cnProductoRealizado );
              UnidadesConsumidas := ExistenciasContenedor.Entradas;
              try
                Edit;
                DmLineaOFComponenteFields.ConsumoReal.Value := DmLineaOFComponenteFields.Cantidad.Value * UnidadesConsumidas;
                Post;
              except
                Cancel;
                raise;
                end;
			  end;	

         If   NroRegistroActual=1
         then begin

              // TipoMovimiento;Ejercicio;Serie;NroDocumento

              If   DmMovimientoTable.FindKey( [ tmDispFabricacion, SessionDataModule.Ejercicio, '', DmOrdenFabricacionFields.NroOrden.Value ] )
              then SessionDataModule.Dm30.MovimientoModule.SuprimeLineasMovimiento( DmMovimientoFields )
              else begin
                   DmMovimientoTable.Append;

                   DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                   DmMovimientoFields.TipoMovimiento.Value := tmDispFabricacion;
                   DmMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
                   DmMovimientoFields.NroDocumento.Value := DmOrdenFabricacionFields.NroOrden.Value;
                   DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg1, [ DmOrdenFabricacionFields.NroOrden.Value ] );
                   DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

                   DmMovimientoTable.Post;

                   DmOrdenFabricacionFields.mDispFabricacion1.Value := DmMovimientoFields.NroOperacion.Value;
                   end;

              SessionDataModule.SendNotification( ntInformation, Format( RsMsg9, [ DmMovimientoFields.NroOperacion.Value ] ) );

              end;

         If   DmLineaOFComponenteFields.NroProceso.Value<>NroProcesoActual
         then begin
              NroProcesoActual := DmLineaOFComponenteFields.NroProceso.Value;
              With DmLineaOFComponenteFields do
                If   DmLineaOFOperacionTable.FindKey( [ Ejercicio.Value, moOrden, NroOrden.Value, NroProcesoActual ] )
                then If   DmOperacionTable.FindKey( [ DmLineaOFOperacionFields.CodigoOperacion ] )
                     then If   DmOperacionFields.AlmacenComponentes.Value=''
                          then try
                                 DmOperacionTable.Edit;
                                 DmOperacionFields.AlmacenComponentes.Value := SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AlmacenComponentes;
                                 DmOperacionTable.Post;
                               except
                                 DmOperacionTable.Cancel;
                                 raise;
                                 end;
              end;

         With DmLineaOFComponenteFields do
           ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( CodigoArticulo.Value,
                                                                                        False,
                                                                                        CodigoClaseA.Value,
                                                                                        CodigoClaseB.Value,
                                                                                        CodigoClaseC.Value,
                                                                                        True,
                                                                                        '',
                                                                                        False,
                                                                                        DmOperacionFields.AlmacenComponentes.Value,
                                                                                        True,
                                                                                        '',
                                                                                        True,
                                                                                        SessionDataModule.Ejercicio,
                                                                                        0,
                                                                                        12 );

         DmLineaMovimientoTable.Append;

         DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
         DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
         DmLineaMovimientoFields.NroLinea.Value := NroRegistroActual;
         DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
         DmLineaMovimientoFields.CodigoArticulo.Value := DmLineaOFComponenteFields.CodigoArticulo.Value;
         If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 1 )
         then DmLineaMovimientoFields.CodigoClaseA.Value := DmLineaOFComponenteFields.CodigoClaseA.Value;
         If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 2 )
         then DmLineaMovimientoFields.CodigoClaseB.Value := DmLineaOFComponenteFields.CodigoClaseB.Value;
         If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( 3 )
         then DmLineaMovimientoFields.CodigoClaseC.Value := DmLineaOFComponenteFields.CodigoClaseC.Value;
         DmLineaMovimientoFields.LoteFabricacion.Value := DmLineaOFComponenteFields.Lote.Value;
         DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
         DmLineaMovimientoFields.CodigoAlmacen.Value := DmOperacionFields.AlmacenComponentes.Value;
         DmLineaMovimientoFields.Cantidad.Value := -DmLineaOFComponenteFields.ConsumoReal.Value;

         {
         If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.NoDescontarComponentes
         then DmLineaMovimientoFields.Cantidad.Value := -DmLineaOFComponenteFields.ConsumoReal.Value
         else DmLineaMovimientoFields.Cantidad.Value := DmLineaOFComponenteFields.ConsumoPrevisto.Value - DmLineaOFComponenteFields.ConsumoReal.Value;
         }

         case SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.CosteComponentes of
             1 : DmLineaMovimientoFields.Precio.Value := ExistenciasArticulo.CosteMedio;
             2 : DmLineaMovimientoFields.Precio.Value := ExistenciasArticulo.Coste;  // Mejor valor disponible
            else DmLineaMovimientoFields.Precio.Value := ExistenciasArticulo.CosteUltEntrada;
            end;

         SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

         SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, False );

         DmLineaMovimientoTable.Post;

         Inc( NroRegistroActual );

         Next;
         end;

       end;

end;

begin

     With DmOrdenFabricacionTable do
       begin
       IndexFieldNames := 'FechaLanzamiento;CodigoArticulo';
       SetRange( [ FechaInicial ], [ FechaFinal ] );
       First;
       While not Eof do
         begin
         If   not DmOrdenFabricacionFields.Cerrado.Value
         then If   SessionDataModule.Dm70.OrdenFabricacionModule.Estado( DmOrdenFabricacionFields.Ejercicio.Value,
                                                                         moOrden,
                                                                         DmOrdenFabricacionFields.NroOrden.Value  )=eoFinalizada
              then begin

                   SessionDataModule.SendNotification( ntInformation, Format( RsMsg1, [ DmOrdenFabricacionFields.NroOrden.Value ] ) );

                   ProcesaLineasOrden;

                   If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.AlmacenarProdDefectuosos
                   then ProcesaProductoDefectuoso;

                   If   SessionDataModule.Dm70.ConfiguracionProduccionModule.ParametrosProduccionRec.IncorporarExtraerArticulos
                   then ProcesaProductoIncorporadoExtraido;

                   ProcesaComponentes;   // componentes consumidos en exceso o defecto

                   try
                     Edit;
                     DmOrdenFabricacionFields.Cerrado.Value := True;
                     Post;
                   except
                     Cancel;
                     raise;
                     end;

                   end;

         Next;
         end;

       end;
end;

procedure ProcesaHojaCarga;
begin
     With DmLineaHojaCargaTable do
       begin

       IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';
       ClienteActual := '';

       SetRange( [ DmHojaCargaFields.Ejercicio.Value, DmHojaCargaFields.NroHoja.Value, 1 ],
                 [ DmHojaCargaFields.Ejercicio.Value, DmHojaCargaFields.NroHoja.Value, MaxSmallInt ] );
       First;
       While not Eof do
         begin

         If   DmLineaHojaCargaFields.NroOperacionOrigen.Value<>0
         then begin

              If   DmMovimientoOrigenTable.FindKey( [ DmLineaHojaCargaFields.EjercicioOrigen.Value, DmLineaHojaCargaFields.NroOperacionOrigen.Value ] )
              then begin

                   If   ClienteActual<>DmMovimientoOrigenFields.Propietario.Value
                   then begin

                        DmMovimientoTable.Append;

                        DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                        DmMovimientoFields.TipoMovimiento.Value := tmVenta;
                        DmMovimientoFields.Fecha.Value := DmHojaCargaFields.Fecha.Value;
                        DmMovimientoFields.Serie.Value := SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.SerieAlbaranesSalida;
                        DmMovimientoFields.NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( DmMovimientoFields );
                        DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg2, [ DmHojaCargaFields.NroHoja.Value ] );
                        DmMovimientoFields.Propietario.Value := DmMovimientoOrigenFields.Propietario.Value;
                        DmMovimientoFields.NroOperacion.Value  := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;

                        DmMovimientoTable.Post;

                        SessionDataModule.SendNotification( ntInformation, Format( RsMsg7, [ DmHojaCargaFields.NroHoja.Value, DmMovimientoFields.NroOperacion.Value, DmMovimientoFields.Serie.Value, DmMovimientoFields.NroDocumento.Value ] ) );

                        NroRegistroActual := 1;

                        ClienteActual := DmMovimientoFields.Propietario.Value;

                        SessionDataModule.Dm10.ClienteModule.Obten( ClienteActual, DsClienteFields );
                        end;

                   If   DmLineaMovimientoOrigenTable.FindKey( [ DmLineaHojaCargaFields.NroRegistroOrigen.Value ] )
                   then begin

                        DmLineaMovimientoTable.Append;

                        DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                        DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                        DmLineaMovimientoFields.NroLinea.Value  := NroRegistroActual;
                        DmLineaMovimientoFields.Fecha.Value := DmHojaCargaFields.Fecha.Value;

                        DmLineaMovimientoFields.TipoMovimientoOrigen.Value := tmPedidoVenta;
                        DmLineaMovimientoFields.EjercicioOrigen.Value := DmLineaHojaCargaFields.EjercicioOrigen.Value;
                        DmLineaMovimientoFields.NroOperacionOrigen.Value := DmLineaHojaCargaFields.NroOperacionOrigen.Value;
                        DmLineaMovimientoFields.NroRegistroOrigen.Value := DmLineaHojaCargaFields.NroRegistroOrigen.Value;

                        DmLineaMovimientoFields.CodigoArticulo.Value := DmLineaMovimientoOrigenFields.CodigoArticulo.Value;
                        DmLineaMovimientoFields.CodigoClaseA.Value := DmLineaMovimientoOrigenFields.CodigoClaseA.Value;
                        DmLineaMovimientoFields.CodigoClaseB.Value := DmLineaMovimientoOrigenFields.CodigoClaseB.Value;
                        DmLineaMovimientoFields.CodigoClaseC.Value := DmLineaMovimientoOrigenFields.CodigoClaseC.Value;
                        DmLineaMovimientoFields.LoteFabricacion.Value := DmLineaMovimientoOrigenFields.LoteFabricacion.Value;
                        DmLineaMovimientoFields.Descripcion.Value := SessionDataModule.Dm30.ArticuloModule.Descripcion( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );
                        DmLineaMovimientoFields.CodigoAlmacen.Value := DmLineaMovimientoOrigenFields.CodigoAlmacen.Value;
                        DmLineaMovimientoFields.Cantidad.Value := -DmLineaHojaCargaFields.Cargado.Value;

                        case SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.MetodoCalculoMargen of
                          0 : ;
                          1 : begin
                              With DmLineaMovimientoFields do
                                ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( CodigoArticulo.Value,
                                                                                                             False,
                                                                                                             CodigoClaseA.Value,
                                                                                                             CodigoClaseB.Value,
                                                                                                             CodigoClaseC.Value,
                                                                                                             False,
                                                                                                             LoteFabricacion.Value,
                                                                                                             False,
                                                                                                             CodigoAlmacen.Value,
                                                                                                             True,
                                                                                                             '',
                                                                                                             True,
                                                                                                             SessionDataModule.Ejercicio,
                                                                                                             0,
                                                                                                             12 );
                                DmLineaMovimientoFields.Precio.Value := ExistenciasArticulo.Coste + ( ( ExistenciasArticulo.Coste * SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.MargenPorcentualVenta ) / 100.0 );
                                end;
                          2 : SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value,
                                                                                          DmLineaMovimientoFields,
                                                                                          DsClienteFields,
                                                                                          DsArticuloFields );
                          end;

                        Inc( NroRegistroActual );

                        SessionDataModule.Dm30.MovimientoModule.RegularizaLineaPedido( DmMovimientoFields, DmLineaMovimientoFields, False );

                        SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, False );

                        DmLineaMovimientoTable.Post;
                        end;

                   {
                   Edit;
                   DmLineaHojaCargaFields.nroMovimientoAlmacen := DmMovimientoFields.NroOperacion;
                   Post;
                   }
                   end;


              end;

         Next;
         end;

       end;

end;

procedure AlbaranesDeSalida;
begin

     NroRegistroActual := 1;

     With DmHojaCargaTable do
       begin

       IndexFieldNames := 'Fecha';
       SetRange( [ FechaInicial ], [ FechaFinal ] );
       First;

       While not Eof do
         begin
         If   not DmHojaCargaFields.NoProcesar.Value and
              not DmHojaCargaFields.Procesado.Value
           then begin
                ProcesaHojaCarga;
                try
                  Edit;
                  DmHojaCargaFields.Procesado.Value := True;
                  Post;
                except
                  Cancel;
                  raise;
                  end;
                end;
         Next;
         end;

       end;
end;

begin

     //* 22.06.2000 Antes que nada compruebo si la fecha de cierre es correcta
     //             (por si la fecha por defecto no pertenece al Ejercicio activo)

     If   not SessionDataModule.IsValidYear( SessionDataModule.FechaHoy )
     then begin
          SessionDataModule.SendNotification( ntStop, RsMsg11, RsMsg12 );
          Exit;
          end;

     var TransactionTag := SessionDataModule.StartTransaction;

     try

       If   ProcesarAltasPorFabricacion
       then AltasPorFabricacion;

       If   GenerarAlbaranesDeSalida
       then AlbaranesDeSalida;

       TransactionTag.Commit;

       SessionDataModule.SendNotification( ntInformation, RsMsg3 );

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendException( E, Self );
       SessionDataModule.SendNotification( ntInformation, RsMsg4, RsMsg5 );
       end;
     end;

end;

{ TCierreCicloFabricacionService }

procedure TCierreCicloFabricacionService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TCierreCicloFabricacionService.Realizar( FechaInicial, FechaFinal : TDate; ProcesarAltasPorFabricacion, GenerarAlbaranesDeSalida : Boolean );
begin
     SessionDataModule.Dm70.CierreCicloFabricacionModule.Realizar( FechaInicial, FechaFinal, ProcesarAltasPorFabricacion, GenerarAlbaranesDeSalida );
end;

var CierreCicloFabricacionControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_CierreCicloFabricacionService, TCierreCicloFabricacionService, CierreCicloFabricacionControl );

end.

