
unit dm_rem;

interface

uses
  Windows, Messages, SysUtils, Classes,

  LibUtils,

  DB,
  nxdb,
  nxsdTypes,

  DataManager,

  ServerDataModule,
  SessionIntf,
  Gim10Fields,

  RemesaIntf,

  dmi_rem;


type

  TRemesaService = class( TSessionModule, IRemesaService )
    private

    public

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaRemesa( Remesa: IRemesa );
    procedure SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : LongInt );

    procedure ActualizaAnotacionCobro( Remesa: IRemesa; Concepto : String );
    procedure SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure ActualizaAceptacion( Remesa: IRemesa; Concepto : String );
    procedure SuprimeAceptacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure ActualizaDescuento( Remesa : IRemesa; Concepto : String );
    procedure SuprimeDescuento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure ActualizaCancelacion( Remesa : IRemesa );
    procedure SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    procedure CancelacionAutomatica( Fecha : TDate; MesesAntiguedad : SmallInt );

    function  ObtenConcepto( Ejercicio : SmallInt; NroRemesa : LongInt; TipoAsiento : SmallInt ) : String;
    procedure ImporteRemesa( Ejercicio : SmallInt; NroRemesa : longInt; var Importe : Decimal; var ImporteImpagados : Decimal; var ImporteCancelados : Decimal );
    function UltimoVencimiento( Ejercicio : SmallInt; NroRemesa : longInt ) : TDate;

    end;

  TRemesaModule = class(TServerDataModule)
    DmRemesaTable: TnxeTable;
    DmEfectoCobrarTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    DmRemesaFields : TRemesaFields;
    DmEfectoCobrarFields : TEfectoCobrarFields;
    DmAsientoFields : TAsientoFields;
    DmApunteFields : TApunteFields;

    DsAsientoFacturaFields : TAsientoFields;
    DsBancoFields : TBancoFields;
    DsClienteFields : TClienteFields;

    function ObtenIDEvento( RemesaFields : TRemesaFields ) : String;
    procedure SustituyeSubcuentaEntidadEfectos( EjercicioRemesa : SmallInt; NroRemesa : LongInt; SubcuentaEntidad : String = '' );

  public

    procedure ImporteRemesa( Ejercicio : SmallInt; NroRemesa : longInt; var Importe : Decimal; var ImporteImpagados : Decimal; var ImporteCancelados : Decimal );
    function UltimoVencimiento( Ejercicio : SmallInt; NroRemesa : longInt ) : TDate;

    function  Obten( Ejercicio : SmallInt; NroRemesa : longInt; RemesaFields : TRemesaFields ) : Boolean;
    function  ObtenAsientoRemesa( RemesaFields : TRemesaFields; TipoAsiento : SmallInt; NroOrdenAsiento : SmallInt = 1; AsientoFields : TAsientoFields = nil ) : Boolean;
    function  ObtenConcepto( Ejercicio : SmallInt; NroRemesa : LongInt; TipoAsiento : SmallInt ) : String;

    procedure ActualizaRemesa( Remesa: IRemesa );
    procedure SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : LongInt ); overload;
    procedure SuprimeRemesa( RemesaFields : TRemesaFields ); overload;

    procedure ActualizaAceptacion( Remesa: IRemesa; Concepto : String ); overload;
    procedure ActualizaAceptacion( RemesaFields : TRemesaFields; Concepto : String ); overload;
    procedure SuprimeAceptacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt;NroRemesa : LongInt ); overload;
    procedure SuprimeAceptacion( RemesaFields : TRemesaFields ); overload;

    procedure ActualizaAnotacionCobro( Remesa: IRemesa; Concepto : String ); overload;
    procedure ActualizaAnotacionCobro( RemesaFields : TRemesaFields; Concepto : String ); overload;
    procedure SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt;NroRemesa : LongInt ); overload;
    procedure SuprimeAnotacionCobro( RemesaFields : TRemesaFields ); overload;

    procedure ActualizaDescuento( Remesa : IRemesa; Concepto : String ); overload;
    procedure ActualizaDescuento( RemesaFields : TRemesaFields; Concepto : String ); overload;
    procedure SuprimeDescuento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt;NroRemesa : LongInt ); overload;
    procedure SuprimeDescuento( RemesaFields : TRemesaFields ); overload;

    procedure ActualizaCancelacion( Remesa : IRemesa ); overload;
    procedure ActualizaCancelacion( RemesaFields : TRemesaFields ); overload;
    procedure SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt;NroRemesa : LongInt ); overload;
    procedure SuprimeCancelacion( RemesaFields : TRemesaFields ); overload;

    procedure CancelacionAutomatica( Fecha : TDate; MesesAntiguedad : SmallInt );

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     DateUtils,
     MainData,
     EnterpriseData,
     AppManager,

     nxrbTypes,
     nxrdClass,
     nxsrServerEngine,
     nxllBDE,

     Gim00Fields,
     SessionData,

     dmi_ast,
     dmi_iva,

     dm_sch,
     dm_ast,
     dm_ban,
     dm_sal,
     dm_ecc,
     dm_cli,
     dm_iva;

{$R *.DFM}

resourceString
       RsMsg1   = 'La remesa nº %d no existe.';
       RsMsg7   = 'Cancelacion N/Remesa nº %d.';
       RsMsg9   = 'Esta remesa contiene efectos anotados como impagados o cancelados.';
       RsMsg10  = 'Antes de suprimir el descuento debe resolver la situación de esos efectos.';
       RsMsg11  = 'Vencimiento de la remesa descontada nº %d.';
       RsMsg12  = 'Esta remesa ya ha superado el periodo estipulado para su vencimiento.'#13'Utilice la opción de cancelación de remesas para generar el asiento correspondiente.';
       RsMsg13  = 'Vencimiento de la remesa aceptada nº %d.';
       RsMsg14  = 'Esta remesa ya ha superado el periodo estipulado para su aceptación.'#13'Utilice la opción de descuento o cobro de remesas para generar el asiento correspondiente.';

       RsMsg21  = 'Remesa nº %d - %d. Se ha creado el asiento nº %d.';
       RsMsg22  = 'El banco de código [%s] incluido en la remesa %d - %d ha sido dado de baja.';
       RsMsg23  = 'Esta remesa no será procesada. Revise los datos de la misma y su fichero de entidades financieras.';

       RsMsg27  = 'Comprobando la remesa nº %d.';

