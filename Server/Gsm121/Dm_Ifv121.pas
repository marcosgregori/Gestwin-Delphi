
unit dm_ifv121;

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

  dmi_ifv121;

type

    TImportacionFacturas121Service = class( TSessionModule, IImportacionFacturas121Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );
    end;

  TImportacionFacturas121Module = class(TServerDataModule)
    DmApunteTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmFacturaTable: TnxeTable;
    DmEfectoPagarTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    DmAsientoFields : TAsientoFields;
    DmApunteFields : TApunteFields;
    DmFacturaFields : TFacturaFields;
    DmEfectoPagarFields : TEfectoPagarFields;

    DsClienteFields : TClienteFields;
    DsProveedorFields : TProveedorFields;
    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsTiposIVAFields,
    DsTiposIVAComisionesFields : TTiposIVAFields;

  public

    procedure EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );
    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,
     Files,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     Gsm103Dm,

     AsientoIntf,

     dmi_ast,
     dmi_fac,
     dmi_iva,

     dm_cli,
     dm_pro,
     dm_ast,
     dm_pga;

{$R *.DFM}

resourceString
  RsMsg1  = 'No existe la ficha del cliente %s.';
  RsMsg2  = 'No existe ningún tipo de I.V.A. al %d%%.';
  RsMsg3  = 'Importación de facturas externas';
  RsMsg4  = 'La fecha de la factura a importar no coincide con el ejercicio activo.';
  RsMsg5  = 'La estructura del fichero no es la adecuada.';
  RsMsg6  = 'Factura nº %d : asiento nº %d, del cliente %s, %s.';
  RsMsg7  = 'N/Fra. Nº %s %d';
  RsMsg8  = 'La factura nº %s %d que pretende importar, ya existe.';
  RsMsg9  = 'Se cancela el proceso de importación. Debe revisar los datos a importar para evitar duplicidades.';
  RsMsg10 = 'Proceso cancelado por el usuario.';
  RsMsg11 = 'S/Fra. Nº %s';
  RsMsg12 = 'No existe la subcuenta del proveedor %s.';
  RsMsg13 = 'Factura nº %s : asiento nº %d, del proveedor %s, %s.';
  RsMsg14 = 'Pago factura nº ';
  RsMsg15 = 'Se ha creado el asiento nº %d con la recaudación y comisiones diarias.';
  RsMsg16 = 'No existe la ficha del proveedor con subcuenta %s.';

  RsRecaudacionDiaria = 'Recaudación diaria';
  RsComisionDiaria = 'Comisión diaria';
  RsSubcuentaCaja = '570000000';
  RsSubcuentaPendienteProveedores = '400800000';

procedure TImportacionFacturas121Module.ServerDataModuleCreate(Sender: TObject);
begin

     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmFacturaFields := TFacturaFields.Create( DmFacturaTable );
     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );

     DsClienteFields := TClienteFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );
     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsTiposIVAComisionesFields := TTiposIVAFields.Create( Self );
end;

procedure TImportacionFacturas121Module.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm121.ImportacionFacturas121Module := nil;
end;

procedure TImportacionFacturas121Module.EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );

var   DataList : TStringList;
      ListaParametros : TStringList;

      SerieNroFacturaActual : String;
      NroAsientoActual,
      NroAsientoComisiones,
      NroApunteActual : Integer;
      Cancelado : Boolean;

      SerieNroFacturaEmitida,
      SerieNroFacturaRecibida,
      Serie : String;
      NroFactura : LongInt;
      Fecha : TDate;
      CodigoBar,
      NombreBar,
      TipoMaquina : String;
      Importe,
      BaseImponible,
      PorcentajeIVA,
      CuotaIVA,
      BaseImponibleComision,
      PorcentajeIVAComision,
      CuotaIVAComision,
      ImporteComision : Decimal;
      NombreFiscalProveedor,
      CIFProveedor,
      SubcuentaProveedor,
      SubcuentaCompras,
      CuentaIngresos : String;

      CodigoCliente,
      SubcuentaIngresos,
      ConceptoApunte,
      ConceptoApunteComisiones,
      CodigoPaisIVA : String;

      TotalImporte,
      TotalBaseImponible,
      TotalPorcentajeIVA,
      TotalCuotaIVA,

      TotalBaseImponibleComision,
      TotalCuotaIVAComision,
      TotalImporteComision : Decimal;

