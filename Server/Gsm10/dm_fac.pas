
unit dm_fac;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  Generics.Defaults, Generics.Collections,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  nxllTypes,
  nxivTypes,
  nxrdClass,
  nxrbTypes,

  Gim00Fields,
  Gim10Fields,

  AsientoIntf,
  FacturaIntf,

  dmi_fac,
  dmi_iva,

  dm_pai,
  dm_iva;

type

    TFacturaService = class( TSessionModule, IFacturaService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    function SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               SerieInicial,
                                               SerieFinal             : String;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PrimerNroOrden         : Integer = 0;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function ImportePendienteFacturaEmitida(     Ejercicio          : SmallInt;
                                                 Serie              : String;
                                                 NroFactura         : LongInt;
                                             out ImporteEfectos     : Decimal;
                                             out ImportePendiente   : Decimal ) : Boolean;

    function ObtenImportesFacturaEmitida(     Ejercicio     : SmallInt;
                                              Serie         : String;
                                              NroFactura    : Integer;
                                          out Asiento         : IAsiento;
                                          out BaseImponible,
                                              CuotaIVA,
                                              CuotaRE,
                                              ImporteTotal  : Decimal ) : Boolean;

    function ObtenImportesFacturaRecibida(     Ejercicio       : SmallInt;
                                               Propietario,
                                               SerieNroFactura : String;
                                           out Asiento         : IAsiento;
                                           out BaseImponible,
                                               CuotaIVA,
                                               ImporteTotal     : Decimal ) : Boolean;

    function ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                        Periodicidad         : SmallInt;
                                                        FechaInicial,
                                                        FechaFinal           : TDateTime ) : IAcumuladoOPeracionesIntracomunitarias;

    procedure CompletaRegistroFacturaRecibida(     SubcuentaPropietario,
                                                   CodigoPais                    : String;
                                                   ModeloIVA                     : TModeloIVAProveedor;
                                               out TipoFactura                   : SmallInt;
                                               out RegimenOTrascendencia         : SmallInt;
                                               out TipoOperacionIntracomunitaria : SmallInt );

    procedure CompletaRegistroFacturaExpedida(     CodigoProvincia               : String;
                                                   CodigoPais                    : String;
                                                   Rectificativa                 : Boolean;
                                                   Simplificada                  : Boolean;
                                                   VentasOnline                  : Boolean;
                                               out TipoFactura                   : SmallInt;
                                               out RegimenOTrascendencia         : SmallInt;
                                               out CausaExencion                 : SmallInt );
    end;

  TFacturaModule = class(TServerDataModule)
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    DmEfectoCobrarTable: TnxeTable;
    DmFormaCobroTable: TnxeTable;
    DmEfectoPagarTable: TnxeTable;
    DmApunteCajaTable: TnxeTable;
    DmAsientoFacturaTable: TnxeTable;
    DmFacturaContableTable: TnxeTable;
    DmFacturaComercialTable: TnxeTable;
    DmFacturaContableAuxTable: TnxeTable;
    DmAsientoAuxTable: TnxeTable;
    DmApunteAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
  private

    DmFacturaContableFields,
    DmFacturaContableAuxFields,
    DmFacturaComercialFields : TFacturaFields;
    DmEfectoCobrarFields : TEfectoCobrarFields;
    DmEfectoPagarFields : TEfectoPagarFields;
    DmAsientoFields,
    DmAsientoFacturaFields,
    DmAsientoAuxFields : TAsientoFields;
    DmApunteFields,
    DmApunteCajaFields,
    DmApunteAuxFields : TApunteFields;

    DsPaisFields : TPaisFields;
    DsFormaCobroFields : TFormaCobroFields;
    DsProveedorFields : TProveedorFields;
    DsClienteFields : TClienteFields;
    DsRemesaFields : TRemesaFields;
    DsTiposIVAFields : TTiposIVAFields;
    DsFacturaFields,
    DsFacturaAnteriorFields : TFacturaFields;

    procedure ClearListaRegistroFacturacion(Lista: TListaRegistroFacturacion);

  public

    function ObtenRegistroContableFactura( Tipo          : SmallInt;
                                           Ejercicio     : SmallInt;
                                           NroAsiento    : Integer;
                                           FacturaFields : TFacturaFields ) : Boolean;

    procedure SuprimeRegistroContableFactura( Tipo         : SmallInt;
                                              NroAsiento   : LongInt;
                                              FacturaTable : TnxeTable = nil );

    function ObtenRegistroComercialFactura( Tipo          : SmallInt;
                                            Ejercicio     : SmallInt;
                                            Propietario,
                                            Serie         : String;
                                            NroRegistro   : Integer;
                                            FacturaFields : TFacturaFields ) : Boolean;

    procedure SuprimeRegistroComercialFactura( Tipo         : SmallInt;
                                               Propietario,
                                               Serie        : String;
                                               NroRegistro  : LongInt;
                                               FacturaTable : TnxeTable = nil );

    procedure CopiaRegistroFactura( Tipo                 : SmallInt;
                                    Propietario,
                                    Serie                : String;
                                    NroFactura,
                                    NroAsiento           : LongInt;
                                    AsientoFacturaFields : TFacturaFields = nil );

    function ClonaRegistroAsiento( NroAsientoOrigen,
                                   NroAsientoDestino    : LongInt;
                                   SuprimeAsientoOrigen : Boolean = False ) : Boolean;

    procedure CompruebaRegistroFacturaAsiento(     AsientoFields     : TAsientoFields;
                                               var RegistroReubicado : Boolean;
                                                   CorregirErrores   : Boolean = False );

    procedure CompletaRegistroFacturaExpedida(     CodigoProvincia,
                                                   CodigoPais            : String;
                                                   Rectificativa,
                                                   Simplificada,
                                                   VentasOnline          : Boolean;
                                               out TipoFactura           : SmallInt;
                                               out RegimenOTrascendencia : SmallInt;
                                               out CausaExencion         : SmallInt ); overload;

    procedure CompletaRegistroFacturaExpedida( CodigoProvincia,
                                               CodigoPais      : String;
                                               Rectificativa,
                                               Simplificada,
                                               VentasOnline    : Boolean;
                                               FacturaFields   : TFacturaFields ); overload;

    procedure CompletaRegistroFacturaRecibida( SubcuentaPropietario,
                                               CodigoPais            : String;
                                               ModeloIVA             : TModeloIVAProveedor;
                                               FacturaFields         : TFacturaFields ); overload;

    procedure CompletaRegistroFacturaRecibida(     SubcuentaPropietario,
                                                   CodigoPais                    : String;
                                                   ModeloIVA                     : TModeloIVAProveedor;
                                               out TipoFactura                   : SmallInt;
                                               out RegimenOTrascendencia         : SmallInt;
                                               out TipoOperacionIntracomunitaria : SmallInt ); overload;


    function SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               SerieInicial,
                                               SerieFinal             : String;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PrimerNroOrden         : Integer = 0;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function ImportePendienteFacturaEmitida(     Ejercicio          : SmallInt;
                                                 Serie              : String;
                                                 NroFactura         : LongInt;
                                             out ImporteEfectos     : Decimal;
                                             out ImportePendiente   : Decimal ) : Boolean;

    function ObtenImportesFacturaEmitida(     Ejercicio     : SmallInt;
                                              Serie         : String;
                                              NroFactura    : Integer;
                                          out Asiento         : IAsiento;
                                          out BaseImponible,
                                              CuotaIVA,
                                              CuotaRE,
                                              ImporteTotal  : Decimal ) : Boolean;

    function ObtenImportesFacturaRecibida(     Ejercicio       : SmallInt;
                                               Propietario,
                                               SerieNroFactura : String;
                                           out Asiento         : IAsiento;
                                           out BaseImponible,
                                               CuotaIVA,
                                               ImporteTotal    : Decimal ) : Boolean;

    function ObtenImporteDeclaradoAnterior(     FechaInicialActual,
                                                FechaFinalActual      : TDate;
                                                Periodicidad          : SmallInt;
                                                TipoAsiento           : SmallInt;
                                                Propietario           : String;
                                            out BaseImponible         : Decimal ) : Boolean;

    function ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                        Periodicidad         : SmallInt;
                                                        FechaInicial,
                                                        FechaFinal           : TDateTime ) : IAcumuladoOPeracionesIntracomunitarias;

    function TextoSerieNroFactura( Serie : String; NroFactura : LongInt ) : String;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses System.Types,
     DateUtils,
     AppManager,
     EnterpriseData,

     SessionData,

     dmi_ast,
     dmi_rem,
     dmi_rdp,

     dm_sub,
     dm_pga,
     dm_pro,
     dm_cli,
     dm_rem,
     dm_sal,
     dm_ast,
     dm_fpa;

{$R *.DFM}

resourceString
    RsMsg1  = 'Comprobando el registro de factura del asiento nº %d.';
    RsMsg2  = 'Fecha %s - Nº Asiento %d';
    RsMsg8  = 'El operador %s, %s no tiene NIF asignado en su ficha.';
    RsMsg9  = 'No se ha podido recuperar el registro de factura del asiento nº %d.';
    RsMsg10 = 'No se ha podido recuperar la ficha del propietario %s.';
    RsMsg11 = 'Seleccionando registros del libro de facturas %s';
    RsMsg12 = 'recibidas.';
    RsMsg13 = 'expedidas.';

{ TFacturaModule }

procedure TFacturaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.EfectoCobrarModule := nil;
end;

procedure TFacturaModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