procedure TRemesaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmRemesaFields := TRemesaFields.Create( DmRemesaTable );
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );

     DsAsientoFacturaFields := TAsientoFields.Create( Self );
     DsBancoFields := TBancoFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
end;

procedure TRemesaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.RemesaModule := nil;
end;

procedure TRemesaModule.SuprimeAceptacion( RemoteCursorID : TnxCursorID;
                                           Ejercicio      : SmallInt;
                                           NroRemesa      : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAceptacion( DmRemesaFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.SuprimeAceptacion( RemesaFields : TRemesaFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaFields.Table ] );

     try


       If   ObtenAsientoRemesa( RemesaFields, taAceptacion )
       then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields );

       RemesaFields.Table.Edit;

       RemesaFields.Estado.Value := erPendiente;
       RemesaFields.FechaAceptacion.Clear;
       RemesaFields.NroAsientoAceptacion.Clear;

       SessionDataModule.Dm00.SchedulerModule.BorraEvento( ObtenIDEvento( RemesaFields ) );

       RemesaFields.Table.Post;

       TransactionTag.Commit;

     except
       RemesaFields.Table.Cancel;
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRemesaModule.SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID;
                                               Ejercicio      : SmallInt;
                                               NroRemesa      : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAnotacionCobro( DmRemesaFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.SuprimeAnotacionCobro( RemesaFields : TRemesaFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaFields.Table ] );

     try

       If   ObtenAsientoRemesa( RemesaFields, taCobroRemesa )
       then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields );

       try

         RemesaFields.Table.Edit;

         If   ValueIsEmpty( RemesaFields.NroAsientoAceptacion.Value )
         then RemesaFields.Estado.Value := erPendiente
         else RemesaFields.Estado.Value := erAceptada;

         RemesaFields.FechaCobro.Clear;
         RemesaFields.NroAsientoCobro.Clear;

         RemesaFields.Table.Post;

       except
         RemesaFields.Table.Cancel;
         raise;
         end;

       TransactionTag.Commit;

     except
       RemesaFields.Table.Cancel;
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRemesaModule.SuprimeCancelacion( RemoteCursorID : TnxCursorID;
                                            Ejercicio      : SmallInt;
                                            NroRemesa      : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeCancelacion( DmRemesaFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.SuprimeCancelacion( RemesaFields : TRemesaFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaFields.Table ] );

     try

       If   ObtenAsientoRemesa( RemesaFields, taCancelacion )
       then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields );

       RemesaFields.Table.Edit;

       RemesaFields.Estado.Value := erDescontada;
       RemesaFields.FechaCancelacion.Clear;
       RemesaFields.NroAstoCancelacion.Clear;

       RemesaFields.Table.Post;

       TransactionTag.Commit;

     except
       RemesaFields.Table.Cancel;
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRemesaModule.SuprimeDescuento( RemoteCursorID : TnxCursorID;
                                          Ejercicio      : SmallInt;
                                          NroRemesa      : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeDescuento( DmRemesaFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.SuprimeDescuento( RemesaFields : TRemesaFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaFields.Table ] );

     try

       try

         DmEfectoCobrarTable.SetRange( [ RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value ] );

         With DmEfectoCobrarTable do
           begin
           First;

           While not Eof  do
             begin
             If   DmEfectoCobrarFields.Impagado.Value or
                  DmEfectoCobrarFields.Cancelado.Value
             then begin
                  SessionDataModule.SendNotification( ntStop, RsMsg9, RsMsg10 );
                  Abort;
                  end;
             Next;
             end;

           end;

         If   ObtenAsientoRemesa( RemesaFields, taDescuento )
         then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields );
         If   ObtenAsientoRemesa( RemesaFields,taDescuento, 2 )
         then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields );

         try

           RemesaFields.Table.Edit;

           If   ValueIsEmpty( RemesaFields.FechaAceptacion.Value )
           then RemesaFields.Estado.Value := erPendiente
           else RemesaFields.Estado.Value := erAceptada;

           RemesaFields.FechaDescuento.Clear;
           RemesaFields.ImporteGastos.Clear;
           RemesaFields.NroAstoDescuento1.Clear;
           RemesaFields.NroAstoDescuento2.Clear;

           SessionDataModule.Dm00.SchedulerModule.BorraEvento( ObtenIDEvento( RemesaFields ) );

           RemesaFields.Table.Post;

         except
           RemesaFields.Table.Cancel;
           raise;
           end;

         TransactionTag.Commit;

       finally
        DmEfectoCobrarTable.CancelRange;
        end;

     except
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRemesaModule.SuprimeRemesa( RemesaFields : TRemesaFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaFields.Table, DmEfectoCobrarTable ] );

     try

       // Saco los efectos de la remesa

       With DmEfectoCobrarTable do
         begin
         SetRange( [ RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value ] );
         First;
         While not Eof do
           begin
           try

             Edit;

             DmEfectoCobrarFields.EjercicioRemesa.Clear;
             DmEfectoCobrarFields.NroRemesa.Clear;
             SessionDataModule.Dm10.ClienteModule.ObtenPorSubcuenta( DmEfectoCobrarFields.SubcuentaCliente.Value, DsClienteFields );
             DmEfectoCobrarFields.SubcuentaEntidad.Value := SessionDataModule.Dm10.EfectoCobrarModule.ObtenCanalPreferente( DsClienteFields );

             DontCheckNullIndexValues := True;   // Si no se activa se ponen los valores anteriores a cero por formar parte del índice

             Post;

           except
             Cancel;
             raise;
             end;

           First;
           end;

         end;

       RemesaFields.Table.Delete;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRemesaModule.SustituyeSubcuentaEntidadEfectos(  EjercicioRemesa  : SmallInt;
                                                           NroRemesa        : LongInt;
                                                           SubcuentaEntidad : String = '' );
