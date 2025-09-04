unit dm_ast;

interface

uses
  Windows, SysUtils, Classes,
  DB, Generics.Defaults, Generics.Collections,

  LibUtils,
  ServerDataModule,
  DataManager,

  Gim10Fields,
  SessionIntf,
  nxdb,
  nxsdTypes,
  nxsrServerEngine,

  dmi_ast,
  dmi_fac,

  AsientoIntf,
  ApunteIntf;

type

  TProcesoAsientoFactura = ( tpaAltaFactura, tpaActualizacionFactura, tpaActualizacionLinea, tpaBajaLinea );

  TAsientoService = class( TSessionModule, IAsientoService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    function ExisteAsientoContador( NroAsiento : LongInt ) : Boolean;
    function ProximoNroAsiento : LongInt;
    function ProximoNroRegistro( TipoDocumento : SmallInt; ResetCounter : Boolean = False ) : LongInt;

    function ObtenImportesFactura( Ejercicio : SmallInt; NroAsiento : LongInt; var BaseImponible, CuotaIVA, CuotaRE, ImporteTotal : Decimal ) : Boolean;
    function ImporteCobrosEfectivo( Subcuenta : String; FechaInicial, FechaFinal : TDateTime; Cargos : Boolean ) : Decimal;

    function ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;

    procedure ActualizaAsiento( Asiento : IAsiento );
    procedure SuprimeAsiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt ); overload;

    function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; PreservaCabecera : Boolean = False ) : Boolean; overload;
    function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; TipoAsiento : SmallInt; FechaDocumento : TDate; SubcuentaPropietario : String; Serie : String; NroDocumento : LongInt; NroEfecto : SmallInt;  PreservaCabecera : Boolean = False ) : Boolean; overload;

    function CopiaAsiento( Ejercicio  : SmallInt; NroAsiento : LongInt; Fecha : TDate ) : Boolean;

    procedure ActualizaApunte( TipoAsiento : TTipoAsiento; Apunte : IApunte );
    procedure SuprimeApunte( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt; TipoAsiento : TTipoAsiento; NroApunte : SmallInt );

    procedure ActualizaFactura( Asiento : IAsiento; ConceptoFactura : String; SubcuentaRetencion : String; TipoRetencion : SmallInt; BaseRetencion, ImporteRetencion : Decimal );

    procedure SuprimeFacturaEmitida( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt );
    procedure SuprimeFacturaRecibida( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt );

    procedure ActualizaApunteFactura( Asiento : IAsiento; Apunte : IApunte );

    procedure SuprimeApunteFactura( Asiento : IAsiento; Apunte : IApunte );

   
    end;

  TAsientoModule = class(TServerDataModule)
    DmApunteTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmAsientoAuxTable: TnxeTable;
    SQLQuery: TnxeQuery;
    DmApunteAuxTable: TnxeTable;
    DmAsientoDocumentoTable: TnxeTable;
    DeApunteTable: TnxeTable;
    DeAsientoTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
  private

    DmAsientoFields,
    DmAsientoAuxFields,
    DmAsientoDocumentoFields,
    DmAsientoLibroFields : TAsientoFields;
    DmFacturaFields : TFacturaFields;
    DmApunteFields,
    DmApunteAuxFields : TApunteFields;

    DeAsientoFields : TAsientoFields;
    DeApunteFields : TApunteFields;

    FEjercicioTransicionCriterioCaja : Variant;   // Para que pueda ser null antes de inicializarse

    FSubcuentaRetencion : String;  // Variables usadas en la generación de registros de facturas
    FTipoRetencion : SmallInt;
    FBaseRetencion,
    FImporteRetencion : Decimal;
    FConceptoFactura : String;

    function GetEjercicioTransicionCriterioCaja : Boolean;

    function ExisteNroAsiento( ValorActual : LongInt ) : Boolean;
    function ExisteAsientoContador( NroAsiento : LongInt ) : Boolean;

    procedure CompletaAsientoFactura( Asiento : IAsiento; Proceso : TProcesoAsientoFactura = tpaActualizacionLinea ); overload;

  public

    function  ProximoNroAsiento : LongInt;
    procedure RetiraNroAsiento( AsientoFields : TAsientoFields; CompruebaEstado : Boolean = True );
    function  ProximoNroRegistro( TipoDocumento : SmallInt; ResetCounter  : Boolean = False ) : LongInt;

    function  Obten( AIndexFieldNames : String; KeyArray : array of const ) : Boolean;

    function  ObtenDocumento( TipoDocumento, Ejercicio : SmallInt; CodigoPropietario : String; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt = 255; AsientoFields : TAsientoFields = nil ) : Boolean;
    function  ObtenImportesFactura( Ejercicio : SmallInt; NroAsiento : LongInt; var BaseImponible, CuotaIVA, CuotaRE, ImporteTotal : Decimal ) : Boolean;

    procedure ActualizaAsiento( Asiento : IAsiento; OnCompletaActualizacionAsiento : TOnCompletaActualizacionAsiento = nil );
    procedure SuprimeAsiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : Integer ); overload;

    function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; PreservaCabecera : Boolean = False; AsientoFacturaTable : TnxeTable = nil ) : Boolean; overload;
    function SuprimeAsiento( AsientoFields : TAsientoFields; PreservaCabecera : Boolean = False; AsientoFacturaTable : TnxeTable = nil ) : Boolean; overload;
    function SuprimeAsiento( AsientoFields : TAsientoFields; TipoAsiento : SmallInt; FechaDocumento : TDate; SubcuentaPropietario : String; Serie : String; NroDocumento : LongInt; NroEfecto : SmallInt; PreservaCabecera : Boolean = False; AsientoFacturaTable : TnxeTable = nil ) : Boolean; overload;
    function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; TipoAsiento : SmallInt; FechaDocumento : TDate; SubcuentaPropietario : String; Serie : String; NroDocumento : LongInt; NroEfecto : SmallInt;  PreservaCabecera : Boolean = False; AsientoFacturaTable : TnxeTable = nil ) : Boolean; overload;

    function CopiaAsiento( Ejercicio  : SmallInt; NroAsiento : LongInt; Fecha : TDate ) : Boolean;

    procedure CompruebaApuntesAsiento( Asiento     : IAsiento;
                                       TableCursor : TnxServerTableCursor );

    procedure ActualizaApunte( TipoAsiento : TTipoAsiento; Apunte : IApunte; OnCompletaActualizacionApunte : TOnCompletaActualizacionApunte = nil );
    procedure SuprimeApunte( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : Integer; TipoAsiento : TTipoAsiento; NroApunte : SmallInt; OnCompletaSupresionApunte : TOnCompletaSupresionApunte = nil );

    function  TrimestreCorrecto( aMonth : SmallInt ) : Boolean;
    function  EjercicioCerrado : Boolean;
    function  ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;

    procedure CompruebaDocumentoAsiento( AsientoFields        : TAsientoFields;
                                         TipoAsiento          : SmallInt;
                                         FechaDocumento       : TDate;
                                         SubcuentaPropietario : String;
                                         Serie                : String;
                                         NroDocumento         : LongInt;
                                         NroEfecto            : SmallInt;
                                         PreservaCabecera     : Boolean = False );

    procedure ActualizaFactura( Asiento            : IAsiento;
                                ConceptoFactura    : String;
                                SubcuentaRetencion : String;
                                TipoRetencion      : SmallInt;
                                BaseRetencion,
                                ImporteRetencion   : Decimal );

    procedure CompletaAsientoFactura( AsientoFields   : TAsientoFields;
                                      ConceptoFactura : String;
                                      Proceso         : TProcesoAsientoFactura = tpaActualizacionLinea ); overload;

    procedure SuprimeFacturaEmitida( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt );
    procedure SuprimeFacturaRecibida( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt );

    procedure ActualizaApunteFactura( Asiento : IAsiento;
                                      Apunte  : IApunte );

    procedure SuprimeApunteFactura( Asiento : IAsiento;
                                    Apunte  : IApunte );

  

    procedure CreaApuntesIVADevengado(     AsientoFields         : TAsientoFields;
                                           ApunteFields          : TApunteFields;
                                           AsientoFacturaFields  : TAsientoFields;
                                           NroEfecto             : SmallInt;
                                           ImporteEfecto         : Decimal;
                                           TextoConcepto         : String;
                                       var NroApunte             : SmallInt );

    function ObtenImportesDevengados(     AsientoFacturaFields  : TAsientoFields;
                                      var BasesImponibles       : TRelacionImportes;
                                      var Cuotas                : TRelacionImportes ) : Decimal;

    function ImporteCobrosEfectivo( Subcuenta : String;
                                    FechaInicial,
                                    FechaFinal     : TDateTime;
                                    Cargos         : Boolean ) : Decimal;

    { Indica que el usuario ha vuelto al modo normal desde el criterio de caja en este ejercicio. Eso siginifica que hay que
      seguir procesando los efectos pendientes de pago/cobro del ejercicio anterior como si aún estuvieran acogidos al criterio de caja (un horror)
    }

    property EjercicioTransicionCriterioCaja : Boolean read GetEjercicioTransicionCriterioCaja;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses System.Types,

     Variants,

     nxrdClass,
     nxrbTypes,
     nxllBde,

     DateUtils,
     AppManager,
     EnterpriseData,
     SessionData,

     dmi_cnd,

     Gsm00Dm,

     dm_pga,
     dm_cnd,

     dm_sal,
     dm_sub,
     dm_cli,
     dm_pro,
     dm_ecc,
     dm_iva;

