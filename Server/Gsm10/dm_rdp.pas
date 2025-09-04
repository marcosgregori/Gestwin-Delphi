
unit dm_rdp;

interface

uses   Windows, Messages, SysUtils, Classes,

       DB,
       nxdb,
       nxsdTypes,

       LibUtils,
       DataManager,
       ServerDataModule,
       SessionIntf,

       Gim10Fields,

       RemesaPagoIntf,

       dmi_rdp;

type

  TRemesaPagoService = class( TSessionModule, IRemesaPagoService )
    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaRemesa( RemesaPago : IRemesaPago );
    procedure SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : LongInt );

    procedure ActualizaAnotacionPago( RemesaPago: IRemesaPago; Concepto : String );
    procedure SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt );

    function  ObtenConceptoAsientoPago( Ejercicio : SmallInt; NroRemesa : LongInt; FechaPago : TDate ) : String;
    function  ImporteRemesa( Ejercicio : SmallInt; NroRemesa : LongInt ) : Decimal;
    end;

  TRemesaPagoModule = class(TServerDataModule )
    DmRemesaPagoTable: TnxeTable;
    DmEfectoPagarTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    procedure RemesaPagoModuleCreate(Sender: TObject);
    procedure RemesaPagoModuleDestroy(Sender: TObject);
  private

    DmRemesaPagoFields : TRemesaPagoFields;
    DmEfectoPagarFields : TEfectoPagarFields;
    DmAsientoFields,
    DsAsientoFacturaFields : TAsientoFields;
    DmApunteFields : TApunteFields;
    DsBancoFields : TBancoFields;
    DsProveedorFields : TProveedorFields;

    procedure SustituyeSubcuentaEntidadEfectos( EjercicioRemesa : SmallInt; NroRemesa : LongInt; SubcuentaEntidad : String = '' );
    procedure SacaEfectosRemesa( EjercicioRemesa : SmallInt; NroRemesa : LongInt );

  public

    procedure ActualizaRemesa( RemesaPago : IRemesaPago );
    procedure SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : LongInt ); overload;

    procedure SuprimeRemesa( RemesaPagoFields : TRemesaPagoFields ); overload;

    procedure ActualizaAnotacionPago( RemesaPago: IRemesaPago; Concepto : String ); overload;
    procedure ActualizaAnotacionPago( RemesaPagoFields : TRemesaPagoFields; Concepto : String ); overload;
    procedure SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : LongInt ); overload;
    procedure SuprimeAnotacionPago( RemesaPagoFields : TRemesaPagoFields ); overload;

    function  Obten( Ejercicio : SmallInt; NroRemesa : LongInt; RemesaPagoFields : TRemesaPagoFields ) : Boolean;
    function  TextoEstado( RemesaPagoFields : TRemesaPagoFields ) : string;
    function  ImporteRemesa( Ejercicio : SmallInt; NroRemesa : LongInt ) : Decimal;
    function  ObtenAsientoPago( Ejercicio : SmallInt; NroRemesa : LongInt; FechaPago : TDate ) : Boolean;
    function  ObtenConceptoAsientoPago( Ejercicio : SmallInt; NroRemesa : LongInt; FechaPago : TDate ) : String;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses nxrbTypes,
     nxrdClass,
     nxsrServerEngine,
     nxllBDE,

     AppManager,
     EnterpriseData,
     DateUtils,
     SessionData,

     Gim00Fields,

     dmi_ast,

     dm_ast;

{$R *.DFM}

resourceString
       RsMsg1 = 'La remesa de pago nº %d no existe.';

procedure TRemesaPagoModule.RemesaPagoModuleCreate(Sender: TObject);
begin
     DmRemesaPagoFields := TRemesaPagoFields.Create( DmRemesaPagoTable );
     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );

     DsAsientoFacturaFields := TAsientoFields.Create( Self );
     DsBancoFields := TBancoFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );
end;

procedure TRemesaPagoModule.RemesaPagoModuleDestroy(Sender: TObject);
begin
    SessionDataModule.Dm10.RemesaPagoModule := nil;
end;

