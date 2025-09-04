
unit dm_ric;

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

  dmi_ric;

type
    TRegularizacionIVAService = class( TSessionModule, IRegularizacionIVAService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( Fecha : TDate );

    end;

  TRegularizacionIVAModule = class(TServerDataModule)
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private
    AsientoFields,
    AsientoFacturaFields : TAsientoFields;
    ApunteFields : TApunteFields;
    EfectoPagarFields : TEfectoPagarFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    ProveedorFields : TProveedorFields;
    ClienteFields : TClienteFields;

  public

    procedure EjecutaProceso( Fecha : TDate );

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

     dmi_iva,
     dmi_ast,
     dmi_fac,

     dm_sub,
     dm_ast,
     dm_sal,
     dm_iva;

{$R *.DFM}

resourceString
     RsMsg1   = 'No se ha creado ningún asiento de regularización porque no hay efectos pendientes de pago o cobro que pertenezcan al ejercicio anterior.';
     RsMsg2   = 'Se ha creado el asiento de %s nº %d.';
     RsMsg10  = 'Proceso realizado satisfactoriamente.';
     RsMsg20  = 'Regularizando %s fuera de plazo.';

var RegularizacionIVAControl : InxClassFactoryControl;

procedure TRegularizacionIVAModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.RegularizacionIVAModule := nil;
end;

procedure TRegularizacionIVAModule.ServerDataModuleCreate(Sender: TObject);
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     AsientoFacturaFields := TAsientoFields.Create( AsientoTable, True );
     ApunteFields := TApunteFields.Create( ApunteTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     ProveedorFields := TProveedorFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
end;

{ TRegularizacionIVAService }

procedure TRegularizacionIVAService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TRegularizacionIVAService.EjecutaProceso( Fecha : TDate );
begin
     SessionDataModule.Dm10.RegularizacionIVAModule.EjecutaProceso( Fecha );
end;

procedure TRegularizacionIVAModule.EjecutaProceso( Fecha : TDate );

var  ProcesoCancelado : Boolean;
     NroAsiento : LongInt;
     NroApunteActual : SmallInt;
     ExisteAsientoFactura,
     ExisteFichaProveedor,
     ExisteFichaCliente : Boolean;
     TextoEfecto,
     TextoConcepto : String;
     FechaInicial,
     FechaFinal : TDate;

begin

    ProcesoCancelado := False;

    var TransactionTag := SessionDataModule.StartTransactionWith( [ AsientoTable ] );

     try

       ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg20, [ 'pagos' ] ) );

       // Si se ha realizado una regularización anterior se suprime el asiento correspondiente

       If   AsientoTable.FindEqualFirst( [ taRegularizacionIVA, SessionDataModule.Ejercicio, 1 ] )
       then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( AsientoFields );

       // Y se genera uno nuevo

       NroAsiento := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
       NroApunteActual := 1;

       AsientoTable.Append;

       AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       AsientoFields.NroAsiento.Value := NroAsiento;
       AsientoFields.Fecha.Value := Fecha;
       AsientoFields.TipoAsiento.Value := taRegularizacionIVA;
       AsientoFields.NroRegistro.Value := 1;  // Pagos

       FechaInicial := EncodeDate( SessionDataModule.Ejercicio - 1, 1, 1 );
       FechaFinal := EncodeDate( SessionDataModule.Ejercicio, 12, 31 );

       With EfectoPagarTable do
         begin
         SetRange( [ FechaInicial ], [ FechaFinal ] );
         First;
         While not Eof and not ProcesoCancelado do
           begin

           ExisteAsientoFactura := SessionDataModule.Dm10.AsientoModule.ObtenDocumento( taFraRecibida,
                                                                                        SessionDataModule.EjercicioFecha( EfectoPagarFields.FechaLibramiento.Value ),
                                                                                        EfectoPagarFields.SubcuentaProveedor.Value,
                                                                                        EfectoPagarFields.Serie.Value,
                                                                                        EfectoPagarFields.NroFactura.Value,
                                                                                        255,
                                                                                        AsientoFacturaFields );

           ExisteFichaProveedor := SessionDataModule.Dm10.ProveedorModule.Obten( EfectoPagarFields.CodigoProveedor.Value, EfectoPagarFields.SubcuentaProveedor.Value, ProveedorFields );
           TextoEfecto := EfectoPagarFields.Serie.Value + ' ' + IntToStr( EfectoPagarFields.NroFactura.Value ) + ' / ' + IntToStr( EfectoPagarFields.NroEfecto.Value );

           If   ( YearOf( EfectoPagarFields.FechaLibramiento.Value )=SessionDataModule.Ejercicio - 1 ) and
                ( ExisteFichaProveedor and ExisteAsientoFactura and ( AsientoFacturaFields.Origen.Value=ofrSujetoPasivo ) and ( ProveedorFields.Factura_ModeloIVA.Value=mipNormal ) ) and
                ( SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value or SessionDataModule.Dm10.AsientoModule.EjercicioTransicionCriterioCaja or ProveedorFields.Factura_RegimenEspecialCC.Value ) and
                SessionDataModule.Dm10.EfectoPagarModule.EfectoPendiente( EfectoPagarFields )
           then begin
                TextoConcepto := 'Regularización S/Ef. ' + TextoEfecto;
                SessionDataModule.Dm10.AsientoModule.CreaApuntesIVADevengado( AsientoFields,
                                                                              ApunteFields,
                                                                              AsientoFacturaFields,
                                                                              EfectoPagarFields.NroEfecto.Value,
                                                                              EfectoPagarFields.Importe.Value,
                                                                              TextoConcepto,
                                                                              NroApunteActual );
                ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, TextoConcepto );
                end;

           ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, TextoEfecto );

           Next;
           end;
        end;

       If   NroApunteActual>1
       then begin
            AsientoTable.Post;
            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg2, [ 'pagos', AsientoFields.NroAsiento.Value ] ) );
            end
       else begin
            AsientoTable.Cancel;
            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg1 );
            end;

       { Los usuarios no acogidos al criterio de caja (y que nunca lo han estado) también pueden realizar el proceso de regularización porque pueden
         tener proveedores acogidos, sin embargo no se deben regularizar los cobros en ningún caso.  }

       If   SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value or
            SessionDataModule.Dm10.AsientoModule.EjercicioTransicionCriterioCaja
       then begin

            ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg20, [ 'cobros' ] ) );

            If   AsientoTable.FindEqualFirst( [ taRegularizacionIVA, SessionDataModule.Ejercicio, 2 ] )
            then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( AsientoFields );

            NroAsiento := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
            NroApunteActual := 1;

            AsientoTable.Append;

            AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
            AsientoFields.NroAsiento.Value := NroAsiento;
            AsientoFields.Fecha.Value := Fecha;
            AsientoFields.TipoAsiento.Value := taRegularizacionIVA;
            AsientoFields.NroRegistro.Value := 2;  // Cobros


            With EfectoCobrarTable do
              begin
              SetRange( [ FechaInicial ], [ FechaFinal ] );
              First;
              While not Eof and not ProcesoCancelado do
                begin

                ExisteAsientoFactura := SessionDataModule.Dm10.AsientoModule.ObtenDocumento( taFraEmitida,
                                                                                             SessionDataModule.EjercicioFecha( EfectoCobrarFields.FechaLibramiento.Value ),
                                                                                             EfectoCobrarFields.SubcuentaCliente.Value,
                                                                                             EfectoCobrarFields.Serie.Value,
                                                                                             EfectoCobrarFields.NroFactura.Value,
                                                                                             255,
                                                                                             AsientoFacturaFields );

                ExisteFichaCliente := SessionDataModule.Dm10.ClienteModule.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields );
                TextoEfecto := EfectoCobrarFields.Serie.Value + ' ' + IntToStr( EfectoCobrarFields.NroFactura.Value ) + ' / ' + IntToStr( EfectoCobrarFields.NroEfecto.Value );

                If   ( YearOf( EfectoCobrarFields.FechaLibramiento.Value )=SessionDataModule.Ejercicio - 1 ) and
                     ExisteAsientoFactura and ExisteFichaCliente and ( ClienteFields.Factura_ModeloIVA.Value=micSinRE ) and
                     SessionDataModule.Dm10.EfectoCobrarModule.EfectoPendiente( EfectoCobrarFields )
                then begin
                     TextoConcepto := 'Regularización N/Ef. ' + TextoEfecto;
                     SessionDataModule.Dm10.AsientoModule.CreaApuntesIVADevengado( AsientoFields,
                                                                                   ApunteFields,
                                                                                   AsientoFacturaFields,
                                                                                   EfectoCobrarFields.NroEfecto.Value,
                                                                                   EfectoCobrarFields.Importe.Value,
                                                                                   TextoConcepto,
                                                                                   NroApunteActual );
                     ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, TextoConcepto );
                     end;

                ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, TextoEfecto );

                Next;
                end;

             end;

            If   NroApunteActual>1
            then begin
                 AsientoTable.Post;
                 ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg2, [ 'cobros', AsientoFields.NroAsiento.Value ] ) );
                 end
            else begin
                 AsientoTable.Cancel;
                 ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg1 );
                 end;

            end;

       If   ProcesoCancelado
       then Abort;

       TransactionTag.Commit;

       SessionDataModule.SendNotification( ntInformation, RsMsg10 );

     except on E : Exception do
       begin
       TransactionTag.RollBack;
       SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido, ExceptionMessage( E ) );
       end;
     end;


end;

initialization
    TnxClassFactory.RegisterClass( CLSID_RegularizacionIVAService, TRegularizacionIVAService, RegularizacionIVAControl );

end.
