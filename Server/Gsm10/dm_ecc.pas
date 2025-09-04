
unit dm_ecc;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  nxsdTypes,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,

  dmi_ecc,

  EfectoCobrarIntf;

type
  TTipoEfectos = ( srEnCartera = 0, srDescontados = 1, srAceptados = 2, srImpagados = 5 );

    TEfectoCobrarService = class( TSessionModule, IEfectoCobrarService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaEfectoCobrar( EfectoCobrar : IEfectoCobrar ); overload;
    procedure SuprimeEfectoCobrar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    procedure ActualizaAnotacionCobro( EfectoCobrar: IEfectoCobrar );
    procedure SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    procedure ActualizaAnotacionImpagado( EfectoCobrar: IEfectoCobrar );
    procedure SuprimeAnotacionImpagado( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    procedure ActualizaCancelacion( EfectoCobrar: IEfectoCobrar );
    procedure SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    function  EfectoPendiente( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt; IncluirEfectosRemesados : Boolean = True ) : Boolean; overload;
    function  FechaCobro( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ) : TDate;
    function CompruebaEfectos( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; SuprimirEfectos : Boolean = False ) : Boolean;
    function GeneraEfectos( NroAsiento : LongInt; SubcuentaCliente, CodigoFormaCobro : String; Importe : Decimal ) : Boolean;
    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt );
    end;

  TEfectoCobrarModule = class(TServerDataModule)
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    DmEfectoCobrarTable: TnxeTable;
    DmFormaCobroTable: TnxeTable;
    DmEfectoCobrarAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
  private

    DmEfectoCobrarFields,
    DmEfectoCobrarAuxFields : TEfectoCobrarFields;
    DmAsientoFields,
    DmAsientoFacFields : TAsientoFields;
    DmApunteFields  : TApunteFields;
    DmFormaCobroFields : TFormaCobroFields;
    DmBancoFields : TBancoFields;
    DmClienteFields : TClienteFields;
    DmRemesaFields : TRemesaFields;
    DmRelacionesDivisaFields : TRelacionesDivisaFields;

    DmRelacionEfectos  : TRelacionEfectos;

    function ObtenTextoConcepto(TextoConcepto: String; EfectoCobrarFields: TEfectoCobrarFields; IncluirFechaVencimiento: Boolean=False): String;

  public

    function CompruebaEfectos( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; SuprimirEfectos : Boolean = False ) : Boolean;
    function EfectoPendiente( EfectoCobrarFields : TEfectoCobrarFields; IncluirEfectosRemesados : Boolean = True ) : Boolean; overload;
    function EfectoPendiente( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt; IncluirEfectosRemesados : Boolean = True ) : Boolean; overload;
    function FechaCobro( EfectoCobrarFields : TEfectoCobrarFields ) : TDate; overload;
    function FechaCobro( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ) : TDate; overload;

    function ObtenRiesgoCliente( Ejercicio : SmallInt; SubcuentaCliente : String; var Cargos : Decimal; var EnCartera : Decimal; var Descontado : Decimal; var Impagados : Decimal ) : Decimal;

    procedure ActualizaEfectoCobrar( EfectoCobrar : IEfectoCobrar ); overload;
    procedure ActualizaEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields ); overload;
    procedure SuprimeEfectoCobrar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ); overload;
    procedure SuprimeEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields ); overload;

    procedure ActualizaAnotacionCobro( EfectoCobrar: IEfectoCobrar ); overload;
    procedure ActualizaAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields ); overload;
    procedure SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ); overload;
    procedure SuprimeAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields ); overload;

    procedure ActualizaAnotacionImpagado( EfectoCobrar: IEfectoCobrar ); overload;
    procedure ActualizaAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields ); overload;
    procedure SuprimeAnotacionImpagado( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ); overload;
    procedure SuprimeAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields ); overload;

    procedure ActualizaCancelacion( EfectoCobrar: IEfectoCobrar ); overload;
    procedure ActualizaCancelacion( EfectoCobrarFields : TEfectoCobrarFields ); overload;
    procedure SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ); overload;
    procedure SuprimeCancelacion( EfectoCobrarFields : TEfectoCobrarFields ); overload;

    function ObtenCanalPreferente( ClienteFields : TClienteFields; CodigoFormaCobro : String = '' ) : String;
    function ObtenSubcuentaRiesgo( SubcuentaCliente : String; TipoEfectos : TTipoEfectos = srDescontados; CrearSubcuenta : Boolean = False; Contado : Boolean = False ) : String;
    function ObtenSubcuentaCliente( SubcuentaRiesgo : String ) : String;

    function GeneraEfectos( NroAsiento : LongInt; SubcuentaCliente, CodigoFormaCobro : String; Importe : Decimal ) : Boolean;

    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt );
    function  ProximoNroEfecto( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt ) : SmallInt;

    function ObtenTextoCicloMandato( Ciclo : SmallInt ) : String;
    function TextoConcepto( EfectoCobrarFields : TEfectoCobrarFields; IncluirFechaVencimiento : Boolean = False ) : String;
    function TextoConceptoCobro( EfectoCobrarFields : TEfectoCobrarFields; IncluirFechaVencimiento : Boolean = False ) : String;

  end;

function  DesgloseVencimientos( FechaDocumento : TDateTime; Plazos, PrimerVencimiento, Intervalo, DiaPago1, DiaPago2, MesNoPago : SmallInt; Meses30dias : Boolean; ImporteFactura : Decimal; var DmRelacionEfectos : TRelacionEfectos ) : SmallInt;

     // Ciclos de un mandato

const cmRecurrente = 0;
      cmPrimero = 1;
      cmUltimo = 2;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,
     nxrbTypes,
     nxrdClass,
     nxsrServerEngine,
     nxllBDE,

     AppManager,
     EnterpriseData,

     Gim00Fields,
     SessionData,

     dmi_ast,
     dmi_iva,
     dmi_rem,

     dm_sub,
     dm_pga,
     dm_cli,
     dm_iva,
     dm_rem,
     dm_sal,
     dm_ast;

{$R *.DFM}

resourceString
     RsMsg1  = 'El efecto nº %s ya ha sido cobrado.';
     RsMsg2  = 'Si desea modificar el estado de esta factura debe [B]suprimir los asientos de cobro de todos los efectos[/B].';
     RsMsg3  = 'El efecto nº %s está incluido en la Remesa nº %d.';
     RsMsg4  = 'Si desea modificar el Estado de esta factura debe excluir todos los efectos de cualquier Remesa.';
     RsMsg5  = 'La subcuenta %s no tiene asociada una ficha de cliente.';
     RsMsg6  = 'Antes de intentar generar efectos de forma automática debe crear una ficha de cliente que utilice esta subcuenta.';
     RsMsg7  = 'Se ha producido un error durante el proceso de generación de efectos.';
     RsMsg8  = 'Ningún efecto generado. Las condiciones impuestas en la forma de cobro no permiten generar efectos.';
     RsMsg9  = 'Cobrado.';
     RsMsg10 = ' (Impagado)';
     RsMsg11 = 'Remesado. Remesa nº %d.';
     RsMsg12 = 'Cobrado. Asiento nº %d.';
     RsMsg13 = 'Pendiente de cobro.';
     RsMsg14 = 'Cobro N/Ef. nº ';
     RsMsg15 = 'N/Efecto nº ';
     // RsProcesoInterrumpido = 'Puesto que en todos los procesos de la aplicación se utilizan transacciones [B]no debería haber ningún tipo de información inconsistente[/B].'#13'Reintente el proceso cuando lo considere oportuno.';
     RsMsg17 = 'No puedo suprimir el efecto nº %d vinculado a éste.';
     RsMsg18 = 'El efecto emitido en su día a partir de este impagado ya consta como pagado o remesado.';
     RsMsg19 = 'Impagado N/Ef. %s.';
     RsMsg20 = 'La forma de cobro de código [%s] no existe.';
     RsMsg21 = 'No se ha podido leer el asiento nº %d.';
     RsMsg22 = 'La generación de efectos a cobrar solicitada no se ha realizado.';
     RsMsg23 = 'Cancelacion N/Ef. %s.';
     RsMsg24 = 'No se ha podido crear el efecto con la diferencia en el importe cobrado.';

var EfectoCobrarControl : InxClassFactoryControl;

procedure TEfectoCobrarModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.EfectoCobrarModule := nil;
end;

procedure TEfectoCobrarModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