begin
     With DmEfectoCobrarTable do
       begin
       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoCobrarTable ] );
       try
         SetRange( [ EjercicioRemesa, NroRemesa ] );
         First;
         While not Eof do
           begin
           try
             Edit;
             If   SubcuentaEntidad=''
             then begin
                  // Se restituye el canal preferente del cliente
                  SessionDataModule.Dm10.ClienteModule.ObtenPorSubcuenta( DmEfectoCobrarFields.SubcuentaCliente.Value, DsClienteFields );
                  DmEfectoCobrarFields.SubcuentaEntidad.Value := SessionDataModule.Dm10.EfectoCobrarModule.ObtenCanalPreferente( DsClienteFields );
                  end
             else DmEfectoCobrarFields.SubcuentaEntidad.Value := SubcuentaEntidad;
             Post;
           except
             Cancel;
             raise;
             end;
           Next;
           end;
         TransactionTag.Commit;
       except
         TransactionTag.Rollback;
         raise;
         end;
       end;
end;

function  TRemesaModule.Obten( Ejercicio    : SmallInt;
                               NroRemesa    : longInt;
                               RemesaFields : TRemesaFields ) : Boolean;
begin
     Result := DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] );
     RemesaFields.Update( DmRemesaTable );
end;

function TRemesaModule.ObtenIDEvento( RemesaFields : TRemesaFields ) : String;

var  ID : String;

begin
     case RemesaFields.Estado.Value of
       erAceptada   : ID := 'AR';
       erDescontada : ID := 'DR';
       erCancelada  : ID := 'CR';
       end;
     Result := SessionDataModule.CodigoEmpresa + Format( '_' + ID + '-%.4d-%.8d', [ RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value ] );
end;

procedure TRemesaModule.ImporteRemesa(    Ejercicio         : SmallInt;
                                          NroRemesa         : longInt;
                                      var Importe           : Decimal;
                                      var ImporteImpagados  : Decimal;
                                      var ImporteCancelados : Decimal );
begin
     Importe := 0.0;
     ImporteImpagados := 0.0;
     ImporteCancelados := 0.0;
     With DmEfectoCobrarTable do
       try
         SetRange( [ Ejercicio, NroRemesa ] );
         First;
         While not Eof do
           begin
           Importe := Importe + DmEfectoCobrarFields.Importe.Value;
           If   DmEfectoCobrarFields.Impagado.Value
           then ImporteImpagados := ImporteImpagados + DmEfectoCobrarFields.Importe.Value;
           If   DmEfectoCobrarFields.Cancelado.Value
           then ImporteCancelados := ImporteCancelados + DmEfectoCobrarFields.Importe.Value;
           Next;
           end;
       finally
         CancelRange;
         end;
end;

function TRemesaModule.UltimoVencimiento( Ejercicio : SmallInt;
                                           NroRemesa : longInt ) : TDate;
begin
     Result := LowestDateTime;
     With DmEfectoCobrarTable do
       try
         SetRange( [ Ejercicio, NroRemesa ] );
         First;
         While not Eof do
           begin
           If   DmEfectoCobrarFields.FechaVencimiento.Value>Result
           then Result := DmEfectoCobrarFields.FechaVencimiento.Value;
           Next;
           end;
       finally
         CancelRange;
         end;
end;

function TRemesaModule.ObtenAsientoRemesa( RemesaFields    : TRemesaFields;
                                           TipoAsiento     : SmallInt;
                                           NroOrdenAsiento : SmallInt = 1;
                                           AsientoFields   : TAsientoFields = nil ) : Boolean;
begin
     Result := False;

     If   Assigned( AsientoFields )
     then AsientoFields.Table.IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'  // Por si acaso
     else AsientoFields := DmAsientoFields;

     If   AsientoFields.Table.FindKey( [ TipoAsiento, SessionDataModule.Ejercicio, '', RemesaFields.NroRemesa.Value, NroOrdenAsiento ] )
     then If   SessionDataModule.EjercicioFecha( AsientoFields.FechaDocumento.Value )=RemesaFields.Ejercicio.Value
          then Result := True
          else begin
               AsientoFields.Table.Next;
               Result := ( AsientoFields.TipoAsiento.Value=TipoAsiento ) and
                         ( AsientoFields.Ejercicio.Value=SessionDataModule.Ejercicio ) and
                         ( AsientoFields.NroFactura.Value=RemesaFields.NroRemesa.Value) and
                         ( SessionDataModule.EjercicioFecha( AsientoFields.FechaDocumento.Value )=RemesaFields.Ejercicio.Value );
               end;

end;

function TRemesaModule.ObtenConcepto( Ejercicio       : SmallInt;
                                      NroRemesa       : LongInt;
                                      TipoAsiento     : SmallInt ) : String;

var Encontrado : Boolean;

begin
     Result := '';
     If   DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] )
     then If   ObtenAsientoRemesa( DmRemesaFields, TipoAsiento )
          then begin
               case  TipoAsiento of
                 taAceptacion   : Encontrado := DmApunteTable.FindEqualLast( [ DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value ] );
                 taCobroRemesa,
                 taDescuento    : Encontrado := DmApunteTable.FindEqualFirst( [ DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value ] );
               end;
               If   Encontrado
               then Result := DmApunteFields.Concepto.Value;
               end;
end;