{$R *.DFM}

resourceString
     RsMsg1  = 'La fecha del documento no pertenece al trimestre actual.';
     RsMsg2  = 'No está permitido crear registros que no pertenezcan al trimestre actual.';
     RsMsg3  = 'actual';
     RsMsg4  = 'El ejercicio actual está cerrado.';
     RsMsg5  = 'Si modifica el contenido de algún asiento y no realiza de nuevo el cierre la contabilidad podría quedar en una situación inconsistente.';
     RsMsg6  =  #13'¿Esta seguro de que desea editar los asientos?';
     RsMsg7  = 'El asiento que intenta suprimir no se corresponde con el generado por este tipo de documento.';
     RsMsg8  = 'No será suprimido.';
     RsMsg9  = 'No se ha podido completar correctamente el asiento de facturación.';
     RsMsg10 = 'El asiento puede haber quedado en una situación inconsistente.'#13'Por favor, revíselo y reintente la operación.';


     RsMsg14 = 'Ya existe un asiento con este mismo número.';
     RsMsg15 = 'Otro usuario ya ha reservado este número de asiento.'#13'Introduzca otro número o pulse [B][F12][/B] para generar un número exclusivo automáticamente.';
     RsMsg16 = 'El asiento de %s nº %d contiene un tipo impositivo que no existe en la factura.';
     RsMsg17 = 'Debe revisar los asientos de %s de la factura nº %s %d y volver a generar, si es necesario, los asientos de erróneos.';
     RsMsg18 = 'No se ha podido suprimir el asiento nº %d.';
     RsMsg19 = 'Compruebe que no está siendo editado por otro usuario y reintente el proceso cuando lo considere oportuno.';
     RsMsg20 = 'El asiento nº %d no existe.';

{ TAsientoModule  }

procedure TAsientoModule.ServerDataModuleCreate(Sender: TObject);
begin

     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmAsientoAuxFields := TAsientoFields.Create( DmAsientoAuxTable );
     DmApunteAuxFields := TApunteFields.Create( DmApunteAuxTable );
     DmAsientoDocumentoFields := TAsientoFields.Create( DmAsientoDocumentoTable );

     DeAsientoFields := TAsientoFields.Create( DeAsientoTable );
     DeApunteFields := TApunteFields.Create( DeApunteTable );

end;

procedure TAsientoModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.AsientoModule := nil;
end;

function TAsientoModule.GetEjercicioTransicionCriterioCaja : Boolean;
begin

     // Es un ejercicio de transición si ya no está activado el criterio de caja pero en el ejercicio anterior hay movimientos de traspaso de I.V.A. por ese motivo

     If   VarIsEmpty( FEjercicioTransicionCriterioCaja )
     then FEjercicioTransicionCriterioCaja := not SessionDataModule.EmpresaFields.RegimenEspecialCriterioCaja.Value and ExistenApuntesTraspasoIVA( SessionDataModule.Ejercicio - 1 );

     Result := FEjercicioTransicionCriterioCaja;
end;

function TAsientoModule.Obten( AIndexFieldNames : String;
                               KeyArray         : array of const ) : Boolean;
begin
     With DmAsientoAuxTable do
       begin
       IndexFieldNames := AIndexFieldNames;
       Result := FindKey( KeyArray );
       end;
end;

procedure TAsientoModule.RetiraNroAsiento( AsientoFields   : TAsientoFields;
                                           CompruebaEstado : Boolean = True );
begin
     If   Assigned( AsientoFields )
     then If   AsientoFields.Dataset is TnxeTable
          then With AsientoFields.Table do
                 If   not CompruebaEstado or ( not InternalProcess and not ( State in [ dsEdit, dsInsert ] ) and ( PreviousState in [ dsEdit, dsInsert ] ) )
                 then SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnAsiento, SessionDataModule.Ejercicio, '', AsientoFields.NroAsiento.Value );
end;

function TAsientoModule.ExisteNroAsiento( ValorActual : LongInt ) : Boolean;
begin
     With DmAsientoAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;NroAsiento';
       Result := FindKey( [ SessionDataModule.Ejercicio, ValorActual ] );
       end;
end;

function TAsientoModule.ExisteAsientoContador( NroAsiento : LongInt ) : Boolean;
begin
     With SessionDataModule do
       Result := Dm00.ContadoresModule.ExisteValor( cnAsiento, Ejercicio, '', NroAsiento );
end;

function TAsientoModule.ProximoNroAsiento : LongInt;

var  ValorActual : LongInt;
     RecordFound : Boolean;

begin

     ValorActual := 0;

     With DmAsientoAuxTable do
       begin
       CancelRange;
       IndexFieldNames := 'Ejercicio;NroAsiento';
       RecordFound := FindEqualLast( [ SessionDataModule.Ejercicio ] );
       If   RecordFound
       then ValorActual := DmAsientoAuxFields.NroAsiento.Value + 1
       else ValorActual := 2;

       ValorActual := SessionDataModule.Dm00.ContadoresModule.ProximoValor( ExisteNroAsiento, cnAsiento, SessionDataModule.Ejercicio, '', ValorActual, 2 );

       SessionDataModule.Dm00.ContadoresModule.CompruebaValorMaximo( ValorActual );
       end;

     Result := ValorActual;
end;

function TAsientoModule.ProximoNroRegistro( TipoDocumento : SmallInt;
                                            ResetCounter  : Boolean = False ) : LongInt;

var  ValorActual : LongInt;
     Count : SmallInt;