procedure TRemesaPagoModule.SuprimeAnotacionPago( RemoteCursorID : TnxCursorID;
                                                  Ejercicio      : SmallInt;
                                                  NroRemesa      : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaPagoTable.FindKey( [ Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAnotacionPago( DmRemesaPagoFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaPagoModule.SuprimeAnotacionPago( RemesaPagoFields : TRemesaPagoFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaPagoFields.Table ] );

     try

       With RemesaPagoFields do
         If   not ValueIsEmpty( NroAsientoPago.Value )
         then If   ObtenAsientoPago( Ejercicio.Value, NroRemesa.Value, FechaPago.Value )
              then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields );

       try

         RemesaPagoFields.Table.Edit;

         RemesaPagoFields.Estado.Value := erpPendiente;
         RemesaPagoFields.FechaPago.Clear;
         RemesaPagoFields.NroAsientoPago.Clear;

         RemesaPagoFields.Table.Post;

       except
         RemesaPagoFields.Table.Cancel;
         raise;
         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;
end;

function  TRemesaPagoModule.Obten( Ejercicio        : SmallInt;
                                   NroRemesa        : LongInt;
                                   RemesaPagoFields : TRemesaPagoFields ) : Boolean;
begin
     Result := DmRemesaPagoTable.FindKey( [ Ejercicio, NroRemesa ] );
     RemesaPagoFields.Update( DmRemesaPagoTable );
end;

procedure TRemesaPagoModule.ActualizaRemesa( RemesaPago : IRemesaPago );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemesaPago.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmRemesaPagoTable ] );

          try

            If   RemesaPago.State=dsEdit
            then If   DmRemesaPagoTable.FindKey( [ RemesaPago.Ejercicio, RemesaPago.NroRemesa ] )
                 then begin
                      TableCursor.RecordLockRelease( False );
                      If   RemesaPago.SubcuentaEntidad<>DmRemesaPagoFields.SubcuentaEntidad.Value
                      then With RemesaPago do
                             SustituyeSubcuentaEntidadEfectos( NroRemesa, Ejercicio, SubcuentaEntidad );
                      end
            else RaiseRecordNotFoundException;

       RemesaPago.ToDataset( DmRemesaPagoFields );

       DmRemesaPagoTable.Post;

       TransactionTag.Commit;

     except on E : Exception do
       begin
       DmRemesaPagoTable.Cancel;
       TransactionTag.Rollback;
       raise;
       end;
     end;

          end
     else RaiseNoCurrentRecordException;

end;

procedure TRemesaPagoModule.SuprimeRemesa( RemoteCursorID : TnxCursorID;
                                           NroRemesa      : Integer );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaPagoTable.FindKey( [ SessionDataModule.Ejercicio, NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeRemesa( DmRemesaPagoFields )
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaPagoModule.SuprimeRemesa( RemesaPagoFields : TRemesaPagoFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ RemesaPagoFields.Table ] );

     try

       With DmEfectoPagarTable do
         begin
         SetRange( [ RemesaPagoFields.Ejercicio.Value, RemesaPagoFields.NroRemesa.Value ] );
         First;
         While not Eof do
           begin
           try
             Edit;
             DmEfectoPagarFields.EjercicioRemesa.Clear;
             DmEfectoPagarFields.NroRemesa.Clear;
             SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( DmEfectoPagarFields.SubcuentaProveedor.Value, DsProveedorFields );
             DmEfectoPagarFields.SubcuentaEntidad.Value := SessionDataModule.Dm10.EfectoPagarModule.ObtenCanalPreferente( DsProveedorFields );
             Post;
           except
             Cancel;
             raise;
             end;
           First;
           end;
         end;

       RemesaPagoFields.Table.Delete;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRemesaPagoModule.SustituyeSubcuentaEntidadEfectos(  EjercicioRemesa  : SmallInt;
                                                               NroRemesa        : LongInt;
                                                               SubcuentaEntidad : String = '' );
begin
     With DmEfectoPagarTable do
       begin
       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoPagarTable ] );
       try
         SetRange( [ EjercicioRemesa, NroRemesa ] );
         First;
         While not Eof do
           begin
           try
             Edit;

             If   SubcuentaEntidad=''
             then begin
                  // Se restituye el canal preferente del proveedor
                  SessionDataModule.Dm10.ProveedorModule.ObtenPorSubcuenta( DmEfectoPagarFields.SubcuentaProveedor.Value, DsProveedorFields );
                  DmEfectoPagarFields.SubcuentaEntidad.Value := SessionDataModule.Dm10.EfectoPagarModule.ObtenCanalPreferente( DsProveedorFields );
                  end
             else DmEfectoPagarFields.SubcuentaEntidad.Value := SubcuentaEntidad;

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