procedure TRemesaModule.ActualizaAceptacion( Remesa   : IRemesa;
                                             Concepto : String );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( Remesa.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Remesa.Ejercicio, Remesa.NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               Remesa.ToDataset( DmRemesaFields );
               ActualizaAceptacion( DmRemesaFields, Concepto );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.ActualizaAceptacion( RemesaFields : TRemesaFields;
                                             Concepto     : String );

var  NroApunte : SmallInt;
     UltimaFechaVencimiento : TDateTime;

begin
     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, RemesaFields.Table ] );

       try

         If   not ValueIsEmpty( RemesaFields.FechaAceptacion.Value )
         then begin

              UltimaFechaVencimiento := 0;  // Un valor mínimo

              try

                If   ObtenAsientoRemesa( RemesaFields, taAceptacion )
                then begin
                     Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields, True );
                     DmAsientoTable.Edit;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaAceptacion.Value;
                     end
                else begin
                     DmAsientoTable.Append;
                     DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     DmAsientoFields.NroAsiento.Value := Dm10.AsientoModule.ProximoNroAsiento;
                     DmAsientoFields.TipoAsiento.Value := taAceptacion;
                     DmAsientoFields.Serie.Value := '';
                     DmAsientoFields.NroFactura.Value := RemesaFields.NroRemesa.Value;
                     DmAsientoFields.NroEfecto.Value := 1;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaAceptacion.Value;
                     DmAsientoFields.FechaDocumento.Value := RemesaFields.Fecha.Value;
                     DmAsientoFields.NroRegistro.Value := Dm10.AsientoModule.ProximoNroRegistro( taAceptacion );
                     end;

                DmAsientoTable.Post;

              except
                DmAsientoTable.Cancel;
                raise;
                end;

              Dm10.BancoModule.Obten( RemesaFields.SubcuentaEntidad.Value, DsBancoFields );

              With DmApunteTable do
                begin
                Cancel;
                Append;
                end;

              NroApunte := 1;

              With DmEfectoCobrarTable do
                try

                  With RemesaFields do
                    SetRange( [ Ejercicio.Value, NroRemesa.Value ] );

                  First;
                  While not Eof  do
                    begin

                    If   DmEfectoCobrarFields.FechaVencimiento.Value>UltimaFechaVencimiento
                    then UltimaFechaVencimiento := DmEfectoCobrarFields.FechaVencimiento.Value;

                    DmApunteTable.Append;

                    DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                    DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                    DmApunteFields.NroApunte.Value := NroApunte ;
                    DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                    DmApunteFields.Subcuenta.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srAceptados, True );
                    DmApunteFields.Contrapartida.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srEnCartera );
                    DmApunteFields.Concepto.Value := Dm10.EfectoCobrarModule.TextoConcepto( DmEfectoCobrarFields, True );  // Con fecha de vencimiento
                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoCobrarFields.Importe.Value );

                    Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                    DmApunteTable.Post;

                    Inc( NroApunte );

                    With Dm10.CuentaModule do
                      InsertaSubcuenta( DmApunteFields.Subcuenta.Value, Descripcion( DmApunteFields.Contrapartida.Value, True, False ) );

                    Next;
                    end;

                  First;
                  While not eof  do
                    begin

                    DmApunteTable.Append;

                    DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                    DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                    DmApunteFields.NroApunte.Value := NroApunte ;
                    DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                    DmApunteFields.Subcuenta.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srEnCartera );
                    DmApunteFields.Contrapartida.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srAceptados, True );
                    DmApunteFields.Concepto.Value := Concepto;

                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoCobrarFields.Importe.Value, True );

                    Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                    DmApunteTable.Post;

                    Inc( NroApunte );

                    Next;
                    end;

                finally
                  CancelRange;
                  end;

              RemesaFields.Estado.Value := erAceptada;
              RemesaFields.NroAsientoAceptacion.Value := DmAsientoFields.NroAsiento.Value;
              end;

         RemesaFields.Table.Post;

         TransactionTag.Commit;

         // Añado un evento utilizando el calendario laboral para determinar la hora de inicio

         If   not Dm00.DmUsuarioFields.DesactivarNotificaciones.Value
         then Dm00.SchedulerModule.CreaEvento( ObtenIDEvento( RemesaFields ),
                                               UltimaFechaVencimiento,
                                               Format( RsMsg13, [ RemesaFields.NroRemesa.Value ] ),
                                               RsMsg14 );

       except
         DmAsientoTable.Cancel;
         DmApunteTable.Cancel;
         RemesaFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;

       end;

end;

procedure TRemesaModule.ActualizaAnotacionCobro( Remesa   : IRemesa;
                                                 Concepto : String );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( Remesa.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Remesa.Ejercicio, Remesa.NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               Remesa.ToDataset( DmRemesaFields );
               ActualizaAnotacionCobro( DmRemesaFields, Concepto );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.ActualizaAnotacionCobro( RemesaFields : TRemesaFields;
                                                 Concepto     : String );
var  NroApunte : SmallInt;
     TipoEfectos : TTipoEfectos;
     ImporteTotalFactura,
     CuotasIVAFactura,
     CuotaIVAProprocional : Decimal;
     ExisteFichaCliente : Boolean;
     TextoConcepto,
     CentroCoste : String;
     Importe : Decimal;

begin
     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, RemesaFields.Table ] );

       try

         If   not ValueIsEmpty( RemesaFields.Fecha.Value )
         then begin

              try
                If   ObtenAsientoRemesa( RemesaFields, taCobroRemesa )
                then begin
                     Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields, True );

                     DmAsientoTable.Edit;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaCobro.Value;
                     end
                else begin
                     DmAsientoTable.Append;
                     DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     DmAsientoFields.NroAsiento.Value := Dm10.AsientoModule.ProximoNroAsiento;
                     DmAsientoFields.TipoAsiento.Value := taCobroRemesa;
                     DmAsientoFields.Serie.Value := '';
                     DmAsientoFields.NroFactura.Value := RemesaFields.NroRemesa.Value;
                     DmAsientoFields.NroEfecto.Value := 1;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaCobro.Value;
                     DmAsientoFields.FechaDocumento.Value := RemesaFields.Fecha.Value;
                     DmAsientoFields.NroRegistro.Value := Dm10.AsientoModule.ProximoNroRegistro( taCobroRemesa );
                     end;

                DmAsientoTable.Post;

              except
                DmAsientoTable.Cancel;
                raise;
                end;

              Dm10.BancoModule.Obten( RemesaFields.SubcuentaEntidad.Value, DsBancoFields );

              NroApunte := 2;
              Importe := 0.0;

              With DmEfectoCobrarTable do
                try

                  With RemesaFields do
                    SetRange( [ Ejercicio.Value, NroRemesa.Value ], [ Ejercicio.Value, NroRemesa.Value ] );

                  First;
                  While not Eof  do
                    begin

                    DmApunteTable.Append;

                    DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                    DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                    DmApunteFields.NroApunte.Value := NroApunte;
                    DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

                    If   RemesaFields.NroAsientoAceptacion.Value<>0
                    then TipoEfectos := srAceptados
                    else TipoEfectos := srEnCartera;

                    TextoConcepto := Dm10.EfectoCobrarModule.TextoConcepto( DmEfectoCobrarFields, True );

                    DmApunteFields.Subcuenta.Value := Dm10.EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, TipoEfectos );
                    DmApunteFields.Contrapartida.Value := DsBancoFields.Subcuenta.Value;
                    DmApunteFields.Concepto.Value := Dm10.EfectoCobrarModule.TextoConcepto( DmEfectoCobrarFields, True );

                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoCobrarFields.Importe.Value, True );

                    Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                    DecAdd( Importe, DmEfectoCobrarFields.Importe.Value );

                    DmApunteTable.Post;

                    Inc( NroApunte );

                    If   EmpresaFields.RegimenEspecialCriterioCaja.Value
                    then If   Dm10.AsientoModule.ObtenDocumento( taFraEmitida,
                                                                 EjercicioFecha( DmEfectoCobrarFields.FechaLibramiento.Value ),
                                                                 DmEfectoCobrarFields.SubcuentaCliente.Value,
                                                                 DmEfectoCobrarFields.Serie.Value,
                                                                 DmEfectoCobrarFields.NroFactura.Value,
                                                                 NroEfectoRegistroFactura,
                                                                 DsAsientoFacturaFields )
                         then Dm10.AsientoModule.CreaApuntesIVADevengado( DmAsientoFields,
                                                                          DmApunteFields,
                                                                          DsAsientoFacturaFields,
                                                                          DmEfectoCobrarFields.NroEfecto.Value,
                                                                          DmEfectoCobrarFields.Importe.Value,
                                                                          DmApunteFields.Concepto.Value,
                                                                          NroApunte );

                    Next;
                    end;

                  DmApunteTable.Append;

                  DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                  DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                  DmApunteFields.NroApunte.Value := 1;
                  DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

                  DmApunteFields.Subcuenta.Value := DsBancoFields.Subcuenta.Value;
                  DmApunteFields.Concepto.Value := Concepto;

                  SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, Importe );

                  Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, false );

                  DmApunteTable.Post;

                finally
                  CancelRange;
                  end;

              With RemesaFields do
                begin
                Estado.Value := erCobrada;
                NroAsientoCobro.Value := DmAsientoFields.NroAsiento.Value;
                end;

              end;

         RemesaFields.Table.Post;

         TransactionTag.Commit;

       except on E : Exception do
         begin
         DmAsientoTable.Cancel;
         DmApunteTable.Cancel;
         RemesaFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;
       end;

       end;

