
unit dm_rla;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  LibUtils,

  Gim30Fields,
  Gim40Fields,
  Gim70Fields,

  dmi_odf;

type

  {
  TLanzamientoService = class( TSessionModule, ILanzamientoService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    end;
  }

   TLanzamientoModule = class(TServerDataModule)
    DmLanzamientoTable: TnxeTable;
    DmLineaLanzamientoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmOrdenFabricacionTable: TnxeTable;
    DmLineaOFOperacionTable: TnxeTable;
    DmLineaOFComponenteTable: TnxeTable;
    DmLanzamientoAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    private

      DmLanzamientoFields,
      DmLanzamientoAuxFields : TLanzamientoFields;
      DmLineaLanzamientoFields : TLineaLanzamientoFields;
      DmPedidoVentasFields : TMovimientoFields;
      DmLineaPedidoVentasFields : TLineaMovimientoFields;
      DmOrdenFabricacionFields : TOrdenFabricacionFields;
      DmLineaOFOperacionFields : TLineaOFOperacionFields;
      DmLineaOFComponenteFields : TLineaOFComponenteFields;

      function GeneraRegistroLanzamiento : Boolean;

    public

     NroPedidoActual : LongInt;

     function ProximoLanzamiento( Ejercicio : SmallInt = 0 ) : LongInt;
     procedure SuprimeRegistroLanzamiento( Ejercicio : SmallInt; NroOperacion : LongInt );
     procedure SuprimeRelacionesLanzamiento( Ejercicio : SmallInt; NroOperacion : LongInt );
     procedure SuprimeRelacionesPreOrden( Ejercicio : SmallInt; NroOrden : LongInt );
     function CreaRegistroPorNumero( Ejercicio : SmallInt; NroOperacion : LongInt ) : Boolean;
     function CreaRegistroPorFecha( CodigoClienteInicial, CodigoClienteFinal : String; FechaInicial, FechaFinal : TDate ) : Boolean;

  end;

const  rlManual      = 0;
       rlAutomatico  = 1;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,
     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsdServerEngine,

     DateUtils,

     Gim00Fields,

     dmi_cnd,
     dmi_mov,

     dm_cnd,

     dm_odf;

{$R *.DFM}

procedure TLanzamientoModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmLanzamientoFields := TLanzamientoFields.Create( DmLanzamientoTable );
     DmLanzamientoAuxFields := TLanzamientoFields.Create( DmLanzamientoAuxTable );
     DmLineaLanzamientoFields := TLineaLanzamientoFields.Create( DmLineaLanzamientoTable );
     DmPedidoVentasFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaPedidoVentasFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
     DmLineaOFOperacionFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionTable );
     DmLineaOFComponenteFields := TLineaOFComponenteFields.Create( DmLineaOFComponenteTable );
end;

procedure TLanzamientoModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.LanzamientoModule := nil;
end;

function TLanzamientoModule.ProximoLanzamiento( Ejercicio : SmallInt = 0 ) : LongInt;

var  ResetCounter : Boolean;
     ValorActual : LongInt;
     Count : SmallInt;

begin

     ValorActual := 0;
     Count := 0;
     ResetCounter := False;

     If   Ejercicio=0
     then Ejercicio := SessionDataModule.Ejercicio;

     With DmLanzamientoAuxTable do
       begin

       IndexFieldNames := 'Ejercicio;NroOperacion';

       repeat

         If   SessionDataModule.Dm00.ContadoresModule.CompruebaContador( cnLanzamiento ) or ResetCounter
         then If   FindEqualLast( [ Ejercicio ] )
              then ValorActual := DmLanzamientoAuxFields.NroOperacion.Value + 1
              else ValorActual := 1;

         ValorActual := SessionDataModule.Dm00.ContadoresModule.Incrementa( cnLanzamiento, Ejercicio, '', ValorActual, 1 );
         ResetCounter := FindKey( [ Ejercicio, ValorActual ] );
         
         Inc( Count );

       until not ResetCounter or ( Count=10 );

       end;

     Result := ValorActual;