procedure TFacturaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmFacturaContableFields := TFacturaFields.Create( DmFacturaContableTable );
     DmFacturaContableAuxFields := TFacturaFields.Create( DmFacturaContableAuxTable );
     DmFacturaComercialFields := TFacturaFields.Create( DmFacturaComercialTable );
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmAsientoFacturaFields := TAsientoFields.Create( DmAsientoFacturaTable );
     DmAsientoAuxFields := TAsientoFields.Create( DmAsientoAuxTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmApunteCajaFields := TApunteFields.Create( DmApunteCajaTable );
     DmApunteAuxFields := TApunteFields.Create( DmApunteAuxTable );

     DsFormaCobroFields := TFormaCobroFields.Create( DmFormaCobroTable );
     DsPaisFields := TPaisFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
     DsRemesaFields := TRemesaFields.Create( Self );
     DsFormaCobroFields := TFormaCobroFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsFacturaFields := TFacturaFields.Create( Self );
     DsFacturaAnteriorFields := TFacturaFields.Create( Self );

end;

procedure TFacturaModule.ClearListaRegistroFacturacion( Lista: TListaRegistroFacturacion );

var  RegistroFacturacion : TRegistroFacturacion;

begin
     For RegistroFacturacion in Lista do
       RegistroFacturacion.Free;
     Lista.Clear;
end;

function TFacturaModule.ImportePendienteFacturaEmitida(     Ejercicio          : SmallInt;
                                                            Serie              : String;
                                                            NroFactura         : LongInt;
                                                        out ImporteEfectos     : Decimal;
                                                        out ImportePendiente   : Decimal ) : Boolean;

var  ImporteFactura : Decimal;

function EfectoCobrado : Boolean;
begin
     If   ValueIsEmpty( DmEfectoCobrarFields.NroRemesa.Value )
     then Result := not ValueIsEmpty( DmEfectoCobrarFields.FechaCobro.Value )
     else If   SessionDataModule.Dm10.RemesaModule.Obten( DmEfectoCobrarFields.EjercicioRemesa.Value,
                                                          DmEfectoCobrarFields.NroRemesa.Value,
                                                          DsRemesaFields )
          then Result := ( DsRemesaFields.Estado.Value<>erPendiente ) and not DmEfectoCobrarFields.Impagado.Value
          else Result := False;
end;

begin
     Result := False;
     ImporteEfectos := 0.0;
     ImportePendiente := 0.0;

     DmAsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';
     If   DmAsientoFacturaTable.FindKey( [ taFraEmitida, Ejercicio, Serie, NroFactura, 255 ] )
     then If   DmApunteTable.FindKey( [ DmAsientoFacturaFields.Ejercicio.Value, DmAsientoFacturaFields.NroAsiento.Value, 1 ] )
          then begin
               ImporteFactura := GetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber );
               If   ImporteFactura<>0.0
               then With DmEfectoCobrarTable do
                      begin
                      try
                        SetRange( [ Ejercicio, Serie, NroFactura, 0 ], [ Ejercicio, Serie, NroFactura, MaxSmallInt ] );
                        First;
                        While not Eof do
                          begin

                          If   not DmEfectoCobrarFields.Impagado.Value
                          then DecAdd( ImporteEfectos, DmEfectoCobrarFields.Importe.Value );

                          If   EfectoCobrado  // No usar la función EfectoCobrar.EfectoPendiente, porque llama a esta misma función y se produce un bucle infinito
                          then If   ValueIsEmpty( DmEfectoCobrarFields.NroRemesa.Value )
                               then DecAdd( ImporteFactura, -DmEfectoCobrarFields.ImporteCobrado.Value )
                               else DecAdd( ImporteFactura, -DmEfectoCobrarFields.Importe.Value );

                          Next;
                          end;
                      finally
                        CancelRange;
                        end;

                      ImportePendiente := ImporteFactura;

                      //* 04.02.2011  El importe cobrado puede ser superior al de la factura al incluir los gastos en los efectos impagados y reemitidos, por ejemplo

                      Result := ImporteFactura>0.0;
                      end;
               end;

end;

function TFacturaModule.SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                                          DeclaracionInformativa : Boolean;
                                                          LibrosRegistro         : TLibrosRegistro;
                                                          SerieInicial,
                                                          SerieFinal             : String;
                                                          FechaInicial,
                                                          FechaFinal             : TDateTime;
                                                          PorTipoIVA             : Boolean = False;
                                                          TipoIVA                : SmallInt = 0;
                                                          PorTipoRetencion       : Boolean = False;
                                                          TipoRetencion          : SmallInt = 0;
                                                          SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

var   IndiceRegistro : SmallInt;

      TotalCuotaFactura,
      TotalImporteFactura : Decimal;

      CodigoPaisIVA : String;
      OperadorIntracomunitario,
      PeriodoAplicacionCriterioCaja,
      RetencionCorrecta : Boolean;
      ListaRegistroFacturacion : TListaRegistroFacturacion;
      SumasFacturacion : TSumasFacturacion;
      FechaAplicacionRegistro : TDate;

      Acumuladofacturacion : IAcumuladoFacturacion;

      DiarioTable : TnxeTable;
      DiarioFields : TDiarioFacturacionFields;
      RemesaFields : TRemesaFields;

function ApunteCorrecto : Boolean;
begin
     Result := ( DmApunteFields.TipoApunte.Value=tapManual  ) and ( not PorTipoIVA or ( DmApunteFields.Tipo.Value=TipoIVA ) );
end;

procedure AñadeRegistroFacturacion;

var  RegistroFacturacion : TRegistroFacturacion;
     Libro : TLibroRegistro;

begin

     If   ApunteCorrecto
     then begin

          If   OperadorIntracomunitario
          then Libro := lrEntregasIntracomunitarias
          else Libro := lrFrasExpedidas;

          SessionDataModule.Dm10.TasaModule.TipoIVA( DmAsientoFields.Fecha.Value, CodigoPaisIVA, DmApunteFields.Tipo.Value, DsTiposIVAFields );

          // Excluyendo de los libros oficiales y de la declaración las bases imponibles no liquidables

          If   ( lrEspecial in LibrosRegistro ) or DsTiposIVAFields.Liquidable.Value
          then begin

               DecAdd( TotalCuotaFactura, DmApunteFields.CuotaIVA.Value );
               DecAdd( TotalImporteFactura, DmApunteFields.ImporteTotal.Value );

               For RegistroFacturacion in ListaRegistroFacturacion do
                 If   ( RegistroFacturacion.FechaAplicacion=FechaAplicacionRegistro ) and
                      ( RegistroFacturacion.CodigoPais=CodigoPaisIVA ) and
                      ( RegistroFacturacion.TipoImpositivo=DmApunteFields.Tipo.Value )
                 then begin
                      DecAdd( RegistroFacturacion.BaseImponible, DmApunteFields.BaseImponible.Value );
                      DecAdd( RegistroFacturacion.CuotaIVA, DmApunteFields.CuotaIVA.Value );
                      // Sería raro que inicialmente este tipo se utilizara sin RE y luego sí, pero el mantenimiento lo permite
                      If   DmApunteFields.CuotaRE.Value<>0.0
                      then begin
                           RegistroFacturacion.TipoRE := DsTiposIVAFields.RERepercutido.Value;
                           DecAdd( RegistroFacturacion.CuotaRE, DmApunteFields.CuotaRE.Value );
                           end;
                      DecAdd( RegistroFacturacion.Importe, DmApunteFields.ImporteTotal.Value );
                      // Cuando se acumulan varias bases del mismo tipo la subcuenta puede no coincidir
                      If   DmApunteFields.Subcuenta.Value<>RegistroFacturacion.Subcuenta
                      then RegistroFacturacion.Subcuenta := '';
                      Exit;
                      end;

               // Añadiendo una nueva base

               RegistroFacturacion := TRegistroFacturacion.Create;

               RegistroFacturacion.Libro := Libro;
               RegistroFacturacion.TipoFactura := DsFacturaFields.TipoFactura.Value;
               RegistroFacturacion.Subcuenta := DmApunteFields.Subcuenta.Value;
               RegistroFacturacion.FechaAplicacion := FechaAplicacionRegistro;
               RegistroFacturacion.TipoImpositivo := DmApunteFields.Tipo.Value;
               RegistroFacturacion.CodigoPais := CodigoPaisIVA;
               RegistroFacturacion.BaseImponible := DmApunteFields.BaseImponible.Value;
               RegistroFacturacion.TipoIVA := DsTiposIVAFields.IVARepercutido.Value;
               RegistroFacturacion.CuotaIVA := DmApunteFields.CuotaIVA.Value;
               If   DmApunteFields.CuotaRE.Value<>0.0
               then begin
                    RegistroFacturacion.TipoRE := DsTiposIVAFields.RERepercutido.Value;
                    RegistroFacturacion.CuotaRE :=  DmApunteFields.CuotaRE.Value;
                    end;
               RegistroFacturacion.Importe := DmApunteFields.ImporteTotal.Value;

               ListaRegistroFacturacion.Add( RegistroFacturacion );
               end;

        end;

end;

procedure ProcesaFacturas;

var   RegistroFacturacion : TRegistroFacturacion;

procedure ProcesaCobrosFactura( SerieFactura     : String;
                                EjercicioFactura : SmallInt;
                                NroFactura       : LongInt );

var  RegistroFacturacion : TRegistroFacturacion;
     ProcesarEfecto : Boolean;