end;

procedure TRemesaModule.ActualizaDescuento( Remesa   : IRemesa;
                                            Concepto : String  );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( Remesa.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Remesa.Ejercicio, Remesa.NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               Remesa.ToDataset( DmRemesaFields );
               ActualizaDescuento( DmRemesaFields, Concepto );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.ActualizaDescuento( RemesaFields : TRemesaFields;
                                            Concepto     : String  );

var  NroApunte : SmallInt;

     UltimaFechaVencimiento : TDate;
     TipoEfectosRemesa : TTipoEfectos;
     Importe,
     ImporteImpagados,
     ImporteCancelados,
     ImporteTotal : Decimal;

begin

     With SessionDataModule.Dm10, DmAsientoTable do
       begin

       If   not ValueIsEmpty( RemesaFields.FechaDescuento.Value )
       then begin

            var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, RemesaFields.Table ] );

            try

              With RemesaFields do
                begin
                BancoModule.Obten( SubcuentaEntidad.Value, DsBancoFields );
                ImporteRemesa( Ejercicio.Value, NroRemesa.Value, Importe, ImporteImpagados, ImporteCancelados );
                end;

              UltimaFechaVencimiento := 0;  // Un valor mínimo
              try

                If   ObtenAsientoRemesa( RemesaFields, taDescuento )
                then begin
                     AsientoModule.SuprimeAsiento( DmAsientoFields, True );
                     Edit;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaDescuento.Value;
                     end
                else begin
                     Append;
                     DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     DmAsientoFields.NroAsiento.Value := AsientoModule.ProximoNroAsiento;
                     DmAsientoFields.TipoAsiento.Value := taDescuento;
                     DmAsientoFields.Serie.Value := '';
                     DmAsientoFields.NroFactura.Value := RemesaFields.NroRemesa.Value;
                     DmAsientoFields.NroEfecto.Value := 1;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaDescuento.Value;
                     DmAsientoFields.FechaDocumento.Value := RemesaFields.Fecha.Value;
                     DmAsientoFields.NroRegistro.Value := AsientoModule.ProximoNroRegistro( taDescuento );
                     end;

                Post;

            except
              Cancel;
              raise;
              end;

              RemesaFields.NroAstoDescuento1.Value := DmAsientoFields.NroAsiento.Value;

              With DmApunteTable do
                begin
                Cancel;
                Append;
                end;

              NroApunte := 1;

              ImporteTotal := Importe - RemesaFields.ImporteGastos.Value;

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.NroApunte.Value := NroApunte ;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
              DmApunteFields.Subcuenta.Value := DsBancoFields.Subcuenta.Value;
              DmApunteFields.Contrapartida.Value := DsBancoFields.Subcuenta_Riesgo.Value;
              DmApunteFields.Concepto.Value := Concepto;

              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteTotal );

              SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

              DmApunteTable.Post;

              Inc( NroApunte  );

              If   RemesaFields.ImporteGastos.Value<>0.0
              then begin

                   DmApunteTable.Append;

                   DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                   DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                   DmApunteFields.NroApunte.Value := NroApunte ;
                   DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

                   DmApunteFields.Subcuenta.Value := DsBancoFields.Subcuenta_Intereses.Value;
                   DmApunteFields.Contrapartida.Value := DsBancoFields.Subcuenta_Riesgo.Value;
                   DmApunteFields.Concepto.Value := Concepto;

                   SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, RemesaFields.ImporteGastos.Value );

                   SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                   DmApunteTable.Post;

                   Inc( NroApunte  );

                   end;

              DmApunteTable.Append;

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.NroApunte.Value := NroApunte ;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

              DmApunteFields.Subcuenta.Value := DsBancoFields.Subcuenta_Riesgo.Value;
              DmApunteFields.Contrapartida.Value := DsBancoFields.Subcuenta.Value;
              DmApunteFields.Concepto.Value := Concepto;

              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, Importe, True );

              SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

              DmApunteTable.Post;

              // Se podría consultar RemesaFields.NroAsientoAceptacion.Value, pero ese sistema es más seguro

              try

                If   ObtenAsientoRemesa( RemesaFields, taDescuento, 2 )
                then begin
                     AsientoModule.SuprimeAsiento( DmAsientoFields, True );
                     Edit;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaDescuento.Value;
                     end
                else begin
                     Append;
                     DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     DmAsientoFields.NroAsiento.Value  := AsientoModule.ProximoNroAsiento;
                     DmAsientoFields.TipoAsiento.Value := taDescuento;
                     DmAsientoFields.Serie.Value := '';
                     DmAsientoFields.NroFactura.Value := RemesaFields.NroRemesa.Value;
                     DmAsientoFields.NroEfecto.Value := 2;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaDescuento.Value;
                     DmAsientoFields.FechaDocumento.Value := RemesaFields.Fecha.Value;
                     DmAsientoFields.NroRegistro.Value := AsientoModule.ProximoNroRegistro( taDescuento );
                     end;

                Post;

              except
                Cancel;
                raise;
                end;

              RemesaFields.NroAstoDescuento2.Value := DmAsientoFields.NroAsiento.Value;

              If   RemesaFields.NroAsientoAceptacion.Value<>0
              then TipoEfectosRemesa := srAceptados
              else TipoEfectosRemesa := srEnCartera;

              NroApunte  := 1;

              With DmEfectoCobrarTable do
                try

                  With RemesaFields do
                    SetRange( [ Ejercicio.Value, NroRemesa.Value ] );

                  First;
                  While not Eof  do
                    begin

                    If   DmEfectoCobrarFields.FechaVencimiento.Value>UltimaFechaVencimiento
                    then UltimaFechaVencimiento := DmEfectoCobrarFields.FechaVencimiento.Value;

                    DmApunteTable.Append;

                    DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                    DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                    DmApunteFields.NroApunte.Value := NroApunte ;
                    DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                    DmApunteFields.Subcuenta.Value := EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srDescontados, True );
                    DmApunteFields.Contrapartida.Value := EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, TipoEfectosRemesa, True, False );
                    DmApunteFields.Concepto.Value := Concepto + ' ' + EfectoCobrarModule.TextoConcepto( DmEfectoCobrarFields, True );  // Con fecha de vencimiento
                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoCobrarFields.Importe.Value );

                    SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                    DmApunteTable.Post;

                    Inc( NroApunte );

                    With CuentaModule do
                      InsertaSubcuenta( DmApunteFields.Subcuenta.Value, Descripcion( DmApunteFields.Contrapartida.Value, True, False ) );

                    Next;
                    end;

                  First;
                  While not eof  do
                    begin

                    DmApunteTable.Append;

                    DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                    DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                    DmApunteFields.NroApunte.Value := NroApunte ;
                    DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                    DmApunteFields.Subcuenta.Value := EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, TipoEfectosRemesa, True, False );
                    DmApunteFields.Contrapartida.Value := EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srDescontados, True );
                    DmApunteFields.Concepto.Value := Concepto + ' ' + EfectoCobrarModule.TextoConcepto( DmEfectoCobrarFields, True );

                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoCobrarFields.Importe.Value, True );

                    SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                    DmApunteTable.Post;

                    Inc( NroApunte );

                    Next;
                    end;

                finally
                  CancelRange;
                  end;

            RemesaFields.Estado.Value := erDescontada;

            RemesaFields.Table.Post;

            TransactionTag.Commit;

            If   ( UltimaFechaVencimiento<>0 ) and
                 not SessionDataModule.Dm00.DmUsuarioFields.DesactivarNotificaciones.Value
            then SessionDataModule.Dm00.SchedulerModule.CreaEvento( ObtenIDEvento( RemesaFields ),
                                                                    UltimaFechaVencimiento,
                                                                    Format( RsMsg11, [ RemesaFields.NroRemesa.Value ] ),
                                                                    RsMsg12 );

          except
            DmAsientoTable.Cancel;
            DmApunteTable.Cancel;
            RemesaFields.Table.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end;
     end;