procedure TRemesaPagoModule.SacaEfectosRemesa( EjercicioRemesa : SmallInt;
                                               NroRemesa       : LongInt );
begin
     With DmEfectoPagarTable do
       begin
       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoPagarTable ] );
       try
         SetRange( [ EjercicioRemesa, NroRemesa ] );
         First;
         While not Eof do
           begin
           try
             Edit;
             DmEfectoPagarFields.EjercicioRemesa.Clear;
             DmEfectoPagarFields.NroRemesa.Clear;
             Post;
           except
             Cancel;
             raise;
             end;
           First;
           end;
         TransactionTag.Commit;
       except
         TransactionTag.Rollback;
         raise;
         end;
       end;
end;

procedure TRemesaPagoModule.ActualizaAnotacionPago( RemesaPago : IRemesaPago;
                                                    Concepto   : String );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemesaPago.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmRemesaPagoTable.FindKey( [ RemesaPago.Ejercicio, RemesaPago.NroRemesa ] )
          then begin
               TableCursor.RecordLockRelease( False );
               RemesaPago.ToDataset( DmRemesaPagoFields );
               ActualizaAnotacionPago( DmRemesaPagoFields, Concepto );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TRemesaPagoModule.ActualizaAnotacionPago( RemesaPagoFields : TRemesaPagoFields;
                                                    Concepto         : String );

var  NroApunte : SmallInt;
     ExisteFichaProveedor : Boolean;
     ImporteRemesa : Decimal;

