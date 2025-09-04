
unit dm_mdc;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB, nxDB,

  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields;

type

  TTipoOperacionCaja = ( mcIngreso, mcPago );

  TMovimientoCajaModule = class(TServerDataModule)
    DmMovimientoCajaTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    DmMovimientoCajaFields : TMovimientoCajaFields;
    DmAsientoFields : TAsientoFields;
    DmApunteFields : TApunteFields;

    FormaCobroFields : TFormaCobroFields;
    ClienteFields : TClienteFields;
    ProveedorFields : TProveedorFields;

  public

    function  DescripcionTipoOperacion( TipoOperacion : TTipoOperacionCaja ) : string;
    function  ProximoNroOperacion( Serie : String ) : longInt;
    procedure Contabiliza( SerieInicial, SerieFinal : String; FechaInicial, FechaFinal : TDateTime );
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     AppManager,
     SessionData,

     nxrbTypes,
     nxrdClass,

     Gim00Fields,

     dmi_ast,

     dm_fco,
     dm_ast,
     dm_cli,
     dm_pro,
     dm_sub,
     dm_sal;

{$R *.DFM}

resourceString
     RsMsg1  = 'N/Factura nº %d';

procedure TMovimientoCajaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmMovimientoCajaFields := TMovimientoCajaFields.Create( DmMovimientoCajaTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );

     FormaCobroFields := TFormaCobroFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
end;

procedure TMovimientoCajaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.MovimientoCajaModule := nil;
end;

function TMovimientoCajaModule.DescripcionTipoOperacion( TipoOperacion : TTipoOPeracionCaja ) : string;

const StrTipo : array[ 0..1 ] of String = ( 'Ingreso en caja',
                                            'Pago por caja' );
begin
     Result := StrTipo[ Ord( TipoOperacion ) ];
end;

function TMovimientoCajaModule.ProximoNroOperacion( Serie : String ) : longInt;
begin

     // Cuidado, esta operacion no preserva el contenido del registro

     With DmMovimientoCajaTable do
       begin
       IndexFieldNames := 'Ejercicio;Serie;NroOperacion';
       If   FindEqualFirst( [ SessionDataModule.Ejercicio, Serie ] )
       then Result := DmMovimientoCajaFields.NroOperacion.Value + 1
       else Result := 1;
       end;
end;

procedure TMovimientoCajaModule.Contabiliza( SerieInicial,
                                             SerieFinal     : String;
                                             FechaInicial,
                                             FechaFinal     : TDateTime );

var   SubcuentaCaja : String;

procedure ContabilizaMovimiento( MovimientoCajaFields : TMovimientoCajaFields );

var   ExisteAsiento : Boolean;
      SubcuentaPropietario,
      SubcuentaCargo,
      SubcuentaAbono : String;
      ApunteFields : TFieldValuesArray;