begin

     ValorActual := 0;
     Count := 0;

     With DmAsientoAuxTable do
       begin
       IndexFieldNames := 'TipoAsiento;Ejercicio;NroRegistro';
       repeat

         If   SessionDataModule.Dm00.ContadoresModule.CompruebaContador( cnNroRegAsiento ) or ResetCounter
         then If   FindEqualLast( [ TipoDocumento, SessionDataModule.Ejercicio ] )
              then ValorActual := DmAsientoAuxFields.NroRegistro.Value + 1
              else ValorActual := 1;

         ValorActual := SessionDataModule.Dm00.ContadoresModule.Incrementa( cnNroRegAsiento, SessionDataModule.Ejercicio, StrInt( TipoDocumento ), ValorActual, 1 );
         ResetCounter := FindKey( [ TipoDocumento, SessionDataModule.Ejercicio, ValorActual ] );

         Inc( Count );

       until not ResetCounter or ( Count=10 );
       end;

     Result := ValorActual;
end;

procedure TAsientoModule.SuprimeApunte( RemoteCursorID            : TnxCursorID;
                                        Ejercicio                 : SmallInt;
                                        NroAsiento                : Integer;
                                        TipoAsiento               : TTipoAsiento;
                                        NroApunte                 : SmallInt;
                                        OnCompletaSupresionApunte : TOnCompletaSupresionApunte = nil );
                                        
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DeApunteTable.FindKey( [ Ejercicio, NroAsiento, NroApunte ] )
          then begin
               var TransactionTag := SessionDataModule.StartTransactionWith( [ DeApunteTable ] );
               try
               
                 SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( TipoAsiento, DeApunteFields, True );

                 DeApunteTable.Delete;

                 If   Assigned( OnCompletaSupresionApunte )
                 then OnCompletaSupresionApunte( DeApunteFields );

                 TransactionTag.Commit;
               except
                 TransactionTag.Rollback;
                 raise;
                 end;
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TAsientoModule.CompruebaApuntesAsiento( Asiento     : IAsiento;
                                                  TableCursor : TnxServerTableCursor );
begin
     If   Asiento.State=dsEdit
     then If   DeAsientoTable.FindKey( [ Asiento.Ejercicio, Asiento.NroAsiento ] )
          then begin
               TableCursor.RecordLockRelease( False );
               If   ( DeAsientoFields.Fecha.Value<>Asiento.Fecha ) or ( DeAsientoFields.TipoAsiento.Value<>Asiento.TipoAsiento )
               then With DeApunteTable do
                      begin
                      SetRange( [ Asiento.Ejercicio, Asiento.NroAsiento ] );
                      try
                        First;
                        While not Eof do
                          begin
                          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DeAsientoFields.TipoAsiento.Value, DeApunteFields, True );
                          try
                            Edit;
                            DeApunteFields.Fecha.Value := Asiento.Fecha;
                            SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DeApunteFields );
                            Post;
                          except
                            Cancel;
                            raise;
                            end;
                          Next;
                          end;
                      finally
                        CancelRange;
                        end;
                      end;
               end
          else RaiseRecordNotFoundException;

end;
procedure TAsientoModule.ActualizaAsiento( Asiento                        : IAsiento;
                                           OnCompletaActualizacionAsiento : TOnCompletaActualizacionAsiento = nil );

var  TableCursor : TnxServerTableCursor;

begin

    { MUY IMPORTANTE :

       Las transacciones anidadas se preservan. Es decir que si esta sesión inicia una transacción en la tabla Asiento y, dentro de ella,
       se inicia otra transacción (por ejemplo en la llamada a la función ActualizaSaldos se inicia y valida (commit) una sobre la tabla Saldos )
       en el momento que se produzca una excepción en cualquiera de las llamadas se invalidan todas las modificaciones anteriores en Saldos
       (nivel inferior) y en Apunte (nivel superior) aunque la primera transacción no incluya la tabla Saldos

       Por ese motivo no importa que se inicie y valide cada vez una transacción en ActualizaSaldos, porque si no se valida la transacción
       superior, se invalidan todas las inferiores.

     }

     If   TnxServerTableCursor.LookupByID( Asiento.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DeAsientoTable, DeApunteTable ] );

          try

            CompruebaApuntesAsiento( Asiento, TableCursor );

            Asiento.ToDataset( DeAsientoFields ); // Aquí se produce el Edit o el Append del dataset, dependiendo del estado de IAsiento

            If   Asiento.State=dsInsert
            then begin
                 DeAsientoFields.Creado.Value := Now;
                 DeAsientoFields.Usuario.Value := SessionDataModule.CodigoUsuario;
                 end;

            If   Assigned( OnCompletaActualizacionAsiento )
            then OnCompletaActualizacionAsiento( DeAsientoFields );

            DeAsientoTable.Post;

            TransactionTag.Commit;

          except
            DeAsientoTable.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end
     else RaiseNoCurrentRecordException;

end;

