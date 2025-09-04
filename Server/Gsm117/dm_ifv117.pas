
unit dm_ifv117;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,
  Gim103Fields,

  dmi_ifv117;

type

    TImportacionFacturasVenta117Service = class( TSessionModule, IImportacionFacturasVenta117Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( ContenidoFichero : String );
    end;

  TImportacionFacturasVenta117Module = class(TServerDataModule)
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    FacturaVentasFields : TFacturaVentasFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    TiposIVAFields : TTiposIVAFields;

    ParametrosImportacionRec : TParametrosImportacionRec;

  public

    procedure EjecutaProceso( ContenidoFichero : String );
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

     Gsm103Dm,

     ParametrosFacturacionIntf,

     dmi_mov,
     dmi_fdv,
     dmi_iva,

     dm_cli,
     dm_mov,
     dm_tma,
     dm_sdf,
     dm_pga,
     dm_art,
     dm_sto,
     dm_fdv;

{$R *.DFM}

resourceString

  RsMsg3  = 'Importación de facturas externas';
  RsMsg4  = 'La fecha de la factura a importar no coincide con el ejercicio activo.';
  RsMsg5  = 'La estructura del fichero no es la adecuada.';
  RsMsg6  = 'Albarán nº %d.';
  RsMsg7  = 'Factura nº %d.';
  RsMsg8  = 'La factura %s %d que pretende importar ya existe.';
  RsMsg9  = 'Se cancela el proceso de importación. Debe revisar los datos a importar para evitar duplicidades.';
  RsMsg10 = 'Proceso cancelado por el usuario.';

procedure TImportacionFacturasVenta117Module.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm117.ImportacionFacturasVenta117Module := nil;
end;

procedure TImportacionFacturasVenta117Module.EjecutaProceso( ContenidoFichero : String );

var   DataList : TStringList;
      DataLine : String;
      ListaParametros : TStringList;

      ParametrosFacturacion : IParametrosFacturacion;

      SerieActual : String;
      NroFacturaActual : LongInt;
      NroLineaActual : Integer;
      Cancelado : Boolean;

      Serie : String;
      NroFactura : LongInt;
      Fecha : TDate;
      CodigoCliente,
      CodigoGrupoCliente,
      CodigoFormaCobro,
      CodigoArticulo,
      Descripcion : String;
      Cantidad : Decimal;
      Precio : Double;
      Descuento : Decimal;
      TipoIVA : SmallInt;
      RegistroAuxiliar,
      CodigoClaseA,
      CodigoClaseB,
      CodigoClaseC,
      CodigoPaisIVA : String;

procedure GeneraFactura;
begin
     If   NroFacturaActual<>0
     then begin
          ParametrosFacturacion.TipoSeleccion := tsDocumento;   // sólo el albaran actual
          ParametrosFacturacion.Serie := MovimientoFields.Serie.Value;
          ParametrosFacturacion.NroDocumento := MovimientoFields.NroDocumento.Value;
          ParametrosFacturacion.FechaFacturacion := MovimientoFields.Fecha.Value;
          ParametrosFacturacion.PrimerNroFactura := NroFacturaActual;

          ParametrosFacturacion := SessionDataModule.Dm30.FacturaVentasModule.GeneraFacturas( ParametrosFacturacion );
          end;
end;

begin

     With ParametrosImportacionRec do
       try

         ListaParametros := TStringList.Create;
         ParametrosFacturacion := TParametrosFacturacion.Create;

         SessionDataModule.SendNotification( ntHeader, RsMsg3 );

         var TransactionTag := SessionDataModule.StartTransactionWith( [ MovimientoTable, LineaMovimientoTable ] );

         try

            SerieActual := '';
            NroFacturaActual := 0;
            NroLineaActual := 1;
            Cancelado := False;

            DataList := TStringList.Create;
            DataList.Text := ContenidoFichero;

            For DataLine in DataList do
              If   DataLine<>''
              then begin

                    CSVExtractParameters( DataLine, ListaParametros );

                    try

                      If   not ( ListaParametros.Count in [ 12, 16 ] )
                      then Abort;

                      Serie := ListaParametros[ 0 ];
                      NroFactura := CSVLongInt( ListaParametros[ 1 ] );
                      Fecha := CSVDate( ListaParametros[ 2 ] );
                      CodigoCliente  := ListaParametros[ 3 ];
                      CodigoGrupoCliente := ListaParametros[ 4 ];
                      CodigoFormaCobro := ListaParametros[ 5 ];
                      CodigoArticulo := ListaParametros[ 6 ];
                      Descripcion := ListaParametros[ 7 ];
                      Cantidad := CSVFloat( ListaParametros[ 8 ] );
                      Precio := CSVFloat( ListaParametros[ 9 ] );
                      Descuento := CSVFloat( ListaParametros[ 10 ] );
                      TipoIVA := CSVInteger( ListaParametros[ 11 ] );

                      If   ListaParametros.Count=16
                      then begin
                           RegistroAuxiliar := ListaParametros[ 12 ];
                           CodigoClaseA := ListaParametros[ 13 ];
                           CodigoClaseB := ListaParametros[ 14 ];
                           CodigoClaseC := ListaParametros[ 15 ];
                           end;

                    except
                      SessionDataModule.SendNotification( ntError, RsMsg5 );
                      raise;
                      end;

                    If   AccountingYear( Fecha, SessionDataModule.NroMesInicial )<>SessionDataModule.Ejercicio
                    then begin
                         SessionDataModule.SendNotification( ntError, RsMsg4 );
                         Abort;
                         end;

                    If   ( SerieActual<>Serie ) or
                         ( NroFacturaActual<>NroFactura )
                    then begin

                         GeneraFactura;

                         // Añado el albarán

                         SerieActual := Serie;
                         NroFacturaActual := NroFactura;
                         NroLineaActual := 1;

                         If   FacturaVentasTable.FindKey( [ SessionDataModule.Ejercicio, Serie, NroFactura ] )
                         then begin
                              SessionDataModule.SendNotification( ntError, Format( RsMsg8, [ Serie, NroFactura ] ), RsMsg9 );
                              Abort;
                              end;

                         SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie, SerieFacturacionFields );
                         SessionDataModule.Dm10.ClienteModule.Obten( CodigoCliente, '', ClienteFields );

                         CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( ClienteFields );

                         // Albarán

                         MovimientoTable.Append;

                         MovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                         MovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
                         MovimientoFields.TipoMovimiento.Value := tmVenta;
                         MovimientoFields.Serie.Value := Serie;
                         MovimientoFields.NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( MovimientoFields );
                         MovimientoFields.Fecha.Value := Fecha;
                         MovimientoFields.Propietario.Value := CodigoCliente;
                         MovimientoFields.GrupoFacturacion.Value := CodigoGrupoCliente;
                         MovimientoFields.CodigoFormaCobro.Value := CodigoFormaCobro;

                         If   ListaParametros.Count=16
                         then MovimientoFields.RegistroAuxiliar.Value := RegistroAuxiliar;

                         MovimientoTable.Post;

                         Cancelado := SessionDataModule.SendNotification( ntRecord, Format( RsMsg6, [ MovimientoFields.NroDocumento.Value ] ) );
                         end;

                    If   Cancelado
                    then Abort;

                    SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( MovimientoFields );

                    SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo, ArticuloFields );
                    SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha, CodigoPaisIVA, TipoIVA, TiposIVAFields );

                    LineaMovimientoTable.Append;

                    LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                    LineaMovimientoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                    LineaMovimientoFields.NroLinea.Value := NroLineaActual;
                    LineaMovimientoFields.Fecha.Value := Fecha;
                    LineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;

                    If   ListaParametros.Count=16
                    then begin
                         LineaMovimientoFields.CodigoClaseA.Value := CodigoClaseA;
                         LineaMovimientoFields.CodigoClaseB.Value := CodigoClaseB;
                         LineaMovimientoFields.CodigoClaseC.Value := CodigoClaseC;
                         end;

                    LineaMovimientoFields.Descripcion.Value := Descripcion;
                    LineaMovimientoFields.CodigoAlmacen.Value := SessionDataModule.Dm30.AlmacenModule.AlmacenPorDefecto( scVentas, ArticuloFields );
                    LineaMovimientoFields.Cantidad.Value := Cantidad;  // La cantidad se pasa en negativo
                    LineaMovimientoFields.CantidadAjustada.Value := -Cantidad;
                    LineaMovimientoFields.Precio.Value := Precio;
                    LineaMovimientoFields.Descuento.Value := Descuento;

                    SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, MovimientoFields.IVAIncluido.Value );

                    SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                    LineaMovimientoTable.Post;

                    Inc( NroLineaActual );

                    end;

              GeneraFactura;

            TransactionTag.Commit;

         except on E : Exception do
           begin
           TransactionTag.Rollback;
           If   Cancelado
           then SessionDataModule.SendNotification( ntWarning, RsMsg10 );
           SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
           end;
         end;

       finally
         ListaParametros.Free;
       end;

end;

procedure TImportacionFacturasVenta117Module.ServerDataModuleCreate(Sender: TObject);
begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );

     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );

end;

{ TImportacionFacturasVenta117Service }

procedure TImportacionFacturasVenta117Service.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TImportacionFacturasVenta117Service.EjecutaProceso( ContenidoFichero : String );
begin
     SessionDataModule.Dm117.ImportacionFacturasVenta117Module.EjecutaProceso( ContenidoFichero );
end;

var ImportacionFacturasVenta117Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_ImportacionFacturasVenta117Service, TImportacionFacturasVenta117Service, ImportacionFacturasVenta117Control );

end.
