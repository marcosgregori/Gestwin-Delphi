
unit dm_rda;

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

  dmi_rda;

type
    TRenumeracionAsientosService = class( TSessionModule, IRenumeracionAsientosService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( PrimerNumeroAsiento : LongInt );

    end;

  TRenumeracionAsientosModule = class(TServerDataModule)
    AsientoAuxTable: TnxeTable;
    RemesaPagoTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    RemesaTable: TnxeTable;
    MovimientoCajaTable: TnxeTable;
    FacturaTable: TnxeTable;
    Asiento1Table: TnxeTable;
    Asiento2Table: TnxeTable;
    ApunteTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    AsientoFields,
    Asiento1Fields,
    Asiento2Fields : TAsientoFields;
    ApunteFields : TApunteFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    EfectoPagarFields : TEfectoPagarFields;
    RemesaFields : TRemesaFields;
    RemesaPagoFields : TRemesaPagoFields;
    MovimientoCajaFields : TMovimientoCajaFields;
    FacturaFields : TFacturaFields;

  public

    procedure EjecutaProceso( PrimerNumeroAsiento : LongInt );

  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxdbBase,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     AsientoIntf,

     dmi_sal,
     dmi_fac,
     dmi_ast,

     dm_sub,
     dm_ast,
     dm_sal;

{$R *.DFM}

resourceString

  RsMsg1  = 'No se ha podido recuperar el %s del asiento nº %d.';
  RsMsg2  = 'Se ha encontrado un error en el vínculo de, al menos, un asiento. [B]Verifique el estado de la contabilidad[/B] y reintente el proceso cuando lo considere oportuno.';

  RsMsg21 = 'Realizando la renumeración de asientos solicitada.'#13'Espere un momento, por favor ...';
  RsMsg24 = 'Nros. de Asiento : %d -> %d';

var RenumeracionAsientosControl : InxClassFactoryControl;

procedure TRenumeracionAsientosModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.RenumeracionAsientosModule := nil;
end;

procedure TRenumeracionAsientosModule.ServerDataModuleCreate(Sender: TObject);
begin
     Asiento1Fields := TAsientoFields.Create( Asiento1Table );
     Asiento2Fields := TAsientoFields.Create( Asiento2Table );
     ApunteFields := TApunteFields.Create( ApunteTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     RemesaFields := TRemesaFields.Create( RemesaTable );
     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );
end;

{ TRenumeracionAsientosService }

procedure TRenumeracionAsientosService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TRenumeracionAsientosService.EjecutaProceso( PrimerNumeroAsiento: Integer);
begin
     SessionDataModule.Dm10.RenumeracionAsientosModule.EjecutaProceso( PrimerNumeroAsiento );
end;

// TRenumeracionAsientosModule

procedure TRenumeracionAsientosModule.EjecutaProceso( PrimerNumeroAsiento : LongInt );

var  NumeroAsientoActual,
     NumeroAsientoNuevo,
     UltimoNumeroAsiento : LongInt;
     ErrorEncontrado,
     ProcesoCancelado : Boolean;
     Contador : LongInt;

procedure RenumeraAsiento( NroAsientoActual, NroAsientoNuevo : LongInt );
begin
     With Asiento1Table do
       If   FindKey( [ SessionDataModule.Ejercicio, NroAsientoActual ] )
       then With Asiento1Fields do
              begin

              case TipoAsiento.Value of

                taFraEmitida,
                taFraRecibida       : With FacturaTable do   // Tipo;Ejercicio;NroRegistro
                                        If   FindKey( [ tfAsiento, SessionDataModule.Ejercicio, NroAsiento.Value ] )
                                        then try
                                               Edit;
                                               FacturaFields.NroRegistro.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de factura', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taCobro             : With EfectoCobrarTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then try
                                               Edit;
                                               EfectoCobrarFields.NroAsientoCobro.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'efecto cobrar', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taPago              : With EfectoPagarTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Propietario.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then try
                                               Edit;
                                               EfectoPagarFields.NroAsiento.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             {
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'efecto a pagar', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             }
                                             end;

                taAceptacion        : With RemesaTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then try
                                               Edit;
                                               RemesaFields.NroAsientoAceptacion.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de aceptación de remesa', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taDescuento         : With RemesaTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then try
                                               Edit;
                                               If   NroEfecto.Value=1
                                               then RemesaFields.NroAstoDescuento1.Value := NroAsientoNuevo
                                               else RemesaFields.NroAstoDescuento2.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de descuento de remesa', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taCancelacion       : With RemesaTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then try
                                               Edit;
                                               RemesaFields.NroAstoCancelacion.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de cancelación de remesa', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taCobroRemesa       : With RemesaTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then try
                                               Edit;
                                               RemesaFields.NroAsientoCobro.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de cobro de remesa', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taAmortizacion      : ;

                taCancelacionEfecto : With EfectoCobrarTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then try
                                               Edit;
                                               EfectoCobrarFields.NroAstoCancelacion.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de cancelación del efecto', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taCartera           : With EfectoCobrarTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then try
                                               Edit;
                                               EfectoCobrarFields.NroAsientoCartera.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de cartera', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taImpagado          : With EfectoCobrarTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then try
                                               Edit;
                                               EfectoCobrarFields.NroAsientoImpagado.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                              Cancel;
                                              raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro del impagado', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;

                taPagoRemesa        : With RemesaPagoTable do
                                        If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then try
                                               Edit;
                                               RemesaPagoFields.NroAsientoPago.Value := NroAsientoNuevo;
                                               Post;
                                             except
                                               Cancel;
                                               raise;
                                               end
                                        else begin
                                             SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ 'registro de pago de remesa', NroAsiento.Value ] ) );
                                             ErrorEncontrado := True;
                                             end;
                end;


              try
                Edit;
                NroAsiento.Value := NroAsientoNuevo;
                Post;
              except
                Cancel;
                raise;
                end;

              With ApunteTable do
                try
                  SetRange( [ Ejercicio.Value, NroAsientoActual, 1 ], [ Ejercicio.Value, NroAsientoActual, MaxSmallInt ] );
                  First;
                  While not Eof do
                    With ApunteFields do
                      try
                        Edit;
                        NroAsiento.Value := NroAsientoNuevo;
                        Post;
                      except
                        Cancel;
                        raise;
                        end;
                finally
                  CancelRange;
                  end;

              end;