begin

     With DmEfectoCobrarTable  do
       try

         // Ejercicio;Serie;NroFactura;NroEfecto

         SetRange( [ EjercicioFactura, SerieFactura, NroFactura ] );

         First;
         While not Eof do
           begin

           If   not SessionDataModule.Dm10.EfectoCobrarModule.EfectoPendiente( DmEfectoCobrarFields )
           then begin

                ProcesarEfecto := False;

                If   DmEfectoCobrarFields.NroRemesa.Value<>0
                then begin
                     RemesaFields.Update;
                     ProcesarEfecto := ( RemesaFields.Estado.Value in [ erCobrada, erCancelada ] ) and
                                       ( RemesaFields.FechaCobro.Value>=FechaInicial ) and
                                       ( RemesaFields.FechaCobro.Value<=FechaFinal )
                     end
                else ProcesarEfecto := ( DmEfectoCobrarFields.FechaCobro.Value>=FechaInicial ) and
                                       ( DmEfectoCobrarFields.FechaCobro.Value<=FechaFinal );

                If   ProcesarEfecto
                then With DmApunteCajaTable do
                       try

                         With DmEfectoCobrarFields do
                           DmApunteCajaTable.SetRange( [ tapTraspasoIVA, Ejercicio.Value, SubcuentaCliente.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );

                         First;
                         While not Eof do
                           begin

                           For RegistroFacturacion in ListaRegistroFacturacion do
                             If   ( RegistroFacturacion.FechaAplicacion=FechaAplicacionRegistro ) and
                                  // ( RegistroFacturacion.CodigoPais=CodigoPaisIVA ) and
                                  ( RegistroFacturacion.TipoImpositivo=DmApunteCajaFields.Tipo.Value )
                             then begin

                                  DecAdd( RegistroFacturacion.BaseImponibleCaja, DmApunteCajaFields.BaseImponible.Value );
                                  DecAdd( RegistroFacturacion.CuotaIVACaja, DmApunteCajaFields.CuotaIVA.Value );
                                  DecAdd( RegistroFacturacion.ImporteCaja, DmApunteCajaFields.ImporteTotal.Value );

                                  // Si se anota más de un cobro con el mismo tipo impositivo, los datos del cobro son los del último efecto procesado

                                  If   DmEfectoCobrarFields.NroRemesa.Value=0
                                  then RegistroFacturacion.FechaCobro := DmEfectoCobrarFields.FechaCobro.Value
                                  else If   RemesaFields.Estado.Value=erCobrada
                                       then RegistroFacturacion.FechaCobro := RemesaFields.FechaCobro.Value
                                       else RegistroFacturacion.FechaCobro := RemesaFields.FechaCancelacion.Value;

                                  RegistroFacturacion.ConceptoCobro := DmEfectoCobrarFields.Concepto.Value;
                                  RegistroFacturacion.CCC := SessionDataModule.Dm10.ClienteModule.IBAN( DsClienteFields );
                                  RegistroFacturacion.CodigoMedioCobro := 'O';
                                  If   SessionDataModule.Dm10.FormaCobroModule.Obten( DmEfectoCobrarFields.FormaDePago.Value, DsFormaCobroFields )
                                  then If   DsFormaCobroFields.TipoDeDocumento.Value=tdChequeBancarioPagare
                                       then RegistroFacturacion.CodigoMedioCobro := 'T'
                                       else If   RegistroFacturacion.CCC<>''
                                            then RegistroFacturacion.CodigoMedioCobro := 'C';

                                  Break;
                                  end;

                           Next;
                           end;

                       finally
                         CancelRange;
                         end;

                end;

           Next;
           end;

       finally
         CancelRange;
         end;

end;

begin

       With DmAsientoTable do
         try

           ListaRegistroFacturacion := TListaRegistroFacturacion.Create;

           SetRange( [ taFraEmitida, FechaInicial ], [ taFraEmitida, FechaFinal ] );

           SessionDataModule.SendNotification( ntInformation, Format( RsMsg11, [ RsMsg13 ] ) );

           SessionDataModule.StartProgress( False, RecordCount );

           First;
           While not Eof do
             begin

             SessionDataModule.SendProgress( 'Factura' );

             SessionDataModule.Dm10.ClienteModule.ObtenPorSubcuenta( DmAsientoFields.Propietario.Value, DsClienteFields );
             SessionDataModule.Dm00.PaisModule.Obten( DsClienteFields.CodigoPais.Value, DsPaisFields );

             CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DsClienteFields );
             OperadorIntracomunitario := ( DsClienteFields.CodigoPais.Value<>CodigoEspaña ) and ( DsPaisFields.Intracomunitario.Value );


             If   ( DmAsientoFields.Serie.Value>=SerieInicial ) and ( DmAsientoFields.Serie.Value<=SerieFinal ) and
                  ( ( lrFrasExpedidas in LibrosRegistro ) or
                    ( ( lrEntregasIntracomunitarias in LibrosRegistro ) and OperadorIntracomunitario ) or
                    ( lrEspecial in LibrosRegistro ) )
             then begin

                  If   not ObtenRegistroContableFactura( tfAsiento, DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, DsFacturaFields )
                  then begin
                       SessionDataModule.SendNotification( ntError, Format( RsMsg9, [ DmAsientoFields.NroAsiento.Value ] ) );
                       Abort;
                       end;

                  With DmApunteTable do
                    try

                      With DmAsientoFields do
                        SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );

                      RetencionCorrecta := not PorTipoRetencion;

                      ClearListaRegistroFacturacion( ListaRegistroFacturacion );
                      TotalCuotaFactura := 0.0;
                      TotalImporteFactura := 0.0;

                      FechaAplicacionRegistro := SessionDataModule.Dm10.TasaModule.UltimaFechaAplicacion( DmAsientoFields.Fecha.Value, { Retencion } False, CodigoPaisIVA );

                      First;
                      While not Eof do
                        begin

                        AñadeRegistroFacturacion;

                        If   PorTipoRetencion
                        then If   DmApunteFields.TipoApunte.Value=tapRetencion
                             then begin
                                  RetencionCorrecta := DmApunteFields.Tipo.Value=TipoRetencion;
                                  Break;
                                  end;

                        Next;
                        end;

                    finally
                      CancelRange;
                      end;

                  If   RetencionCorrecta
                  then begin

                       If    PeriodoAplicacionCriterioCaja and
                             SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value and
                             ( DsClienteFields.Factura_ModeloIVA.Value=micSinRE )
                       then ProcesaCobrosFactura( DmAsientoFields.Serie.Value,
                                                  DmAsientoFields.Ejercicio.Value,
                                                  DmAsientoFields.NroFactura.Value );

                       For RegistroFacturacion in ListaRegistroFacturacion do
                         begin

                         If   DeclaracionInformativa or not SoloTablaResumen
                         then begin

                              DiarioTable.Append;

                              IndiceRegistro := ListaRegistroFacturacion.IndexOfItem( RegistroFacturacion, TDirection.FromBeginning ) + 1;

                              DiarioFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                              DiarioFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                              DiarioFields.NroApunte.Value := IndiceRegistro;

                              DiarioFields.Libro.Value := RegistroFacturacion.Libro;
                              DiarioFields.Serie.Value := DmAsientoFields.Serie.Value;
                              DiarioFields.NroRegistro.Value := DmAsientoFields.NroFactura.Value;   // Para que las facturas de un mismo día estén ordenadas por nº de factura
                              DiarioFields.NroFactura.Value := DmAsientoFields.NroFactura.Value;
                              DiarioFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                              DiarioFields.FechaDocumento.Value := DmAsientoFields.FechaDocumento.Value;
                              DiarioFields.Tipo.Value := RegistroFacturacion.TipoImpositivo;
                              DiarioFields.Propietario.Value := DmAsientoFields.Propietario.Value;
                              DiarioFields.Nombre.Value := DmAsientoFields.Nombre.Value;
                              DiarioFields.NIF.Value := DsClienteFields.NIF.Value;
                              DiarioFields.Subcuenta.Value := RegistroFacturacion.Subcuenta;
                              DiarioFields.BaseImponibleIVA.Value  := RegistroFacturacion.BaseImponible;
                              DiarioFields.TipoIVA.Value := RegistroFacturacion.TipoIVA;
                              DiarioFields.TipoRE.Value := RegistroFacturacion.TipoRE;
                              DiarioFields.CuotaIVA.Value := RegistroFacturacion.CuotaIVA;
                              DiarioFields.CuotaRE.Value :=  RegistroFacturacion.CuotaRE;
                              DiarioFields.Importe.Value := RegistroFacturacion.Importe;

                              DiarioFields.NroBasesImponibles.Value := ListaRegistroFacturacion.Count;
                              DiarioFields.TotalCuotas.Value := TotalCuotaFactura;
                              DiarioFields.TotalImporte.Value := TotalImporteFactura;

                              If   RegistroFacturacion.ImporteCaja<>0.0
                              then begin
                                   DiarioFields.BaseImponibleCaja.Value := RegistroFacturacion.BaseImponibleCaja;
                                   DiarioFields.CuotaIVACaja.Value := RegistroFacturacion.CuotaIVACaja;
                                   DiarioFields.ImporteCaja.Value := RegistroFacturacion.ImporteCaja;
                                   DiarioFields.FechaCobro.Value := RegistroFacturacion.FechaCobro;
                                   DiarioFields.ConceptoCobro.Value := RegistroFacturacion.ConceptoCobro;
                                   DiarioFields.CCC.Value := RegistroFacturacion.CCC;
                                   DiarioFields.CodigoMedioCobro.Value := RegistroFacturacion.CodigoMedioCobro;
                                   end;

                              DiarioTable.Post;
                              end;

                         If   SessionDataModule.SendNotification( ntRecord, StrFormatDate( DiarioFields.Fecha.Value, dfDefault2 ) + ' - ' + IntToStr( DiarioFields.NroAsiento.Value ) + ' / ' + IntToStr( IndiceRegistro ) )
                         then Abort;

                         AcumuladoFacturacion.Acumula( RegistroFacturacion );
                         end;

                       end;

                  end;

             Next;
             end;

         finally
           ClearListaRegistroFacturacion( ListaRegistroFacturacion );
           ListaRegistroFacturacion.Free;
           CancelRange;
           end;

end;

begin

     PeriodoAplicacionCriterioCaja := YearOf( FechaInicial )>=2014;

     Acumuladofacturacion := TAcumuladoFacturacion.Create;

     DiarioTable := TnxeTable.Create( nil );
     DiarioTable.Database := SessionDataModule.TemporalDatabase;
     DiarioTable.TableName := DiarioTableName;
     DiarioTable.Open;

     try

       DiarioFields := TDiarioFacturacionFields.Create( DiarioTable );
       RemesaFields := TRemesaFields.Create( SessionDataModule.Dm10.RemesaModule.DmRemesaTable, True );

       Acumuladofacturacion := TAcumuladoFacturacion.Create;

       ProcesaFacturas;

       // Añadida la comprobación de la SumaCuotaIVA para que se incluyan las facturas sin base imponible (pe. fras. de aduanas)
       // Añadida la comprobación y generación de registros por periodos impositivos

       If   not DeclaracionInformativa
       then begin

            AcumuladoFacturacion.OrdenaSumas;

            var Id : SmallInt := 1;
            For SumasFacturacion in AcumuladoFacturacion.Sumas do
              If   ( SumasFacturacion.BaseImponibleIVA<>0.0 ) or
                   ( SumasFacturacion.BaseImponibleRE<>0.0 ) or
                   ( SumasFacturacion.CuotaIVA<>0.0 )
              then begin

                   With SumasFacturacion do
                     SessionDataModule.Dm10.TasaModule.TipoIVA( FechaAplicacion, CodigoPais, TipoImpositivo, DsTiposIVAFields );

                   DiarioTable.Append;

                   DiarioFields.Libro.Value := 0;
                   DiarioFields.Ejercicio.Value := 0;                            // Registro especial
                   DiarioFields.Fecha.Value := SumasFacturacion.FechaAplicacion;
                   DiarioFields.NroAsiento.Value := Id;                          // Id
                   DiarioFields.Tipo.Value := SumasFacturacion.TipoImpositivo;
                   DiarioFields.CodigoPais.Value := SumasFacturacion.CodigoPais;
                   If   SumasFacturacion.CodigoPais<>''
                   then DiarioFields.NombrePais.Value := SessionDataModule.Dm00.PaisModule.Descripcion( SumasFacturacion.CodigoPais );
                   DiarioFields.Nombre.Value := DsTiposIVAFields.Descripcion.Value;
                   DiarioFields.BaseImponibleIVA.Value := SumasFacturacion.BaseImponibleIVA;
                   DiarioFields.TipoIVA.Value := DsTiposIVAFields.IVARepercutido.Value;
                   DiarioFields.CuotaIVA.Value := SumasFacturacion.CuotaIVA;
                   DiarioFields.BaseImponibleRE.Value := SumasFacturacion.BaseImponibleRE;
                   DiarioFields.TipoRE.Value := DsTiposIVAFields.RERepercutido.Value;
                   DiarioFields.CuotaRE.Value := SumasFacturacion.CuotaRE;
                   DiarioFields.Importe.Value := SumasFacturacion.Importe;

                   DiarioTable.Post;

                   Inc( Id );
                   end;

            end;

     finally
        DiarioTable.Free;
        SessionDataModule.EndProgress;
        end;

     Result := AcumuladoFacturacion;
end;

function TFacturaModule.SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                                          DeclaracionInformativa : Boolean;
                                                          LibrosRegistro         : TLibrosRegistro;
                                                          FechaInicial,
                                                          FechaFinal             : TDateTime;
                                                          PrimerNroOrden         : Integer = 0;
                                                          PorTipoIVA             : Boolean = False;
                                                          TipoIVA                : SmallInt = 0;
                                                          PorTipoRetencion       : Boolean = False;
                                                          TipoRetencion          : SmallInt = 0;
                                                          SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;


var   IndiceRegistro : SmallInt;
      NroOrdenActual : LongInt;
      LibroCorrecto,
      EsBienDeInversion,
      RetencionCorrecta,
      PeriodoAplicacionCriterioCaja : Boolean;

      FechaAplicacionRegistro : TDate;

      TotalCuotaFactura,
      TotalImporteFactura : Decimal;

      Acumuladofacturacion : IAcumuladoFacturacion;

      ListaRegistroFacturacion : TListaRegistroFacturacion;
      SumasFacturacion : TSumasFacturacion;

      DiarioTable : TnxeTable;
      DiarioFields : TDiarioFacturacionFields;
      RemesaPagoFields : TRemesaPagoFields;

function TipoDeLibroCorrecto : Boolean;
begin

     //*12.02.2009  Añadida la comprobación del importe para los registros de bienes de inversión

     EsBienDeInversion := SessionDataModule.Dm10.CuentaModule.EsBienDeInversion( DmApunteFields.Subcuenta.Value );

     Result := ( ( lrFrasRecibidas in LibrosRegistro ) and not EsBienDeInversion ) or
               ( ( lrBienesInversion in LibrosRegistro ) and EsBienDeInversion ) or
               ( lrAdquisicionesIntracomunitarias in LibrosRegistro ) or
               ( lrInversionSujetoPasivo in LibrosRegistro ) or
               ( lrRegimenEspecial in LibrosRegistro ) or
               ( lrEspecial in LibrosRegistro );
end;

