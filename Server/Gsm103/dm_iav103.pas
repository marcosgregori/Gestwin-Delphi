
unit dm_iav103;

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

  dmi_iav103;

type

    TImportacionAlbaranesVenta103Service = class( TSessionModule, IImportacionAlbaranesVenta103Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
    end;

  TImportacionAlbaranesVenta103Module = class(TServerDataModule)
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    TiposIVAFields : TTiposIVAFields;

    ParametrosImportacionRec : TParametrosImportacionRec;

  public

    procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
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

     dmi_mov,

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

  RsMsg3  = 'Importación de albaranes externos';
  RsMsg4  = 'La fecha de los movimientos a importar no coincide con el ejercicio activo.';

  RsMsg7  = 'Albaran nº %d.';
  RsMsg8  = 'El albarán %s %d que pretende importar ya existe.';
  RsMsg9  = 'Se cancela el proceso de importación. Debe revisar los datos a importar para evitar duplicidades.';

procedure TImportacionAlbaranesVenta103Module.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm103.ImportacionAlbaranesVenta103Module := nil;
end;

procedure TImportacionAlbaranesVenta103Module.EjecutaProceso( SerieDestino, ContenidoFichero : String );

var   DataList : TStringList;
      DataLine : String;

      NroAlbaranActual,
      NroAlbaranImp : LongInt;
      NroLineaActual : SmallInt;
      FechaImp : TDateTime;
      CodigoClienteImp : String;
      RegistroAuxiliarImp : String;
      CodigoArticuloImp : String;
      DescripcionImp : String;
      CantidadImp : double;

procedure DesglosaLineaEntrada;

// 00000001 01062002 00001 000 A00           I:22/02 16:45 F:22/02 17:55 L:123456,78 1234567,89

begin
     try

       NroAlbaranImp := StrToInt( Copy( DataLine, 1, 8 ) );
       SessionDataModule.StrToDate( Copy( DataLine, 10, 8 ), FechaImp, dfDefault );
       CodigoClienteImp := Copy( DataLine, 19, 5 );
       RegistroAuxiliarImp := Trim( Copy( DataLine, 25, 3 ) );
       CodigoArticuloImp := Trim( Copy( DataLine, 29, 13 ) );
       DescripcionImp := Trim( Copy( DataLine, 43, 40 ) );
       CantidadImp := StrToFloat( Copy( DataLine, 83, 9 ) );

     except on E : Exception do
       begin
       SessionDataModule.SendException( E, Self );
       raise;
       end;
     end;
end;

begin

     With ParametrosImportacionRec do
       begin

       SessionDataModule.SendNotification( ntHeader, RsMsg3 );

       var TransactionTag := SessionDataModule.StartTransactionWith( [ MovimientoTable, LineaMovimientoTable ] );

       try

          SessionDataModule.Dm00.ConfiguracionModule.ObtenParametros( ctParametrosModulo103, SessionDataModule.CodigoEmpresa, TParametrosRec( ParametrosImportacionRec ) );

          NroAlbaranActual := 0;
          NroLineaActual := 1;

          DataList := TStringList.Create;
          DataList.Text := ContenidoFichero;

          For DataLine in DataList do
            If   DataLine<>''
             then begin

                  DesglosaLineaEntrada;

                  If   YearOf( FechaImp )<>SessionDataModule.Ejercicio
                  then begin
                       SessionDataModule.SendNotification( ntError, RsMsg4 );
                       Abort;
                       end;

                  If   NroAlbaranActual<>NroAlbaranImp
                  then begin

                       NroAlbaranActual := NroAlbaranImp;
                       NroLineaActual := 1;

                       If   MovimientoTable.FindKey( [ tmVenta, SessionDataModule.Ejercicio, SerieDestino, NroAlbaranImp ] )
                       then begin
                            SessionDataModule.SendNotification( ntError, Format( RsMsg8, [ SerieDestino, NroAlbaranImp ] ), RsMsg9 );
                            Abort;
                            end;

                       SessionDataModule.Dm10.SerieFacturacionModule.Obten( SerieDestino, SerieFacturacionFields );
                       SessionDataModule.Dm10.ClienteModule.Obten( CodigoClienteImp, '', ClienteFields );

                       With MovimientoFields do
                         begin

                         MovimientoTable.Append;

                         Ejercicio.Value := SessionDataModule.Ejercicio;
                         NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
                         TipoMovimiento.Value := tmVenta;
                         Serie.Value := SerieDestino;
                         NroDocumento.Value := NroAlbaranImp;
                         Fecha.Value := FechaImp;
                         Propietario.AsString := CodigoClienteImp;
                         RegistroAuxiliar.AsString := RegistroAuxiliarImp;

                         SessionDataModule.SendNotification( ntInformation, Format( 'Creado el albarán : %s %8d', [ SerieDestino, NroAlbaranImp ] ) );

                         MovimientoTable.Post;
                         end;

                       end;

                  SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( MovimientoFields );

                  With LineaMovimientoFields do
                    begin

                    LineaMovimientoTable.Append;

                    NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                    Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                    NroLinea.Value := NroLineaActual;
                    Fecha.Value := FechaImp;
                    CodigoArticulo.AsString := CodigoArticuloImp;
                    Descripcion.AsString := DescripcionImp;
                    CodigoAlmacen.Value := SessionDataModule.EmpresaFields.Ventas_AlmacenDefec.Value;
                    Cantidad.Value := -CantidadImp;
                    CantidadAjustada.Value := CantidadImp;

                    SessionDataModule.Dm30.ArticuloModule.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );
                    SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( tmVenta, LineaMovimientoFields, ClienteFields, ArticuloFields );
                    SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, MovimientoFields.IVAIncluido.Value );

                    SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                    LineaMovimientoTable.Post;

                    inc( NroLineaActual );
                    end;

                  SessionDataModule.SendNotification( ntRecord, Format( RsMsg7, [ NroAlbaranImp ] ) );
                  end;

          TransactionTag.Commit;

       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendException( E, Self );
         SessionDataModule.SendNotification( ntError, RsMsg1 );
         SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
         end;
       end;

     end;

end;

procedure TImportacionAlbaranesVenta103Module.ServerDataModuleCreate(Sender: TObject);
begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );

end;

{ TImportacionAlbaranesVenta103Service }

procedure TImportacionAlbaranesVenta103Service.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TImportacionAlbaranesVenta103Service.EjecutaProceso( SerieDestino, ContenidoFichero : String );
begin
     SessionDataModule.Dm103.ImportacionAlbaranesVenta103Module.EjecutaProceso( SerieDestino, ContenidoFichero );
end;

var ImportacionAlbaranesVenta103Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_ImportacionAlbaranesVenta103Service, TImportacionAlbaranesVenta103Service, ImportacionAlbaranesVenta103Control );

end.