end;

procedure TRemesaModule.ActualizaCancelacion( Remesa : IRemesa );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( Remesa.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ Remesa.Ejercicio, Remesa.NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               Remesa.ToDataset( DmRemesaFields );
               ActualizaCancelacion( DmRemesaFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaModule.ActualizaCancelacion( RemesaFields : TRemesaFields );

var  NroApunte : SmallInt;

     Importe,
     ImporteImpagados,
     ImporteCancelados,
     ImporteTotal : Decimal;

begin

     RemesaFields.NroAstoCancelacion.Value := 0;

     With SessionDataModule.Dm10, DmAsientoTable do
       begin

       With RemesaFields do
         begin
         BancoModule.Obten( SubcuentaEntidad.Value, DsBancoFields );
         ImporteRemesa( Ejercicio.Value, NroRemesa.Value, Importe, ImporteImpagados, ImporteCancelados );
         end;

       ImporteTotal := Importe - ImporteImpagados - ImporteCancelados;

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, RemesaFields.Table ] );

       try

         If   ImporteTotal<>0.0
         then begin

              try

                If   ObtenAsientoRemesa( RemesaFields, taCancelacion )
                then begin
                     AsientoModule.SuprimeAsiento( DmAsientoFields, True );
                     Edit;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaCancelacion.Value;
                     end
                else begin
                     Append;
                     DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                     DmAsientoFields.NroAsiento.Value := AsientoModule.ProximoNroAsiento;
                     DmAsientoFields.TipoAsiento.Value := taCancelacion;
                     DmAsientoFields.Serie.Value := '';
                     DmAsientoFields.NroFactura.Value := RemesaFields.NroRemesa.Value;
                     DmAsientoFields.NroEfecto.Value := 1;
                     DmAsientoFields.Fecha.Value := RemesaFields.FechaCancelacion.Value;
                     DmAsientoFields.FechaDocumento.Value := RemesaFields.Fecha.Value;
                     DmAsientoFields.NroRegistro.Value := AsientoModule.ProximoNroRegistro( taCancelacion );
                     end;

                Post;

              except
                Cancel;
                raise;
                end;

              RemesaFields.NroAstoCancelacion.Value := DmAsientoFields.NroAsiento.Value;

              With DmApunteTable do
                begin
                Cancel;
                Append;
                end;

              NroApunte := 1;

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.NroApunte.Value := NroApunte ;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
              DmApunteFields.Subcuenta.Value := DsBancoFields.Subcuenta_Riesgo.Value;
              DmApunteFields.Concepto.Value := Format( RsMsg7, [ RemesaFields.NroRemesa.Value ] );
              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteTotal, False );

              SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

              DmApunteTable.Post;

              Inc( NroApunte  );

              With DmEfectoCobrarTable do
                try

                  With RemesaFields do
                    SetRange( [ Ejercicio.Value, NroRemesa.Value ], [ Ejercicio.Value, NroRemesa.Value ] );

                  First;
                  While not Eof  do
                   begin

                   If   not DmEfectoCobrarFields.Cancelado.Value and
                        not DmEfectoCobrarFields.Impagado.Value
                   then begin

                        DmApunteTable.Append;

                        DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                        DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                        DmApunteFields.NroApunte.Value := NroApunte;
                        DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                        DmApunteFields.Subcuenta.Value := EfectoCobrarModule.ObtenSubcuentaRiesgo( DmEfectoCobrarFields.SubcuentaCliente.Value, srDescontados, True, False );
                        DmApunteFields.Contrapartida.Value := DsBancoFields.Subcuenta_Riesgo.Value;
                        DmApunteFields.Concepto.Value := Format( RsMsg7, [ RemesaFields.NroRemesa.Value ] );

                        SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoCobrarFields.Importe.Value, True );

                        SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                        DmApunteTable.Post;

                        Inc( NroApunte );

                        If   SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value or AsientoModule.EjercicioTransicionCriterioCaja
                        then If   ClienteModule.Obten( DmEfectoCobrarFields.CodigoCliente.Value, DmEfectoCobrarFields.SubcuentaCliente.Value, DsClienteFields ) and ( DsClienteFields.Factura_ModeloIVA.Value=micSinRE )
                             then If   AsientoModule.ObtenDocumento( taFraEmitida,
                                                                     SessionDataModule.EjercicioFecha( DmEfectoCobrarFields.FechaLibramiento.Value ),
                                                                     DmEfectoCobrarFields.SubcuentaCliente.Value,
                                                                     DmEfectoCobrarFields.Serie.Value,
                                                                     DmEfectoCobrarFields.NroFactura.Value,
                                                                     NroEfectoRegistroFactura,
                                                                     DsAsientoFacturaFields )
                                  then If   not ( AsientoModule.EjercicioTransicionCriterioCaja and ( YearOf( DsAsientoFacturaFields.Fecha.Value )=SessionDataModule.Ejercicio ) ) and
                                            ( ( SessionDataModule.Ejercicio - YearOf( DsAsientoFacturaFields.Fecha.Value ) )<=2 )  // Los efectos de facturas de más de 2 ejercicios ya deben haber sido liquidadas y, por lo tanto, ya no se debe contabilizar el traspaso del I.V.A.
                                       then AsientoModule.CreaApuntesIVADevengado( DmAsientoFields,
                                                                                   DmApunteFields,
                                                                                   DsAsientoFacturaFields,
                                                                                   DmEfectoCobrarFields.NroEfecto.Value,
                                                                                   DmEfectoCobrarFields.Importe.Value,
                                                                                   DmApunteFields.Concepto.Value,
                                                                                   NroApunte );

                        end;

                   Next;
                   end;

                finally
                  DmApunteTable.Cancel;
                  CancelRange;
                  end;

              end;

         // Aunque no se haya generado un asiento porque el ImporteTotal es 0, igual hay que marcar la remesa como cancelada

         RemesaFields.Estado.Value := erCancelada;
         RemesaFields.Table.Post;

         TransactionTag.Commit;

       except
         DmAsientoTable.Cancel;
         RemesaFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
       end;

     end;