procedure TEfectoCobrarModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmEfectoCobrarAuxFields := TEfectoCobrarFields.Create( DmEfectoCobrarAuxTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmFormaCobroFields := TFormaCobroFields.Create( DmFormaCobroTable );

     DmAsientoFacFields := TAsientoFields.Create( Self );
     DmBancoFields := TBancoFields.Create( Self );
     DmClienteFields := TClienteFields.Create( Self );
     DmRemesaFields := TRemesaFields.Create( Self );
     DmRelacionesDivisaFields := TRelacionesDivisaFields.Create( Self );

end;

function TEfectoCobrarModule.CompruebaEfectos( Ejercicio         : SmallInt;
                                               Serie             : String;
                                               NroFactura        : LongInt;
                                               SuprimirEfectos   : Boolean = False ) : Boolean;
var  TextoError : String;

begin
     Result := False;
     With DmEfectoCobrarTable do
       try
         SetRange( [ Ejercicio, Serie, NroFactura ] );
         First;
         While not Eof do
           If   not ValueIsEmpty( DmEfectoCobrarFields.NroAsientoCobro.Value )
           then begin
                TextoError := Format( RsMsg1, [ Serie + ' - ' + IntToStr( NroFactura ) + ' / ' + IntToStr( DmEfectoCobrarFields.NroEfecto.Value ) ] );
                SessionDataModule.SendNotification( ntStop, TextoError, RsMsg2 );
                Exit;
                end
           else If   not ValueIsEmpty( DmEfectoCobrarFields.NroRemesa.Value )
                then begin
                     TextoError :=  Format( RsMsg3, [ Serie + ' - ' + IntToStr( NroFactura ) + ' / ' + IntToStr( DmEfectoCobrarFields.NroEfecto.Value ), DmEfectoCobrarFields.NroRemesa.Value ] );
                     SessionDataModule.SendNotification( ntStop, TextoError, RsMsg4 );
                     Exit;
                     end
                else Next;
       finally
         CancelRange;
         end;

     If   SuprimirEfectos
     then SuprimeEfectosFactura( Ejercicio, Serie, NroFactura );

     Result := True;
end;

procedure TEfectoCobrarModule.SuprimeEfectosFactura( Ejercicio  : SmallInt;
                                                     Serie      : String;
                                                     NroFactura : LongInt );
begin
     With DmEfectoCobrarTable do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoCobrarTable ] );

       try

         try
           SetRange( [ Ejercicio, Serie, NroFactura ] );
           First;
           While not Eof do
             SuprimeEfectoCobrar( DmEfectoCobrarFields );
         finally
           CancelRange;
           end;
         TransactionTag.Commit;
       except
         TransactionTag.Rollback;
         raise;
         end;

       end;
end;

procedure TEfectoCobrarModule.SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID;
                                                     Ejercicio      : SmallInt;
                                                     Serie          : String;
                                                     NroFactura     : Integer;
                                                     NroEfecto      : SmallInt );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAnotacionCobro( DmEfectoCobrarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.SuprimeAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ EfectoCobrarFields.Table ] );

     try

       With EfectoCobrarFields do
         If   not ValueIsEmpty( NroAsientoCobro.Value )
         then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                   NroAsientoCobro.Value,
                                                                   taCobro,
                                                                   FechaLibramiento.Value,
                                                                   SubcuentaCliente.Value,
                                                                   Serie.Value,
                                                                   NroFactura.Value,
                                                                   NroEfecto.Value );

       try
         EfectoCobrarFields.Table.Edit;

         EfectoCobrarFields.NroAsientoCobro.Clear;
         EfectoCobrarFields.FechaCobro.Clear;
         EfectoCobrarFields.ImporteCobrado.Clear;
         EfectoCobrarFields.DiferenciaCambio.Clear;
         EfectoCobrarFields.GenerarEfectoDiferencia.Clear;
         EfectoCobrarFields.SubcuentaDiferencia.Clear;
         EfectoCobrarFields.GastosGestion.Clear;
         EfectoCobrarFields.GastosDevolucion.Clear;
         EfectoCobrarFields.SubcuentaGastos.Clear;
         EfectoCobrarFields.ConceptoCobro.Clear;

         EfectoCobrarFields.Table.Post;

       except
         EfectoCobrarFields.Table.Cancel;
         raise;
         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

function TEfectoCobrarModule.ObtenTextoCicloMandato( Ciclo : SmallInt ) : String;
begin
     case Ciclo of
       cmPrimero    : Result := 'FRST';
       cmRecurrente : Result := 'RCUR';
       cmUltimo     : Result := 'FNAL';
     end;
end;

function  TEfectoCobrarModule.ObtenTextoConcepto( TextoConcepto           : String;
                                                  EfectoCobrarFields      : TEfectoCobrarFields;
                                                  IncluirFechaVencimiento : Boolean = False ) : String;
begin
     With EfectoCobrarFields do
        begin
        Result := StrInt( NroFactura.Value ) + '-' + StrInt( NroEfecto.Value );
        If   Serie.Value<>''
        then Result := Serie.Value + '-' + Result;
        If   IncluirFechaVencimiento
        then Result := Result + ' ' + StrFormatDate( FechaVencimiento.Value, dfDefault );
        Result := TextoConcepto + Result;
        end;
end;


function  TEfectoCobrarModule.TextoConcepto( EfectoCobrarFields      : TEfectoCobrarFields;
                                             IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg15, EfectoCobrarFields, IncluirFechaVencimiento );
end;

function  TEfectoCobrarModule.TextoConceptoCobro( EfectoCobrarFields      : TEfectoCobrarFields;
                                                  IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg14, EfectoCobrarFields, IncluirFechaVencimiento );
end;

procedure TEfectoCobrarModule.ActualizaEfectoCobrar(     EfectoCobrar : IEfectoCobrar );
                                                     var TableCursor  : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( EfectoCobrar.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   EfectoCobrar.State=dsEdit
          then If   DmEfectoCobrarTable.FindKey( [ EfectoCobrar.Ejercicio, EfectoCobrar.Serie, EfectoCobrar.NroFactura, EfectoCobrar.NroEfecto ] )
               then TableCursor.RecordLockRelease( False )
               else RaiseRecordNotFoundException;;
          EfectoCobrar.ToDataset( DmEfectoCobrarFields );
          ActualizaEfectoCobrar( DmEfectoCobrarFields );
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.SuprimeEfectoCobrar( RemoteCursorID : TnxCursorID;
                                                   Ejercicio      : SmallInt;
                                                   Serie          : String;
                                                   NroFactura     : LongInt;
                                                   NroEfecto      : SmallInt );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeEfectoCobrar( DmEfectoCobrarFields );
               end;
          end
     else RaiseNoCurrentRecordException;
end;

// ----------------------------------------

function TEfectoCobrarModule.EfectoPendiente( Ejercicio               : SmallInt;
                                              Serie                   : String;
                                              NroFactura              : LongInt;
                                              NroEfecto               : SmallInt;
                                              IncluirEfectosRemesados : Boolean = True  ) : Boolean;
begin
     With DmEfectoCobrarTable do
       If   FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
       then Result := EfectoPendiente( DmEfectoCobrarFields, IncluirEfectosRemesados )
       else Result := False;
end;

function TEfectoCobrarModule.EfectoPendiente( EfectoCobrarFields      : TEfectoCobrarFields;
                                              IncluirEfectosRemesados : Boolean = True ) : Boolean;

var  ImporteEfectos,
     ImportePendiente : Decimal;

begin
     With EfectoCobrarFields do
       If   ValueIsEmpty( NroRemesa.Value )
       then Result := ValueIsEmpty( FechaCobro.Value ) or ( FechaCobro.Value=0 )  // La segunda comprobación es para los registros de versiones anteriores
       else If   IncluirEfectosRemesados
            then begin
                 If   SessionDataModule.Dm10.RemesaModule.Obten( EjercicioRemesa.Value, NroRemesa.Value, DmRemesaFields )
                 then begin
                      If   Impagado.Value and not VolverAEmitir.Value
                      then Result := SessionDataModule.Dm10.FacturaModule.ImportePendienteFacturaEmitida( Ejercicio.Value, Serie.Value, NroFactura.Value, ImporteEfectos, ImportePendiente )
                      else Result := DmRemesaFields.Estado.Value in [ erPendiente, erAceptada ];
                      // No excluyo las remesas aceptadas porque, aunque el usuario considera su cobro asegurado, es conveniente que aparezcan en las tablas de previsión como pendientes de cobro
                      end
                 else Result := True;
                 end
            else Result := False;
end;

function TEfectoCobrarModule.FechaCobro( Ejercicio  : SmallInt;
                                         Serie      : String;
                                         NroFactura : LongInt;
                                         NroEfecto  : SmallInt  ) : TDate;
begin
     With DmEfectoCobrarTable do
       If   FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
       then Result := FechaCobro( DmEfectoCobrarFields )
       else Result := 0;
end;

function TEfectoCobrarModule.FechaCobro( EfectoCobrarFields : TEfectoCobrarFields ) : TDate;
begin
     Result := 0;
     With EfectoCobrarFields do
       If   ValueIsEmpty( NroRemesa.Value )
       then Result := FechaCobro.Value
       else If   not Impagado.Value
            then If   SessionDataModule.Dm10.RemesaModule.Obten( EjercicioRemesa.Value, NroRemesa.Value, DmRemesaFields )
                 then If   DmRemesaFields.Estado.Value=erCobrada
                      then Result := DmRemesaFields.FechaCobro.Value
                      else If   DmRemesaFields.Estado.Value=erCancelada
                           then Result := DmRemesaFields.FechaCancelacion.Value;
end;


function TEfectoCobrarModule.GeneraEfectos( NroAsiento        : LongInt;
                                            SubcuentaCliente,
                                            CodigoFormaCobro  : String;
                                            Importe           : Decimal ) : Boolean;

var   Index,
      DiaCobro1,
      DiaCobro2 : SmallInt;

begin
     Result := False;
     If   DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, NroAsiento ] )
     then With SessionDataModule, Dm10 do
            begin

            If   not ClienteModule.ObtenPorSubcuenta( SubcuentaCliente, DmClienteFields )
            then begin
                 SendNotification( ntStop, Format( RsMsg5, [ SubcuentaCliente ] ), RsMsg6 );
                 Exit;
                 end;

            If   not DmFormaCobroTable.FindKey( [ CodigoFormaCobro ] )
            then begin
                 SendNotification( ntStop, Format( RsMsg20, [ CodigoFormaCobro ] ) );
                 Abort;
                 end;

            If   CompruebaEfectos( DmAsientoFields.Ejercicio.Value, DmAsientoFields.Serie.Value, DmAsientoFields.NroFactura.Value )
            then begin

                 var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoCobrarTable ] );

                 try

                   SuprimeEfectosFactura( DmAsientoFields.Ejercicio.Value, DmAsientoFields.Serie.Value, DmAsientoFields.NroFactura.Value );

                   // He añadido dias de cobro al registro de formas de cobro. Con esto pretendo que se puedan crear formas de cobro
                   // con dias de cobro por defecto aplicables a cualquier cliente (p.e. tarjetas de crédito, etc...)

                   If   ValueIsEmpty( DmClienteFields.Cobro_DiaCobro1.Value ) and not ValueIsEmpty( DmFormaCobroFields.DiaCobro1.Value )
                   then DiaCobro1 := DmFormaCobroFields.DiaCobro1.Value
                   else DiaCobro1 := DmClienteFields.Cobro_DiaCobro1.Value;

                   If   ValueIsEmpty( DmClienteFields.Cobro_DiaCobro2.Value ) and not ValueIsEmpty( DmFormaCobroFields.DiaCobro2.Value )
                   then DiaCobro2 := DmFormaCobroFields.DiaCobro2.Value
                   else DiaCobro2 := DmClienteFields.Cobro_DiaCobro2.Value;

                   If   DesgloseVencimientos( DmAsientoFields.FechaDocumento.Value,
                                              DmFormaCobroFields.Plazos.Value,
                                              DmFormaCobroFields.PrimerVencimiento.Value,
                                              DmFormaCobroFields.Intervalo.Value,
                                              DiaCobro1,
                                              DiaCobro2,
                                              DmClienteFields.Cobro_MesNoCobro.Value,
                                              DmFormaCobroFields.Meses30dias.Value,
                                              Importe,
                                              DmRelacionEfectos )=0
                   then begin
                        SessionDataModule.SendNotification( ntStop, RsMsg8 );
                        Abort;
                        end;

                   With DmEfectoCobrarTable do
                     For Index := 0 to DmRelacionEfectos.NroEfectos do
                       If   DmRelacionEfectos.Importe[ Index ]<>0.0
                       then try

                              Append;

                              DmEfectoCobrarFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                              DmEfectoCobrarFields.Serie.Value := DmAsientoFields.Serie.Value;
                              DmEfectoCobrarFields.NroFactura.Value := DmAsientoFields.NroFactura.Value;
                              DmEfectoCobrarFields.SubcuentaCliente.Value := SubcuentaCliente;
                              DmEfectoCobrarFields.FormaDePago.Value := CodigoFormaCobro;
                              DmEfectoCobrarFields.SubcuentaEntidad.Value := ObtenCanalPreferente( DmClienteFields, CodigoFormaCobro );
                              DmEfectoCobrarFields.FechaLibramiento.Value := DmAsientoFields.FechaDocumento.Value;

                              DmEfectoCobrarFields.NroEfecto.Value := Index;
                              DmEfectoCobrarFields.FechaVencimiento.Value := DmRelacionEfectos.FechaVencimiento[ Index ];
                              DmEfectoCobrarFields.Importe.Value := DmRelacionEfectos.Importe[ Index ];

                              DmEfectoCobrarFields.Concepto.Value := TextoConcepto( DmEfectoCobrarFields );

                              If   Index=0
                              then begin
                                   DmEfectoCobrarFields.ImporteCobrado.Value := DmEfectoCobrarFields.Importe.Value;
                                   DmEfectoCobrarFields.FechaCobro.Value := DmEfectoCobrarFields.FechaVencimiento.Value;
                                   DmEfectoCobrarFields.ConceptoCobro.Value := TextoConceptoCobro( DmEfectoCobrarFields );
                                   SessionDataModule.Dm10.EfectoCobrarModule.ActualizaAnotacionCobro( DmEfectoCobrarFields ); // Hace el Post del efecto
                                   end
                              else ActualizaEfectoCobrar( DmEfectoCobrarFields ); // Se crean los asientos de gestión cartera si es necesario y estan activados (EmpresaFields.Contable_DesglosarCtasCobros)

                            except
                              Cancel;
                              raise;
                              end;

                     TransactionTag.Commit;

                     Result := True;

                   except on E : Exception do
                     begin
                     TransactionTag.Rollback;
                     If   not ( E is EAbort )
                     then SessionDataModule.SendNotification( ntStop, RsMsg7, RsProcesoInterrumpido );
                     end;
                   end;

                 end;
          end
     else SessionDataModule.SendNotification( ntError, Format( RsMsg21, [ NroAsiento ] ), RsMsg22 );