begin

     If   SessionDataModule.EmpresaFields.Cliente_CanalSerie.Value
     then SubcuentaCaja := '57' + LeftPad( MovimientoCajaFields.Serie.Value, 7 )
     else SubcuentaCaja := '570000000';

     If   not ValueIsEmpty( MovimientoCajaFields.FormaCobro.Value )
     then If   SessionDataModule.Dm10.FormaCobroModule.Obten( MovimientoCajaFields.FormaCobro.Value, FormaCobroFields )
          then If   FormaCobroFields.NoContabilizar.Value
               then Exit;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, DmMovimientoCajaTable ] );

     try

       DmMovimientoCajaTable.Edit;

       If   ValueIsEmpty( MovimientoCajaFields.NroAsiento.Value ) or not MovimientoCajaFields.Contabilizado.Value
       then begin
            MovimientoCajaFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
            ExisteAsiento := False;
            end
       else begin
            ExisteAsiento := DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, MovimientoCajaFields.NroAsiento.Value ] );
            If   ExisteAsiento
            then begin
                 If   not SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( MovimientoCajaFields.Ejercicio.Value,
                                                                               MovimientoCajaFields.NroAsiento.Value,
                                                                               taMovimientoCaja,
                                                                               MovimientoCajaFields.Fecha.Value,
                                                                               MovimientoCajaFields.Propietario.Value,
                                                                               MovimientoCajaFields.Serie.Value,
                                                                               MovimientoCajaFields.NroOperacion.Value,
                                                                               0 )
                 then MovimientoCajaFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
                 end
            else MovimientoCajaFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
            end;

       With DmAsientoTable do
         If   ExisteAsiento
         then Edit
         else Append;

       DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       DmAsientoFields.NroAsiento.Value := MovimientoCajaFields.NroAsiento.Value;
       DmAsientoFields.TipoAsiento.Value := taMovimientoCaja;
       DmAsientoFields.Fecha.Value := MovimientoCajaFields.Fecha.Value;
       DmAsientoFields.FechaDocumento.Value := MovimientoCajaFields.Fecha.Value;
       DmAsientoFields.Serie.Value := MovimientoCajaFields.Serie.Value;
       DmAsientoFields.NroFactura.Value := MovimientoCajaFields.NroOperacion.Value;
       DmAsientoFields.Propietario.Value := MovimientoCajaFields.Propietario.Value;

       case TTipoOperacionCaja( MovimientoCajaFields.TipoOperacion.Value ) of
         mcIngreso : begin
                     SessionDataModule.Dm10.ClienteModule.Obten( MovimientoCajaFields.Propietario.Value, ClienteFields );
                     SubcuentaPropietario := ClienteFields.Subcuenta.Value;
                     DmAsientoFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( SubcuentaPropietario, True, False );
                     end;
         mcPago    : begin
                     SessionDataModule.Dm10.ProveedorModule.Obten( MovimientoCajaFields.Propietario.Value, ProveedorFields );
                     SubcuentaPropietario := ProveedorFields.Subcuenta.Value;
                     DmAsientoFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( SubcuentaPropietario, True, False );
                     end;
         end;

       DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( DmAsientoFields.TipoAsiento.Value );

       DmAsientoTable.Post;

       With DmApunteTable do
         begin

         Append;

         DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
         DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
         DmApunteFields.NroApunte.Value := 1;
         DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

         case TTipoOperacionCaja( MovimientoCajaFields.TipoOperacion.Value ) of
           mcIngreso : If   MovimientoCajaFields.Importe.Value>0.0
                       then begin
                            SubcuentaCargo := SubcuentaCaja;
                            SubcuentaAbono := SubcuentaPropietario;
                            end
                       else begin
                            SubcuentaCargo := SubcuentaPropietario;
                            SubcuentaAbono := SubcuentaCaja;
                            end;

           mcPago    : If   MovimientoCajaFields.Importe.Value>0.0
                       then begin
                            SubcuentaCargo := SubcuentaPropietario;
                            SubcuentaAbono := SubcuentaCaja;
                            end
                       else begin
                            SubcuentaCargo := SubcuentaCaja;
                            SubcuentaAbono := SubcuentaPropietario;
                            end;
           end;


         DmApunteFields.Subcuenta.Value := SubcuentaCargo;
         DmApunteFields.Contrapartida.Value := SubcuentaAbono;
         DmApunteFields.Concepto.Value := MovimientoCajaFields.Descripcion.Value;
         DmApunteFields.Debe.Value := Abs( MovimientoCajaFields.Importe.Value );
         DmApunteFields.Haber.Value := 0.0;

         SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );

         Post;

         ApunteFields := GetFieldValues;
         Append;
         SetFieldValues( ApunteFields );

         DmApunteFields.NroApunte.Value := 2;
         DmApunteFields.Subcuenta.Value := SubcuentaAbono;
         DmApunteFields.Contrapartida.Value := SubcuentaCargo;
         DmApunteFields.Debe.Value := 0.0;
         DmApunteFields.haber.Value := Abs( MovimientoCajaFields.Importe.Value );

         SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );

         Post;

         end;

       MovimientoCajaFields.Contabilizado.Value := True;

       DmMovimientoCajaTable.Post;

       TransactionTag.Commit;

     except
       DmApunteTable.Cancel;
       DmMovimientoCajaTable.Cancel;
       TransactionTag.Rollback;
       raise;
       end;

end;

begin

     With DmMovimientoCajaTable do
       try
         IndexFieldNames := 'Serie;Fecha';
         SetRange( [ SerieInicial, FechaInicial ], [ SerieFinal, FechaFinal ] );
         First;
         While not Eof do
           begin
           If   not DmMovimientoCajaFields.Contabilizado.Value
           then ContabilizaMovimiento( DmMovimientoCajaFields );
           Next;
           end;
       finally
         CancelRange;
         end;
end;

end.