function ApunteCorrecto : Boolean;
begin
     Result := ( DmApunteFields.TipoApunte.Value=tapManual ) and
               ( not PorTipoIVA or ( DmApunteFields.Tipo.Value=TipoIVA ) ) and
               TipoDeLibroCorrecto;
end;

procedure AñadeRegistroFacturacion;

var  RegistroFacturacion : TRegistroFacturacion;
     Libro : TLibroRegistro;

begin

     If   ApunteCorrecto
     then begin

          If   DmAsientoFields.Origen.Value=ofrIntracomunitaria
          then Libro := lrAdquisicionesIntracomunitarias
          else If   DmAsientoFields.Origen.Value=ofrInversionSP
               then Libro := lrInversionSujetoPasivo
               else If   SessionDataModule.Dm10.CuentaModule.EsBienDeInversion( DmApunteFields.Subcuenta.Value )
                    then Libro := lrBienesInversion
                    else Libro := lrFrasRecibidas;

          SessionDataModule.Dm10.TasaModule.TipoIVA( DmAsientoFields.FechaDocumento.Value,
                                                     { CodigoPaisIVA } '',  // En las facturas recibidas no es aplicable
                                                     DmApunteFields.Tipo.Value,
                                                     DsTiposIVAFields );

          // Excluyendo de los libros oficiales y de la declaración las bases imponibles no liquidables

          If   ( lrEspecial in LibrosRegistro ) or DsTiposIVAFields.Liquidable.Value
          then begin

               DecAdd( TotalCuotaFactura, DmApunteFields.CuotaIVA.Value );
               DecAdd( TotalImporteFactura, DmApunteFields.ImporteTotal.Value );

               If   Libro<>lrBienesInversion
               then For RegistroFacturacion in ListaRegistroFacturacion do
                      If   ( RegistroFacturacion.FechaAplicacion=FechaAplicacionRegistro ) and
                           ( RegistroFacturacion.TipoImpositivo=DmApunteFields.Tipo.Value )
                      then begin
                           DecAdd( RegistroFacturacion.BaseImponible, DmApunteFields.BaseImponible.Value );
                           DecAdd( RegistroFacturacion.CuotaIVA, DmApunteFields.CuotaIVA.Value );
                           DecAdd( RegistroFacturacion.Importe, DmApunteFields.ImporteTotal.Value );
                           // Cuando se acumulan varias bases del mismo tipo la subcuenta puede no coincidir
                           If   DmApunteFields.Subcuenta.Value<>RegistroFacturacion.Subcuenta
                           then RegistroFacturacion.Subcuenta := '';
                           Exit;
                           end;

               // Añadiendo una nueva base

               RegistroFacturacion := TRegistroFacturacion.Create;

               RegistroFacturacion.Libro := Libro;
               RegistroFacturacion.TipoFactura := DsFacturaFields.TipoFactura.Value;
               RegistroFacturacion.Subcuenta := DmApunteFields.Subcuenta.Value;
               RegistroFacturacion.FechaAplicacion := FechaAplicacionRegistro;
               RegistroFacturacion.TipoImpositivo := DmApunteFields.Tipo.Value;
               RegistroFacturacion.BaseImponible := DmApunteFields.BaseImponible.Value;
               RegistroFacturacion.TipoIVA := DsTiposIVAFields.IVASoportado.Value;
               RegistroFacturacion.CuotaIVA := DmApunteFields.CuotaIVA.Value;
               RegistroFacturacion.Importe := DmApunteFields.ImporteTotal.Value;

               ListaRegistroFacturacion.Add( RegistroFacturacion );
               end;

        end;

end;

procedure ProcesaFacturas;

var  RegistroFacturacion : TRegistroFacturacion;

procedure ProcesaPagosFactura( SerieFactura,
                               ProveedorFactura : String;
                               EjercicioFactura : SmallInt;
                               NroFactura       : LongInt );

var  RegistroFacturacion : TRegistroFacturacion;
     ProcesarEfecto : Boolean;

begin

     With DmEfectoPagarTable  do
       try

         // Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto

         SetRange( [ EjercicioFactura, ProveedorFactura, SerieFactura, NroFactura ] );

         First;
         While not Eof do
           begin

           If   not SessionDataModule.Dm10.EfectoPagarModule.EfectoPendiente( DmEfectoPagarFields )
           then begin

                ProcesarEfecto := False;

                If   DmEfectoPagarFields.NroRemesa.Value<>0
                then begin
                     RemesaPagoFields.Update;
                     ProcesarEfecto := ( RemesaPagoFields.Estado.Value=erpPagada ) and
                                       ( RemesaPagoFields.FechaPago.Value>=FechaInicial ) and
                                       ( RemesaPagoFields.FechaPago.Value<=FechaFinal );
                     end
                else ProcesarEfecto := ( DmEfectoPagarFields.FechaPago.Value>=FechaInicial ) and
                                       ( DmEfectoPagarFields.FechaPago.Value<=FechaFinal );

                If   ProcesarEfecto
                then With DmApunteCajaTable do
                       try

                         With DmEfectoPagarFields do
                           DmApunteCajaTable.SetRange( [ tapTraspasoIVA, Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );

                         First;
                         While not Eof do
                           begin

                           For RegistroFacturacion in ListaRegistroFacturacion do
                             If   ( RegistroFacturacion.FechaAplicacion=FechaAplicacionRegistro ) and
                                  ( RegistroFacturacion.TipoImpositivo=DmApunteCajaFields.Tipo.Value )
                             then begin
                                  DecAdd( RegistroFacturacion.BaseImponibleCaja, DmApunteCajaFields.BaseImponible.Value );
                                  DecAdd( RegistroFacturacion.CuotaIVACaja, DmApunteCajaFields.CuotaIVA.Value );
                                  DecAdd( RegistroFacturacion.ImporteCaja, DmApunteCajaFields.ImporteTotal.Value );

                                  // Si se anota más de un pago con el mismo tipo impositivo, los datos del pago son los del último efecto procesado

                                  If   DmEfectoPagarFields.NroRemesa.Value=0
                                  then RegistroFacturacion.FechaCobro := DmEfectoPagarFields.FechaPago.Value
                                  else RegistroFacturacion.FechaCobro := RemesaPagoFields.FechaPago.Value;

                                  RegistroFacturacion.ConceptoCobro := DmEfectoPagarFields.Concepto.Value;
                                  RegistroFacturacion.CCC := SessionDataModule.Dm10.ProveedorModule.IBAN( DsProveedorFields );
                                  RegistroFacturacion.CodigoMedioCobro := 'O';
                                  If   SessionDataModule.Dm10.FormaCobroModule.Obten( DmEfectoPagarFields.FormaDePago.Value, DsFormaCobroFields )
                                  then If   DsFormaCobroFields.TipoDeDocumento.Value=tdChequeBancarioPagare
                                       then RegistroFacturacion.CodigoMedioCobro := 'T'
                                       else If   RegistroFacturacion.CCC<>''
                                            then RegistroFacturacion.CodigoMedioCobro := 'C';

                                  Break;
                                  end;

                           Next;
                           end;

                       finally
                         CancelRange;
                         end;

                end;

           Next;
           end;

       finally
         CancelRange;
         end;

end;

begin

       With DmAsientoTable do
         try

           ListaRegistroFacturacion := TListaRegistroFacturacion.Create;

           SetRange( [ taFraRecibida, FechaInicial ], [ taFraRecibida, FechaFinal ] );

           SessionDataModule.SendNotification( ntInformation, Format( RsMsg11, [ RsMsg12 ] ) );
           SessionDataModule.StartProgress( False, RecordCount );

           First;
           While not Eof  do
             begin

             SessionDataModule.SendProgress( 'Factura' );

             SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( DmAsientoFields.Propietario.Value, DsProveedorFields );
             SessionDataModule.Dm00.PaisModule.Obten( DsProveedorFields.CodigoPais.Value, DsPaisfields );

             If   ( ( ( lrFrasRecibidas in LibrosRegistro ) or ( lrBienesInversion in LibrosRegistro ) ) and ( DmAsientoFields.Origen.Value=ofrSujetoPasivo ) and ( DsProveedorFields.Factura_ModeloIVA.Value<>mipRegimenEspecial ) ) or
                  ( ( lrRegimenEspecial in LibrosRegistro ) and ( DsProveedorFields.Factura_ModeloIVA.Value=mipRegimenEspecial ) ) or
                  ( ( lrAdquisicionesIntracomunitarias in LibrosRegistro ) and ( DmAsientoFields.Origen.Value=ofrIntracomunitaria ) ) or
                  ( ( lrInversionSujetoPasivo in LibrosRegistro ) and ( DmAsientoFields.Origen.Value=ofrInversionSP ) ) or
                  ( lrEspecial in LibrosRegistro )
             then begin

                  If   not ObtenRegistroContableFactura( tfAsiento, DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, DsFacturaFields )
                  then begin
                       SessionDataModule.SendNotification( ntError, Format( RsMsg9, [ DmAsientoFields.NroAsiento.Value ] ) );
                       Abort;
                       end;

                  With DmApunteTable do
                    try

                      With DmAsientoFields do
                        SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );

                      ClearListaRegistroFacturacion( ListaRegistroFacturacion );
                      TotalCuotaFactura := 0.0;
                      TotalImporteFactura := 0.0;
                      FechaAplicacionRegistro := SessionDataModule.Dm10.TasaModule.UltimaFechaAplicacion( DmAsientoFields.FechaDocumento.Value );

                      RetencionCorrecta := not PorTipoRetencion;
                      LibroCorrecto := False;

                      First;
                      While not Eof do
                        begin
                        AñadeRegistroFacturacion;
                        If   PorTipoRetencion
                        then If   DmApunteFields.TipoApunte.Value=tapRetencion
                             then begin
                                  RetencionCorrecta := DmApunteFields.Tipo.Value=TipoRetencion;
                                  Break;
                                  end;
                        Next;
                        end;

                    finally
                      CancelRange;
                      end;

                  If   RetencionCorrecta
                  then begin

                       If   PeriodoAplicacionCriterioCaja and
                            ( DsProveedorFields.Factura_RegimenEspecialCC.Value or
                            ( SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value and ( DsProveedorFields.Factura_ModeloIVA.Value=mipNormal ) ) )
                       then ProcesaPagosFactura( DmAsientoFields.Serie.Value,
                                                 DmAsientoFields.Propietario.Value,
                                                 DmAsientoFields.Ejercicio.Value,
                                                 DmAsientoFields.NroFactura.Value );

                       For RegistroFacturacion in ListaRegistroFacturacion do
                         begin

                         If   DeclaracionInformativa or not SoloTablaResumen
                         then begin

                              DiarioTable.Append;

                              IndiceRegistro := ListaRegistroFacturacion.IndexOfItem( RegistroFacturacion, TDirection.FromBeginning ) + 1;

                              DiarioFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                              DiarioFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                              DiarioFields.NroApunte.Value := IndiceRegistro;

                              If   PrimerNroOrden=0
                              then DiarioFields.NroRegistro.Value := DmAsientoFields.NroRegistro.Value
                              else DiarioFields.NroRegistro.Value := NroOrdenActual;

                              DiarioFields.Libro.Value := RegistroFacturacion.Libro;
                              DiarioFields.Serie.Value := DmAsientoFields.Serie.Value;
                              DiarioFields.NroFactura.Value := DmAsientoFields.NroFactura.Value;
                              DiarioFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                              DiarioFields.FechaDocumento.Value := DmAsientoFields.FechaDocumento.Value;
                              DiarioFields.Tipo.Value := RegistroFacturacion.TipoImpositivo;
                              DiarioFields.Propietario.Value := DmAsientoFields.Propietario.Value;
                              DiarioFields.Nombre.Value := DmAsientoFields.Nombre.Value;
                              DiarioFields.NIF.Value := DsProveedorFields.NIF.Value;
                              DiarioFields.Subcuenta.Value := RegistroFacturacion.Subcuenta;
                              DiarioFields.BaseImponibleIVA.Value := RegistroFacturacion.BaseImponible;
                              DiarioFields.TipoIVA.Value := RegistroFacturacion.TipoIVA;
                              DiarioFields.CuotaIVA.Value := RegistroFacturacion.CuotaIVA;
                              DiarioFields.Importe.Value := RegistroFacturacion.Importe;

                              DiarioFields.NroBasesImponibles.Value := ListaRegistroFacturacion.Count;
                              DiarioFields.TotalCuotas.Value := TotalCuotaFactura;
                              DiarioFields.TotalImporte.Value := TotalImporteFactura;

                              If   RegistroFacturacion.ImporteCaja<>0.0
                              then begin
                                   DiarioFields.BaseImponibleCaja.Value := RegistroFacturacion.BaseImponibleCaja;
                                   DiarioFields.CuotaIVACaja.Value := RegistroFacturacion.CuotaIVACaja;
                                   DiarioFields.ImporteCaja.Value := RegistroFacturacion.ImporteCaja;
                                   DiarioFields.FechaCobro.Value := RegistroFacturacion.FechaCobro;
                                   DiarioFields.ConceptoCobro.Value := RegistroFacturacion.ConceptoCobro;
                                   DiarioFields.CCC.Value := RegistroFacturacion.CCC;
                                   DiarioFields.CodigoMedioCobro.Value := RegistroFacturacion.CodigoMedioCobro;

                                   AcumuladoFacturacion.ExisteRegistroCriterioCaja := True;
                                   end;

                              DiarioTable.Post;

                              If   SessionDataModule.SendNotification( ntRecord, StrFormatDate( DiarioFields.Fecha.Value, dfDefault2 ) + ' - ' + IntToStr( DiarioFields.NroAsiento.Value ) + ' / ' + IntToStr( IndiceRegistro ) )
                              then Abort;

                              end;

                         Acumuladofacturacion.Acumula( RegistroFacturacion );
                         end;

                       end;

                  Inc( NroOrdenActual );
                  end;

             Next;
             end;

         finally
           ClearListaRegistroFacturacion( ListaRegistroFacturacion );
           ListaRegistroFacturacion.Free;
           CancelRange;
           end;