procedure TAsientoModule.SuprimeAsiento( RemoteCursorID      : TnxCursorID;
                                         Ejercicio           : SmallInt;
                                         NroAsiento          : Integer );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DeAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAsiento( DeAsientoFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TAsientoModule.CompruebaDocumentoAsiento( AsientoFields        : TAsientoFields;
                                                    TipoAsiento          : SmallInt;
                                                    FechaDocumento       : TDate;
                                                    SubcuentaPropietario : String;
                                                    Serie                : String;
                                                    NroDocumento         : LongInt;
                                                    NroEfecto            : SmallInt;
                                                    PreservaCabecera     : Boolean = False );
begin
     If   ( AsientoFields.TipoAsiento.Value<>TipoAsiento ) or
          ( AsientoFields.FechaDocumento.Value<>FechaDocumento ) or
          ( ( AsientoFields.Propietario.Value<>'' ) and ( AsientoFields.Propietario.Value<>SubcuentaPropietario ) ) or
          ( AsientoFields.Serie.Value<>Serie ) or
          ( AsientoFields.NroFactura.Value<>NroDocumento ) or
          ( AsientoFields.NroEfecto.Value<>NroEfecto )
     then begin
          SessionDataModule.SendNotification( ntError, RsMsg7, RsMsg8 );
          Abort;
          end;
end;

//

function TAsientoModule.SuprimeAsiento( Ejercicio           : SmallInt;
                                        NroAsiento          : LongInt;
                                        PreservaCabecera    : Boolean  = False;
                                        AsientoFacturaTable : TnxeTable = nil ) : Boolean;
begin
     Result := False;
     If   DmAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
     then Result := SuprimeAsiento( DmAsientoFields, PreservaCabecera, AsientoFacturaTable )
end;

function TAsientoModule.SuprimeAsiento( Ejercicio            : SmallInt;
                                        NroAsiento           : LongInt;
                                        TipoAsiento          : SmallInt;
                                        FechaDocumento       : TDate;
                                        SubcuentaPropietario : String;
                                        Serie                : String;
                                        NroDocumento         : LongInt;
                                        NroEfecto            : SmallInt;
                                        PreservaCabecera     : Boolean = False;
                                        AsientoFacturaTable  : TnxeTable = nil ) : Boolean;
begin
     Result := False;
     If   DmAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
     then begin
          CompruebaDocumentoAsiento( DmAsientoFields, TipoAsiento, FechaDocumento, SubcuentaPropietario, Serie, NroDocumento, NroEfecto );
          Result := SuprimeAsiento( DmAsientoFields, PreservaCabecera, AsientoFacturaTable );
          end;
end;

procedure TAsientoModule.ActualizaFactura( Asiento            : IAsiento;
                                           ConceptoFactura    : String;
                                           SubcuentaRetencion : String;
                                           TipoRetencion      : SmallInt;
                                           BaseRetencion,
                                           ImporteRetencion   : Decimal );

var  UltimoNroApunte,
     NroApunteRetencion : SmallInt;

begin
     ActualizaAsiento( Asiento,
     procedure( DeAsiento : TAsientoFields )
       begin

       // No es muy elegante pero si efectivo

       FSubcuentaRetencion := SubcuentaRetencion;
       FTipoRetencion := TipoRetencion;
       FBaseRetencion := BaseRetencion;
       FImporteRetencion := ImporteRetencion;
       FConceptoFactura := ConceptoFactura;

       CompletaAsientoFactura( Asiento, IfThen( Asiento.State=dsInsert, tpaAltaFactura, tpaActualizacionFactura ) );

       end );
end;

procedure TAsientoModule.CompletaAsientoFactura( AsientoFields   : TAsientoFields;
                                                 ConceptoFactura : String;
                                                 Proceso         : TProcesoAsientoFactura = tpaActualizacionLinea );
begin
     FConceptoFactura := ConceptoFactura;
     CompletaAsientoFactura( TAsiento.FromDataset( AsientoFields ), Proceso );
end;

procedure TAsientoModule.CompletaAsientoFactura( Asiento   : IAsiento;
                                                 Proceso   : TProcesoAsientoFactura = tpaActualizacionLinea );

var   NroApunteAutomatico,
      Index : SmallInt;
      SumaBaseyCuotas,
      SumaImporteTotal : Decimal;
      RecordExists : Boolean;
      Cuota : array[ 1..NroMaximoTiposTasas ] of Decimal;
      Fecha : TDate;
      SubcuentaIVASoportado,
      SubcuentaIVARepercutido : String;
      Eos : Boolean;
      ApunteFieldValues : TFieldValuesArray;

begin

     SumaBaseyCuotas := 0.0;
     SumaImporteTotal := 0.0;

     With SessionDataModule, DmApunteTable do
       try

         var TransactionTag := SessionDataModule.StartTransactionWith( [ DmApunteTable ] );

         try

           try

             // En el caso de altas y actualizaciones de la cabecera, siempre uso como valor del concepto el que se sube

             If   not ( Proceso in [ tpaAltaFactura, tpaActualizacionFactura ] )
             then If   DmApunteTable.FindKey( [ Asiento.Ejercicio, Asiento.NroAsiento, 1 ] )
                  then FConceptoFactura := DmApunteFields.Concepto.Value
                  else FConceptoFactura := '';

             FillChar( Cuota, sizeOf( Cuota ), #0 );

             SetRange( [ Asiento.Ejercicio, Asiento.NroAsiento, 2 ], [ Asiento.Ejercicio, Asiento.NroAsiento, MaxSmallInt ] );

             If   Proceso<>tpaActualizacionFactura
             then begin
                  FSubcuentaRetencion := '';
                  FBaseRetencion := 0.0;
                  FTipoRetencion := 0;
                  FImporteRetencion := 0.0;
                  end;

             NroApunteAutomatico := 1;

             // Primero suprimo los posibles apuntes automáticos existentes

             Last;
             While not Bof and ( DmApunteFields.TipoApunte.Value<>tapManual ) do
               begin

               Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, True );

               If   ( Proceso<>tpaActualizacionFactura ) and ( DmApunteFields.TipoApunte.Value=tapRetencion )
               then begin
                    FSubcuentaRetencion := DmApunteFields.Subcuenta.Value;
                    FBaseRetencion := DmApunteFields.BaseImponible.Value;
                    FTipoRetencion := DmApunteFields.Tipo.Value;
                    FImporteRetencion := GetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, { Inverted } Asiento.TipoAsiento=taFraRecibida );
                    end;

               Delete;
               end;

             If   Proceso=tpaActualizacionLinea
             then DeApunteFields.DatasetPost;

             First;
             While not Eof do
               begin

               Edit;
               DmApunteFields.Concepto.Value := FConceptoFactura;

               SumaBaseyCuotas := SumaBaseyCuotas  + DmApunteFields.BaseImponible.Value + DmApunteFields.CuotaIVA.Value + DmApunteFields.CuotaRE.Value;
               SumaImporteTotal := SumaImporteTotal + DmApunteFields.ImporteTotal.Value;

               If   DmApunteFields.Tipo.Value in [ 1..NroMaximoTiposTasas ]
               then Cuota[ DmApunteFields.Tipo.Value ] := Cuota[ DmApunteFields.Tipo.Value ] + DmApunteFields.CuotaIVA.Value + DmApunteFields.CuotaRE.Value;

               NroApunteAutomatico := DmApunteFields.NroApunte.Value;

               // El siguiente cambio solo puede ocurrir si el usuario cambia la Fecha de la factura
               // sin pasar por las lineas

               If   DmApunteFields.Fecha.Value<>Asiento.Fecha
               then begin
                    Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, True );
                    DmApunteFields.Fecha.Value := Asiento.Fecha;
                    Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, False );
                    end;

               If   Asiento.TipoAsiento=taFraEmitida
               then DmApunteFields.Contrapartida.Value := Asiento.Propietario;

               Post;
               Next;
               end;

             Inc( NroApunteAutomatico );

             // Retenciones

             If   FImporteRetencion<>0.0
             then begin

                  Append;

                  DmApunteFields.Ejercicio.Value := Asiento.Ejercicio;
                  DmApunteFields.NroAsiento.Value := Asiento.NroAsiento;
                  DmApunteFields.NroApunte.Value := NroApunteAutomatico;
                  DmApunteFields.Fecha.Value := Asiento.Fecha;
                  DmApunteFields.Subcuenta.Value := FSubcuentaRetencion;
                  DmApunteFields.Contrapartida.Value := Asiento.Propietario;
                  DmApunteFields.Concepto.Value := FConceptoFactura;
                  DmApunteFields.BaseImponible.Value := FBaseRetencion;
                  DmApunteFields.Tipo.Value := FTipoRetencion;

                  SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, FImporteRetencion, Asiento.TipoAsiento=taFraRecibida );

                  DmApunteFields.TipoApunte.Value := tapRetencion;

                  Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, False );

                  Post;

                  Inc( NroApunteAutomatico );

                  end;

             // Cuotas de I.V.A.

             If   Asiento.TipoAsiento=taFraEmitida
             then Fecha := Asiento.Fecha
             else Fecha := Asiento.FechaDocumento;

             For Index := 1 to NroMaximoTiposTasas do
               If   Cuota[ Index ]<>0.0
               then begin

                    Dm10.TasaModule.ObtenSubcuentasIVA( Fecha, Index, SubcuentaIVASoportado, SubcuentaIVARepercutido );

                    Append;

                    DmApunteFields.Ejercicio.Value := Asiento.Ejercicio;
                    DmApunteFields.NroAsiento.Value := Asiento.NroAsiento;
                    DmApunteFields.NroApunte.Value := NroApunteAutomatico;
                    DmApunteFields.Fecha.Value := Asiento.Fecha;

                    If   Asiento.TipoAsiento=taFraEmitida
                    then DmApunteFields.Subcuenta.Value := SubcuentaIVARepercutido
                    else DmApunteFields.Subcuenta.Value := SubcuentaIVASoportado;

                    DmApunteFields.CentroCoste.Value := '';
                    DmApunteFields.Contrapartida.Value := Asiento.Propietario;
                    DmApunteFields.Concepto.Value := FConceptoFactura;

                    SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, Cuota[ Index ], Asiento.TipoAsiento=taFraEmitida );

                    DmApunteFields.Tipo.Value := Index; //** Desde el 02.02.2007
                    DmApunteFields.TipoApunte.Value := tapCuotaIVA;

                    Inc( NroApunteAutomatico );

                    ApunteFieldValues := GetFieldValues;

                    Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, False );

                    Post;

                    //* La gestión de facturas intracomunitarias e inversión del sujeto pasivo

                    If   ( Asiento.TipoAsiento=taFraRecibida ) and ( VarToInteger( Asiento.Origen ) in [ ofrIntracomunitaria, ofrInversionSP ] )
                    then begin

                         Append;
                         SetFieldValues( ApunteFieldValues );

                         DmApunteFields.NroApunte.Value := NroApunteAutomatico;
                         DmApunteFields.Subcuenta.Value := SubcuentaIVARepercutido;

                         SwapFieldValues( DmApunteFields.Debe, DmApunteFields.Haber );

                         Inc( NroApunteAutomatico );

                         Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, False );

                         Post;

                         end;

                    end;

           finally
             CancelRange;
             end;

           // El total de la factura

           If   FindKey( [ Asiento.Ejercicio, Asiento.NroAsiento, 1 ] )
           then begin
                Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, True );
                Edit;
                end
           else Append;

           DmApunteFields.Ejercicio.Value := Asiento.Ejercicio;
           DmApunteFields.NroAsiento.Value := Asiento.NroAsiento;
           DmApunteFields.NroApunte.Value := 1;
           DmApunteFields.Fecha.Value := Asiento.Fecha;
           DmApunteFields.Subcuenta.Value := Asiento.Propietario;
           DmApunteFields.CentroCoste.Value := '';
           DmApunteFields.Contrapartida.Value := '';
           DmApunteFields.Concepto.Value := FConceptoFactura;
           DmApunteFields.TipoApunte.Value := tapManual;

           SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, SumaImporteTotal - FImporteRetencion, Asiento.TipoAsiento=taFraRecibida );

           Dm10.SaldosModule.ActualizaSaldos( Asiento.TipoAsiento, DmApunteFields, False );

           Post;

           TransactionTag.Commit;

         except
           Cancel;
           TransactionTag.Rollback;
           SendNotification( ntError, RsMsg9 , RsMsg10 );
           end;

       finally
         CancelRange;
         end;