begin
     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, RemesaPagoFields.Table ] );

       try

         If   not ValueIsEmpty( RemesaPagoFields.FechaPago.Value )
         then begin

              If   ObtenAsientoPago( RemesaPagoFields.Ejercicio.Value, RemesaPagoFields.NroRemesa.Value, RemesaPagoFields.FechaPago.Value )
              then begin
                   Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields, True );
                   DmAsientoTable.Edit;
                   DmAsientoFields.Fecha.Value := RemesaPagoFields.FechaPago.Value;
                   end
              else begin
                   DmAsientoTable.Append;
                   DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                   DmAsientoFields.NroAsiento.Value := Dm10.AsientoModule.ProximoNroAsiento;
                   DmAsientoFields.TipoAsiento.Value := taPagoRemesa;
                   DmAsientoFields.Serie.Value := '';
                   DmAsientoFields.NroFactura.Value := RemesaPagoFields.NroRemesa.Value;
                   DmAsientoFields.NroEfecto.Value := 1;
                   DmAsientoFields.Fecha.Value := RemesaPagoFields.FechaPago.Value;
                   DmAsientoFields.FechaDocumento.Value := RemesaPagoFields.Fecha.Value;
                   DmAsientoFields.NroRegistro.Value := Dm10.AsientoModule.ProximoNroRegistro( taPagoRemesa );
                   end;

              DmAsientoTable.Post;

              Dm10.BancoModule.Obten( RemesaPagoFields.SubcuentaEntidad.Value, DsBancoFields );

              ImporteRemesa := 0.0;

              // Primero los apuntes con el importe de cada efecto y, al final, el del importe total en el apunte nº 1

              NroApunte := 2;

              With DmEfectoPagarTable do
                try

                  With RemesaPagoFields do
                    SetRange( [ Ejercicio.Value, NroRemesa.Value ], [ Ejercicio.Value, NroRemesa.Value ] );

                  First;
                  While not Eof  do
                    begin

                    DmApunteTable.Append;

                    DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                    DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                    DmApunteFields.NroApunte.Value := NroApunte;
                    DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

                    DmApunteFields.Subcuenta.Value := DmEfectoPagarFields.SubcuentaProveedor.Value;
                    DmApunteFields.Contrapartida.Value := DsBancoFields.Subcuenta.Value;
                    DmApunteFields.Concepto.Value := Dm10.EfectoPagarModule.TextoConceptoPago( DmEfectoPagarFields, True );

                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmEfectoPagarFields.Importe.Value );

                    Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, false );

                    DmApunteTable.Post;

                    DecAdd( ImporteRemesa, DmEfectoPagarFields.Importe.Value );

                    Inc( NroApunte );

                    With DmEfectoPagarFields do
                      begin

                      ExisteFichaProveedor := Dm10.ProveedorModule.Obten( CodigoProveedor.Value, SubcuentaProveedor.Value, DsProveedorFields );

                      If   SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value or Dm10.AsientoModule.EjercicioTransicionCriterioCaja or
                           ( ExisteFichaProveedor and DsProveedorFields.Factura_RegimenEspecialCC.Value )
                      then If   Dm10.AsientoModule.ObtenDocumento( taFraRecibida,
                                                                   EjercicioFecha( FechaLibramiento.Value ),
                                                                   SubcuentaProveedor.Value,
                                                                   Serie.Value,
                                                                   NroFactura.Value,
                                                                   NroEfectoRegistroFactura,
                                                                   DsAsientoFacturaFields )
                           then If   not ( Dm10.AsientoModule.EjercicioTransicionCriterioCaja and ( YearOf( DsAsientoFacturaFields.Fecha.Value )=SessionDataModule.Ejercicio ) ) and
                                          ( ( SessionDataModule.Ejercicio - YearOf( DsAsientoFacturaFields.Fecha.Value ) )<=2 )  // Los efectos de facturas de más de 2 ejercicios ya deben haber sido liquidadas y, por lo tanto, ya no se debe contabilizar el traspaso del I.V.A.
                                then Dm10.AsientoModule.CreaApuntesIVADevengado( DmAsientoFields,
                                                                                 DmApunteFields,
                                                                                 DsAsientoFacturaFields,
                                                                                 NroEfecto.Value,
                                                                                 Importe.Value,
                                                                                 DmApunteFields.Concepto.Value,
                                                                                 NroApunte );

                      end;

                    Next;
                    end;

                finally
                  CancelRange;
                  end;

              DmApunteTable.Append;

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.NroApunte.Value := 1;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

              DmApunteFields.Subcuenta.Value := DsBancoFields.Subcuenta.Value;
              DmApunteFields.Concepto.Value := Concepto;

              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteRemesa, True );

              Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, false );

              DmApunteTable.Post;

              With RemesaPagoFields do
                begin
                Estado.Value := erpPagada;
                NroAsientoPago.Value := DmAsientoFields.NroAsiento.Value;
                end;

              end;

         RemesaPagoFields.Table.Post;

         TransactionTag.Commit;

       except on E : Exception do
         begin
         DmAsientoTable.Cancel;
         DmApunteTable.Cancel;
         RemesaPagoFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;
       end;

       end;


end;

function TRemesaPagoModule.ImporteRemesa( Ejercicio : SmallInt;
                                          NroRemesa : LongInt ) : Decimal;
begin
     Result := 0.0;
     With DmEfectoPagarTable do
       try
         SetRange( [ Ejercicio, NroRemesa ] );
         First;
         While not Eof do
           begin
           DecAdd( Result, DmEfectoPagarFields.Importe.Value );
           Next;
           end;
       finally
         CancelRange;
         end;
end;


function TRemesaPagoModule.TextoEstado( RemesaPagoFields : TRemesaPagoFields ) : string;

var  TextoTipoOrden : String;