end;

function TEfectoCobrarModule.ObtenCanalPreferente( ClienteFields    : TClienteFields;
                                                   CodigoFormaCobro : String = '' ) : String;
begin
     Result := ClienteFields.Cobro_CtaEntidad.Value;
     If   CodigoFormaCobro=''
     then CodigoFormaCobro := ClienteFields.Cobro_FormaCobro.Value;
     If   SessionDataModule.Dm10.FormaCobroModule.Obten( CodigoFormaCobro, DmFormaCobroFields )
     then If   DmFormaCobroFields.CanalPreferente.Value<>''
          then Result := DmFormaCobroFields.CanalPreferente.Value;
end;

function TEfectoCobrarModule.ProximoNroEfecto( Ejercicio    : SmallInt;
                                               Serie        : String;
                                               NroFactura   : LongInt ) : SmallInt;
begin
     With DmEfectoCobrarAuxTable do
       If   FindEqualLast( [ Ejercicio, Serie, NroFactura ] )
       then Result  := DmEfectoCobrarAuxFields.NroEfecto.Value + 1
       else Result  := 1;
end;

// Otras funciones

function DesgloseVencimientos(     FechaDocumento      : TDateTime;
                                   Plazos,
                                   PrimerVencimiento,
                                   Intervalo,
                                   DiaPago1,
                                   DiaPago2,
                                   MesNoPago           : SmallInt;
                                   Meses30dias         : Boolean;
                                   ImporteFactura      : Decimal;
                               var DmRelacionEfectos   : TRelacionEfectos ) : SmallInt;

var   Intervalo1,
      Intervalo2,
      DiaPago1Mes,
      DiaPago2Mes,
      DiasMes,
      Day,
      SavedDay,
      Month,
      SavedMonth,
      Year,
      SavedYear,
      X1,
      X2,
      Hh : SmallInt;
      I1,
      I2,
      I3 : Decimal;
      T2,
      V4,
      Vv4 : SmallInt;

      AjusteNoPago: Boolean;

      GuardaEjercicio,
      GuardaMes,
      GuardaDia : SmallInt;

      Index         : SmallInt;

procedure CalculaDiasMes;

const ListaDiasMesNatural : array[ 1..12 ] of byte = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
      ListaDiasMes30      : array[ 1..12 ] of byte = ( 30, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 );

begin
     If   Meses30dias
     then DiasMes := ListaDiasMes30[ Month ]
     else DiasMes := ListaDiasMesNatural[ Month ];

     If   ( Month=2 ) and IsLeapYear( Year )
     then DiasMes := 29;

     DiaPago1Mes := DiaPago1;
     If   DiaPago1Mes>DiasMes
     then DiaPago1Mes := DiasMes;

     DiaPago2Mes := DiaPago2;
     If   DiaPago2Mes>DiasMes
     then DiaPago2Mes := DiasMes;
end;

procedure CompruebaMes;
begin
     If   Month>12
     then begin
          Month := Month - 12;
          Inc( Year );
          end;
end;

procedure CompruebaMesNoPago;
begin
     AjusteNoPago := Month=MesNoPago;
     If   AjusteNoPago
     then begin
          GuardaEjercicio := Year;
          GuardaMes := Month;
          GuardaDia := Day;
          Inc( Month );
          If   DiaPago1=0
          then Day := 1
          else Day := DiaPago1;          // de esta forma se ajusta al 1 del mes siguiente y, si existen dias de pago
          CompruebaMes;                  // al primer dia de pago disponible
          end;
end;

procedure GuardaFecha;
begin
     SavedDay := Day;
     SavedMonth := Month;
     SavedYear := Year;
end;

procedure RecuperaFecha;
begin
     Day := SavedDay;
     Month := SavedMonth;
     Year := SavedYear;
end;