end;

procedure ProcesaAsientoActual;
begin

     NumeroAsientoActual := Asiento2Fields.NroAsiento.Value;
     If   NumeroAsientoActual<>NumeroAsientoNuevo
     then begin

          If   Asiento1Table.FindKey( [ SessionDataModule.Ejercicio, NumeroAsientoNuevo ] )
          then begin
               RenumeraAsiento( NumeroAsientoNuevo, UltimoNumeroAsiento );
               Inc( UltimoNumeroAsiento );
               end;

          RenumeraAsiento( NumeroAsientoActual, NumeroAsientoNuevo );
          end;

     Inc( NumeroAsientoNuevo );

     If  ( Contador mod 50 )=0
     then ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, Format( RsMsg24, [ NumeroAsientoActual, NumeroAsientoNuevo ] ) );
     Inc( Contador );

end;

begin

     ProcesoCancelado := False;
     ErrorEncontrado := False;
     Contador := 0;

     var TransactionTag := SessionDataModule.StartTransaction;

     SessionDataModule.SendNotification( ntInformation, RsMsg21 );

     try

       With Asiento2Table do
         begin

         NumeroAsientoNuevo := PrimerNumeroAsiento;
         UltimoNumeroAsiento := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;

         IndexFieldNames := 'TipoAsiento;Fecha';
         SetRange( [ taApertura, SessionDataModule.PrimerDiaEjercicio ], [ taApertura, SessionDataModule.UltimoDiaEjercicio ] );
         First;
         While not Eof do              // Puede haber más de un Asiento de apertura
           begin
           ProcesaAsientoActual;
           Next;
           end;

         IndexFieldNames := 'Fecha';

         SetRange( [ SessionDataModule.PrimerDiaEjercicio ], [ SessionDataModule.UltimoDiaEjercicio ] );

         First;
         While not Eof and not ProcesoCancelado do
           begin
           If   Asiento2Fields.TipoAsiento.Value<>taApertura
           then ProcesaAsientoActual;
           Next;
           end;

         end;

         If   ProcesoCancelado or
              ErrorEncontrado
         then Abort
         else TransactionTag.Commit;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       If   ErrorEncontrado
       then SessionDataModule.SendNotification( ntError, RsMsg2 );
       SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido, ExceptionMessage( E ) );
       end;
     end;

end;


initialization
    TnxClassFactory.RegisterClass( CLSID_RenumeracionAsientosService, TRenumeracionAsientosService, RenumeracionAsientosControl );

end.