end;

procedure TLanzamientoModule.SuprimeRegistroLanzamiento( Ejercicio    : SmallInt;
                                                         NroOperacion : LongInt );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLanzamientoTable, DmLineaLanzamientoTable ] );
     try
       With DmLanzamientoTable do
         If   FindKey( [ Ejercicio, NroOperacion ] )
         then begin
              SuprimeRelacionesLanzamiento( Ejercicio, NroOperacion );
              With DmLineaLanzamientoTable do
                try
                  SetRange( [ Ejercicio, NroOperacion, 1 ], [ Ejercicio, NroOperacion, MaxSmallInt ] );
                  DeleteRecords;
                finally
                  CancelRange;
                  end;
              Delete;
              end;
       TransactionTag.Commit;
     except
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TLanzamientoModule.SuprimeRelacionesLanzamiento( Ejercicio    : SmallInt;
                                                           NroOperacion : LongInt );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmOrdenFabricacionTable, DmLineaOFComponenteTable, DmLineaOFOperacionTable ] );
     try
       With DmOrdenFabricacionTable do
         begin
         IndexFieldNames := 'EjercicioLanzamiento;NroOperacionLanzamiento';
         SetRange( [ Ejercicio, NroOperacion ], [ Ejercicio, NroOperacion ] );
         First;
         While not Eof do
           begin
           With DmOrdenFabricacionFields do
             begin
             DmLineaOFComponenteTable.DeleteRangeRecords ( [ Ejercicio, moPreOrden, NroOrden, 1, 1 ], [ Ejercicio, moPreOrden, NroOrden, MaxSmallInt, MaxSmallInt ] );
             DmLineaOFOperacionTable.DeleteRangeRecords( [ Ejercicio, moPreOrden, NroOrden, 1  ], [ Ejercicio, moPreOrden, NroOrden, MaxSmallInt  ] );
             end;
           Delete;
           Next;
           end;
         end;
       TransactionTag.Commit;
     except
       TransactionTag.Rollback;
       raise;
     end;
end;

procedure TLanzamientoModule.SuprimeRelacionesPreOrden( Ejercicio : SmallInt;
                                                        NroOrden  : LongInt );
begin
     With DmOrdenFabricacionTable do
       begin
       IndexFieldNames := 'Ejercicio;Tipo;NroOrden';
       If   FindKey( [ Ejercicio, moPreOrden, NroOrden ] )
       then With DmOrdenFabricacionFields do
              begin
              DmLineaOFOperacionTable.DeleteRangeRecords  ( [ Ejercicio, moPreOrden, NroOrden, 1 ], [ Ejercicio, moPreOrden, NroOrden, MaxSmallInt  ] );
              DmLineaOFComponenteTable.DeleteRangeRecords ( [ Ejercicio, moPreOrden, NroOrden, 1, 1 ], [ Ejercicio, moPreOrden, NroOrden, MaxSmallInt, MaxSmallInt ] );
              end;
       end;

     // Faltan los albaranes de venta !!!!

end;

function TLanzamientoModule.GeneraRegistroLanzamiento : Boolean;

var   taskNumber        : LongInt;
      NroRegistroActual : SmallInt;

procedure ProcesaOrden;