begin

  //* 22.07.2002  Varias modificaciones que afectan al modo de calcular los vencimientos cuando
  //              hay dias de pago : los dias de pago/cobro ahora no alargan los plazos.

  Result := 0;

  FillChar( DmRelacionEfectos, SizeOf( DmRelacionEfectos ), #0 );

  With DmRelacionEfectos do
    begin

    If   ImporteFactura=0.0
    then Exit;

    If   Plazos=0
    then begin
         NroEfectos := 1;
         FechaLibramiento[ 0 ] := FechaDocumento;
         FechaVencimiento[ 0 ] := FechaDocumento;
         Importe[ 0 ] := ImporteFactura;
         Result := 1;
         Exit;
         end;

    NroEfectos := Plazos;
    Intervalo1 := PrimerVencimiento;
    Intervalo2 := Intervalo;

    If   DiaPago2=0
    then DiaPago2 := DiaPago1;
    If   DiaPago2<DiaPago1
    then begin
         Index := DiaPago1;
         DiaPago1 := DiaPago2;
         DiaPago2 := Index;
         end;

    X2 := 0;
    Hh := 1;
    V4 := NroEfectos;
    Vv4 := NroEfectos;
    I1 := Redondea( ImporteFactura / V4 );
    I3 := Redondea( ImporteFactura - V4 * I1 );
    I2 := I1;
    I1 := I1 + i3;

    Day := DayOf( FechaDocumento );
    Month := MonthOf( FechaDocumento );
    Year := YearOf( FechaDocumento );

    GuardaFecha;

    repeat

      CalculaDiasMes;

      If   X2=0
      then Day := Day + Intervalo1    { primer Intervalo }
      else Day := Day + Intervalo2;   { segundo          }

      repeat

        repeat
          T2 := Day - DiasMes;
          If   T2>0
          then begin
               Day := T2;
               Inc( Month );
               end;
          CompruebaMes;
          CalculaDiasMes;
        until Day<=DiasMes;

        CompruebaMesNoPago;
        CalculaDiasMes;                // Aqui se ajustan DiaPago1Mes y DiaPago2Mes

        If   Day<=DiasMes
        then begin

             GuardaFecha;             // Guardo el dia original para que se cuente de nuevo a partir de él

             If   ( DiaPago1Mes<>0 ) or ( DiaPago2Mes<>0 )
             then begin
                  If   Day>DiaPago2Mes
                  then begin
                       Day := DiaPago1Mes;
                       Inc( Month );
                       CompruebaMesNoPago;
                       CompruebaMes;
                       CalculaDiasMes;
                       If   Day>DiasMes
                       then Day := DiasMes;
                       end
                  else begin
                       If   Day<=DiaPago1Mes
                       then Day := DiaPago1Mes
                       else Day := DiaPago2Mes;
                       end;
                  end;
             end;

      until Day<=DiasMes;

      FechaVencimiento[ Hh ] := EncodeDate( Year, Month, Day );

      RecuperaFecha;

      Hh := Hh + 1;
      V4 := V4 - 1;
      X2 := 1;

      If   AjusteNoPago
      then begin
           Year := GuardaEjercicio;
           Month := GuardaMes;
           Day := GuardaDia;
           end;

    until V4=0;

    X1 := 0;
    Hh := 1;

    repeat
      If   X1<>0
      then I1 := i2;
      Importe [ Hh ] := I1;
      Hh := Hh + 1;
      X1 := 1;
      Vv4 := Vv4 - 1;
    until Vv4=0;

  Result := NroEfectos;
  end;

end;

function TEfectoCobrarModule.ObtenSubcuentaCliente( SubcuentaRiesgo : String ) : String;
begin
     Result := SubcuentaRiesgo;  // Por defecto no hacemos nada
     If   Copy( SubcuentaRiesgo, 1, 3 )='431'
     then Result := '4300' + Copy( SubcuentaRiesgo, 5, 5 )
     else If   Copy( SubcuentaRiesgo, 1, 3 )='441'
          then Result := '4400' + Copy( SubcuentaRiesgo, 5, 5 );
end;

function TEfectoCobrarModule.ObtenSubcuentaRiesgo( SubcuentaCliente : String;
                                                   TipoEfectos      : TTipoEfectos = srDescontados;
                                                   CrearSubcuenta   : Boolean = False;
                                                   Contado          : Boolean = False ) : String;

var CuentaCliente : String;
    EsUnCliente,
    EsUnDeudor : Boolean;

function CompletaSubcuenta( Digito : Byte ) : String;
begin
     If   EsUnCliente
     then Result := '431' + IntToStr( Digito ) + CuentaCliente
     else Result := '441' + IntToStr( Digito ) + CuentaCliente;
end;

begin
     Result := SubcuentaCliente;
     EsUnCliente := Copy( SubcuentaCliente, 1, 3 )='430';
     EsUnDeudor := Copy( SubcuentaCliente, 1, 3 )='440';

     // Si no es una 430 ni una 440, no debe generarse. Puede ser, por ejemplo, una cuenta 4315 (Impagados)
     // La opción de contado utiliza siempre la cuenta del cliente para las anotaciones de cobros

     If   ( EsUnCliente or EsUnDeudor ) and not Contado
     then begin

          CuentaCliente := Copy( SubcuentaCliente, 5, 5 );

          If   SessionDataModule.EmpresaFields.Contable_DesglosarCtasCobros.Value
          then Result := CompletaSubcuenta( Ord( TipoEfectos ) )
          else If   TipoEfectos in [ srDescontados, srAceptados ]
               then Result := CompletaSubcuenta( Ord( TipoEfectos ) );

          // Todos los demás tipos de efectos se anotan directamente en la subcuenta del cliente (versión simplificada de gestión de cobros)

          If   CrearSubcuenta and ( Result<>'' )
          then With SessionDataModule.Dm10.CuentaModule do
                 InsertaSubcuenta( Result, Descripcion( SubcuentaCliente, True, False ) );

          end;
end;

function TEfectoCobrarModule.ObtenRiesgoCliente(     Ejercicio        : SmallInt;
                                                     SubcuentaCliente : String;
                                                 var Cargos           : Decimal;
                                                 var EnCartera        : Decimal;
                                                 var Descontado       : Decimal;
                                                 var Impagados        : Decimal ) : Decimal;

begin
     With SessionDataModule do
       begin
       Cargos := Dm10.SaldosModule.SaldoPeriodo( SubcuentaCliente, '', True, Ejercicio, 0, NroMesFinal ).Saldo;
       If   EmpresaFields.Contable_DesglosarCtasCobros.Value
       then begin
            EnCartera := Dm10.SaldosModule.SaldoPeriodo( ObtenSubcuentaRiesgo( SubcuentaCliente, srEnCartera ), '', True, Ejercicio, 0, NroMesFinal ).Saldo;
            Impagados := Dm10.SaldosModule.SaldoPeriodo( ObtenSubcuentaRiesgo( SubcuentaCliente, srImpagados ), '', True, Ejercicio, 0, NroMesFinal ).Saldo;
            end
       else begin
            EnCartera := 0.0;
            Impagados := 0.0;
            end;
       Descontado := Dm10.SaldosModule.SaldoPeriodo( ObtenSubcuentaRiesgo( SubcuentaCliente, srDescontados ), '', True, Ejercicio, 0, NroMesFinal ).Saldo;
       Result := Cargos + EnCartera + Descontado + Impagados;
       end;
end;

procedure TEfectoCobrarModule.ActualizaEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields );

var   GeneraAsiento : Boolean;
      ApunteFieldValues : TFieldValuesArray;

begin

    var TransactionTag := SessionDataModule.StartTransactionWith( [ EfectoCobrarFields.Table, DmAsientoTable, DmApunteTable ] );

    try

       If   SessionDataModule.EmpresaFields.Contable_DesglosarCtasCobros.Value
       then begin

            GeneraAsiento := True;

            // Los efectos con forma de cobro 'Contado' no generan asiento de cartera

            If   EfectoCobrarFields.FormaDePago.Value<>''
            then If   DmFormaCobroTable.FindKey( [ EfectoCobrarFields.FormaDePago.Value ] )
                 then GeneraAsiento := ( DmFormaCobroFields.Plazos.Value<>0 ) and not DmFormaCobroFields.NoContabilizar.Value;

            // Se contabiliza con la fecha de libramiento, por lo tanto debe ser la del ejercicio

            If   GeneraAsiento and
                 ( SessionDataModule.Ejercicio=SessionDataModule.EjercicioFecha( EfectoCobrarFields.FechaLibramiento.Value ) )
            then begin

                 try

                   DmAsientoTable.CancelRange;

                   If   not ValueIsEmpty( EfectoCobrarFields.NroAsientoCartera.Value ) and
                        DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, EfectoCobrarFields.NroAsientoCartera.Value ] )
                   then begin
                        SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields,
                                                                             taCartera,
                                                                             EfectoCobrarFields.FechaLibramiento.Value,
                                                                             EfectoCobrarFields.SubcuentaCliente.Value,
                                                                             EfectoCobrarFields.Serie.Value,
                                                                             EfectoCobrarFields.NroFactura.Value,
                                                                             EfectoCobrarFields.NroEfecto.Value,
                                                                             True ); // La cabecera del asiento se preserva, de forma que se reutiliza el mismo número de asiento
                        DmAsientoTable.Edit;
                        end
                   else begin
                        DmAsientoTable.Append;

                        DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                        DmAsientoFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
                        DmAsientoFields.TipoAsiento.Value := taCartera;
                        DmAsientoFields.Serie.Value := EfectoCobrarFields.Serie.Value;
                        DmAsientoFields.NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                        DmAsientoFields.NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                        DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taCartera );
                        end;

                   // Estos valores pueden ser modificados por el usuario usando la misma clave del efecto

                   DmAsientoFields.Fecha.Value := EfectoCobrarFields.FechaLibramiento.Value;
                   DmAsientoFields.FechaDocumento.Value := EfectoCobrarFields.FechaLibramiento.Value;
                   DmAsientoFields.Propietario.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                   DmAsientoFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( EfectoCobrarFields.SubcuentaCliente.Value, True, False );

                   DmAsientoTable.Post;

                 except
                   DmAsientoTable.Cancel;
                   raise;
                   end;

                 EfectoCobrarFields.NroAsientoCartera.Value := DmAsientoFields.NroAsiento.Value;

                 With DmApunteTable do
                   begin

                   CancelRange;

                   try

                     Append;

                     DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                     DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                     DmApunteFields.NroApunte.Value := 1;
                     DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                     DmApunteFields.Subcuenta.Value := SessionDataModule.Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srEnCartera, True );
                     DmApunteFields.Contrapartida.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                     DmApunteFields.Concepto.Value := EfectoCobrarFields.Concepto.Value;
                     DmApunteFields.TipoApunte.Value := tapManual;

                     SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.Importe.Value, False );

                     ApunteFieldValues := GetFieldValues;

                     SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                     Post;

                     Append;

                     SetFieldValues( ApunteFieldValues );

                     DmApunteFields.NroApunte.Value := DmApunteFields.NroApunte.Value + 1;
                     DmApunteFields.Subcuenta.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                     DmApunteFields.Contrapartida.Value := SessionDataModule.Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srEnCartera, True );

                     SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.Importe.Value, True );

                     SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                     Post;

                   except
                     Cancel;
                     raise;
                     end;

                   end;

                 end
            else With EfectoCobrarFields do
                   begin
                   If   not ValueIsEmpty( NroAsientoCartera.Value )
                   then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                             NroAsientoCartera.Value,
                                                                             taCobro,
                                                                             FechaLibramiento.Value,
                                                                             SubcuentaCliente.Value,
                                                                             Serie.Value,
                                                                             NroFactura.Value,
                                                                             NroEfecto.Value );
                   NroAsientoCartera.Clear;
                   end;

            SessionDataModule.Dm10.AsientoModule.RetiraNroAsiento( DmAsientoFields, False );

            end;

       EfectoCobrarFields.Table.Post;

       TransactionTag.Commit;

     except on E : Exception do
       begin
       EfectoCobrarFields.Dataset.Cancel;
       TransactionTag.Rollback;
       raise;
       end;
     end;