end;

procedure TAsientoModule.ActualizaApunteFactura( Asiento : IAsiento;
                                                 Apunte  : IApunte );
begin
     ActualizaApunte( Asiento.TipoAsiento, Apunte,
      procedure( DeApunteFields : TApunteFields )
       begin
       CompletaAsientoFactura( Asiento );
       end );

end;


procedure TAsientoModule.SuprimeApunteFactura( Asiento : IAsiento;
                                               Apunte  : IApunte );

begin
     SuprimeApunte( Apunte.RemoteCursorID,
                    Asiento.Ejercicio,
                    Asiento.NroAsiento,
                    Asiento.TipoAsiento,
                    Apunte.NroApunte,
      procedure( DeApunteFields : TApunteFields )
       begin
       CompletaAsientoFactura( Asiento, tpaBajaLinea );
       end );
end;

procedure TAsientoModule.SuprimeFacturaEmitida( RemoteCursorID : TnxCursorID;
                                                Ejercicio      : SmallInt;
                                                NroAsiento     : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
          then begin
               If   SessionDataModule.Dm10.EfectoCobrarModule.CompruebaEfectos( DmAsientoFields.Ejercicio.Value,
                                                                                DmAsientoFields.Serie.Value,
                                                                                DmAsientoFields.NroFactura.Value,
                                                                                     True )
                    then begin
                         TableCursor.RecordLockRelease( False );
                         SuprimeAsiento( DmAsientoFields );
                         end;
                    end
               else RaiseRecordNotFoundException;
               end
          else RaiseNoCurrentRecordException;
end;


procedure TAsientoModule.SuprimeFacturaRecibida( RemoteCursorID : TnxCursorID;
                                                 Ejercicio      : SmallInt;
                                                 NroAsiento     : Integer );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
     then begin
          If   SessionDataModule.Dm10.EfectoPagarModule.CompruebaEfectos( DmAsientoFields.Ejercicio.Value,
                                                                          DmAsientoFields.Propietario.Value,
                                                                          DmAsientoFields.Serie.Value,
                                                                               True )
               then begin
                    TableCursor.RecordLockRelease( False );
                    SuprimeAsiento( DmAsientoFields );
                    end;
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

function TAsientoModule.SuprimeAsiento( AsientoFields        : TAsientoFields;
                                        TipoAsiento          : SmallInt;
                                        FechaDocumento       : TDate;
                                        SubcuentaPropietario : String;
                                        Serie                : String;
                                        NroDocumento         : LongInt;
                                        NroEfecto            : SmallInt;
                                        PreservaCabecera     : Boolean = False;
                                        AsientoFacturaTable  : TnxeTable = nil ) : Boolean;
begin
     CompruebaDocumentoAsiento( AsientoFields, TipoAsiento, FechaDocumento, SubcuentaPropietario, Serie, NroDocumento, NroEfecto );
     Result := SuprimeAsiento( AsientoFields, PreservaCabecera, AsientoFacturaTable );
end;

function TAsientoModule.SuprimeAsiento( AsientoFields       : TAsientoFields;
                                        PreservaCabecera    : Boolean = False;
                                        AsientoFacturaTable : TnxeTable = nil ) : Boolean;
begin
     Result := False;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ AsientoFields.Table, DmApunteTable ] );

     try

       try
         DmApunteTable.SetRange( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
         DmApunteTable.First;
         While not DmApunteTable.Eof do
           begin
           SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, DmApunteFields, True );
           DmApunteTable.Delete;
           end;
       finally
         DmApunteTable.CancelRange;
         end;

       If   not PreservaCabecera
       then begin
            // Suprimiendo relaciones del asiento
            SessionDataModule.Dm10.FacturaModule.SuprimeRegistroContableFactura( tfAsiento, AsientoFields.NroAsiento.Value, AsientoFacturaTable );
            AsientoFields.Table.Delete;
            end;

       TransactionTag.Commit;

       Result := True;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

function TAsientoModule.CopiaAsiento( Ejercicio  : SmallInt;
                                      NroAsiento : LongInt;
                                      Fecha      : TDate ) : Boolean;

var  NuevoNroAsiento : LongInt;

begin
     Result := False;
     If   DmAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoAuxTable, DmApunteAuxTable ] );

          try

            NuevoNroAsiento := ProximoNroAsiento;   // En esta función utilzo también DmAsientoAuxTable, por eso guardo antes el valor

            DmAsientoAuxTable.Append;

            DmAsientoAuxTable.CopyFields( DmAsientoTable );

            DmAsientoAuxFields.Ejercicio.Value := SessionDataModule.Ejercicio;
            DmAsientoAuxFields.NroAsiento.Value := NuevoNroAsiento;
            DmAsientoAuxFields.Fecha.Value := Fecha;

            DmAsientoAuxTable.Post;

            With DmApunteTable do
              try

                SetRange( [ Ejercicio, NroAsiento ] );

                First;

                While not Eof do
                  begin

                  DmApunteAuxTable.Append;

                  DmApunteAuxTable.CopyFields( DmApunteTable );

                  DmApunteAuxFields.Ejercicio.Value  := DmAsientoAuxFields.Ejercicio.Value;
                  DmApunteAuxFields.NroAsiento.Value := DmAsientoAuxFields.NroAsiento.Value;
                  DmApunteAuxFields.Fecha.Value := DmAsientoAuxFields.Fecha.Value;

                  SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoAuxFields.TipoAsiento.Value, DmApunteAuxFields );

                  DmApunteAuxTable.Post;

                  Next;
                  end;

              finally
                CancelRange;
                end;

            TransactionTag.Commit;

            Result := True;

           except
             TransactionTag.Rollback;

             DmAsientoAuxTable.Cancel;
             DmApunteAuxTable.Cancel;

             SessionDataModule.SendNotification( ntStop, RsErrorCopiaRegistro, RsProcesoInterrumpido );
             end;

          end;
