unit dm_vpe;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  LibUtils,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,

  dmi_vpe;

type

  TVentasPeriodicasService = class( TSessionModule, IVentasPeriodicasService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure GeneraVentasPeriodicas( Tipo : SmallInt; Serie, CodigoClienteInicial, CodigoClienteFinal : String; Fecha : TDate );
    end;

  TVentasPeriodicasModule = class(TServerDataModule)
    DmLineaVentaPeriodicaTable: TnxeTable;
    DmVentaPeriodicaTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private
    DmVentaPeriodicaFields : TVentaPeriodicaFields;
    DmLineaVentaPeriodicaFields : TLineaVentaPeriodicaFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DsClienteFields : TClienteFields;
    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsArticuloFields : TArticuloFields;
    DsTiposIVAFields : TTiposIVAFields;

  public

    procedure GeneraVentasPeriodicas( Tipo : SmallInt; Serie, CodigoClienteInicial, CodigoClienteFinal : String; Fecha : TDate );
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxdbBase,
     nxllBde,
     nxrdClass,
     nxrbTypes,

     AppManager,
     SessionData,
     EnterpriseData,

     dmi_mov,

     f_sec,

     dm_sdf,
     dm_mov,
     dm_art;

{$R *.DFM}

var    VentasPeriodicasControl : InxClassFactoryControl;

resourceString
    RsMsg2 = 'Generado el albarán %s %d del cliente %s. Ficha nº %d.';
    RsMsg3 = 'El cliente %s consta como obsoleto en su ficha. No se ha generado el albarán de venta correspondiente.';
    RsMsg4 = 'No se ha generado ningún albarán.';

procedure TVentasPeriodicasModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmVentaPeriodicaFields := TVentaPeriodicaFields.Create( DmVentaPeriodicaTable );
     DmLineaVentaPeriodicaFields := TLineaVentaPeriodicaFields.Create(DmLineaVentaPeriodicaTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );

     DsClienteFields := TClienteFields.Create( Self );
     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
end;

procedure TVentasPeriodicasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.VentasPeriodicasModule := nil
end;

procedure TVentasPeriodicasModule.GeneraVentasPeriodicas( Tipo                   : SmallInt;
                                                          Serie,
                                                          CodigoClienteInicial,
                                                          CodigoClienteFinal     : String;
                                                          Fecha                  : TDate );

type  TMesesPago = set of Byte;

var   Generar : Boolean;
      MesesPago : TMesesPago;
      EjercicioUltimaAplicacion,
      EjercicioActual : Word;
      MesUltimaAplicacion,
      MesActual : Byte;
      AlbaranCreado : Boolean;

function GeneraMesesPago( MesInicial, Periodicidad : Byte ) : TMesesPago;

var  Periodos,
     MesPago : Byte;

begin
     Result := [];
     If   MesInicial=0
     then MesInicial := SessionDataModule.NroMesInicial;
     If   MesInicial in [ 1..12 ]
     then begin
          Periodos := 12 div Periodicidad;
          MesPago := MesInicial;
          While Periodos>0 do
            begin
            Result := Result + [ MesPago ];
            Inc( MesPago, Periodicidad );
            If   MesPago>12
            then MesPago := MesPago - 12;
            Dec( Periodos );
            end;
          end;
end;

begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmLineaMovimientoTable, DmLineaVentaPeriodicaTable ] );

     try


      With DmVentaPeriodicaTable do
        try

          SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie, DsSerieFacturacionFields );

          AlbaranCreado := False;

          SetRange( [ Serie, CodigoClienteInicial ], [ Serie, CodigoClienteFinal ] );
          First;
          While not eof do
            begin

            If   not DmVentaPeriodicaFields.NoAplicar.Value and
                 ( ( Serie='' ) or ( DmVentaPeriodicaFields.Serie.Value=Serie ) )  and
                 ( ( Tipo=0 ) or ( DmVentaPeriodicaFields.Tipo.Value=Tipo ) )
            then begin

                 MesActual := MonthOf( Fecha );
                 EjercicioActual := YearOf( Fecha );
                 MesUltimaAplicacion := 0;
                 EjercicioUltimaAplicacion := 0;

                 If   not ValueIsEmpty( DmVentaPeriodicaFields.UltimaAplicacion.Value )
                 then begin
                      MesUltimaAplicacion := MonthOf( DmVentaPeriodicaFields.UltimaAplicacion.Value );
                      EjercicioUltimaAplicacion := YearOf( DmVentaPeriodicaFields.UltimaAplicacion.Value );
                      end;

                 Generar := False;
                 case DmVentaPeriodicaFields.Periodicidad.Value of
                   0 : MesesPago := GeneraMesesPago( DmVentaPeriodicaFields.MesPago.Value, 12 );
                   1 : MesesPago := GeneraMesesPago( DmVentaPeriodicaFields.MesPago.Value,  6 );
                   2 : MesesPago := GeneraMesesPago( DmVentaPeriodicaFields.MesPago.Value,  4 );
                   3 : MesesPago := GeneraMesesPago( DmVentaPeriodicaFields.MesPago.Value,  3 );
                   4 : MesesPago := GeneraMesesPago( DmVentaPeriodicaFields.MesPago.Value,  2 );
                   5 : MesesPago := GeneraMesesPago( DmVentaPeriodicaFields.MesPago.Value,  1 );
                   end;

                 Generar := ( MesActual in MesesPago ) and
                            ( ( EjercicioActual>EjercicioUltimaAplicacion ) or
                              ( ( EjercicioActual=EjercicioUltimaAplicacion ) and ( MesActual>MesUltimaAplicacion ) ) );

                 SessionDataModule.Dm10.ClienteModule.Obten( DmVentaPeriodicaFields.CodigoCliente.Value, '', DsClienteFields );

                 If   Generar
                 then If   DsClienteFields.Obsoleto.Value
                      then SessionDataModule.SendNotification( ntWarning, Format( RsMsg3, [ DmVentaPeriodicaFields.CodigoCliente.Value ] ) )
                      else begin

                           DmMovimientoTable.Append;

                           DmMovimientoFields.TipoMovimiento.Value := tmVenta;
                           DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                           DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
                           DmMovimientoFields.Serie.Value := Serie;
                           DmMovimientoFields.CentroCoste.Value := DmVentaPeriodicaFields.CentroCoste.Value;
                           DmMovimientoFields.RegistroAuxiliar.Value := DmVentaPeriodicaFields.RegistroAuxiliar.Value;
                           DmMovimientoFields.NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( DmMovimientoFields );
                           DmMovimientoFields.Fecha.Value := Fecha;
                           DmMovimientoFields.Propietario.Value := DmVentaPeriodicaFields.CodigoCliente.Value;
                           DmMovimientoFields.CodigoVendedor.Value := DsClienteFields.Vendedor.Value;
                           DmMovimientoFields.CodigoFormaCobro.Value := DsClienteFields.Cobro_FormaCobro.Value;
                           DmMovimientoFields.GrupoFacturacion.Value := DsClienteFields.Factura_Agrupacion.Value;
                           DmMovimientoFields.Anotacion.Value := DmVentaPeriodicaFields.Anotacion.Value;
                           DmMovimientoFields.Origen.Value := omVentaPeriodica;
                           DmMovimientoFields.TipoVentaPeriodica.Value := Tipo;

                           SessionDataModule.SendNotification( ntInformation, Format( RsMsg2, [ DmMovimientoFields.Serie.Value,
                                                                                                DmMovimientoFields.NroDocumento.Value,
                                                                                                DmVentaPeriodicaFields.CodigoCliente.Value,
                                                                                                DmVentaPeriodicaFields.NroFicha.Value ] ) );

                           SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( DmMovimientoFields );

                           With DmLineaVentaPeriodicaTable do
                             try

                               With DmVentaPeriodicaFields do
                                 SetRange( [ NroFicha.Value, 0 ], [ NroFicha.Value, MaxSmallInt ] );

                               First;
                               While not eof do
                                 begin

                                 With DmLineaMovimientoFields do
                                   begin

                                   DmLineaMovimientoTable.Append;

                                   Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                                   NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                                   Fecha.Value := DmMovimientoFields.Fecha.Value;
                                   NroPagina.Value := 0;
                                   NroLinea.Value := DmLineaVentaPeriodicaFields.NroRegistro.Value;
                                   CodigoArticulo.Value := DmLineaVentaPeriodicaFields.CodigoArticulo.Value;
                                   UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;
                                   CodigoClaseA.Value := DmLineaVentaPeriodicaFields.CodigoClaseA.Value;
                                   CodigoClaseB.Value := DmLineaVentaPeriodicaFields.CodigoClaseB.Value;
                                   CodigoClaseC.Value := DmLineaVentaPeriodicaFields.CodigoClaseC.Value;
                                   NumeroSerie.Value := DmLineaVentaPeriodicaFields.NumeroSerie.Value;
                                   Descripcion.Value := DmLineaVentaPeriodicaFields.Descripcion.Value;
                                   Cantidad.Value := -DmLineaVentaPeriodicaFields.Cantidad.Value;
                                   CantidadAjustada.Value := DmLineaVentaPeriodicaFields.Cantidad.Value;

                                   SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, DsArticuloFields );

                                   If   DmLineaVentaPeriodicaFields.Precio.Value=0.0
                                   then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( tmVenta, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields )
                                   else begin
                                        Precio.Value := DmLineaVentaPeriodicaFields.Precio.Value;
                                        Descuento.Value := DmLineaVentaPeriodicaFields.Descuento.Value;
                                        end;

                                   SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                                  DsClienteFields,
                                                                                                  DsArticuloFields,
                                                                                                  DsSerieFacturacionFields,
                                                                                                  DsTiposIVAFields,
																								                                                                          DmMovimientoFields.IVAIncluido.Value );

                                   Anotacion.Value := DmLineaVentaPeriodicaFields.Anotacion.Value;

                                   SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );

                                   DmLineaMovimientoTable.Post;
                                   end;

                                 Next;
                                 end;

                             finally
                               CancelRange;
                               end;

                           DmMovimientoTable.Post;

                           AlbaranCreado := True;

                           SessionDataModule.Dm30.MovimientoModule.RetiraDocumento( DmMovimientoFields, False );

                           try
                             Edit;
                             DmVentaPeriodicaFields.UltimaAplicacion.Value := Fecha;
                             Post;
                           except
                             Cancel;
                             raise;
                             end;

                           end;

                 end;

            Next;
            end;


          If   not AlbaranCreado
          then SessionDataModule.SendNotification( ntStop, RsMsg4 );

        finally
          CancelRange;
          end;

      TransactionTag.Commit;

      except on E : Exception do
        begin
        TransactionTag.Rollback;
        SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
        end;
      end;


end;

{ TVentasPeriodicasService }

procedure TVentasPeriodicasService.GeneraVentasPeriodicas( Tipo                   : SmallInt;
                                                           Serie,
                                                           CodigoClienteInicial,
                                                           CodigoClienteFinal     : String;
                                                           Fecha                  : TDate );
begin
    SessionDataModule.Dm30.VentasPeriodicasModule.GeneraVentasPeriodicas( Tipo, Serie, CodigoClienteInicial, CodigoClienteFinal, Fecha );
end;

procedure TVentasPeriodicasService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

initialization
   TnxClassFactory.RegisterClass( CLSID_VentasPeriodicasService, TVentasPeriodicasService, VentasPeriodicasControl );


end.