begin
     With DmLineaMovimientoTable do
       begin

       With DmPedidoVentasFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt ] );

       First;
       While not Eof do
         begin

         With DmLineaPedidoVentasFields do
           begin

           If   DmLineaLanzamientoTable.FindKey( [ Ejercicio.Value, NroOperacion.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] )
           then begin

                With DmLineaLanzamientoFields do
                  begin
                  Pendiente.Value := Pendiente.Value + Cantidad.Value;
                  Fabricar.Value := Fabricar.Value + Cantidad.Value;
                  end;

                DmLineaLanzamientoTable.PostRecord( False );

                end
           else begin

                DmLineaLanzamientoTable.Append;

                DmLineaLanzamientoFields.Ejercicio.Value := DmLanzamientoFields.Ejercicio.Value;
                DmLineaLanzamientoFields.NroOperacion.Value := DmLanzamientoFields.NroOperacion.Value;
                DmLineaLanzamientoFields.NroRegistro.Value := NroRegistroActual;
                DmLineaLanzamientoFields.EjercicioPedido.Value := DmPedidoVentasFields.Ejercicio.Value;
                DmLineaLanzamientoFields.NroOperacionPedido.Value := DmPedidoVentasFields.NroOperacion.Value;
                DmLineaLanzamientoFields.CodigoArticulo.Value := DmLineaPedidoVentasFields.CodigoArticulo.Value;
                DmLineaLanzamientoFields.CodigoClaseA.Value := DmLineaPedidoVentasFields.CodigoClaseA.Value;
                DmLineaLanzamientoFields.CodigoClaseB.Value := DmLineaPedidoVentasFields.CodigoClaseB.Value;
                DmLineaLanzamientoFields.CodigoClaseC.Value := DmLineaPedidoVentasFields.CodigoClaseC.Value;
                DmLineaLanzamientoFields.Pendiente.Value := Cantidad.Value;
                DmLineaLanzamientoFields.Fabricar.Value := Cantidad.Value;

                DmLineaLanzamientoTable.Post;

                Inc( NroRegistroActual );
                end
                ;
           end;
         Next;
         end;
       end;

end;

begin

     Result := False;

     NroRegistroActual := 1;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLanzamientoTable, DmLineaLanzamientoTable ] );

     try

       With DmLanzamientoTable do
         begin
         Append;
         DmLanzamientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
         DmLanzamientoFields.NroOperacion.Value := ProximoLanzamiento;
         DmLanzamientoFields.Fecha.Value := SessionDataModule.FechaHoy;
         DmLanzamientoFields.Tipo.Value := rlManual;
         Post;
         end;

       With DmLanzamientoFields do
         DmLineaLanzamientoTable.DeleteRangeRecords( [ Ejercicio.Value, NroOperacion.Value, 0 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt ] );

       With DmMovimientoTable do
         begin

         // Los límites tienen que haberse fijado previamente

         First;
         While not Eof do
           begin
           ProcesaOrden;
           Next;
           end;
         end;

       If   NroRegistroActual=1  // Suprimo la cabecera generada
       then Abort;

       TransactionTag.Commit;

       Result := True;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendException( E, Self );
       end;
     end;

end;

function TLanzamientoModule.CreaRegistroPorFecha( CodigoClienteInicial,
                                                  CodigoClienteFinal  : String;
                                                  FechaInicial,
                                                  FechaFinal          : TDate ) : Boolean;
begin
     With DmMovimientoTable do
       begin
       IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
       SetRange( [ tmPedidoVenta, CodigoClienteInicial, FechaInicial ], [ tmPedidoVenta, CodigoClienteFinal, FechaFinal ] );
       end;
     Result := GeneraRegistroLanzamiento;
end;

function TLanzamientoModule.CreaRegistroPorNumero( Ejercicio    : SmallInt;
                                                   NroOperacion : LongInt ) : Boolean;
begin
     With DmMovimientoTable do
       begin
       IndexFieldNames := 'Ejercicio;NroOperacion';
       SetRange( [ Ejercicio, NroOperacion ], [ Ejercicio, NroOperacion ] );
       end;
     Result := GeneraRegistroLanzamiento;
end;

{ TLanzamientoService     // De momento no es necesrio un servicio

procedure TLanzamientoService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TLanzamientoService.GeneraLanzamientoDesdePedido( NroOperacion : Integer );
begin

end;

var LanzamientoControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_LanzamientoService, TLanzamientoService, LanzamientoControl );
}

end.