procedure GeneraAsiento;
begin

     If   SerieNroFacturaActual<>''  // Es el primer registro leído
     then begin

          If   DmAsientoTable.FindKey( [ taFraEmitida, SessionDataModule.Ejercicio, Serie, NroFactura, NroEfectoRegistroFactura ] )
          then begin
               SessionDataModule.SendNotification( ntError, Format( RsMsg8, [ Serie, NroFactura ] ), RsMsg9 );
               Abort;
               end;

          // El asiento de la factura

          DmAsientoTable.Append;

          DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmAsientoFields.NroAsiento.Value := NroAsientoActual;
          DmAsientoFields.Fecha.Value := Fecha;
          DmAsientoFields.TipoAsiento.Value := taFraEmitida;

          DmAsientoFields.FechaDocumento.Value := Fecha;
          DmAsientoFields.Propietario.Value := DsClienteFields.Subcuenta.Value;
          DmAsientoFields.Nombre.Value := DsClienteFields.Nombre.Value;
          DmAsientoFields.Serie.Value := Serie;
          DmAsientoFields.NroFactura.Value := NroFactura;
          DmAsientoFields.NroEfecto.Value := NroEfectoRegistroFactura;
          DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taFraEmitida );
          DmAsientoFields.Origen.Value := ofrSujetoPasivo;

          DmAsientoTable.Post;

          // El primer apunte con el cargo por el importe total de la factura

          DmApunteTable.Append;

          DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmApunteFields.NroAsiento.Value := NroAsientoActual;
          DmApunteFields.NroApunte.Value := 1;
          DmApunteFields.Fecha.Value := Fecha;
          DmApunteFields.Subcuenta.Value := DsClienteFields.Subcuenta.Value;
          DmApunteFields.Concepto.Value := ConceptoApunte;
          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, TotalImporte );
          DmApunteFields.BaseImponible.Value := 0.0;
          DmApunteFields.Tipo.Value := 0;
          DmApunteFields.CuotaIVA.Value := 0.0;
          DmApunteFields.ImporteTotal.Value  := 0.0;

          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taFraEmitida, DmApunteFields );

          DmApunteTable.Post;

          // Creando el registro de la factura con los datos fiscales

          try

            // Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro

            If   DmFacturaTable.FindKey( [ tfFacturaVentas, SessionDataModule.Ejercicio, '', '', NroAsientoActual ] )
            then DmFacturaTable.Edit
            else begin
                 DmFacturaTable.Append;

                 DmFacturaFields.Tipo.Value := tfAsiento;
                 DmFacturaFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                 DmFacturaFields.Propietario.Value := '';
                 DmFacturaFields.SerieFactura.Value := '';
                 DmFacturaFields.NroRegistro.Value := NroAsientoActual;

                 end;

            SessionDataModule.Dm10.FacturaModule.CompletaRegistroFacturaExpedida( DsClienteFields.CodigoProvincia.Value,
                                                                                  DsClienteFields.CodigoPais.Value,
                                                                                  { Rectificativa } DsSerieFacturacionFields.FacturasRectificativas.Value,
                                                                                  { Simplificada } DsClienteFields.NIF.Value='',
                                                                                  { VentasOnline } False,
                                                                                  DmFacturaFields );

            DmFacturaTable.Post;

          except
            DmFacturaTable.Cancel;
            raise;
            end;

          SessionDataModule.Dm10.AsientoModule.CompletaAsientoFactura( DmAsientoFields, ConceptoApunte, tpaActualizacionFactura );

          SessionDataModule.SendNotification( ntRecordInformation,
                                              Format( RsMsg6, [ DmAsientoFields.NroFactura.Value,
                                                                NroAsientoActual,
                                                                DsClienteFields.Codigo.Value,
                                                                DsClienteFields.Nombre.Value ] ) );

          // Factura de comisiones

          If   TotalImporteComision<>0.0
          then begin

               DmAsientoTable.Append;

               DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
               DmAsientoFields.NroAsiento.Value := NroAsientoComisiones;
               DmAsientoFields.Fecha.Value := Fecha;
               DmAsientoFields.TipoAsiento.Value := taFraRecibida;

               DmAsientoFields.FechaDocumento.Value := Fecha;
               DmAsientoFields.Propietario.Value := SubcuentaProveedor;
               DmAsientoFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( SubcuentaProveedor );
               DmAsientoFields.Serie.Value := SerieNroFacturaRecibida;
               DmAsientoFields.NroFactura.Value := 0;
               DmAsientoFields.NroEfecto.Value := NroEfectoRegistroFactura;
               DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taFraRecibida );
               DmAsientoFields.Origen.Value := ofrSujetoPasivo;

               DmAsientoTable.Post;

               // El primer apunte con el cargo por el importe total de la factura

               DmApunteTable.Append;

               DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
               DmApunteFields.NroAsiento.Value := NroAsientoComisiones;
               DmApunteFields.NroApunte.Value := 1;
               DmApunteFields.Fecha.Value := Fecha;
               DmApunteFields.Subcuenta.Value := SubcuentaProveedor;
               DmApunteFields.Concepto.Value := ConceptoApunteComisiones;
               SetSignedValue( DmApunteFields.Haber, DmApunteFields.Debe, TotalImporteComision );
               DmApunteFields.BaseImponible.Value := 0.0;
               DmApunteFields.Tipo.Value := 0;
               DmApunteFields.CuotaIVA.Value := 0.0;
               DmApunteFields.ImporteTotal.Value  := 0.0;

               SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taFraEmitida, DmApunteFields );

               DmApunteTable.Post;

               // Creando el registro de la factura de comisiones con los datos fiscales

               try

                 If   DmFacturaTable.FindKey( [ tfFacturaCompras, SessionDataModule.Ejercicio, '', '', NroAsientoComisiones ] )
                 then DmFacturaTable.Edit
                 else begin
                      DmFacturaTable.Append;

                      DmFacturaFields.Tipo.Value := tfAsiento;
                      DmFacturaFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                      DmFacturaFields.Propietario.Value := '';
                      DmFacturaFields.SerieFactura.Value := '';
                      DmFacturaFields.NroRegistro.Value := NroAsientoComisiones;

                      end;

                 SessionDataModule.Dm10.FacturaModule.CompletaRegistroFacturaRecibida( SubcuentaProveedor,
                                                                                       DsProveedorFields.CodigoPais.Value,
                                                                                       { ModeloIVA } DsProveedorFields.Factura_ModeloIVA.Value,
                                                                                       DmFacturaFields );

                 DmFacturaTable.Post;

               except
                 DmFacturaTable.Cancel;
                 raise;
                 end;

               SessionDataModule.Dm10.AsientoModule.CompletaAsientoFactura( DmAsientoFields, ConceptoApunteComisiones, tpaActualizacionFactura );

               // Registro del efecto a pagar y anotación del pago (asiento) si es al contado

               SessionDataModule.Dm10.EfectoPagarModule.GeneraEfectos( NroAsientoComisiones,
                                                                       SubcuentaProveedor,
                                                                       DsProveedorFields.Pago_FormaPago.Value,
                                                                       TotalImporteComision );

               Cancelado := SessionDataModule.SendNotification( ntRecordInformation,
                                                                Format( RsMsg13, [ DmAsientoFields.Serie.Value,
                                                                                   NroAsientoComisiones,
                                                                                   DsProveedorFields.Codigo.Value,
                                                                                   DsProveedorFields.Nombre.Value ] ) );

               end;

          end;

     NroAsientoComisiones := 0