end;

begin

     PeriodoAplicacionCriterioCaja := YearOf( FechaInicial )>=2014;

     Acumuladofacturacion := TAcumuladoFacturacion.Create;

     DiarioTable := TnxeTable.Create( nil );
     DiarioTable.Database := SessionDataModule.TemporalDatabase;
     DiarioTable.TableName := DiarioTableName;
     DiarioTable.Open;

     try

       DiarioFields := TDiarioFacturacionFields.Create( DiarioTable );
       RemesaPagoFields := TRemesaPagoFields.Create( SessionDataModule.Dm10.RemesaPagoModule.DmRemesaPagoTable, True );

       NroOrdenActual := PrimerNroOrden;

       ProcesaFacturas;

       //** Falta procesar las facturas fuera de plazo del criterio de caja en la liquidación de Enero

       //* 21.10.1999  Añadida la comprobación de la SumaCuotaIVA para que se incluyan las facturas sin base imponible (pe. fras. de aduanas)

       If   not DeclaracionInformativa
       then begin

            Acumuladofacturacion.OrdenaSumas;

            var Id : SmallInt := 1;
            For SumasFacturacion in Acumuladofacturacion.Sumas do
              If   ( SumasFacturacion.BaseImponibleIVA<>0.0 ) or ( SumasFacturacion.CuotaIVA<>0.0 )
              then begin

                   With SumasFacturacion do
                     SessionDataModule.Dm10.TasaModule.TipoIVA( FechaAplicacion, TipoImpositivo, DsTiposIVAFields );

                   DiarioTable.Append;

                   DiarioFields.Libro.Value := 0;
                   DiarioFields.Ejercicio.Value := 0;               // Registro especial
                   DiarioFields.Fecha.Value := SumasFacturacion.FechaAplicacion;
                   DiarioFields.NroAsiento.Value := Id;             // Id
                   DiarioFields.Tipo.Value := SumasFacturacion.TipoImpositivo;
                   DiarioFields.Nombre.Value := DsTiposIVAFields.Descripcion.Value;
                   DiarioFields.BaseImponibleIVA.Value := SumasFacturacion.BaseImponibleIVA;
                   DiarioFields.TipoIVA.Value := DsTiposIVAFields.IVASoportado.Value;
                   DiarioFields.CuotaIVA.Value := SumasFacturacion.CuotaIVA;
                   DiarioFields.Importe.Value := SumasFacturacion.Importe;

                   DiarioTable.Post;

                   Inc( Id );
                   end;

              end;

         finally
           DiarioTable.Free;
           SessionDataModule.EndProgress;
           end;

     Result := AcumuladoFacturacion;
end;

// Devuelve True si se ha rehubicado un registro. En ese caso puede ser necesaria una segunda vuelta para crear el del
// asiento que lo ha podido perder.

procedure TFacturaModule.CompruebaRegistroFacturaAsiento(     AsientoFields     : TAsientoFields;
                                                          var RegistroReubicado : Boolean;
                                                              CorregirErrores   : Boolean = False );

var  RegistroComercialEncontrado,
     Correcto : Boolean;
     CodigoComercial : String;

begin

     Correcto := False;

     // SessionDataModule.SendNotification( ntRecord, Format( RsMsg1, [ AsientoFields.NroAsiento.Value ] ) );  // Demasiado lento

     If   not DmFacturaContableTable.FindKey( [ tfAsiento, SessionDataModule.Ejercicio, AsientoFields.NroAsiento.Value ] )
     then begin
          DmFacturaContableTable.Append;

          DmFacturaContableFields.Tipo.Value := tfAsiento;
          DmFacturaContableFields.Ejercicio.Value := SessionDataModule.Ejercicio;
          DmFacturaContableFields.Propietario.Value := '';
          DmFacturaContableFields.SerieFactura.Value := '';
          DmFacturaContableFields.NroRegistro.Value := AsientoFields.NroAsiento.Value;

          DmFacturaContableTable.Post;
          end;

     If   CorregirErrores
     then begin

          RegistroComercialEncontrado := False;

          If   AsientoFields.TipoAsiento.Value=taFraRecibida
          then begin
               If   AsientoFields.Propietario.Value<>''
               then begin
                    If   Length( AsientoFields.Propietario.Value )=LongitudSubcuenta   // Proviene de un registro de compras y gastos contable
                    then begin
                         If   DmFacturaContableAuxTable.FindEqualFirst( [ tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.Propietario.Value, AsientoFields.Serie.Value ] )
                         then begin

                              If   DmFacturaContableFields.NroRegistro.Value<>DmFacturaContableAuxFields.NroRegistro.Value
                              then begin
                                   DmFacturaContableTable.Delete;  // Suprimo el registro duplicado erróneo
                                   RegistroReubicado := True;
                                   end;

                              DmFacturaContableAuxTable.Edit;
                              DmFacturaContableAuxFields.Propietario.Clear;
                              DmFacturaContableAuxFields.SerieFactura.Clear;
                              DmFacturaContableAuxFields.NroRegistro.Value := AsientoFields.NroAsiento.Value;
                              DmFacturaContableAuxTable.Post;

                              end;

                         end
                    else If   SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( AsientoFields.Propietario.Value, DsProveedorFields )
                         then RegistroComercialEncontrado := DmFacturaComercialTable.FindKey( [ tfFacturaCompras,
                                                                                                AsientoFields.Ejercicio.Value,
                                                                                                DsProveedorFields.Codigo.Value,
                                                                                                AsientoFields.Serie.Value,
                                                                                                0 ] );
                    end;

               end
          else If   AsientoFields.TipoAsiento.Value=taFraEmitida
               then RegistroComercialEncontrado := DmFacturaComercialTable.FindKey( [ tfFacturaVentas,
                                                                                      AsientoFields.Ejercicio.Value,
                                                                                      '',
                                                                                      AsientoFields.Serie.Value,
                                                                                      AsientoFields.NroFactura.Value ] );

          If   RegistroComercialEncontrado
          then begin

               DmFacturaContableTable.Edit;

               DmFacturaContableFields.EjercicioFraRectificada.Value := DmFacturaComercialFields.EjercicioFraRectificada.Value;
               DmFacturaContableFields.SerieFraRectificada.Value := DmFacturaComercialFields.SerieFraRectificada.Value;
               DmFacturaContableFields.NroFacturaRectificada.Value := DmFacturaComercialFields.NroFacturaRectificada.Value;
               DmFacturaContableFields.Razon.Value := DmFacturaComercialFields.Razon.Value;
               DmFacturaContableFields.Metodo.Value := DmFacturaComercialFields.Metodo.Value;
               DmFacturaContableFields.TipoFactura.Value := DmFacturaComercialFields.TipoFactura.Value;
               DmFacturaContableFields.RegimenOTrascendencia.Value := DmFacturaComercialFields.RegimenOTrascendencia.Value;
               DmFacturaContableFields.TipoFacturaRectificativa.Value := DmFacturaComercialFields.TipoFacturaRectificativa.Value;
               DmFacturaContableFields.CausaExencion.Value := DmFacturaComercialFields.CausaExencion.Value;
               DmFacturaContableFields.TipoOperacionIntracomunitaria.Value := DmFacturaComercialFields.TipoOperacionIntracomunitaria.Value;
               DmFacturaContableFields.SituacionInmueble.Value := DmFacturaComercialFields.SituacionInmueble.Value;
               DmFacturaContableFields.ReferenciaCatastral.Value := DmFacturaComercialFields.ReferenciaCatastral.Value;
               DmFacturaContableFields.IdentificacionDescripcionBienes.Value := DmFacturaComercialFields.IdentificacionDescripcionBienes.Value;
               DmFacturaContableFields.FechaInicioUtilizacion.Value := DmFacturaComercialFields.FechaInicioUtilizacion.Value;
               DmFacturaContableFields.ProrrataAnualDefinitiva.Value := DmFacturaComercialFields.ProrrataAnualDefinitiva.Value;
               DmFacturaContableFields.Descripcion.Value := DmFacturaComercialFields.Descripcion.Value;

               DmFacturaContableFields.Propietario.Clear;
               DmFacturaContableFields.SerieFactura.Clear;

               DmFacturaContableFields.NroRegistro.Value := AsientoFields.NroAsiento.Value;

               DmFacturaContableTable.Post;

               end;

          end;

end;

procedure TFacturaModule.CopiaRegistroFactura( Tipo                 : SmallInt;
                                               Propietario,
                                               Serie                : String;
                                               NroFactura,
                                               NroAsiento           : LongInt;
                                               AsientoFacturaFields : TFacturaFields = nil );   // La tabla y campos destino. Pueden ser de otra Empresa

var  FieldValues : TFieldValuesArray;
     Found : Boolean;