end;

procedure TEfectoCobrarModule.SuprimeEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ EfectoCobrarFields.Table ] );

     try

       With EfectoCobrarFields do
         If   not ValueIsEmpty( NroAsientoCartera.Value )
         then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                            					             NroAsientoCartera.Value,
                                            					             taCartera,
						                                                       FechaLibramiento.Value,
						                                                       SubcuentaCliente.Value,
						                                                       Serie.Value,
						                                                       NroFactura.Value,
						                                                       NroEfecto.Value );

       EfectoCobrarFields.Table.Delete;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

procedure TEfectoCobrarModule.ActualizaAnotacionCobro( EfectoCobrar : IEfectoCobrar );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( EfectoCobrar.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ EfectoCobrar.Ejercicio, EfectoCobrar.Serie, EfectoCobrar.NroFactura, EfectoCobrar.NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               EfectoCobrar.ToDataset( DmEfectoCobrarFields );
               ActualizaAnotacionCobro( DmEfectoCobrarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.ActualizaAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields );

var   ExisteFichaCliente : Boolean;
      CuentaDifCambio : string;
      ImporteEfecto : Decimal;
      CentroCoste : String;
      ApunteFieldValues : TFieldValuesArray;
      NroApunteActual : SmallInt;
      Diferencia : Decimal;
      Contado,
      GeneraAsiento,
      ExisteAsientoFactura : Boolean;
      ProximoNroEfecto : SmallInt;

begin

     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, EfectoCobrarFields.Table ] );

       try

         If   not ValueIsEmpty( EfectoCobrarFields.FechaCobro.Value )
         then begin

              // Primero compruebo si hay que generar un nuevo efecto por la diferencia

              With EfectoCobrarFields do
                 Diferencia := Redondea( Importe.Value - ImporteCobrado.Value + DiferenciaCambio.Value );

              If   Diferencia<>0.0
              then If   EfectoCobrarFields.GenerarEfectoDiferencia.Value and
                        ( EfectoCobrarFields.GenerarEfectoDiferencia.OldValue<>EfectoCobrarFields.GenerarEfectoDiferencia.Value )
                   then try

                          If   DmEfectoCobrarAuxTable.FindEqualLast( [ EfectoCobrarFields.Ejercicio.Value, EfectoCobrarFields.Serie.Value, EfectoCobrarFields.NroFactura.Value ] )
                          then begin

                               ProximoNroEfecto := DmEfectoCobrarAuxFields.NroEfecto.Value + 1;

                               DmEfectoCobrarAuxTable.Append;
                               DmEfectoCobrarAuxTable.CopyFields( EfectoCobrarFields.Table );

                               DmEfectoCobrarAuxFields.NroEfecto.Value := ProximoNroEfecto;

                               DmEfectoCobrarAuxFields.Concepto.Value := TextoConcepto( DmEfectoCobrarAuxFields );
                               DmEfectoCobrarAuxFields.FechaCobro.Clear;
                               DmEfectoCobrarAuxFields.Importe.Value := Diferencia;

                               DmEfectoCobrarAuxFields.DiferenciaCambio.Clear;
                               DmEfectoCobrarAuxFields.ImporteCobrado.Clear;
                               DmEfectoCobrarAuxFields.ConceptoCobro.Clear;
                               DmEfectoCobrarAuxFields.GenerarEfectoDiferencia.Clear;
                               DmEfectoCobrarAuxFields.SubcuentaDiferencia.Clear;
                               DmEfectoCobrarAuxFields.GastosGestion.Clear;
                               DmEfectoCobrarAuxFields.GastosDevolucion.Clear;
                               DmEfectoCobrarAuxFields.SubcuentaGastos.Clear;
                               DmEfectoCobrarAuxFields.NroAsientoCobro.Clear;

                               ActualizaEfectoCobrar( DmEfectoCobrarAuxFields );

                               EfectoCobrarFields.NroEfectoDiferencia.Value := ProximoNroEfecto;
                               end
                          else Abort;

                          except
                            DmEfectoCobrarAuxTable.Cancel;
                            SessionDataModule.SendNotification( ntStop, RsMsg24, '' );
                            raise;
                            end;

              GeneraAsiento := True;
              Contado := False;

              If   EfectoCobrarFields.FormaDePago.Value<>''
              then If   DmFormaCobroTable.FindKey( [ EfectoCobrarFields.FormaDePago.Value ] )
                   then begin
                        If   DmFormaCobroFields.NoContabilizar.Value
                        then GeneraAsiento := False;
                        Contado := DmFormaCobroFields.Plazos.Value=0;
                        end;

              If   GeneraAsiento
              then begin

                   ExisteAsientoFactura := SessionDataModule.Dm10.AsientoModule.ObtenDocumento( taFraEmitida,
                                                                                                EjercicioFecha( EfectoCobrarFields.FechaLibramiento.Value ),
                                                                                                EfectoCobrarFields.SubcuentaCliente.Value,
                                                                                                EfectoCobrarFields.Serie.Value,
                                                                                                EfectoCobrarFields.NroFactura.Value,
                                                                                                NroEfectoRegistroFactura,
                                                                                                DmAsientoFacFields );

                   ExisteFichaCliente := Dm10.ClienteModule.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, DmClienteFields );

                   CentroCoste := '';
                   If   EmpresaFields.Contable_CtrosCoste.Value and ExisteAsientoFactura
                   then If   DmApunteTable.FindKey( [ DmAsientoFacFields.Ejercicio.Value, DmAsientoFacFields.NroAsiento.Value, 2 ] )
                        then CentroCoste := DmApunteFields.CentroCoste.Value;

                   try

                     If   not ValueIsEmpty( EfectoCobrarFields.NroAsientoCobro.Value ) and
                          DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, EfectoCobrarFields.NroAsientoCobro.Value ] )
                     then begin
                          SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields,
                                                                               taCobro,
                                                                               EfectoCobrarFields.FechaLibramiento.Value,
                                                                               EfectoCobrarFields.SubcuentaCliente.Value,
                                                                               EfectoCobrarFields.Serie.Value,
                                                                               EfectoCobrarFields.NroFactura.Value,
                                                                               EfectoCobrarFields.NroEfecto.Value,
                                                                               True );
                          DmAsientoTable.Edit;
                          end
                     else begin
                          DmAsientoTable.Append;

                          DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                          DmAsientoFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;

                          DmAsientoFields.TipoAsiento.Value := taCobro;
                          DmAsientoFields.FechaDocumento.Value := EfectoCobrarFields.FechaLibramiento.Value;
                          DmAsientoFields.Propietario.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                          DmAsientoFields.Serie.Value := EfectoCobrarFields.Serie.Value;
                          DmAsientoFields.NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                          DmAsientoFields.NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                          DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taCobro );
                          DmAsientoFields.Nombre.Value := Dm10.CuentaModule.Descripcion( EfectoCobrarFields.SubcuentaCliente.Value, True, False );
                          end;

                     DmAsientoFields.Fecha.Value := EfectoCobrarFields.FechaCobro.Value;

                     DmAsientoTable.Post;

                   except
                     DmAsientoTable.Cancel;
                     raise;
                     end;

                   EfectoCobrarFields.NroAsientoCobro.Value := DmAsientoFields.NroAsiento.Value;

                   NroApunteActual := 1;

                   With DmApunteTable do
                     begin

                     CancelRange;

                     Append;

                     DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                     DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                     DmApunteFields.NroApunte.Value := NroApunteActual;
                     DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                     DmApunteFields.Subcuenta.Value := EfectoCobrarFields.SubcuentaEntidad.Value;
                     DmApunteFields.Contrapartida.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srEnCartera, True, Contado );
                     DmApunteFields.Concepto.Value := EfectoCobrarFields.ConceptoCobro.Value;
                     DmApunteFields.TipoApunte.Value := tapManual;

                     SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.ImporteCobrado.Value - EfectoCobrarFields.GastosGestion.Value, False );

                     ApunteFieldValues := GetFieldValues;

                     Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                     Post;

                     If   EfectoCobrarFields.GenerarEfectoDiferencia.Value
                     then ImporteEfecto := EfectoCobrarFields.ImporteCobrado.Value - EfectoCobrarFields.DiferenciaCambio.Value
                     else ImporteEfecto := EfectoCobrarFields.Importe.Value;
                     Diferencia := EfectoCobrarFields.Importe.Value - EfectoCobrarFields.ImporteCobrado.Value + EfectoCobrarFields.DiferenciaCambio.Value;

                     Inc( NroApunteActual );

                     Append;

                     SetFieldValues( ApunteFieldValues );

                     DmApunteFields.NroApunte.Value := NroApunteActual;
                     DmApunteFields.Subcuenta.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srEnCartera, True, Contado );
                     DmApunteFields.Contrapartida.Value := EfectoCobrarFields.SubcuentaEntidad.Value;

                     SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteEfecto, True );

                     Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                     Post;

                     Inc( NroApunteActual );

                     If   ( EmpresaFields.RegimenEspecialCriterioCaja.Value or ( Dm10.AsientoModule.EjercicioTransicionCriterioCaja and ( YearOf( DmAsientoFacFields.Fecha.Value )<SessionDataModule.Ejercicio ) ) ) and
                          ExisteAsientoFactura and
                          ExisteFichaCliente and
                          ( DmClienteFields.Factura_ModeloIVA.Value=micSinRE ) and
						                    ( ( SessionDataModule.Ejercicio - YearOf( DmAsientoFacFields.Fecha.Value ) )<=2 )   // Los efectos de facturas de más de 2 ejercicios ya deben haber sido liquidadas y, por lo tanto, ya no se debe contabilizar el traspaso del I.V.A.
                     then SessionDataModule.Dm10.AsientoModule.CreaApuntesIVADevengado( DmAsientoFields,
                                                                                        DmApunteFields,
                                                                                        DmAsientoFacFields,
                                                                                        EfectoCobrarFields.NroEfecto.Value,
                                                                                        EfectoCobrarFields.ImporteCobrado.Value,
                                                                                        DmApunteFields.Concepto.Value,
                                                                                        NroApunteActual );

                     If   ( Diferencia<>0.0 ) and not EfectoCobrarFields.GenerarEfectoDiferencia.Value
                     then begin

                          Append;

                          SetFieldValues( ApunteFieldValues );

                          DmApunteFields.NroApunte.Value := NroApunteActual;

                          DmApunteFields.Subcuenta.Value := EfectoCobrarFields.SubcuentaDiferencia.Value;
                          DmApunteFields.CentroCoste.Value := CentroCoste;
                          DmApunteFields.Contrapartida.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srEnCartera, True );

                          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, Diferencia, False );

                          Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                          Post;

                          Inc( NroApunteActual );
                          end;

                     If   EfectoCobrarFields.GastosGestion.Value<>0.0
                     then begin

                          Append;

                          SetFieldValues( ApunteFieldValues );

                          DmApunteFields.NroApunte.Value := NroApunteActual;

                          DmApunteFields.Subcuenta.Value := EfectoCobrarFields.SubcuentaGastos.Value;
                          DmApunteFields.CentroCoste.Value := CentroCoste;
                          DmApunteFields.Contrapartida.Value := EfectoCobrarFields.SubcuentaEntidad.Value;

                          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.GastosGestion.Value, False );

                          Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                          Post;

                          Inc( NroApunteActual );
                          end;

                     If   EfectoCobrarFields.DiferenciaCambio.Value<>0.0
                     then If   EmpresaFields.Contable_Divisas.Value
                          then begin

                               CuentaDifCambio  := '';
                               If   Dm10.ClienteModule.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, DmClienteFields )
                               then If   Dm10.RelacionesDivisaModule.Obten( DmClienteFields.CodigoDivisa.Value, DmRelacionesDivisaFields )
                                    then If   EfectoCobrarFields.DiferenciaCambio.Value>0.0
                                         then CuentaDifCambio := DmRelacionesDivisaFields.DifPositivasCambio.Value
                                         else CuentaDifCambio := DmRelacionesDivisaFields.DifNegativasCambio.Value;

                               If   CuentaDifCambio=''
                               then If   EfectoCobrarFields.DiferenciaCambio.Value>0.0
                                    then begin
                                         CuentaDifCambio := Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaDifPositivasCambio );
                                         Dm10.CuentaModule.InsertaSubcuenta( CuentaDifCambio, Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaDifPositivasCambio ) );
                                         end
                                    else begin
                                         CuentaDifCambio := Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaDifNegativasCambio );
                                         Dm10.CuentaModule.InsertaSubcuenta( CuentaDifCambio, Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaDifNegativasCambio ) );
                                         end;

                               Append;

                               SetFieldValues( ApunteFieldValues );

                               DmApunteFields.NroApunte.Value := NroApunteActual;
                               DmApunteFields.Subcuenta.Value := CuentaDifCambio;
                               DmApunteFields.CentroCoste.Value := CentroCoste;
                               DmApunteFields.Contrapartida.Value := EfectoCobrarFields.SubcuentaEntidad.Value;

                               SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.DiferenciaCambio.Value, True );

                               Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                               Post;
                               end;

                     end;

                   end
              else With EfectoCobrarFields do
                     begin
                     If   not ValueIsEmpty( NroAsientoCobro.Value )
                     then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                               NroAsientoCobro.Value,
                                                                               taCobro,
                                                                               FechaLibramiento.Value,
                                                                               SubcuentaCliente.Value,
                                                                               Serie.Value,
                                                                               NroFactura.Value,
                                                                               NroEfecto.Value );
                     NroAsientoCobro.Clear;
                     end;

              Dm10.AsientoModule.RetiraNroAsiento( DmAsientoFields, False );

              end;

         EfectoCobrarFields.Table.Post;

         TransactionTag.Commit;

       except on E : Exception do
         begin
         DmAsientoTable.Cancel;
         DmApunteTable.Cancel;
         EfectoCobrarFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;
       end;

       end;