end;


procedure ProcesaFicheroDiario;

var  ImporteRecaudacion,
     ImporteComision,
     RecaudacionDiaria,
     ComisionDiaria : Decimal;
     DateChecked : Boolean;

begin

     NroApunteActual := 1;
     Cancelado := False;

     RecaudacionDiaria := 0.0;
     ComisionDiaria := 0.0;
     DateChecked := False;

     DataList := TStringList.Create;
     DataList.Text := ContenidoFichero;

     For var DataLine in DataList do
       If   DataLine<>''
       then begin

            CSVExtractParameters( DataLine, ListaParametros );

            try

              Fecha := CSVDate( ListaParametros[ 0 ] );
              ImporteRecaudacion := CSVFloat( ListaParametros[ 9 ] );
              ImporteComision := CSVFloat( ListaParametros[ 12 ] );
              SubcuentaProveedor := ListaParametros[ 17 ];

            except
              SessionDataModule.SendNotification( ntError, RsMsg5 );
              raise;
              end;

            If   not DateChecked
            then begin
                 If  LibUtils.AccountingYear( Fecha, SessionDataModule.NroMesInicial )<>SessionDataModule.Ejercicio
                 then begin
                      SessionDataModule.SendNotification( ntError, RsMsg4 );
                      Abort;
                      end;
                 DateChecked := True;
                 end;

            If   not SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( SubcuentaProveedor, DsProveedorFields )
            then begin
                 SessionDataModule.SendNotification( ntError, Format( RsMsg16, [ SubcuentaProveedor ] ) );
                 Abort;
                 end;

            DecAdd( RecaudacionDiaria, ImporteRecaudacion );

            If   DsProveedorFields.Pago_FormaPago.Value<>'01'
            then DecAdd( ComisionDiaria, Importecomision );

            end;

     If   RecaudacionDiaria<>0.0
     then begin

          // El asiento de la recaudación diaria

          DmAsientoTable.Append;

          DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmAsientoFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
          DmAsientoFields.Fecha.Value := Fecha;
          DmAsientoFields.TipoAsiento.Value := taOrdinario;

          DmAsientoTable.Post;

          // El primer apunte con la recaudación diaria a caja directamente

          DmApunteTable.Append;

          DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
          DmApunteFields.NroApunte.Value := 1;
          DmApunteFields.Fecha.Value := Fecha;
          DmApunteFields.Subcuenta.Value := RsSubcuentaCaja;
          DmApunteFields.Contrapartida.Value := RsSubcuentaPendienteProveedores;
          DmApunteFields.Concepto.Value := RsRecaudacionDiaria;
          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, RecaudacionDiaria);

          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taOrdinario, DmApunteFields );

          DmApunteTable.Post;

          // El segundo el abono a la cuenta 408

          DmApunteTable.Append;

          DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
          DmApunteFields.NroApunte.Value := 2;
          DmApunteFields.Fecha.Value := Fecha;
          DmApunteFields.Subcuenta.Value := RsSubcuentaPendienteProveedores;
          DmApunteFields.Contrapartida.Value := RsSubcuentaCaja;
          DmApunteFields.Concepto.Value := RsRecaudacionDiaria;
          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, -RecaudacionDiaria);

          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taOrdinario, DmApunteFields );

          DmApunteTable.Post;

          // Y lo mismo con las comisiones

          If   ComisionDiaria<>0.0
          then begin

               DmApunteTable.Append;

               DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
               DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
               DmApunteFields.NroApunte.Value := 3;
               DmApunteFields.Fecha.Value := Fecha;
               DmApunteFields.Subcuenta.Value := RsSubcuentaCaja;
               DmApunteFields.Contrapartida.Value := RsSubcuentaPendienteProveedores;
               DmApunteFields.Concepto.Value := RsComisionDiaria;
               SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, -ComisionDiaria );

               SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taOrdinario, DmApunteFields );

               DmApunteTable.Post;

               DmApunteTable.Append;

               DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
               DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
               DmApunteFields.NroApunte.Value := 4;
               DmApunteFields.Fecha.Value := Fecha;
               DmApunteFields.Subcuenta.Value := RsSubcuentaPendienteProveedores;
               DmApunteFields.Contrapartida.Value := RsSubcuentaCaja;
               DmApunteFields.Concepto.Value := RsComisionDiaria;
               SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ComisionDiaria);

               SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taOrdinario, DmApunteFields );

               DmApunteTable.Post;

               end;

          SessionDataModule.SendNotification( ntInformation, Format( RsMsg15, [ DmAsientoFields.NroAsiento.Value ] ) );

          end;