end;

procedure TRemesaModule.CancelacionAutomatica( Fecha           : TDate;
                                               MesesAntiguedad : SmallInt );

var  FechaInicial,
     FechaCancelacion : TDate;
     CancelarRemesa : Boolean;
     DiasCancelacion : SmallInt;

begin

     With SessionDataModule.Dm10 do
       try

         FechaInicial := IncMonth( Fecha, -MesesAntiguedad );

         With DmRemesaTable do
           try

             IndexFieldNames := 'Fecha';

             SetRange( [ FechaInicial ], [ Fecha ] );
             Last;
             While not Bof do
               begin

               If   DmRemesaFields.Estado.Value=erDescontada
               then begin

                    SessionDataModule.SendNotification( ntRecord, Format( RsMsg27, [ DmRemesaFields.NroRemesa.Value ] ) );

                    With DmEfectoCobrarTable do
                      begin

                      If   BancoModule.Obten( DmRemesaFields.SubcuentaEntidad.Value, DsBancoFields )
                      then begin

                           With DmRemesaFields do
                             SetRange( [ Ejercicio.Value, NroRemesa.Value ], [ Ejercicio.Value, NroRemesa.Value ] );

                           CancelarRemesa := True;

                           First;
                           While not Eof do
                             begin
                             Case DmRemesaFields.TipoOrden.Value of
                               19 : DiasCancelacion := DsBancoFields.DiasCancelacion19.Value;
                               32 : DiasCancelacion := DsBancoFields.DiasCancelacion32.Value;
                               58 : DiasCancelacion := DsBancoFields.DiasCancelacion58.Value;
                               else DiasCancelacion := DsBancoFields.DiasCancelacion.Value;
                               end;
                             FechaCancelacion := IncDay( DmEfectoCobrarFields.FechaVencimiento.Value, DiasCancelacion );
                             If   FechaCancelacion>=Fecha
                             then begin
                                  CancelarRemesa := False;
                                  Break;
                                  end;

                             Next;
                             end;

                           If   CancelarRemesa
                           then begin
                                DmRemesaTable.Edit;
                                DmRemesaFields.FechaCancelacion.Value := Fecha;
                                ActualizaCancelacion( DmRemesaFields );
                                If   DmRemesaFields.NroAstoCancelacion.Value<>0  // Si solo hay impagados no se genera el asiento de cancelación, pero se marca como cancelada
                                then SessionDataModule.SendNotification( ntInformation, Format( RsMsg21, [ DmRemesaFields.Ejercicio.Value, DmRemesaFields.NroRemesa.Value, DmRemesaFields.NroAstoCancelacion.Value ] ) );
                                end;

                           end
                      else SessionDataModule.SendNotification( ntWarning, Format( RsMsg22, [ DmRemesaFields.SubcuentaEntidad.Value, DmRemesaFields.Ejercicio.Value, DmRemesaFields.NroRemesa.Value ] ) );

                      end;
                    end;

               Prior;
               end;

           finally
             CancelRange;
             IndexFieldNames := 'Ejercicio;NroRemesa';
             end;

         except
           DmRemesaTable.Cancel;
           end;