end;

procedure TEfectoCobrarModule.ActualizaAnotacionImpagado( EfectoCobrar : IEfectoCobrar );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( EfectoCobrar.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ EfectoCobrar.Ejercicio, EfectoCobrar.Serie, EfectoCobrar.NroFactura, EfectoCobrar.NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               EfectoCobrar.ToDataset( DmEfectoCobrarFields );
               ActualizaAnotacionImpagado( DmEfectoCobrarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.ActualizaAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields );

var  CuentaRiesgoCliente,
     CuentaImpagadosCliente : String;
     ImporteDevolucion : Decimal;
     FieldValuesArray : TFieldValuesArray;

begin

     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, EfectoCobrarFields.Table ] );

       try

         If   not ValueIsEmpty( EfectoCobrarFields.NroEfectoReemitido.Value )
         then If   DmEfectoCobrarAuxTable.FindKey( [ EjercicioFecha( EfectoCobrarFields.FechaImpagado.Value ), EfectoCobrarFields.Serie.Value, EfectoCobrarFields.NroFactura.Value, EfectoCobrarFields.NroEfectoReemitido.Value ] )
              then If   not ValueIsEmpty( DmEfectoCobrarAuxFields.FechaCobro.Value ) or
                        not ValueIsEmpty( DmEfectoCobrarAuxFields.NroRemesa.Value )
                   then begin
                        SessionDataModule.SendNotification( ntStop, Format( RsMsg17, [ EfectoCobrarFields.NroEfectoReemitido.Value ] ), RsMsg18 );
                        Abort;
                        end
                   else SuprimeEfectoCobrar( DmEfectoCobrarAuxFields );

         Dm10.FormaCobroModule.Obten( EfectoCobrarFields.FormaDePago.Value, DmFormaCobroFields );

         If   EfectoCobrarFields.Impagado.Value
         then begin

              If   DmFormaCobroFields.NoContabilizar.Value
              then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                        EfectoCobrarFields.NroAsientoImpagado.Value,
                                                                        taImpagado,
                                                                        EfectoCobrarFields.FechaLibramiento.Value,
                                                                        EfectoCobrarFields.SubcuentaCliente.Value,
                                                                        EfectoCobrarFields.Serie.Value,
                                                                        EfectoCobrarFields.NroFactura.Value,
                                                                        EfectoCobrarFields.NroEfecto.Value )
              else begin

                   Dm10.BancoModule.Obten( EfectoCobrarFields.SubcuentaEntidad.Value, DmBancoFields );

                   CuentaRiesgoCliente := ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srDescontados, True );
                   CuentaImpagadosCliente := ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value, srImpagados, True );
                   ImporteDevolucion := EfectoCobrarFields.Importe.Value + EfectoCobrarFields.GastosDevolucion.Value;

                   try

                     If   not ValueIsEmpty( EfectoCobrarFields.NroAsientoImpagado.Value ) and
                          DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, EfectoCobrarFields.NroAsientoImpagado.Value ] )
                     then begin
                          Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields,
                                                             taImpagado,
                                                             EfectoCobrarFields.FechaLibramiento.Value,
                                                             EfectoCobrarFields.SubcuentaCliente.Value,
                                                             EfectoCobrarFields.Serie.Value,
                                                             EfectoCobrarFields.NroFactura.Value,
                                                             EfectoCobrarFields.NroEfecto.Value,
                                                             True );
                          DmAsientoTable.Edit;
                          end
                     else begin
                          DmAsientoTable.Append;

                          DmAsientoFields.Ejercicio.Value := Ejercicio;
                          DmAsientoFields.NroAsiento.Value := Dm10.AsientoModule.ProximoNroAsiento;
                          DmAsientoFields.TipoAsiento.Value := taImpagado;
                          DmAsientoFields.Propietario.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                          DmAsientoFields.Serie.Value := EfectoCobrarFields.Serie.Value;
                          DmAsientoFields.NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                          DmAsientoFields.NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                          DmAsientoFields.FechaDocumento.Value := EfectoCobrarFields.FechaLibramiento.Value;
                          DmAsientoFields.NroRegistro.Value := Dm10.AsientoModule.ProximoNroRegistro( taImpagado );
                          DmAsientoFields.Nombre.Value := Dm10.CuentaModule.Descripcion( EfectoCobrarFields.SubcuentaCliente.Value, True, False );
                          end;

                     DmAsientoFields.Fecha.Value := EfectoCobrarFields.FechaImpagado.Value;

                     DmAsientoTable.Post;

                   except
                     DmAsientoTable.Cancel;
                     raise;
                     end;

                   EfectoCobrarFields.NroAsientoImpagado.Value := DmAsientoFields.NroAsiento.Value;

                   DmApunteTable.Append;

                   DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                   DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                   DmApunteFields.NroApunte.Value := 1;
                   DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                   DmApunteFields.Subcuenta.Value := DmBancoFields.Subcuenta_Riesgo.Value;
                   DmApunteFields.Contrapartida.Value := CuentaRiesgoCliente;
                   DmApunteFields.Concepto.Value := Format( RsMsg19, [ EfectoCobrarFields.Serie.Value + ' ' + StrInt( EfectoCobrarFields.NroFactura.Value ) + '/' + StrInt( EfectoCobrarFields.NroEfecto.Value ) ] );

                   SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.Importe.Value );

                   FieldValuesArray := DmApunteTable.GetFieldValues;

                   Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );
                   DmApunteTable.Post;

                   DmApunteTable.Append;

                   DmApunteTable.SetFieldValues( FieldValuesArray );

                   DmApunteFields.NroApunte.Value := 2;
                   DmApunteFields.Subcuenta.Value := CuentaImpagadosCliente; // EfectoCobrarFields.Cliente.Value;
                   DmApunteFields.Contrapartida.Value := DmBancoFields.Subcuenta_Riesgo.Value;

                   SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteDevolucion );

                   Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );
                   DmApunteTable.Post;

                   DmApunteTable.Append;

                   DmApunteTable.SetFieldValues( FieldValuesArray );

                   DmApunteFields.NroApunte.Value := 3;
                   DmApunteFields.Subcuenta.Value := DmBancoFields.Subcuenta.Value;
                   DmApunteFields.Contrapartida.Value := CuentaImpagadosCliente; // EfectoCobrarFields.Cliente.Value;

                   SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteDevolucion, True );

                   Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );
                   DmApunteTable.Post;

                   DmApunteTable.Append;

                   DmApunteTable.SetFieldValues( FieldValuesArray );

                   DmApunteFields.NroApunte.Value := 4;
                   DmApunteFields.Subcuenta.Value := CuentaRiesgoCliente;
                   DmApunteFields.Contrapartida.Value := DmBancoFields.Subcuenta_Riesgo.Value;

                   SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.Importe.Value, True );

                   Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );
                   DmApunteTable.Post;
                   end;

              If   EfectoCobrarFields.VolverAEmitir.Value
              then begin

                   If   ValueIsEmpty( EfectoCobrarFields.NroEfectoReemitido.Value )
                   then EfectoCobrarFields.NroEfectoReemitido.Value := ProximoNroEfecto( EfectoCobrarFields.Ejercicio.Value, EfectoCobrarFields.Serie.Value, EfectoCobrarFields.NroFactura.Value );

                   DmEfectoCobrarAuxTable.Append;

                   DmEfectoCobrarAuxFields.Ejercicio.Value := EfectoCobrarFields.Ejercicio.Value;
                   DmEfectoCobrarAuxFields.Serie.Value := EfectoCobrarFields.Serie.Value;
                   DmEfectoCobrarAuxFields.NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                   DmEfectoCobrarAuxFields.NroEfecto.Value := EfectoCobrarFields.NroEfectoReemitido.Value;
                   DmEfectoCobrarAuxFields.SubcuentaCliente.Value := CuentaImpagadosCliente;
                   DmEfectoCobrarAuxFields.SubcuentaEntidad.Value := EfectoCobrarFields.SubcuentaEntidad.Value;
                   DmEfectoCobrarAuxFields.FechaLibramiento.Value := EfectoCobrarFields.FechaLibramiento.Value;
                   DmEfectoCobrarAuxFields.FechaVencimiento.Value := EfectoCobrarFields.FechaImpagado.Value;
                   DmEfectoCobrarAuxFields.FormaDePago.Value := EfectoCobrarFields.FormaDePago.Value;
                   DmEfectoCobrarAuxFields.CodigoCliente.Value := EfectoCobrarFields.CodigoCliente.Value;
                   DmEfectoCobrarAuxFields.Vendedor.Value := EfectoCobrarFields.Vendedor.Value;
                   DmEfectoCobrarAuxFields.GrupoFacturacion.Value := EfectoCobrarFields.GrupoFacturacion.Value;
                   DmEfectoCobrarAuxFields.Concepto.Value := TextoConcepto( DmEfectoCobrarAuxFields );
                   DmEfectoCobrarAuxFields.Importe.Value := EfectoCobrarFields.Importe.Value + EfectoCobrarFields.GastosDevolucion.Value;

                   ActualizaEfectoCobrar( DmEfectoCobrarAuxFields );

                   end;

              EfectoCobrarFields.Table.Post;

              end
         else SuprimeAnotacionImpagado( EfectoCobrarFields );

         TransactionTag.Commit;

       except on E : Exception do
         begin
         DmApunteTable.Cancel;
         DmAsientoTable.Cancel;
         EfectoCobrarFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;
       end;

       end;