begin

     try

       If   not Assigned( AsientoFacturaFields )
       then AsientoFacturaFields := DmFacturaContableFields;

       SuprimeRegistroContableFactura( tfAsiento, NroAsiento, AsientoFacturaFields.Table );

       Found := DmFacturaComercialTable.FindKey( [ Tipo, SessionDataModule.Ejercicio, Propietario, Serie, NroFactura ] );

       If   Found
       then FieldValues := DmFacturaComercialTable.GetFieldValues;

       AsientoFacturaFields.Table.Append;
       If   Found
       then AsientoFacturaFields.Table.SetFieldValues( FieldValues );

       AsientoFacturaFields.Tipo.Value := tfAsiento;
       AsientoFacturaFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       AsientoFacturaFields.Propietario.Value := '';
       AsientoFacturaFields.SerieFactura.Value := '';
       AsientoFacturaFields.NroRegistro.Value := NroAsiento;

       AsientoFacturaFields.Table.Post;

     except
       AsientoFacturaFields.Table.Cancel;
       raise;
       end;

end;

function TFacturaModule.ClonaRegistroAsiento( NroAsientoOrigen,
                                              NroAsientoDestino    : LongInt;
                                              SuprimeAsientoOrigen : Boolean = False ) : Boolean;

var  FieldValues : TFieldValuesArray;

begin
     Result := False;
     If   DmFacturaContableTable.FindKey( [ tfAsiento, SessionDataModule.Ejercicio, NroAsientoOrigen ] )
     then begin
          FieldValues := DmFacturaContableTable.GetFieldValues;

          try
            DmFacturaContableTable.Append;
            DmFacturaContableFields.Table.SetFieldValues( FieldValues );
            DmFacturaContableFields.NroRegistro.Value := NroAsientoDestino;
            DmFacturaContableTable.Post;
          except
            DmFacturaContableTable.Cancel;
            raise;
            end;

          If   SuprimeAsientoOrigen
          then SuprimeRegistroContableFactura( tfAsiento, NroAsientoOrigen );

          Result := True;
          end;
end;

function TFacturaModule.ObtenRegistroContableFactura( Tipo          : SmallInt;
                                                      Ejercicio     : SmallInt;
                                                      NroAsiento    : Integer;
                                                      FacturaFields : TFacturaFields ) : Boolean;
begin
     Result := DmFacturaContableTable.FindKey( [ Tipo, Ejercicio, NroAsiento ] );
     FacturaFields.Update( DmFacturaContableTable );
end;

procedure TFacturaModule.SuprimeRegistroContableFactura( Tipo         : SmallInt;
                                                         NroAsiento   : Integer;
                                                         FacturaTable : TnxeTable = nil );
begin
     If   not Assigned( FacturaTable )
     then FacturaTable := DmFacturaContableTable;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ FacturaTable ] );
     try
       If   FacturaTable.FindKey( [ Tipo, SessionDataModule.Ejercicio, NroAsiento ] )
       then FacturaTable.Delete;
       TransactionTag.Commit;
     except
       TransactionTag.Rollback;
       raise;
       end;
end;

function TFacturaModule.ObtenRegistroComercialFactura( Tipo          : SmallInt;
                                                       Ejercicio     : SmallInt;
                                                       Propietario,
                                                       Serie         : String;
                                                       NroRegistro   : Integer;
                                                       FacturaFields : TFacturaFields ) : Boolean;
begin
     Result := DmFacturaComercialTable.FindKey( [ Tipo, Ejercicio, Propietario, Serie, NroRegistro ] );
     FacturaFields.Update( DmFacturaComercialTable );
end;

procedure TFacturaModule.SuprimeRegistroComercialFactura( Tipo         : SmallInt;
                                                          Propietario,
                                                          Serie        : String;
                                                          NroRegistro  : Integer;
                                                          FacturaTable : TnxeTable = nil );
begin
     If   not Assigned( FacturaTable )
     then FacturaTable := DmFacturaComercialTable;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ FacturaTable ] );
     try
       If   FacturaTable.FindKey( [ Tipo, SessionDataModule.Ejercicio, Propietario, Serie, NroRegistro ] )
       then FacturaTable.Delete;
       TransactionTag.Commit;
     except
       TransactionTag.Rollback;
       raise;
       end;
end;


procedure TFacturaModule.CompletaRegistroFacturaExpedida( CodigoProvincia,
                                                          CodigoPais      : String;
                                                          Rectificativa,
                                                          Simplificada,
                                                          VentasOnline    : Boolean;
                                                          FacturaFields   : TFacturaFields );

var TipoFactura,
    RegimenOTrascendencia,
    CausaExencion : SmallInt;

begin
     CompletaRegistroFacturaExpedida( CodigoProvincia,
                                      CodigoPais,
                                      Rectificativa,
                                      Simplificada,
                                      VentasOnline,
                                      TipoFactura,
                                      RegimenOTrascendencia,
                                      CausaExencion );
     FacturaFields.Creado.Value := Now;
     FacturaFields.TipoFactura.Value := TipoFactura;
     FacturaFields.RegimenOTrascendencia.Value := RegimenOTrascendencia;
     FacturaFields.CausaExencion.Value := CausaExencion;
end;

procedure TFacturaModule.CompletaRegistroFacturaExpedida(     CodigoProvincia,
                                                              CodigoPais            : String;
                                                              Rectificativa,
                                                              Simplificada,
                                                              VentasOnline          : Boolean;
                                                          out TipoFactura           : SmallInt;
                                                          out RegimenOTrascendencia : SmallInt;
                                                          out CausaExencion         : SmallInt );
begin

     TipoFactura := tfeOrdinaria;
     RegimenOTrascendencia := rteRegimenGeneral;
     CausaExencion := fexArticulo20;

     // Tipo de factura

     If   Rectificativa
     then TipoFactura := tfeRectificativaResto                   // Factura Rectificativa (Resto)
     else If   Simplificada
          then TipoFactura := tfeSimplificadaOSinIdentificacion  // Factura Simplificada (ticket) o sin identificación del destinatario (clientes varios)
          else TipoFactura := tfeOrdinaria;                      // Factura

     // Régimen o trascendencia

      If   ( ( CodigoPais<>'' ) and ( CodigoPais<>CodigoEspaña ) ) or

          ( ( CodigoPais=CodigoEspaña ) and
            ( CodigoProvincia='35' ) or     // Canarias, Ceuta y Melilla
            ( CodigoProvincia='38' ) or
            ( CodigoProvincia='51' ) or
            ( CodigoProvincia='52' ) )

     then begin

          RegimenOTrascendencia := rteExportacion;                   // Exportación
          CausaExencion := fexArticulo21;                            // E2 Exenta por el artículo 21

          If    ( CodigoPais<>CodigoEspaña ) and SessionDataModule.Dm00.PaisModule.Obten( CodigoPais, DsPaisFields )
          then If   DsPaisFields.Intracomunitario.Value
               then begin
                    If   VentasOnline
                    then RegimenOTrascendencia := rteVentasOnline
                    else RegimenOTrascendencia := rteRegimenGeneral; // Operación de régimen general (modificado el 17.04.2018)
                    CausaExencion := fexArticulo25;                  // E5 Exenta por el artículo 25
                    end;

          {
           E1 Exenta por el artículo 20
           E2 Exenta por el artículo 21
           E3 Exenta por el artículo 22
           E4 Exenta por artículo 23 y 24
           E5 Exenta por el artículo 25
           E6 Exenta por Otros
          }

          end;

     If   ( SessionDataModule.Ejercicio>=2014 ) and SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value
     then RegimenOTrascendencia := rteCriterioCaja;            // Régimen especial criterio de caja

end;

procedure TFacturaModule.CompletaRegistroFacturaRecibida( SubcuentaPropietario,
                                                          CodigoPais            : String;
                                                          ModeloIVA             : TModeloIVAProveedor;
                                                          FacturaFields         : TFacturaFields );

var TipoFactura,
    RegimenOTrascendencia,
    TipoOperacionIntracomunitaria : SmallInt;

begin
     CompletaRegistroFacturaRecibida( SubcuentaPropietario,
                                      CodigoPais,
                                      ModeloIVA,
                                      TipoFactura,
                                      RegimenOTrascendencia,
                                      TipoOperacionIntracomunitaria );
     FacturaFields.Creado.Value := Now;
     FacturaFields.TipoFactura.Value := TipoFactura;
     FacturaFields.RegimenOTrascendencia.Value := RegimenOTrascendencia;
     FacturaFields.TipoOperacionIntracomunitaria.Value := TipoOperacionIntracomunitaria;
end;

procedure TFacturaModule.CompletaRegistroFacturaRecibida(     SubcuentaPropietario          : String;
                                                              CodigoPais                    : String;
                                                              ModeloIVA                     : TModeloIVAProveedor;
                                                          out TipoFactura                   : SmallInt;
                                                          out RegimenOTrascendencia         : SmallInt;
                                                          out TipoOperacionIntracomunitaria : SmallInt );
begin

     TipoFactura := tfrOrdinaria;
     RegimenOTrascendencia := rtrRegimenGeneral;
     TipoOperacionIntracomunitaria := faiSujetas;

     If   ( CodigoPais<>'' ) and ( CodigoPais<>CodigoEspaña )
     then begin
          TipoFactura := tfrImportacionesDUA;                         // Importaciones (DUA)
          If   SessionDataModule.Dm00.PaisModule.Obten( CodigoPais, DsPaisFields )
          then If   DsPaisFields.Intracomunitario.Value
               then begin
                    TipoFactura := tfrOrdinaria;                      // Cuando se trata de proveedores intracomunitarios el tipo de factura es ordinario
                    RegimenOTrascendencia := rtrIntracomunitarias;    // Adquisiciones intracomunitarias de bienes y prestaciones de servicios
                    end;
          end
     else If   ModeloIVA=mipRegimenEspecial
          then begin
               TipoFactura := tfrJustificantes;                       // Justificantes contables
               RegimenOTrascendencia := rtrAgriculturaGanaderiaPesca; // Operaciones por las que los empresarios satisfacen compensaciones en las adquisiciones a personas acogidas al Régimen especial de la agricultura, ganaderia y pesca
               end;

     If   Copy( SubcuentaPropietario, 1, 2 )='41'
     then TipoOperacionIntracomunitaria := faiServicios;              // Clave I : Acreedores por prestación de servicios

end;

function  TFacturaModule.ObtenImportesFacturaEmitida(     Ejercicio      : SmallInt;
                                                          Serie          : String;
                                                          NroFactura     : LongInt;
                                                      out Asiento        : IAsiento;
                                                      out BaseImponible,
                                                          CuotaIVA,
                                                          CuotaRE,
                                                          ImporteTotal    : Decimal ) : Boolean;
begin
     Result := False;
     DmAsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';
     If   DmAsientoFacturaTable.FindKey( [ taFraEmitida, Ejercicio, Serie, NroFactura, 255 ] )
     then With DmAsientoFacturaFields do
            begin
            Asiento := TAsiento.FromDataset( DmAsientoFacturaFields );
            Result := SessionDataModule.Dm10.AsientoModule.ObtenImportesFactura( Ejercicio.Value,
                                                                                 NroAsiento.Value,
                                                                                 BaseImponible,
                                                                                 CuotaIVA,
                                                                                 CuotaRE,
                                                                                 ImporteTotal );
            end;
end;