end;

procedure TRemesaModule.ActualizaRemesa( Remesa : IRemesa );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( Remesa.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmRemesaTable ] );

     try

            If   Remesa.State=dsEdit
            then begin
                 If   DmRemesaTable.FindKey( [ Remesa.Ejercicio, Remesa.NroRemesa ] )
                 then begin
                      If   Remesa.SubcuentaEntidad<>DmRemesaFields.SubcuentaEntidad.Value
                      then With Remesa do
                             SustituyeSubcuentaEntidadEfectos( Ejercicio, NroRemesa, SubcuentaEntidad );
                      end
                 else RaiseRecordNotFoundException;

                 TableCursor.RecordLockRelease( False );
                 end;

       Remesa.ToDataset( DmRemesaFields );

       DmRemesaTable.Post;

       TransactionTag.Commit;

     except on E : Exception do
       begin
       DmRemesaTable.Cancel;
       TransactionTag.Rollback;
       raise;
       end;
     end;

          end
     else RaiseNoCurrentRecordException;

end;

procedure TRemesaModule.SuprimeRemesa( RemoteCursorID : TnxCursorID;
                                       NroRemesa      : Integer );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaTable.FindKey( [ SessionDataModule.Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeRemesa( DmRemesaFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

{ TRemesaService }

procedure TRemesaService.ActualizaAceptacion( Remesa   : IRemesa;
                                              Concepto : String );
begin
     SessionDataModule.Dm10.RemesaModule.ActualizaAceptacion( Remesa, Concepto );
end;

procedure TRemesaService.ActualizaAnotacionCobro( Remesa   : IRemesa;
                                                  Concepto : String);
begin
     SessionDataModule.Dm10.RemesaModule.ActualizaAnotacionCobro( Remesa, Concepto );
end;

procedure TRemesaService.ActualizaCancelacion( Remesa : IRemesa);
begin
     SessionDataModule.Dm10.RemesaModule.ActualizaCancelacion( Remesa );
end;

procedure TRemesaService.ActualizaDescuento( Remesa   : IRemesa;
                                             Concepto : String );
begin
     SessionDataModule.Dm10.RemesaModule.ActualizaDescuento( Remesa, Concepto );
end;

procedure TRemesaService.ActualizaRemesa( Remesa : IRemesa );
begin
     SessionDataModule.Dm10.RemesaModule.ActualizaRemesa( Remesa );
end;

procedure TRemesaService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TRemesaService.CancelacionAutomatica( Fecha : TDate; MesesAntiguedad : SmallInt );
begin
     SessionDataModule.Dm10.RemesaModule.CancelacionAutomatica( Fecha, MesesAntiguedad );
end;

procedure TRemesaService.ImporteRemesa(    Ejercicio         : SmallInt;
                                           NroRemesa         : longInt;
                                       var Importe           : Decimal;
                                       var ImporteImpagados  : Decimal;
                                       var ImporteCancelados : Decimal );
begin
     SessionDataModule.Dm10.RemesaModule.ImporteRemesa( Ejercicio, NroRemesa, Importe, ImporteImpagados, ImporteCancelados );
end;

function TRemesaService.ObtenConcepto( Ejercicio: SmallInt; NroRemesa: Integer; TipoAsiento: SmallInt ): String;
begin
     Result := SessionDataModule.Dm10.RemesaModule.ObtenConcepto( Ejercicio, NroRemesa, TipoAsiento );
end;

procedure TRemesaService.SuprimeAceptacion( RemoteCursorID : TnxCursorID;
                                            Ejercicio      : SmallInt;
                                            NroRemesa      : Integer );
begin
     SessionDataModule.Dm10.RemesaModule.SuprimeAceptacion( RemoteCursorID, Ejercicio, NroRemesa );
end;

procedure TRemesaService.SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID;
                                                Ejercicio      : SmallInt;
                                                NroRemesa      : Integer );
begin
     SessionDataModule.Dm10.RemesaModule.SuprimeAnotacionCobro( RemoteCursorID, Ejercicio, NroRemesa );
end;

procedure TRemesaService.SuprimeCancelacion( RemoteCursorID : TnxCursorID;
                                             Ejercicio      : SmallInt;
                                             NroRemesa      : Integer);
begin
     SessionDataModule.Dm10.RemesaModule.SuprimeCancelacion( RemoteCursorID, Ejercicio, NroRemesa );
end;

procedure TRemesaService.SuprimeDescuento( RemoteCursorID : TnxCursorID;
                                           Ejercicio      : SmallInt;
                                           NroRemesa      : Integer);
begin
     SessionDataModule.Dm10.RemesaModule.SuprimeDescuento( RemoteCursorID, Ejercicio, NroRemesa );
end;

procedure TRemesaService.SuprimeRemesa( RemoteCursorID : TnxCursorID;
                                        NroRemesa      : Integer);
begin
     SessionDataModule.Dm10.RemesaModule.SuprimeRemesa( RemoteCursorID, NroRemesa );
end;

function TRemesaService.UltimoVencimiento(Ejercicio: SmallInt;NroRemesa: Integer): TDate;
begin
     Result := SessionDataModule.Dm10.RemesaModule.UltimoVencimiento( Ejercicio, NroRemesa );
end;

var RemesaControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_RemesaService, TRemesaService, RemesaControl );

end.