end;

procedure TEfectoCobrarModule.ActualizaCancelacion( EfectoCobrar : IEfectoCobrar );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( EfectoCobrar.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ EfectoCobrar.Ejercicio, EfectoCobrar.Serie, EfectoCobrar.NroFactura, EfectoCobrar.NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               EfectoCobrar.ToDataset( DmEfectoCobrarFields );
               ActualizaCancelacion( DmEfectoCobrarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.ActualizaCancelacion( EfectoCobrarFields : TEfectoCobrarFields );

var  Eos,
     ExisteAsientoCancelacion : Boolean;
     NroApunteActual: SmallInt;

begin
     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, EfectoCobrarFields.Table ] );

       try

         Dm10.FormaCobroModule.Obten( EfectoCobrarFields.FormaDePago.Value, DmFormaCobroFields );

         If   EfectoCobrarFields.Cancelado.Value and not DmFormaCobroFields.NoContabilizar.Value
         then begin

              Dm10.BancoModule.Obten( EfectoCobrarFields.SubcuentaEntidad.Value, DmBancoFields );

              ExisteAsientoCancelacion := False;

              try

                If   not ValueIsEmpty( EfectoCobrarFields.NroAstoCancelacion.Value ) and
                     DmAsientoTable.FindKey( [ Ejercicio, EfectoCobrarFields.NroAstoCancelacion.Value ] )
                then begin
                     Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields,
                                                        taCancelacionEfecto,
                                                        EfectoCobrarFields.FechaLibramiento.Value,
                                                        EfectoCobrarFields.SubcuentaCliente.Value,
                                                        EfectoCobrarFields.Serie.Value,
                                                        EfectoCobrarFields.NroFactura.Value,
                                                        EfectoCobrarFields.NroEfecto.Value,
                                                        True );
                     DmAsientoTable.Edit;
                     DmAsientoFields.Fecha.Value := EfectoCobrarFields.FechaCancelacion.Value;
                     end
                else begin
                     DmAsientoTable.Append;
                     DmAsientoFields.Ejercicio.Value := Ejercicio;
                     DmAsientoFields.NroAsiento.Value := Dm10.AsientoModule.ProximoNroAsiento;
                     DmAsientoFields.TipoAsiento.Value := taCancelacionEfecto;
                     DmAsientoFields.Serie.Value := EfectoCobrarFields.Serie.Value;
                     DmAsientoFields.NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                     DmAsientoFields.NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                     DmAsientoFields.Fecha.Value := EfectoCobrarFields.FechaCancelacion.Value;
                     DmAsientoFields.FechaDocumento.Value := EfectoCobrarFields.FechaLibramiento.Value;
                     DmAsientoFields.NroRegistro.Value := Dm10.AsientoModule.ProximoNroRegistro( taCancelacionEfecto );
                     end;

                DmAsientoTable.Post;

              except
                DmAsientoTable.Cancel;
                raise;
                end;

              NroApunteActual := 1;

              DmApunteTable.Append;

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

              DmApunteFields.NroApunte.Value := NroApunteActual;
              DmApunteFields.Subcuenta.Value := DmBancoFields.Subcuenta_Riesgo.Value;
              DmApunteFields.Contrapartida.Value := EfectoCobrarFields.SubcuentaCliente.Value;
              DmApunteFields.Concepto.Value := Format( RsMsg23, [ EfectoCobrarFields.Serie.Value + ' ' + StrInt( EfectoCobrarFields.NroFactura.Value ) + '/' + StrInt( EfectoCobrarFields.NroEfecto.Value ) ] );
              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.Importe.Value );

              Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

              DmApunteTable.Post;

              DmApunteTable.Append;

              Inc( NroApunteActual );

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
              DmApunteFields.NroApunte.Value := NroApunteActual;
              DmApunteFields.Subcuenta.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( EfectoCobrarFields.SubcuentaCliente.Value );
              DmApunteFields.Contrapartida.Value := DmBancoFields.Subcuenta_Riesgo.Value;
              DmApunteFields.Concepto.Value := Format( RsMsg23, [ EfectoCobrarFields.Serie.Value + ' ' + StrInt( EfectoCobrarFields.NroFactura.Value ) + '/' + StrInt( EfectoCobrarFields.NroEfecto.Value ) ] );
              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoCobrarFields.Importe.Value, True );

              Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

              DmApunteTable.Post;

              Inc( NroApunteActual );

              If   EmpresaFields.RegimenEspecialCriterioCaja.Value or Dm10.AsientoModule.EjercicioTransicionCriterioCaja
              then If   Dm10.ClienteModule.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, DmClienteFields ) and ( DmClienteFields.Factura_ModeloIVA.Value=micSinRE )
                   then If   Dm10.AsientoModule.ObtenDocumento( taFraEmitida,
                                                                EjercicioFecha( EfectoCobrarFields.FechaLibramiento.Value ),
                                                                EfectoCobrarFields.SubcuentaCliente.Value,
                                                                EfectoCobrarFields.Serie.Value,
                                                                EfectoCobrarFields.NroFactura.Value,
                                                                NroEfectoRegistroFactura,
                                                                DmAsientoFacFields )
                        then If   not ( Dm10.AsientoModule.EjercicioTransicionCriterioCaja and ( YearOf( DmAsientoFacFields.Fecha.Value )=SessionDataModule.Ejercicio ) ) and
                                  ( ( SessionDataModule.Ejercicio - YearOf( DmAsientoFacFields.Fecha.Value ) )<=2 )  // Los efectos de facturas de más de 2 ejercicios ya deben haber sido liquidadas y, por lo tanto, ya no se debe contabilizar el traspaso del I.V.A.
                             then Dm10.AsientoModule.CreaApuntesIVADevengado( DmAsientoFields,
                                                                              DmApunteFields,
                                                                              DmAsientoFacFields,
                                                                              EfectoCobrarFields.NroEfecto.Value,
                                                                              EfectoCobrarFields.Importe.Value,
                                                                              DmApunteFields.Concepto.Value,
                                                                              NroApunteActual );

              try
                EfectoCobrarFields.Table.Edit;
                EfectoCobrarFields.NroAstoCancelacion.Value := DmAsientoFields.NroAsiento.Value;
                EfectoCobrarFields.Table.Post;
              except
                EfectoCobrarFields.Table.Cancel;
                raise;
                end;

              end
         else SuprimeCancelacion( EfectoCobrarFields );

         TransactionTag.Commit;

       except on E : Exception do
         begin
         DmApunteTable.Cancel;
         DmAsientoTable.Cancel;
         EfectoCobrarFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;
       end;

       end;

