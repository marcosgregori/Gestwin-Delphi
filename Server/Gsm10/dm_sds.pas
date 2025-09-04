
unit dm_sds;

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

  dmi_sds;

type
    TSustitucionSubcuentasService = class( TSessionModule, ISustitucionSubcuentasService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( SubcuentaActual, SubcuentaNueva : String; TodosLosEjercicios : Boolean = False );

    end;

  TSustitucionSubcuentasModule = class(TServerDataModule)
    ProveedorTable: TnxeTable;
    ClienteTable: TnxeTable;
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    CuentaTable: TnxeTable;
    SaldosTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    ExistenciaTable: TnxeTable;
    RemesaTable: TnxeTable;
    RemesaPagoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private
    CuentaFields : TCuentaFields;
    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;
    ClienteFields : TClienteFields;
    ProveedorFields : TProveedorFields;
    SaldosFields : TSaldosFields;
    EfectoCobrarFields  : TEfectoCobrarFields;
    EfectoPagarFields : TEfectoPagarFields;
    ExistenciaFields : TExistenciaFields;
    RemesaFields : TRemesaFields;
    RemesaPagoFields : TRemesaPagoFields;

  public

    procedure EjecutaProceso( SubcuentaActual, SubcuentaNueva : String; TodosLosEjercicios : Boolean = False );
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

     AsientoIntf,

     dmi_sal,

     dm_sub,
     dm_ast,
     dm_sal;

{$R *.DFM}

resourceString

  RsMsg32  = 'Asientos';
  RsMsg33  = 'Efectos a cobrar';
  RsMsg34  = 'Efectos a pagar';
  RsMsg35  = 'Suprimiendo saldos de la subcuenta anterior';
  RsMsg36  = 'Ha ocurrido un error durante el proceso.'#13'Puesto que este proceso se realiza dentro de una TRANSACCION los ficheros deberían estar igual que antes de intentar realizarlo.';
  RsMsg38  = 'El proceso de sustitución se ha realizado correctamente.';
  RsMsg39  = 'Remesas de cobro';
  RsMsg40  = 'Remesas de pago';
  RsMsg42  = 'La subcuenta nueva no existe.'#13'Cuando la sustitución no es de una selección o rango, debe existir la subcuenta destino.';
  RsMsg43  = 'Subcuentas';
  RsMsg44  = 'Se ha producido un error al procesar ';

var SustitucionSubcuentasControl : InxClassFactoryControl;

procedure TSustitucionSubcuentasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.SustitucionSubcuentasModule := nil;
end;

procedure TSustitucionSubcuentasModule.ServerDataModuleCreate(Sender: TObject);
begin
     CuentaFields := TCuentaFields.Create( CuentaTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     ClienteFields := TClienteFields.Create( CLienteTable );
     ProveedorFields := TProveedorFields.Create( ProveedorTable );
     SaldosFields := TSaldosFields.Create( SaldosTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     ExistenciaFields := TExistenciaFields.Create( ExistenciaTable );
     RemesaFields := TRemesaFields.Create( RemesaTable );
     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );
end;

{ TSustitucionSubcuentasService }

procedure TSustitucionSubcuentasService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TSustitucionSubcuentasService.EjecutaProceso( SubcuentaActual,
                                                        SubcuentaNueva     : String;
                                                        TodosLosEjercicios : Boolean );
begin
     SessionDataModule.Dm10.SustitucionSubcuentasModule.EjecutaProceso( SubcuentaActual, SubcuentaNueva, TodosLosEjercicios );
end;

procedure TSustitucionSubcuentasModule.EjecutaProceso( SubcuentaActual,
                                                       SubcuentaNueva     : String;
                                                       TodosLosEjercicios : Boolean = False );

var Seleccion : Boolean;
    CodigoInicial,
    CodigoFinal,
    DescripcionSubcuenta : String;
    ProcesoCancelado : Boolean;

    Contador : LongInt;
    IdentificadorRegistro : String;

function EsCodigoSubcuentaActual( Codigo : String ) : Boolean;

var  Index : SmallInt;

begin
     Result := False;
     If   Codigo<>''
     then begin
          For Index := 1 to Length( Codigo ) do
            If   SubcuentaActual[ Index ]<>'*'
            then If   Codigo[ Index ]<>SubcuentaActual[ Index ]
                 then Exit;
          Result := True;
          end;
end;

function CodigoSubcuentaNueva( Codigo : String ) : String;

var  Index : SmallInt;

begin
     For Index := 1 to Length( Codigo ) do
        If   SubcuentaNueva[ Index ]<>'*'
        then Codigo[ Index ] := SubcuentaNueva[ Index ];
     Result := Codigo;
end;

begin

     try

       var TransactionTag := SessionDataModule.StartTransaction;  // Aquí no conviene especificar las tablas afectadas. Cuantas más sean, mejor.

       try

         ProcesoCancelado := False;

         Seleccion := Pos( '*', SubcuentaActual )<>0;

         With CuentaTable do
           If   Seleccion
           then begin
                If   TodosLosEjercicios
                then begin
                     ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg32 );
                     IndexName := csSeqAccessIndexName; // Secuencial
                     First;
                     While not Eof and not ProcesoCancelado do
                       begin
                       With CuentaFields do
                         If   Nivel.Value=SessionDataModule.Dm10.CuentaModule.NivelSubcuenta
                         then begin
                              ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, Codigo.Value );
                              If   EsCodigoSubcuentaActual( Codigo.Value )
                              then try
                                     Edit;
                                     Codigo.Value := CodigoSubcuentaNueva( Codigo.Value );
                                     Post;
                                   except
                                     Cancel;
                                     raise;
                                     end;
                              end;
                       Next;
                       end;
                     end;
                end
           else begin
                IndexFieldNames := 'Codigo';
                If   FindKey( [ SubcuentaNueva ] )
                then DescripcionSubcuenta := CuentaFields.Descripcion.Value
                else begin
                     ProcesoCancelado := SessionDataModule.SendNotification( ntError, RsMsg42 );
                     Abort;
                     end;
                end;

         // Asientos

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg32 );
         Contador := 0;
         IdentificadorRegistro := '';

         With AsientoTable do
           begin

           If   not TodosLosEjercicios
           then SetRange( [ SessionDataModule.Ejercicio, 1 ], [ SessionDataModule.Ejercicio, MaxLongint ] );

           First;
           While not Eof and not ProcesoCancelado do
             begin

             With AsientoFields do
               begin

               IdentificadorRegistro := StrInt( Ejercicio.Value ) + ' - ' + StrInt( NroAsiento.Value );

               If   ( Contador mod 50 )=0
               then ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, IdentificadorRegistro );
               Inc( Contador );

               If   EsCodigoSubcuentaActual( Propietario.Value )
               then try
                      Edit;
                      Propietario.Value := CodigoSubcuentaNueva( Propietario.Value );
                      If   not Seleccion
                      then Nombre.Value := DescripcionSubcuenta;
                      Post;
                    except
                      SessionDataModule.SendNotification( ntError, RsMsg44 + ' el asiento ' + IdentificadorRegistro );
                      Cancel;
                      raise;
                      end;

               With ApunteTable do
                 begin
                 SetRange( [ Ejercicio.Value, NroAsiento.Value, 1 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );
                 First;
                 While not Eof do
                   begin

                   With ApunteFields do
                     If   EsCodigoSubcuentaActual( Subcuenta.Value ) or EsCodigoSubcuentaActual( Contrapartida.Value )
                     then try
                            Edit;
                            If   EsCodigoSubcuentaActual( Contrapartida.Value )
                            then Contrapartida.Value := CodigoSubcuentaNueva( Contrapartida.Value )
                            else begin
                                 SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, True  );
                                 Subcuenta.Value := CodigoSubcuentaNueva( Subcuenta.Value );
                                 SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, false );
                                 end;

                            Post;
                          except
                            SessionDataModule.SendNotification( ntError, RsMsg44 + ' el apunte ' + StrInt( Ejercicio.Value ) + ' - ' + StrInt( NroAsiento.Value ) + ' / ' + StrInt( NroApunte.Value ) );
                            Cancel;
                            raise;
                            end;

                   Next;
                   end;

                 end;

               end;

             Next;
             end;

           end;

         If   ProcesoCancelado
         then Abort;

         // Efectos a cobrar

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg33 );
         Contador := 0;
         IdentificadorRegistro := '';

         With EfectoCobrarTable do
           begin

           // Ejercicio;Serie;NroFactura;NroEfecto

           If   not TodosLosEjercicios
           then SetRange( [ SessionDataModule.Ejercicio, '', 1, 0 ], [ SessionDataModule.Ejercicio, HighStrCode, MaxLongint, MaxSmallInt ] );

           First;
           While not Eof and not ProcesoCancelado do
             begin

             With EfectoCobrarFields do
               begin

               try

                 IdentificadorRegistro := StrInt( Ejercicio.Value ) + ' - ' + StrInt( NroFactura.Value ) + ' / ' + StrInt( NroEfecto.Value );

                 If   ( Contador mod 50 )=0
                 then ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, IdentificadorRegistro );

                 Inc( Contador );

                 If   EsCodigoSubcuentaActual( SubcuentaCliente.Value )
                 then begin
                      Edit;
                      SubcuentaCliente.Value := CodigoSubcuentaNueva( SubcuentaCliente.Value );
                      end;
                 If   EsCodigoSubcuentaActual( SubcuentaEntidad.Value )
                 then begin
                      Edit;
                      SubcuentaEntidad.Value := CodigoSubcuentaNueva( SubcuentaEntidad.Value );
                      end;
                 If   EsCodigoSubcuentaActual( SubcuentaDiferencia.Value )
                 then begin
                      Edit;
                      SubcuentaDiferencia.Value := CodigoSubcuentaNueva( SubcuentaDiferencia.Value );
                      end;
                 If   EsCodigoSubcuentaActual( SubcuentaGastos.Value )
                 then begin
                      Edit;
                      SubcuentaGastos.Value := CodigoSubcuentaNueva( SubcuentaGastos.Value );
                      end;
                 If   Modified
                 then Post;

               except
                 SessionDataModule.SendNotification( ntError, RsMsg44 + ' efecto el a cobrar ' + IdentificadorRegistro );
                 Cancel;
                 raise;
                 end;

               end;

             Next;
             end;

           end;

         If   ProcesoCancelado
         then abort;

         // Remesas de cobro

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg39 );

         With RemesaTable do
           begin

           // Ejercicio;NroRemesa

           If   not TodosLosEjercicios
           then SetRange( [ SessionDataModule.Ejercicio, 1 ], [ SessionDataModule.Ejercicio, MaxLongint ] );

           First;
           While not Eof and not ProcesoCancelado do
             begin

             With RemesaFields do
               begin

               IdentificadorRegistro := StrInt( Ejercicio.Value ) + ' - ' + StrInt( NroRemesa.Value );

               ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, IdentificadorRegistro );
               If   EsCodigoSubcuentaActual( SubcuentaEntidad.Value )
               then try
                      Edit;
                      SubcuentaEntidad.Value := CodigoSubcuentaNueva( SubcuentaEntidad.Value );
                      Post;
                    except
                      SessionDataModule.SendNotification( ntError, RsMsg44 + ' la remesa de cobro ' + IdentificadorRegistro );
                      Cancel;
                      raise;
                      end;
               end;

             Next;
             end;

           end;

         If   ProcesoCancelado
         then abort;

         // Efectos a pagar

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg34 );
         Contador := 0;

         With EfectoPagarTable do
           begin

           // Utilizo el indice secuencial porque no hay ninguno que incluya el ejercicio pero no la subcuenta

           IndexName := csSeqAccessIndexName;

           IdentificadorRegistro := '';

           First;
           While not Eof and not ProcesoCancelado do
             begin

             With EfectoPagarFields do
               begin

               try

                 If   TodosLosEjercicios or ( SessionDataModule.Ejercicio=Ejercicio.Value )
                 then begin

                      IdentificadorRegistro := StrInt( Ejercicio.Value ) + ' - ' + SubcuentaProveedor.Value + '-' + Serie.Value + ' / ' + StrInt( NroEfecto.Value );

                      If   ( Contador mod 50 )=0
                      then ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, IdentificadorRegistro );
                      Inc( Contador );

                      If   EsCodigoSubcuentaActual( SubcuentaProveedor.Value )
                      then begin
                           Edit;
                           SubcuentaProveedor.Value := CodigoSubcuentaNueva( SubcuentaProveedor.Value );
                           end;
                      If   EsCodigoSubcuentaActual( SubcuentaEntidad.Value )
                      then begin
                           Edit;
                           SubcuentaEntidad.Value := CodigoSubcuentaNueva( SubcuentaEntidad.Value );
                           end;

                      end;

                 If   Modified
                 then Post;

               except
                 SessionDataModule.SendNotification( ntError, RsMsg44 + ' el efecto a pagar ' + IdentificadorRegistro );
                 Cancel;
                 raise;
                 end;

               end;

             Next;
             end;
           end;

         If   ProcesoCancelado
         then Abort;

         // Remesas de pago

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg40 );

         With RemesaPagoTable do
           begin

           // Ejercicio;NroRemesa

           If   not TodosLosEjercicios
           then SetRange( [ SessionDataModule.Ejercicio, 1 ], [ SessionDataModule.Ejercicio, MaxLongint ] );

           First;
           While not Eof and not ProcesoCancelado do
             begin

             With RemesaPagoFields do
               begin

               IdentificadorRegistro := StrInt( Ejercicio.Value ) + ' - ' + StrInt( NroRemesa.Value );

               ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, IdentificadorRegistro );
               If   EsCodigoSubcuentaActual( SubcuentaEntidad.Value )
               then try
                      Edit;
                      SubcuentaEntidad.Value := CodigoSubcuentaNueva( SubcuentaEntidad.Value );
                      Post;
                    except
                      SessionDataModule.SendNotification( ntError, RsMsg44 + ' la remesa de pago ' + IdentificadorRegistro );
                      Cancel;
                      raise;
                      end;
               end;

             Next;
             end;

           end;

         If   ProcesoCancelado
         then abort;

         // Procesando los ficheros maestros (solo en cambios globales)

         If   TodosLosEjercicios
         then begin

              // Existencias

              With ExistenciaTable do
                begin
                First;
                While not Eof do
                  begin
                  If   EsCodigoSubcuentaActual( ExistenciaFields.Codigo.Value )
                  then try
                         Edit;
                         ExistenciaFields.Codigo.Value := CodigoSubcuentaNueva( ExistenciaFields.Codigo.Value );
                         Post;
                       except
                         Cancel;
                         raise;
                         end;
                  Next;
                  end;
                end;

              // Cliente

              With CLienteTable do
                begin
                First;
                While not Eof do
                  begin
                  try
                    If   EsCodigoSubcuentaActual( ClienteFields.Subcuenta.Value )
                    then begin
                         Edit;
                         ClienteFields.Subcuenta.Value := CodigoSubcuentaNueva( ClienteFields.Subcuenta.Value );
                         end;
                    If   EsCodigoSubcuentaActual( ClienteFields.Cobro_CtaEntidad.Value )
                    then begin
                         Edit;
                         ClienteFields.Cobro_Entidad.Value := CodigoSubcuentaNueva( ClienteFields.Cobro_CtaEntidad.Value );
                         end;
                    If   Modified
                    then Post;
                  except
                    Cancel;
                    raise;
                    end;
                  Next;
                  end;


              // Proveedor

              With ProveedorTable do
                begin
                First;
                While not Eof do
                  begin
                  try
                    If   EsCodigoSubcuentaActual( ProveedorFields.Subcuenta.Value )
                    then begin
                         Edit;
                         ProveedorFields.Subcuenta.Value := CodigoSubcuentaNueva( ProveedorFields.Subcuenta.Value );
                         end;
                    If   EsCodigoSubcuentaActual( ProveedorFields.Pago_Subcuenta.Value )
                    then begin
                         Edit;
                         ProveedorFields.Pago_Subcuenta.Value := CodigoSubcuentaNueva( ProveedorFields.Pago_Subcuenta.Value );
                         end;
                    If   Modified
                    then Post;
                  except
                    Cancel;
                    raise;
                    end;
                  Next;
                  end;

              end;

         // Saldos

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg35 );

         With SaldosTable do
           begin

           CodigoInicial := SessionDataModule.Dm10.CuentaModule.CodigoSeleccion( SubcuentaActual, Seleccion, False );
           CodigoFinal := SessionDataModule.Dm10.CuentaModule.CodigoSeleccion( SubcuentaActual, Seleccion );

           If   TodosLosEjercicios
           then SetRange( [ 0, CodigoInicial, '' ], [ MaxSmallInt, CodigoFinal, HighStrCode ] )
           else SetRange( [ SessionDataModule.Ejercicio, CodigoInicial, '' ], [ SessionDataModule.Ejercicio, CodigoFinal, HighStrCode ] );

           First;
           While not Eof do
             Delete;

           end;

         If   ProcesoCancelado
         then Abort;

         end;

        end;

      TransactionTag.Commit;
      SessionDataModule.SendNotification( ntInformation, RsMsg38 );

     except
       TransactionTag.Rollback;
       SessionDataModule.SendNotification( ntError, RsMsg36 );
       end;

     finally
      end;

end;

initialization
    TnxClassFactory.RegisterClass( CLSID_SustitucionSubcuentasService, TSustitucionSubcuentasService, SustitucionSubcuentasControl );

end.