function TFacturaModule.ObtenImportesFacturaRecibida(     Ejercicio       : SmallInt;
                                                          Propietario,
                                                          SerieNroFactura : String;
                                                      out Asiento         : IAsiento;
                                                      out BaseImponible,
                                                          CuotaIVA,
                                                          ImporteTotal    : Decimal ) : Boolean;

var CuotaRE : Decimal;

begin
     Result := False;
     DmAsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
     If   DmAsientoFacturaTable.FindKey( [ taFraRecibida, Ejercicio, Propietario, SerieNroFactura, 0, 255 ] )
     then With DmAsientoFacturaFields do
            begin
            Asiento := TAsiento.FromDataset( DmAsientoFacturaFields );
            Result := SessionDataModule.Dm10.AsientoModule.ObtenImportesFactura( Ejercicio.Value,
                                                                                 NroAsiento.Value,
                                                                                 BaseImponible,
                                                                                 CuotaIVA,
                                                                                 CuotaRE,
                                                                                 ImporteTotal );
            end;
end;

function TFacturaModule.ObtenImporteDeclaradoAnterior(     FechaInicialActual,
                                                           FechaFinalActual      : TDate;
                                                           Periodicidad          : SmallInt;
                                                           TipoAsiento           : SmallInt;
                                                           Propietario           : String;
                                                       out BaseImponible         : Decimal ) : Boolean;

var  FechaInicial,
     FechaFinal : TDate;

begin
     case Periodicidad of
       // Mensual
       0 : begin
           FechaInicial := IncMonth( FechaInicialActual, -1 );
           FechaFinal := IncMonth( FechaFinalActual, -1 );
           end;
       // Trimestral
       1 : begin
           FechaInicial := IncMonth( FechaInicialActual, -3 );
           FechaFinal := IncMonth( FechaFinalActual, -3 );
           end;
       // Anual
       2 : begin
           FechaInicial := IncMonth( FechaInicialActual, -12 );
           FechaFinal := IncMonth( FechaFinalActual, -12 );
           end;
       end;

     DmAsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';

     BaseImponible := 0.0;

     With DmAsientoAuxTable do
       begin
       SetRange( [ TipoAsiento, FechaInicial ], [ TipoAsiento, FechaFinal ] );
       First;
       While not Eof do
         begin

         If   DmAsientoAuxFields.Propietario.Value=Propietario
         then If   ObtenRegistroContableFactura( tfAsiento, DmAsientoAuxFields.Ejercicio.Value, DmAsientoAuxFields.NroAsiento.Value, DsFacturaAnteriorFields )
              then begin

                   var FacturaValida := True;

                   // Si es una factura rectificativa comprobamos si pertenece al mismo periodo o a uno anterior

                   If   ( ( TipoAsiento=taFraEmitida ) and ( DsFacturaAnteriorFields.TipoFactura.Value in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ] ) or
                          ( TipoAsiento=taFraRecibida ) and ( DsFacturaAnteriorFields.TipoFactura.Value in [ tfrRectificativa_80_1_2..tfrRectificativaSimplificada ] ) )
                   then If   DmAsientoFacturaTable.FindKey( [ TipoAsiento, DsFacturaAnteriorFields.EjercicioFraRectificada.Value,
                                                                           DsFacturaAnteriorFields.SerieFraRectificada.Value,
                                                                           DsFacturaAnteriorFields.NroFacturaRectificada, 255 ] )
                        then FacturaValida := DmAsientoFacturaFields.Fecha.Value>=FechaInicial;

                   If   FacturaValida
                   then begin

                        DmApunteAuxTable.SetRange( [ DmAsientoAuxFields.Ejercicio.Value, DmAsientoAuxFields.NroAsiento.Value, 2 ],
                                                   [ DmAsientoAuxFields.Ejercicio.Value, DmAsientoAuxFields.NroAsiento.Value, MaxSmallInt ] );

                        While not DmApunteAuxTable.Eof do
                           begin
                           If   DmApunteAuxFields.TipoApunte.Value=tapManual
                           then DecAdd( BaseImponible, DmApunteAuxFields.BaseImponible.Value );
                           DmApunteAuxTable.Next;
                           end;

                        end;

                   end;

         Next;
         end;

       end;
end;

function TFacturaModule.ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                                   Periodicidad         : SmallInt;
                                                                   FechaInicial,
                                                                   FechaFinal           : TDateTime ) : IAcumuladoOPeracionesIntracomunitarias;

const ClaveOperacionArray : Array of Char = [ 'E', 'T', 'S', 'M', 'H' ];

var   IndiceRegistro : SmallInt;

      OperacionesTable,
      OperacionesAuxTable : TnxeTable;
      OperacionesFields : TOperacionesIntracomunitariasFields;
      AcumuladoOperacionesIntracomunitarias : TAcumuladoOperacionesIntracomunitarias;

      Ejercicio,
      TipoRegistro,
      TipoOperacion : SmallInt;
      IdRegistroFactura : LongWord;
      ClaveOperacion : String;
      CodigoPais,
      NIF,
      NIFOperadorComunitario,
      NombreOperador : String;

      EjercicioRectificacion : SmallInt;
      SerieNroFacturaRectificada : String;
      FechaRectificacion : TDate;

      BaseImponibleFactura,
      BaseImponibleRectificada,
      BaseImponibleAnterior : Decimal;

      AsientoFraRectificada : IAsiento;
      BaseImponible,
      CuotaIVA,
      CuotaRE,
      ImporteTotal : Decimal;

function ObtenNIFIntracomunitario( CodigoISO : String; NIF : String ) : String;
begin
     If   IsAlphabeticString( Copy( NIF, 1, 2 ) ) // El NIF ya incluye el codigo ISO
     then Result := RightPad( NIF, 20 )
     else Result := CodigoISO + RightPad( NIF, 18 );
end;