end;

procedure TEfectoCobrarModule.SuprimeAnotacionImpagado( RemoteCursorID : TnxCursorID;
                                                        Ejercicio      : SmallInt;
                                                        Serie          : String;
                                                        NroFactura     : LongInt;
                                                        NroEfecto      : SmallInt );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAnotacionImpagado( DmEfectoCobrarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.SuprimeAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ EfectoCobrarFields.Table ] );

     try

        With EfectoCobrarFields do
          If   not ValueIsEmpty( NroAsientoImpagado.Value )
          then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                    NroAsientoImpagado.Value,
                                                                    taImpagado,
                                                                    FechaLibramiento.Value,
                                                                    SubcuentaCliente.Value,
                                                                    Serie.Value,
                                                                    NroFactura.Value,
                                                                    NroEfecto.Value );

        try

          EfectoCobrarFields.Table.Edit;

          EfectoCobrarFields.Impagado.Value := False;
          EfectoCobrarFields.FechaImpagado.Clear;
          EfectoCobrarFields.GastosDevolucion.Clear;
          EfectoCobrarFields.VolverAEmitir.Value := False;
          EfectoCobrarFields.NroEfectoReemitido.Clear;
          EfectoCobrarFields.NroAsientoImpagado.Clear;

          EfectoCobrarFields.Table.Post;

        except
          EfectoCobrarFields.Table.Cancel;
          raise;
          end;

        TransactionTag.Commit;

      except
        TransactionTag.Rollback;
        raise;
        end;

end;

procedure TEfectoCobrarModule.SuprimeCancelacion( RemoteCursorID : TnxCursorID;
                                                  Ejercicio      : SmallInt;
                                                  Serie          : String;
                                                  NroFactura     : Integer;
                                                  NroEfecto      : SmallInt);
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoCobrarTable.FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeCancelacion( DmEfectoCobrarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoCobrarModule.SuprimeCancelacion( EfectoCobrarFields : TEfectoCobrarFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ EfectoCobrarFields.Table ] );

     try

       With EfectoCobrarFields do
         If   not ValueIsEmpty( NroAstoCancelacion.Value )
         then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                   NroAstoCancelacion.Value,
                                                                   taCancelacionEfecto,
                                                                   FechaLibramiento.Value,
                                                                   SubcuentaCliente.Value,
                                                                   Serie.Value,
                                                                   NroFactura.Value,
                                                                   NroEfecto.Value );

       try
         EfectoCobrarFields.Table.Edit;

         EfectoCobrarFields.Cancelado.Clear;
         EfectoCobrarFields.FechaCancelacion.Clear;
         EfectoCobrarFields.NroAstoCancelacion.Clear;

         EfectoCobrarFields.Table.Post;

       except
         EfectoCobrarFields.Table.Cancel;
         Raise;
         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;
end;


{ TEfectoCobrarService }

procedure TEfectoCobrarService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TEfectoCobrarService.CompruebaEfectos( Ejercicio : SmallInt; Serie: String; NroFactura: Integer; SuprimirEfectos: Boolean ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoCobrarModule.CompruebaEfectos( Ejercicio, Serie, NroFactura, SuprimirEfectos );
end;

function TEfectoCobrarService.EfectoPendiente( Ejercicio: SmallInt; Serie: String; NroFactura: Integer; NroEfecto: SmallInt; IncluirEfectosRemesados: Boolean ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoCobrarModule.EfectoPendiente( Ejercicio, Serie, NroFactura, NroEfecto, IncluirEfectosRemesados );
end;

function TEfectoCobrarService.FechaCobro( Ejercicio: SmallInt; Serie: String; NroFactura: Integer; NroEfecto: SmallInt ) : TDate;
begin
     Result := SessionDataModule.Dm10.EfectoCobrarModule.FechaCobro( Ejercicio, Serie, NroFactura, NroEfecto );
end;

function TEfectoCobrarService.GeneraEfectos( NroAsiento       : Integer;
                                             SubcuentaCliente,
                                             CodigoFormaCobro : String;
                                             Importe          : Decimal ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoCobrarModule.GeneraEfectos( NroAsiento, SubcuentaCliente, CodigoFormaCobro, Importe );
end;

procedure TEfectoCobrarService.ActualizaEfectoCobrar( EfectoCobrar : IEfectoCobrar );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.ActualizaEfectoCobrar( EfectoCobrar );
end;

procedure TEfectoCobrarService.SuprimeEfectoCobrar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.SuprimeEfectoCobrar( RemoteCursorID, Ejercicio, Serie, NroFactura, NroEfecto );
end;

procedure TEfectoCobrarService.SuprimeEfectosFactura( Ejercicio : SmallInt; Serie: String; NroFactura: Integer);
begin
     SessionDataModule.Dm10.EfectoCobrarModule.SuprimeEfectosFactura( Ejercicio, Serie, NroFactura );
end;

procedure TEfectoCobrarService.ActualizaAnotacionCobro( EfectoCobrar: IEfectoCobrar );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.ActualizaAnotacionCobro( EfectoCobrar );
end;

procedure TEfectoCobrarService.SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.SuprimeAnotacionCobro( RemoteCursorID, Ejercicio, Serie, NroFactura, NroEfecto );
end;

procedure TEfectoCobrarService.ActualizaAnotacionImpagado( EfectoCobrar: IEfectoCobrar );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.ActualizaAnotacionImpagado( EfectoCobrar );
end;

procedure TEfectoCobrarService.ActualizaCancelacion( EfectoCobrar : IEfectoCobrar );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.ActualizaCancelacion( EfectoCobrar );
end;

procedure TEfectoCobrarService.SuprimeAnotacionImpagado( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.SuprimeAnotacionImpagado( RemoteCursorID, Ejercicio, Serie, NroFactura, NroEfecto );
end;

procedure TEfectoCobrarService.SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : Integer; NroEfecto : SmallInt );
begin
     SessionDataModule.Dm10.EfectoCobrarModule.SuprimeCancelacion( RemoteCursorID, Ejercicio, Serie, NroFactura, NroEfecto );
end;

initialization
    TnxClassFactory.RegisterClass( CLSID_EfectoCobrarService, TEfectoCobrarService, EfectoCobrarControl );

end.