end;


function  TAsientoModule.ObtenDocumento( TipoDocumento,
                                         Ejercicio         : SmallInt;
                                         CodigoPropietario : String;
                                         Serie             : String;
                                         NroFactura        : LongInt;
                                         NroEfecto         : SmallInt = 255;
                                         AsientoFields     : TAsientoFields = nil ) : Boolean;
begin
     Result := False;
     With DmAsientoAuxTable do
       If   TipoDocumento in [ taFraRecibida, taPago ]
       then begin
            IndexFieldNames := 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
            Result := FindKey( [ TipoDocumento, Ejercicio, CodigoPropietario, Serie, NroFactura, NroEfecto ] );
            end
       else begin
            IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';
            Result := FindKey( [ TipoDocumento, Ejercicio, Serie, NroFactura, NroEfecto ] );
            end;
     If   Assigned( AsientoFields )
     then AsientoFields.Update( DmAsientoAuxTable );
end;

function  TAsientoModule.ObtenImportesFactura(     Ejercicio      : SmallInt;
                                                   NroAsiento     : LongInt;
                                               var BaseImponible,
                                                   CuotaIVA,
                                                   CuotaRE,
                                                   ImporteTotal    : Decimal ) : Boolean;
begin
     Result := False;

     BaseImponible := 0.0;
     CuotaIVA := 0.0;
     CuotaRE := 0.0;
     ImporteTotal := 0.0;

     With DmApunteAuxTable do
       try
          IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';
          SetRange( [ Ejercicio, NroAsiento, 2 ], [ Ejercicio, NroAsiento, MaxSmallInt ] );
          First;
          Result := not Eof;
          While not Eof and ( DmApunteAuxFields.TipoApunte.Value=tapManual ) do
            begin
            DecAdd( BaseImponible, DmApunteAuxFields.BaseImponible.Value );
            DecAdd( CuotaIVA, DmApunteAuxFields.CuotaIVA.Value );
            DecAdd( CuotaRE, DmApunteAuxFields.CuotaRE.Value );
            DecAdd( ImporteTotal, DmApunteAuxFields.ImporteTotal.Value );
            Next;
            end;
        finally
          CancelRange;
          end;

end;

procedure TAsientoModule.ActualizaApunte( TipoAsiento                   : TTipoAsiento;
                                          Apunte                        : IApunte;
                                          OnCompletaActualizacionApunte : TOnCompletaActualizacionApunte = nil );

var  TableCursor : TnxServerTableCursor;
     SumaCuotasAnterior : Decimal;