end;

procedure ProcesaFicheroMensual;
begin

     SerieNroFacturaActual := '';
     NroApunteActual := 1;
     Cancelado := False;

     DataList := TStringList.Create;
     DataList.Text := ContenidoFichero;

     For var DataLine in DataList do
       If   DataLine<>''
       then begin

            CSVExtractParameters( DataLine, ListaParametros );

            // Comprobando el cambio de factura antes de leer el resto de los valores evito que se pierdan
            // los de la factura actual.

            If   ListaParametros[ 1 ]<>SerieNroFacturaActual
            then GeneraAsiento;

            try

              Fecha := CSVDate( ListaParametros[ 0 ] );
              SerieNroFacturaEmitida := ListaParametros[ 1 ];
              SerieNroFacturaRecibida := ListaParametros[ 2 ];

              CodigoBar := ListaParametros[ 4 ];
              NombreBar := ListaParametros[ 5 ];
              TipoMaquina := ListaParametros[ 6 ];  // A = Con IVA y B= Sin IVA

              Importe := CSVFloat( ListaParametros[ 7 ] );
              BaseImponible := CSVFloat( ListaParametros[ 8 ] );
              PorcentajeIVA := CSVFloat( ListaParametros[ 9 ] );
              CuotaIVA := CSVFloat( ListaParametros[ 10 ] );
              BaseImponibleComision := CSVFloat( ListaParametros[ 11 ] );
              PorcentajeIVAComision := CSVFloat( ListaParametros[ 12 ] );
              CuotaIVAComision := CSVFloat( ListaParametros[ 13 ] );
              ImporteComision := CSVFloat( ListaParametros[ 14 ] );

              NombreFiscalProveedor := ListaParametros[ 16 ];
              CIFProveedor := ListaParametros[ 17 ];
              SubcuentaProveedor := ListaParametros[ 18 ];

              CuentaIngresos := ListaParametros[ 20 ];  // A, B, D, I, E

              //..

              CodigoCliente := Copy( SubcuentaProveedor, 5, 5 );

              case CuentaIngresos[ 1 ] of
                'E' : SubcuentaIngresos := '700000000';
                'B' : SubcuentaIngresos := '705000002';
                else // A, D, I
                      SubcuentaIngresos := '705000001';
                end;

            except
              SessionDataModule.SendNotification( ntError, RsMsg5 );
              raise;
              end;

            If   LibUtils.AccountingYear( Fecha, SessionDataModule.NroMesInicial )<>SessionDataModule.Ejercicio
            then begin
                 SessionDataModule.SendNotification( ntError, RsMsg4 );
                 Abort;
                 end;

            If   SerieNroFacturaActual<>SerieNroFacturaEmitida
            then begin

                 TotalImporte := 0.0;
                 TotalBaseImponible := 0.0;
                 TotalPorcentajeIVA := 0.0;
                 TotalCuotaIVA := 0.0;

                 TotalBaseImponibleComision := 0.0;
                 TotalCuotaIVAComision := 0.0;
                 TotalImporteComision := 0.0;

                 Serie := '';

                 var Ld := SerieNroFacturaEmitida.LastDelimiter( [ '/' ] );
                 If   Ld=0
                 then NroFactura := StrToInt( SerieNroFacturaEmitida )  // No debería ocurrir, pero bueno
                 else NroFactura := StrToInt( Copy( SerieNroFacturaEmitida, Ld + 2 ) );

                 SerieNroFacturaActual := SerieNroFacturaEmitida;
                 NroAsientoActual := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;

                 NroApunteActual := 2; // El primero es el cargo con el importe total de la factura

                 SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie, DsSerieFacturacionFields );

                 If   not SessionDataModule.Dm10.ClienteModule.Obten( CodigoCliente, '', DsClienteFields )
                 then begin
                      SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ CodigoCliente ] ) );
                      Abort;
                      end;

                 CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DsClienteFields );

                 If   not SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( SubcuentaProveedor, DsProveedorFields )
                 then begin
                      SessionDataModule.SendNotification( ntError, Format( RsMsg12, [ SubcuentaProveedor ] ) );
                      Abort;
                      end;

                 If   DsProveedorFields.Factura_CtaCompras.Value=''
                 then SubcuentaCompras := '621000000'
                 else SubcuentaCompras := DsProveedorFields.Factura_CtaCompras.Value;

                 end;

            If   not SessionDataModule.Dm10.TasaModule.ObtenTipoIVAPorcentaje( Fecha, CodigoPaisIVA, tpIVARepercutido, PorcentajeIVA, DsTiposIVAFields )
            then begin
                 SessionDataModule.SendNotification( ntError, Format( RsMsg2, [ PorcentajeIVA ] ) );
                 Abort;
                 end;

            If   not SessionDataModule.Dm10.TasaModule.ObtenTipoIVAPorcentaje( Fecha, CodigoEspaña, tpIVASoportado, PorcentajeIVAComision, DsTiposIVAComisionesFields )
            then begin
                 SessionDataModule.SendNotification( ntError, Format( RsMsg2, [ PorcentajeIVA ] ) );
                 Abort;
                 end;

            ConceptoApunte := Format( RsMsg7, [ Serie, NroFactura ] );
            ConceptoApunteComisiones := Format( RsMsg11, [ SerieNroFacturaRecibida ] );

            // Apunte de venta

            DmApunteTable.Append;

            DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
            DmApunteFields.NroAsiento.Value := NroAsientoActual;
            DmApunteFields.NroApunte.Value := NroApunteActual;
            DmApunteFields.Fecha.Value := Fecha;
            DmApunteFields.Subcuenta.Value := SubcuentaIngresos;
            DmApunteFields.Contrapartida.Value := DsClienteFields.Subcuenta.Value;
            DmApunteFields.Concepto.Value := ConceptoApunte;

            SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, BaseImponible, True );

            DmApunteFields.BaseImponible.Value := BaseImponible;
            DmApunteFields.TipoApunte.Value := tapManual;

            DmApunteFields.Tipo.Value := DsTiposIVAFields.Codigo.Value;
            DmApunteFields.CuotaIVA.Value := CuotaIVA;
            DmApunteFields.CuotaRE.Value := 0.0;
            DmApunteFields.ImporteTotal.Value := Importe;

            SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taFraEmitida, DmApunteFields, False );

            DmApunteTable.Post;

            // Apunte de la factura de compra (comisiones)

            If   BaseImponibleComision<>0.0
            then begin

                 If   NroAsientoComisiones=0
                 then NroAsientoComisiones := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;

                 DmApunteTable.Append;

                 DmApunteFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                 DmApunteFields.NroAsiento.Value := NroAsientoComisiones;
                 DmApunteFields.NroApunte.Value := NroApunteActual;
                 DmApunteFields.Fecha.Value := Fecha;
                 DmApunteFields.Subcuenta.Value := SubcuentaCompras;
                 DmApunteFields.Contrapartida.Value := SubcuentaProveedor;
                 DmApunteFields.Concepto.Value := ConceptoApunteComisiones;

                 SetSignedValue( DmApunteFields.Haber, DmApunteFields.Debe, BaseImponibleComision, True );

                 DmApunteFields.BaseImponible.Value := BaseImponibleComision;
                 DmApunteFields.TipoApunte.Value := tapManual;

                 DmApunteFields.Tipo.Value := DsTiposIVAComisionesFields.Codigo.Value;
                 DmApunteFields.CuotaIVA.Value := CuotaIVAComision;
                 DmApunteFields.CuotaRE.Value := 0.0;
                 DmApunteFields.ImporteTotal.Value := ImporteComision;

                 SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( taFraRecibida, DmApunteFields, False );

                 DmApunteTable.Post;

                 end;

            DecAdd( TotalImporte, Importe );
            DecAdd( TotalBaseImponible, BaseImponible );
            DecAdd( TotalPorcentajeIVA, PorcentajeIVA );
            DecAdd( TotalCuotaIVA, CuotaIVA );

            DecAdd( TotalBaseImponibleComision, BaseImponibleComision );
            DecAdd( TotalCuotaIVAComision, CuotaIVAComision );
            DecAdd( TotalImporteComision, ImporteComision );

            Inc( NroApunteActual );
            end;

     GeneraAsiento;
end;

begin

     ListaParametros := TStringList.Create;

     SessionDataModule.SendNotification( ntHeader, RsMsg3 );

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable ] );


     try

        If   Diario
        then ProcesaFicheroDiario
        else ProcesaFicheroMensual;

        TransactionTag.Commit;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       If   Cancelado
       then SessionDataModule.SendNotification( ntWarning, RsMsg10 )
       else SessionDataModule.SendNotification( ntExceptionError, ExceptionMessage( E ) );
       SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
       end;

     end;

end;

{ TImportacionFacturas121Service }

procedure TImportacionFacturas121Service.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TImportacionFacturas121Service.EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );
begin
     SessionDataModule.Dm121.ImportacionFacturas121Module.EjecutaProceso( ContenidoFichero, Diario );
end;

var ImportacionFacturas121Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_ImportacionFacturas121Service, TImportacionFacturas121Service, ImportacionFacturas121Control );

end.