begin
     Result := '';
     With RemesaPagoFields do
       case Estado.Value of
         erpPendiente : Result := 'Pendiente de pago';
         erpPagada    : begin
                        Result := 'Pagada el ' + StrFormatDate( RemesaPagoFields.FechaPago.Value );
                        If   TipoOrden.Value<>0
                        then begin
                             TextoTipoOrden := '';
                             case TipoOrden.Value of
                               34  : case CodigoOrden.Value of
                                        51 : TextoTipoOrden := '34 - Facturas para Confirming';
                                        56 : TextoTipoOrden := '34 - Orden de transferencia';
                                        57 : TextoTipoOrden := '34 - Facturas para emitir cheque y pagaré';
                                        59 : TextoTipoOrden := '34 - Facturas para emitir pago certificado';
                                        end;
                               68  : case CodigoOrden.Value of
                                        59 : TextoTipoOrden := '68 - Pagos domiciliados';
                                        end;
                               onnPagare :
                                      TextoTipoOrden := 'Pagarés';
                               onnPagosCertificadosBV :
                                      TextoTipoOrden := 'Pagos certificados/Confirming BV';
                               onnPagosFactoringBBV :
                                      TextoTipoOrden := 'Pagos/Factoring BBV-Netcash';
                               end;
                             If   TextoTipoOrden<>''
                             then Result := Result + ' ( ' + TextoTipoOrden + ' )';
                             end;
                        end;
         end;
end;

function TRemesaPagoModule.ObtenConceptoAsientoPago( Ejercicio : SmallInt;
                                                     NroRemesa : LongInt;
                                                     FechaPago : TDate ) : String;
begin
     Result := '';
     If   ObtenAsientoPago( Ejercicio, NroRemesa, FechaPago )
     then If   DmApunteTable.FindEqualFirst( [ DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value ] )
          then Result := DmApunteFields.Concepto.Value;
end;

function TRemesaPagoModule.ObtenAsientoPago( Ejercicio : SmallInt;
                                             NroRemesa : LongInt;
                                             FechaPago : TDate ) : Boolean;
begin
     Result := False;
     If   DmAsientoTable.FindKey( [ taPagoRemesa, SessionDataModule.EjercicioFecha( FechaPago ), '', NroRemesa, 1 ] )
     then If   SessionDataModule.EjercicioFecha( DmAsientoFields.FechaDocumento.Value )=Ejercicio
          then Result := True
          else begin
               DmAsientoTable.Next;
               Result := ( DmAsientoFields.TipoAsiento.Value=taPagoRemesa ) and
                         ( DmAsientoFields.Ejercicio.Value=Ejercicio ) and
                         ( DmAsientoFields.NroFactura.Value=NroRemesa ) and
                         ( SessionDataModule.EjercicioFecha( DmAsientoFields.FechaDocumento.Value )=Ejercicio );
               end;
end;

{ TRemesaPagoService }

procedure TRemesaPagoService.ActualizaAnotacionPago( RemesaPago : IRemesaPago; Concepto: String );
begin
     SessionDataModule.Dm10.RemesaPagoModule.ActualizaAnotacionPago( RemesaPago, Concepto );
end;

procedure TRemesaPagoService.ActualizaRemesa( RemesaPago : IRemesaPago );
begin
     SessionDataModule.Dm10.RemesaPagoModule.ActualizaRemesa( RemesaPago );
end;

procedure TRemesaPagoService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TRemesaPagoService.ImporteRemesa( Ejercicio : SmallInt; NroRemesa: Integer): Decimal;
begin
     Result := SessionDataModule.Dm10.RemesaPagoModule.ImporteRemesa( Ejercicio, NroRemesa );
end;

function TRemesaPagoService.ObtenConceptoAsientoPago( Ejercicio : SmallInt; NroRemesa: Integer; FechaPago : TDate ): String;
begin
     Result := SessionDataModule.Dm10.RemesaPagoModule.ObtenConceptoAsientoPago( Ejercicio, NroRemesa, FechaPago );
end;

procedure TRemesaPagoService.SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroRemesa : Integer );
begin
     SessionDataModule.Dm10.RemesaPagoModule.SuprimeAnotacionPago( RemoteCursorID, Ejercicio, NroRemesa );
end;

procedure TRemesaPagoService.SuprimeRemesa( RemoteCursorID : TnxCursorID; NroRemesa : Integer );
begin
     SessionDataModule.Dm10.RemesaPagoModule.SuprimeRemesa( RemoteCursorID, NroRemesa );
end;

var RemesaPagoControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_RemesaPagoService, TRemesaPagoService, RemesaPagoControl );

end.