begin

     If   TnxServerTableCursor.LookupByID( Apunte.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          SumaCuotasAnterior := 0.0;
          
          var TransactionTag := SessionDataModule.StartTransactionWith( [ DeApunteTable ] );

          try
            If   Apunte.State=dsEdit
            then If   DeApunteTable.FindKey( [ Apunte.Ejercicio, Apunte.NroAsiento, Apunte.NroApunte ] )
                 then begin
                      TableCursor.RecordLockRelease( False );
                      // DeApunteFields todavía contiene el valor original
                      SumaCuotasAnterior :=  DeApunteFields.CuotaIVA.Value + DeApunteFields.CuotaRE.Value;
                      SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( TipoAsiento, DeApunteFields, True ) 
                      end
                 else RaiseRecordNotFoundException;
                 
            Apunte.ToDataset( DeApunteFields );                                                                  

            // Ahora es cuando se actualizan los saldos con el nuevo contenido
            
            SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( TipoAsiento, DeApunteFields );

            If   Assigned( OnCompletaActualizacionApunte )
            then OnCompletaActualizacionApunte( DeApunteFields )  // El procedimiento debe guardar el registro
            else DeApunteTable.Post;

            TransactionTag.Commit;

          except
            DeApunteTable.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end
     else RaiseNoCurrentRecordException;

end;

function TAsientoModule.ObtenImportesDevengados(     AsientoFacturaFields  : TAsientoFields;
                                                 var BasesImponibles       : TRelacionImportes;
                                                 var Cuotas                : TRelacionImportes ) : Decimal;

// var  ImporteCuota : Decimal;

begin
     Result := 0.0;
     FillChar( Cuotas, SizeOf( Cuotas ), #0 );
     With DmApunteAuxTable do
       try
         IndexFieldNames := 'TipoApunte;EjercicioFactura;Propietario;Serie;NroFactura;NroEfecto';
         With AsientoFacturaFields do
           SetRange( [ tapTraspasoIVA, Ejercicio.Value, Propietario.Value, Serie.Value, NroFactura.Value ] );
         First;
         While not Eof do
           begin
           If   DmApunteAuxFields.Tipo.Value in [ 1..NroMaximoTiposTasas ]
           then begin
                // ImporteCuota := GetSignedValue( DmApunteAuxFields.Debe, DmApunteAuxFields.Haber, AsientoFacturaFields.TipoAsiento.Value=taFraRecibida );
                DecAdd( BasesImponibles[ DmApunteAuxFields.Tipo.Value ], DmApunteAuxFields.BaseImponible.Value );
                DecAdd( Cuotas[ DmApunteAuxFields.Tipo.Value ], DmApunteAuxFields.CuotaIVA.Value );
                DecAdd( Result, DmApunteAuxFields.CuotaIVA.Value );
                end;
           Next;
           end;

       finally
         CancelRange;
         end;

end;

procedure TAsientoModule.CreaApuntesIVADevengado(     AsientoFields         : TAsientoFields;
                                                      ApunteFields          : TApunteFields;
                                                      AsientoFacturaFields  : TAsientoFields;
                                                      NroEfecto             : SmallInt;
                                                      ImporteEfecto         : Decimal;
                                                      TextoConcepto         : String;
                                                  var NroApunte             : SmallInt );

var  CuotaFactura,
     BasePendiente,
     CuotaPendiente,
     BaseImponibleProporcional,
     CuotaIVAProporcional,
     TotalCuotaDevengada,
     DiferenciaBase,
     DiferenciaCuota,
     ImporteFactura : Decimal;
     SubcuentaIVASoportado,
     SubcuentaIVARepercutido,
     SubcuentaIVA,
     SubcuentaIVACaja : String;
     Index : SmallInt;
     BasesImponibles,
     Cuotas,
     BasesImponiblesDevengadas,
     CuotasDevengadas : TRelacionImportes;

begin
     If   YearOf( AsientoFacturaFields.Fecha.Value )>=2014   // Antes de esa fecha no existe el criterio de caja
     then With SessionDataModule do
            begin

            var TransactionTag := SessionDataModule.StartTransactionWith( [ ApunteFields.Table ] );

            try

              CuotaFactura := 0.0;
              ImporteFactura := 0.0;

              FillChar( BasesImponibles, SizeOf( BasesImponibles ), #0 );
              FillChar( Cuotas, SizeOf( Cuotas ), #0 );

              With DmApunteAuxTable do
                try
                   IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';
                   With AsientoFacturaFields do
                     SetRange( [ Ejercicio.Value, NroAsiento.Value, 1 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );
                   First;
                   While not Eof  do
                     begin

                     // Es muy importante obtener el importe de la factura del total del asiento y no de la suma de los
                     // importes de cada línea manual, porque la factura puede tener retenciones que minoran su importe total

                     If   DmApunteAuxFields.NroApunte.Value=1
                     then ImporteFactura := GetSignedValue( DmApunteAuxFields.Debe, DmApunteAuxFields.Haber, AsientoFacturaFields.TipoAsiento.Value=taFraRecibida )
                     else If   ( DmApunteAuxFields.TipoApunte.Value=tapManual ) and
                               ( DmApunteAuxFields.Tipo.Value in [ 1..NroMaximoTiposTasas ] )
                          then begin
                               DecAdd( BasesImponibles[ DmApunteAuxFields.Tipo.Value ], DmApunteAuxFields.BaseImponible.Value );
                               DecAdd( Cuotas[ DmApunteAuxFields.Tipo.Value ], DmApunteAuxFields.CuotaIVA.Value );
                               DecAdd( CuotaFactura, DmApunteAuxFields.CuotaIVA.Value );
                               end;
                     Next;
                     end;
                finally
                  CancelRange;
                  end;

            TotalCuotaDevengada := ObtenImportesDevengados( AsientoFacturaFields, BasesImponiblesDevengadas, CuotasDevengadas );
            CuotaPendiente := CuotaFactura - TotalCuotaDevengada;

              If   CuotaPendiente<>0
              then begin

                   For Index := 1 to NroMaximoTiposTasas do
                     If   Cuotas[ Index ]<>0.0
                     then begin

                          Dm10.TasaModule.ObtenSubcuentasIVA( AsientoFacturaFields.Fecha.Value, Index, SubcuentaIVASoportado, SubcuentaIVARepercutido );

                          If   AsientoFacturaFields.TipoAsiento.Value=taFraRecibida
                          then begin
                               SubcuentaIVA := SubcuentaIVASoportado;
                               SubcuentaIVACaja := '4721' + Copy( SubcuentaIVA, 5, 5 );
                               Dm10.CuentaModule.CreaSubcuentaDefecto( cpCtaIVASoportadoPagado, SubcuentaIVACaja );
                               end
                          else begin
                               SubcuentaIVA := SubcuentaIVARepercutido;
                               SubcuentaIVACaja := '4771' + Copy( SubcuentaIVA, 5, 5 );
                               Dm10.CuentaModule.CreaSubcuentaDefecto( cpCtaIVARepercutidoCobrado, SubcuentaIVACaja );
                               end;

                          BaseImponibleProporcional := Redondea( ( BasesImponibles[ Index ] * ImporteEfecto ) / ImporteFactura );
                          CuotaIVAProporcional := Redondea( ( Cuotas[ Index ] * ImporteEfecto ) / ImporteFactura );

                          // Si la diferencia es menor de un céntimo es porque hay un descuadre por fraccionar las cuotas (ccts)

                          BasePendiente := BasesImponibles[ Index ] - BasesImponiblesDevengadas[ Index ];
                          DiferenciaBase := Abs( BaseImponibleProporcional - BasePendiente );
                          If   ( DiferenciaBase<>0.0 ) and ( DiferenciaBase<=0.01 )
                          then BaseImponibleProporcional := BasePendiente;

                          CuotaPendiente := Cuotas[ Index ] - CuotasDevengadas[ Index ];
                          DiferenciaCuota := Abs( CuotaIVAProporcional - CuotaPendiente );
                          If   ( DiferenciaCuota<>0.0 ) and ( DiferenciaCuota<=0.01 )                // La comparación con 0.0 es innecesaria pero me sirve para saber cuando hay descuadre (debug)
                          then CuotaIVAProporcional := CuotaPendiente;

                          ApunteFields.Table.Append;

                          ApunteFields.Ejercicio.Value := AsientoFields.Ejercicio.Value;
                          ApunteFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                          ApunteFields.NroApunte.Value := NroApunte;
                          ApunteFields.Fecha.Value := AsientoFields.Fecha.Value;
                          ApunteFields.Subcuenta.Value := SubcuentaIVA;
                          ApunteFields.Contrapartida.Value := SubcuentaIVACaja;
                          ApunteFields.Concepto.Value := TextoConcepto;

                          // Los datos del efecto que ha generado este apunte de pago o cobro parcial solo se incluyen en el primer apunte

                          ApunteFields.TipoApunte.Value := tapTraspasoIVA;
                          ApunteFields.EjercicioFactura.Value := AsientoFacturaFields.Ejercicio.Value;
                          ApunteFields.Propietario.Value := AsientoFacturaFields.Propietario.Value;
                          ApunteFields.Serie.Value := AsientoFacturaFields.Serie.Value;
                          ApunteFields.NroFactura.Value := AsientoFacturaFields.NroFactura.Value;
                          ApunteFields.NroEfecto.Value := NroEfecto;

                          ApunteFields.Tipo.Value := Index;
                          ApunteFields.BaseImponible.Value := BaseImponibleProporcional;
                          ApunteFields.CuotaIVA.Value := CuotaIVAProporcional;
                          ApunteFields.ImporteTotal.Value := BaseImponibleProporcional + CuotaIVAProporcional;

                          SetSignedValue( ApunteFields.Debe, ApunteFields.Haber, CuotaIVAProporcional, AsientoFacturaFields.TipoAsiento.Value=taFraRecibida );

                          Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                          ApunteFields.Table.Post;

                          Inc( NroApunte );

                          ApunteFields.Table.Append;

                          ApunteFields.Ejercicio.Value := AsientoFields.Ejercicio.Value;
                          ApunteFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                          ApunteFields.NroApunte.Value := NroApunte;
                          ApunteFields.Fecha.Value := AsientoFields.Fecha.Value;
                          ApunteFields.Subcuenta.Value := SubcuentaIVACaja;
                          ApunteFields.CentroCoste.Value := '';
                          ApunteFields.Contrapartida.Value := SubcuentaIVA;
                          ApunteFields.Concepto.Value := TextoConcepto;

                          SetSignedValue( ApunteFields.Debe, ApunteFields.Haber, CuotaIVAProporcional, AsientoFacturaFields.TipoAsiento.Value=taFraEmitida );

                          Dm10.SaldosModule.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                          ApunteFields.Table.Post;

                          Inc( NroApunte );

                          end;

                     end;

              TransactionTag.Commit;

            except
              ApunteFields.Table.Cancel;
              TransactionTag.Rollback;
              raise;
              end;

            end;
end;

function TAsientoModule.ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;

var  FechaInicial : TDate;

begin
     Result := False;
     If   Ejercicio=0
     then Ejercicio := SessionDataModule.Ejercicio;
     FechaInicial := EncodeDate( Ejercicio, 1, 1 );
     With SQLQuery do
       try
         SQL.Text := 'SELECT NroAsiento ' +
                     'FROM   Apunte ' +
                     'WHERE  EjercicioFactura=' + StrInt( Ejercicio ) + ' AND ' +
                     '       TipoApunte=' + IntToStr( tapTraspasoIVA ) + ' AND ' +
                     '       SUBSTRING( Propietario FROM 1 FOR 2 )=''43''';
         Open;
         Result := RecordCount>0;
       finally
         Close;
         end;
end;


procedure TAsientoModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

function TAsientoModule.TrimestreCorrecto( AMonth : SmallInt ) : Boolean;
begin
     If   SessionDataModule.EmpresaFields.Contable_BloqueoTrim.Value
     then Result := ( Pred( AMonth ) div 3 )=( Pred( MonthOf( SessionDataModule.FechaHoy ) ) div 3 )
     else Result := True;
end;

function  TAsientoModule.EjercicioCerrado : Boolean;
begin
     With DmAsientoAuxTable do
       begin
       IndexFieldNames := 'TipoAsiento;Ejercicio;NroRegistro';
       Result := FindEqualFirst( [ taCierre, SessionDataModule.Ejercicio ] );
       end;
end;


function TAsientoModule.ImporteCobrosEfectivo( Subcuenta      : String;
                                               FechaInicial,
                                               FechaFinal     : TDateTime;
                                               Cargos         : Boolean ) : Decimal;

var  Importe : Decimal;
     CampoImporte : String;
     ImporteField : TBCDField;

begin
     Result := 0.0;
     With SQLQuery do
       begin
       If   Cargos
       then CampoImporte := 'Debe'
       else CampoImporte := 'Haber';
       Close;
       SQL.Text := 'SELECT SUM( ' + CampoImporte + ' ) AS Importe ' +
                   'FROM Apunte ' +
                   'WHERE FECHA BETWEEN ' + SQLDateString( FechaInicial ) + ' AND ' +  SQLDateString( FechaFinal ) + ' ' +
                   '      AND Subcuenta=' + QuotedStr( Subcuenta ) + ' AND SUBSTRING( Contrapartida FROM 1 FOR 3 )=''570''';
       Open;
       try
         If   not Eof
         then begin
              ImporteField := SQLQuery.FieldByName( 'Importe' ) as TBCDField;
              If   Assigned( ImporteField )
              then begin
                   Importe := ImporteField.Value;
                   If   Importe>=6000
                   then Result := Importe;
                   end;
              end;
       finally
         Close;
         end;
       end;
end;

{ TAsientoService }

procedure TAsientoService.ActualizaAsiento( Asiento : IAsiento );
begin
     SessionDataModule.Dm10.AsientoModule.ActualizaAsiento( Asiento );
end;

procedure TAsientoService.ActualizaApunte( TipoAsiento : TTipoAsiento; Apunte : IApunte );
begin
     SessionDataModule.Dm10.AsientoModule.ActualizaApunte( TipoAsiento, Apunte );
end;

procedure TAsientoService.ActualizaFactura( Asiento            : IAsiento;
                                            ConceptoFactura    : String;
                                            SubcuentaRetencion : String;
                                            TipoRetencion      : SmallInt;
                                            BaseRetencion,
                                            ImporteRetencion   : Decimal );
begin
     SessionDataModule.Dm10.AsientoModule.ActualizaFactura( Asiento, ConceptoFactura, SubcuentaRetencion, TipoRetencion, BaseRetencion, ImporteRetencion );
end;

procedure TAsientoService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;



function TAsientoService.ExisteAsientoContador( NroAsiento : Integer ): Boolean;
begin
     Result := SessionDataModule.Dm10.AsientoModule.ExisteAsientoContador( NroAsiento );
end;

function TAsientoService.ImporteCobrosEfectivo( Subcuenta: String; FechaInicial, FechaFinal : TDateTime; Cargos : Boolean ) : Decimal;
begin
     Result := SessionDataModule.Dm10.AsientoModule.ImporteCobrosEfectivo( Subcuenta, FechaInicial, FechaFinal, Cargos );
end;

function TAsientoService.ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;
begin
     Result := SessionDataModule.Dm10.AsientoModule.ExistenApuntesTraspasoIVA( Ejercicio );
end;

function TAsientoService.ObtenImportesFactura( Ejercicio : SmallInt; NroAsiento : LongInt; var BaseImponible, CuotaIVA, CuotaRE, ImporteTotal : Decimal ) : Boolean;
begin
     Result := SessionDataModule.Dm10.AsientoModule.ObtenImportesFactura( Ejercicio, NroAsiento, BaseImponible, CuotaIVA, CuotaRE, ImporteTotal );
end;

function TAsientoService.ProximoNroAsiento: LongInt;
begin
     Result := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
end;

function TAsientoService.ProximoNroRegistro( TipoDocumento : SmallInt;
                                             ResetCounter  : Boolean ) : LongInt;
begin
     Result := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( TipoDocumento, ResetCounter );
end;

procedure TAsientoService.SuprimeApunte( RemoteCursorID : TnxCursorID;
                                         Ejercicio      : SmallInt;
                                         NroAsiento     : LongInt;
                                         TipoAsiento    : TTipoAsiento;
                                         NroApunte   : SmallInt );
begin
     SessionDataModule.Dm10.AsientoModule.SuprimeApunte( RemoteCursorID, Ejercicio, NroAsiento, TipoAsiento, NroApunte );
end;

function TAsientoService.SuprimeAsiento( Ejercicio        : SmallInt;
                                         NroAsiento       : LongInt;
                                         PreservaCabecera : Boolean  = False ) : Boolean;
begin
     Result := SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( Ejercicio, NroAsiento, PreservaCabecera );
end;

function TAsientoService.SuprimeAsiento( Ejercicio            : SmallInt;
                                         NroAsiento           : Integer;
                                         TipoAsiento          : SmallInt;
                                         FechaDocumento       : TDate;
                                         SubcuentaPropietario,
                                         Serie                : String;
                                         NroDocumento         : Integer;
                                         NroEfecto            : SmallInt;
                                         PreservaCabecera     : Boolean = False ) : Boolean;
begin
     Result := SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( Ejercicio, NroAsiento, TipoAsiento, FechaDocumento, SubcuentaPropietario, Serie, NroDocumento, NroEfecto, PreservaCabecera );
end;

procedure TAsientoService.SuprimeFacturaEmitida( RemoteCursorID: TnxCursorID; Ejercicio: SmallInt; NroAsiento: Integer);
begin
     SessionDataModule.Dm10.AsientoModule.SuprimeFacturaEmitida( RemoteCursorID, Ejercicio, NroAsiento );
end;

procedure TAsientoService.SuprimeFacturaRecibida( RemoteCursorID: TnxCursorID; Ejercicio: SmallInt; NroAsiento: Integer);
begin
     SessionDataModule.Dm10.AsientoModule.SuprimeFacturaRecibida( RemoteCursorID, Ejercicio, NroAsiento );
end;

procedure TAsientoService.ActualizaApunteFactura( Asiento : IAsiento; Apunte : IApunte );
begin
     SessionDataModule.Dm10.AsientoModule.ActualizaApunteFactura( Asiento, Apunte );
end;

procedure TAsientoService.SuprimeApunteFactura( Asiento : IAsiento; Apunte : IApunte );
begin
     SessionDataModule.Dm10.AsientoModule.SuprimeApunteFactura( Asiento, Apunte );
end;

procedure TAsientoService.SuprimeAsiento( RemoteCursorID : TnxCursorID;
                                          Ejercicio      : SmallInt;
                                          NroAsiento     : LongInt );
begin
     SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( RemoteCursorID, Ejercicio, NroAsiento );
end;

function TAsientoService.CopiaAsiento( Ejercicio  : SmallInt;
                                       NroAsiento : Integer;
                                       Fecha      : TDate) : Boolean;
begin
     Result := SessionDataModule.Dm10.AsientoModule.CopiaAsiento( Ejercicio, NroAsiento, Fecha );
end;

var AsientoControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_AsientoService, TAsientoService, AsientoControl );

end.