begin

     AcumuladoOperacionesIntracomunitarias := TAcumuladoOperacionesIntracomunitarias.Create;

     OperacionesTable := TnxeTable.Create( nil );
     OperacionesTable.Database := SessionDataModule.TemporalDatabase;
     OperacionesTable.TableName := OperacionesTableName;
     OperacionesTable.Open;

     // La tabla OperacionesAuxTable solo se utiliza para comprobar registros existentes de rectificaciones

     OperacionesAuxTable := TnxeTable.Create( nil );
     OperacionesAuxTable.Database := SessionDataModule.TemporalDatabase;
     OperacionesAuxTable.TableName := OperacionesTableName;
     OperacionesAuxTable.Open;

     try

       OperacionesFields := TOperacionesIntracomunitariasFields.Create( OperacionesTable );

       try

         DmAsientoTable.SetRange( [ taFraEmitida, FechaInicial ], [ taFraRecibida, FechaFinal ] );

         SessionDataModule.SendNotification( ntInformation, Format( RsMsg11, [ '' ] ) );
         SessionDataModule.StartProgress( False, DmAsientoTable.RecordCount );

         DmAsientoTable.First;
         While not DmAsientoTable.Eof  do
           begin

           SessionDataModule.SendProgress( 'Factura' );

           var ExisteFichaPropietario := False;

           // De momento no tengo otra forma de identificar las facturas emitidas intracomunitarias que el pais del cliente

           If   DmAsientoFields.TipoAsiento.Value=taFraEmitida
           then begin
                ExisteFichaPropietario := SessionDataModule.Dm10.ClienteModule.ObtenPorSubcuenta( DmAsientoFields.Propietario.Value, DsClienteFields );
                NIF := DsClienteFields.NIF.Value;
                NombreOperador := DsClienteFields.Nombre.Value;
                CodigoPais := DsClienteFields.CodigoPais.Value;
                end
           else If   DmAsientoFields.Origen.Value=ofrIntracomunitaria  // Así evito realizar la consulta en las facturas que no son intracomunitarias
                then begin
                     ExisteFichaPropietario := SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( DmAsientoFields.Propietario.Value, DsProveedorFields );
                     NIF := DsProveedorFields.NIF.Value;
                     NombreOperador := DsProveedorFields.Nombre.Value;
                     CodigoPais := DsProveedorFields.CodigoPais.Value;
                     end;

           SessionDataModule.Dm00.PaisModule.Obten( CodigoPais, DsPaisfields );

           If    ( ( DmAsientoFields.TipoAsiento.Value=taFraRecibida ) and ( DmAsientoFields.Origen.Value=ofrIntracomunitaria ) ) or
                 ( ( DmAsientoFields.TipoAsiento.Value=taFraEmitida ) and ( CodigoPais<>CodigoEspaña ) and ( DsPaisFields.Intracomunitario.Value ) )
           then begin

                If   not ExisteFichaPropietario
                then begin
                     SessionDataModule.SendNotification( ntError, Format( RsMsg10, [ DmAsientoFields.Propietario.Value ] ) );
                     Abort;
                     end;

                If   NIF=''
                then begin
                     SessionDataModule.SendNotification( ntError, Format( RsMsg8, [ DmAsientoFields.Propietario.Value, NombreOperador ] ) );
                     Abort;
                     end;

                If   not ObtenRegistroContableFactura( tfAsiento, DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, DsFacturaFields )
                then begin
                     SessionDataModule.SendNotification( ntError, Format( RsMsg9, [ DmAsientoFields.NroAsiento.Value ] ) );
                     Abort;
                     end;

                With DmAsientoFields do
                  DmApunteTable.SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );

                DmApunteTable.First;

                If   DmAsientoFields.TipoAsiento.Value=taFraEmitida
                then begin

                     If   DsFacturaFields.TipoFactura.Value in [ 4..8 ]
                     then TipoOperacion := toRectificacionEntregas
                     else TipoOperacion := toEntregas;

                     // Mantengo el calculo viejo de la clave de operación

                     If   DsFacturaFields.TipoOperacionIntracomunitaria.IsNull
                     then begin
                          If   Copy( DmApunteFields.Subcuenta.Value, 1, 3 )='705'   // Prestación de servicios
                          then ClaveOperacion := 'S'
                          else ClaveOperacion := 'E'
                          end
                     else If   DsFacturaFields.TipoOperacionIntracomunitaria.Value in [ 0..4 ]
                          then ClaveOperacion := ClaveOperacionArray[ DsFacturaFields.TipoOperacionIntracomunitaria.Value ]
                          else ClaveOperacion := 'E'

                     end
                else begin

                     If   DsFacturaFields.TipoFactura.Value in [ 6..10 ]
                     then TipoOperacion := toRectificacionAdquisiciones
                     else TipoOperacion := toAdquisiciones;

                     If   DsFacturaFields.TipoOperacionIntracomunitaria.IsNull
                     then begin
                          If   Copy( DmAsientoFields.Propietario.Value, 1, 2 )='41' // Acreedores por prestación de servicios
                          then ClaveOperacion := 'I'
                          else ClaveOperacion := 'A';
                          end
                     else If   DsFacturaFields.TipoOperacionIntracomunitaria.Value=1
                          then ClaveOperacion := 'I'
                          else ClaveOperacion := 'A';

                     end;

                NIFOperadorComunitario := ObtenNIFIntracomunitario( DsPaisFields.CodigoISO2.Value, NIF );

                // Tipos de registro : 0 = Adquisiciones y rectificaciones en el periodo y 1 = Rectificaciones de facturas de periodos anteriorres

                TipoRegistro := triNormal;

                Ejercicio := YearOf( DmAsientoFields.Fecha.Value );  // Por los ejercicios partidos

                //  Ejercicio, Tipo, ClaveOperacion, NIF

                try

                  BaseImponibleFactura := 0.0;

                  While not DmApunteTable.Eof do
                    begin
                    If   DmApunteFields.TipoApunte.Value=tapManual
                    then DecAdd( BaseImponibleFactura, DmApunteFields.BaseImponible.Value );
                    DmApunteTable.Next;
                    end;

                  If   TipoOperacion in [ toRectificacionAdquisiciones, toRectificacionEntregas ]
                  then begin

                       If   TipoOperacion=toRectificacionEntregas
                       then ObtenImportesFacturaEmitida(  DsFacturaFields.EjercicioFraRectificada.Value,
                                                          DsFacturaFields.SerieFraRectificada.Value,
                                                          DsFacturaFields.NroFacturaRectificada.Value,
                                                          AsientoFraRectificada,
                                                          BaseImponible,
                                                          CuotaIVA,
                                                          CuotaRE,
                                                          ImporteTotal )
                       else ObtenImportesFacturaRecibida( DsFacturaFields.EjercicioFraRectificada.Value,
                                                          DsFacturaFields.Propietario.Value,
                                                          DsFacturaFields.SerieFraRectificada.Value,
                                                          AsientoFraRectificada,
                                                          BaseImponible,
                                                          CuotaIVA,
                                                          ImporteTotal );

                       If   Assigned( AsientoFraRectificada )
                       then begin

                            If   AsientoFraRectificada.Fecha<FechaInicial   // La factura a la que rectifica es anterior al periodo de liquidación
                            then begin

                                 TipoRegistro := triRectificacionFraAnterior;

                                 If   OperacionesTable.FindKey( [ Ejercicio, triRectificacionFraAnterior, ClaveOperacion, NIFOperadorComunitario ] )
                                 then OperacionesTable.Edit
                                 else begin

                                      // Hay que averiguar la base imponible declarada anteriormente de este operador

                                      ObtenImporteDeclaradoAnterior( FechaInicial,
                                                                     FechaFinal,
                                                                     Periodicidad,
                                                                     DmAsientoFields.TipoAsiento.Value,
                                                                     DmAsientoFields.Propietario.Value,
                                                                     BaseImponibleAnterior );

                                      OperacionesTable.Append;

                                      OperacionesFields.Ejercicio.Value := YearOf( DmAsientoFields.Fecha.Value );
                                      OperacionesFields.TipoRegistro.Value := TipoRegistro;
                                      OperacionesFields.ClaveOperacion.Value := ClaveOperacion;
                                      OperacionesFields.NIF.Value := NIFOperadorComunitario;
                                      OperacionesFields.Subcuenta.Value := DmAsientoFields.Propietario.Value;
                                      OperacionesFields.NombreOperador.Value := NombreOperador;

                                      OperacionesFields.BaseImponibleRectificada.Value := BaseImponibleAnterior;
                                      OperacionesFields.BaseImponibleAnterior.Value := BaseImponibleAnterior;

                                      With AcumuladoOperacionesIntracomunitarias do
                                        NroRegistrosRectificaciones := NroRegistrosRectificaciones + 1;

                                      end;

                                   OperacionesFields.BaseImponible.Value := OperacionesFields.BaseImponible.Value + BaseImponibleFactura;

                                   OperacionesFields.FechaRectificacion.Value := AsientoFraRectificada.Fecha;
                                   OperacionesFields.EjercicioRectificacion.Value := DsFacturaFields.EjercicioFraRectificada.Value;
                                   OperacionesFields.SerieFacturaRectificada.Value := DsFacturaFields.SerieFraRectificada.Value;
                                   OperacionesFields.NroFacturaRectificada.Value := DsFacturaFields.NroFacturaRectificada.Value;

                                   OperacionesFields.BaseImponibleRectificada.Value := OperacionesFields.BaseImponibleRectificada.Value + BaseImponibleFactura;
                            
                                   With AcumuladoOperacionesIntracomunitarias do
                                     TotalBaseImponibleRectificaciones :=  TotalBaseImponibleRectificaciones + BaseImponibleFactura;

                                   OperacionesTable.Post;

                                 end;

                            end;

                       end;

                  // Si ya se ha creado un registro rectificativo de un periodo anterior, no se incluye en el registro genérico

                  If   TipoRegistro=triNormal
                  then begin

                       If   OperacionesTable.FindKey( [ Ejercicio, triNormal, ClaveOperacion, NIFOperadorComunitario ] )
                       then OperacionesTable.Edit
                       else begin

                            OperacionesTable.Append;

                            OperacionesFields.Ejercicio.Value := YearOf( DmAsientoFields.Fecha.Value );
                            OperacionesFields.TipoRegistro.Value := triNormal;
                            OperacionesFields.ClaveOperacion.Value := ClaveOperacion;
                            OperacionesFields.NIF.Value := NIFOperadorComunitario;
                            OperacionesFields.Subcuenta.Value := DmAsientoFields.Propietario.Value;
                            OperacionesFields.NombreOperador.Value := NombreOperador;

                            With AcumuladoOperacionesIntracomunitarias do
                              NroRegistrosFacturacion := NroRegistrosFacturacion + 1;

                            end;

                       // En los registros genéricos se acumulan las bases imponibles de facturas normales y se deducen las rectificativas del mismo periodo

                       OperacionesFields.BaseImponible.Value := OperacionesFields.BaseImponible.Value + BaseImponibleFactura;

                       With AcumuladoOperacionesIntracomunitarias do
                         TotalBaseImponible := TotalBaseImponible + BaseImponibleFactura;

                       OperacionesTable.Post;

                       end;

                  If   SessionDataModule.SendNotification( ntRecord, Format( RsMsg2, [ StrFormatDate( DmAsientoFields.Fecha.Value, dfDefault2 ), DmAsientofields.NroAsiento.Value ] ) )
                  then Abort;

                finally
                  DmApunteTable.CancelRange;
                  OperacionesTable.Cancel;
                  end;

                end;

           DmAsientoTable.Next;
           end;

         finally
           DmAsientoTable.CancelRange;
           end;

     finally
       OperacionesAuxTable.Free;
       OperacionesTable.Free;
       SessionDataModule.EndProgress;
       end;

     Result := AcumuladoOperacionesIntracomunitarias;
end;

function TFacturaModule.TextoSerieNroFactura( Serie : String; NroFactura : LongInt ) : String;
begin
     Result := Serie;
     If   NroFactura<>0
     then Result := Result + ' ' + IntToStr( NroFactura );
end;

{ TFacturaService }

procedure TFacturaService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TFacturaService.SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                                           DeclaracionInformativa : Boolean;
                                                           LibrosRegistro         : TLibrosRegistro;
                                                           SerieInicial,
                                                           SerieFinal             : String;
                                                           FechaInicial,
                                                           FechaFinal             : TDateTime;
                                                           PorTipoIVA             : Boolean = False;
                                                           TipoIVA                : SmallInt = 0;
                                                           PorTipoRetencion       : Boolean = False;
                                                           TipoRetencion          : SmallInt = 0;
                                                           SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;
begin
     Result := SessionDataModule.Dm10.FacturaModule.SeleccionaRegistrosFrasExpedidas( DiarioTableName, DeclaracionInformativa, LibrosRegistro, SerieInicial, SerieFinal, FechaInicial, FechaFinal, PorTipoIVA, TipoIVA, PorTipoRetencion, TipoRetencion, SoloTablaResumen );
end;

function TFacturaService.SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                                           DeclaracionInformativa : Boolean;
                                                           LibrosRegistro         : TLibrosRegistro;
                                                           FechaInicial,
                                                           FechaFinal             : TDateTime;
                                                           PrimerNroOrden         : Integer = 0;
                                                           PorTipoIVA             : Boolean = False;
                                                           TipoIVA                : SmallInt = 0;
                                                           PorTipoRetencion       : Boolean = False;
                                                           TipoRetencion          : SmallInt = 0;
                                                           SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;
begin
     Result := SessionDataModule.Dm10.FacturaModule.SeleccionaRegistrosFrasRecibidas( DiarioTableName, DeclaracionInformativa, LibrosRegistro, FechaInicial, FechaFinal, PrimerNroOrden, PorTipoIVA, TipoIVA, PorTipoRetencion, TipoRetencion, SoloTablaResumen );
end;

procedure TFacturaService.CompletaRegistroFacturaExpedida(     CodigoProvincia,
                                                               CodigoPais            : String;
                                                               Rectificativa,
                                                               Simplificada,
                                                               VentasOnline          : Boolean;
                                                           out TipoFactura           : SmallInt;
                                                           out RegimenOTrascendencia : SmallInt;
                                                           out CausaExencion         : SmallInt );
begin
     SessionDataModule.Dm10.FacturaModule.CompletaRegistroFacturaExpedida( CodigoProvincia, CodigoPais, Rectificativa, Simplificada, VentasOnline, TipoFactura, RegimenOTrascendencia, CausaExencion );
end;

procedure TFacturaService.CompletaRegistroFacturaRecibida(     SubcuentaPropietario,
                                                               CodigoPais                    : String;
                                                               ModeloIVA                     : TModeloIVAProveedor;
                                                           out TipoFactura                   : SmallInt;
                                                           out RegimenOTrascendencia         : SmallInt;
                                                           out TipoOperacionIntracomunitaria : SmallInt );
begin
     SessionDataModule.Dm10.FacturaModule.CompletaRegistroFacturaRecibida( SubcuentaPropietario, CodigoPais, ModeloIVA, TipoFactura, RegimenOTrascendencia, TipoOperacionIntracomunitaria );
end;

function TFacturaService.ImportePendienteFacturaEmitida( Ejercicio : SmallInt; Serie : String; NroFactura : Integer; out ImporteEfectos, ImportePendiente : Decimal ) : Boolean;
begin
     Result := SessionDataModule.Dm10.FacturaModule.ImportePendienteFacturaEmitida( Ejercicio, Serie, NroFactura, ImporteEfectos, ImportePendiente );
end;

function TFacturaService.ObtenImportesFacturaEmitida(     Ejercicio     : SmallInt;
                                                          Serie         : String;
                                                          NroFactura    : Integer;
                                                      out Asiento       : IAsiento;
                                                      out BaseImponible,
                                                          CuotaIVA,
                                                          CuotaRE,
                                                          ImporteTotal  : Decimal ) : Boolean;

begin
     Result := SessionDataModule.Dm10.FacturaModule.ObtenImportesFacturaEmitida( Ejercicio, Serie, NroFactura, Asiento, BaseImponible, CuotaIVA, CuotaRE, ImporteTotal );
end;

function TFacturaService.ObtenImportesFacturaRecibida(      Ejercicio       : SmallInt;
                                                            Propietario,
                                                            SerieNroFactura : String;
                                                        out Asiento         : IAsiento;
                                                        out BaseImponible,
                                                            CuotaIVA,
                                                            ImporteTotal    : Decimal ) : Boolean;

begin
     Result := SessionDataModule.Dm10.FacturaModule.ObtenImportesFacturaRecibida( Ejercicio, Propietario, SerieNroFactura, Asiento, BaseImponible, CuotaIVA, ImporteTotal );
end;

function TFacturaService.ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                                    Periodicidad         : SmallInt;
                                                                    FechaInicial,
                                                                    FechaFinal           : TDateTime ) : IAcumuladoOPeracionesIntracomunitarias;
begin
     Result := SessionDataModule.Dm10.FacturaModule.ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName, Periodicidad, FechaInicial, FechaFinal );
end;


var FacturaControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_FacturaService, TFacturaService, FacturaControl );

end.

