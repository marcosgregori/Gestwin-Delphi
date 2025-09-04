unit dm_upd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  DB, nxdb,

  AppContainer, AppForms, DataManager,

  EnterpriseDataAccess,
  Gdm00Dm;


type
  TOnUpdateDatabaseProgressEvent = function( TableName : String; Index, Count : SmallInt ) : Boolean of object;

  TActualizacionModule = class(TDataModule)
    AsientoTable: TnxeTable;
    AsientoTableEjercicio: TSmallintField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ExecuteProcess;
    function DoUpdateDatabaseProgress(TableName: String; Index,
      Count: SmallInt): Boolean;

  public
    procedure UpdateDemoDatabase;
    procedure UpdateDatabase( CodigoEmpresa : String );
  end;

var  ActualizacionModule: TActualizacionModule = nil;

function Actualizacion : TActualizacionModule;

implementation

uses LibUtils,

     AppManager,
     DateUtils,

     nxllTypes,

     b_msg,
     b_pro,

     DataAccess,
     NexusRpcData,

     dm_emp,
     dm_pga,

     f_prg;

{$R *.dfm}
resourceString
     RsMsg1  = 'Actualizando la Empresa de demostración.';
     RsMsg2  = 'La Empresa de demostración se actualiza para que, entre otras cosas, los datos de ejemplo hagan referencia al ejercicio actual.';
     RsMsg3  = 'No existe el registro de la Empresa de demostración. No se relizará ningun proceso.';
     RsMsg4  = 'Ajustando el ejercicio y las fechas de los registros.';
     RsMsg5  = 'No se ha podido ajustar el ejercicio en los registros. Compruebe que los movimientos de ejemplo estén en el ejercicio activo.';
     RsMsg6  = 'Ajuste de la Empresa de demostración';
     RsMsg7  = 'Ésta es la primera vez que accede a la Empresa de demostración.'#13'Se va a proceder a revisar los ficheros y a ajustar la fecha de los registros para que coincida con el ejercicio actual.';

function Actualizacion : TActualizacionModule;
begin
     CreateDataModule( TActualizacionModule, ActualizacionModule );
     Result := ActualizacionModule;
end;

procedure TActualizacionModule.UpdateDatabase( CodigoEmpresa : String );
begin
     NexusRpc.UpdateDatabase( CodigoEmpresa );
end;

procedure TActualizacionModule.UpdateDemoDatabase;
begin
     ShowNotification( ntInformation, RsMsg6, RsMsg7 );
     CreateProcessForm( ExecuteProcess, RsMsg1, { Cancellable } False );
end;

procedure TActualizacionModule.DataModuleDestroy(Sender: TObject);
begin
     ActualizacionModule := nil;
end;

function TActualizacionModule.DoUpdateDatabaseProgress( TableName : String;
                                                        Index,
                                                        Count     : SmallInt ) : Boolean;
begin
     If   Assigned( ProcessFrame )
     then With ProcessFrame do
            begin
            ProgressBar.Position := ( Succ( Index ) * 100 ) div Succ( Count );
            Result := Canceled;
            end
     else Result := False;
end;

procedure TActualizacionModule.ExecuteProcess;

var   EjercicioReferencia : SmallInt;
      VentanaInicio,
      Intervalo : SmallInt;
      SoloContable : Boolean;
      SQLResult : TnxDynVariantArray;

begin
     With ProcessFrame, DataModule00 do
       begin

       AddMsg( ntInformation, RsMsg2 );

       If   not DmEmpresaTable.FindKey( [ '999' ] )
       then AddMsg( ntError, RsMsg3 )
       else With EnterpriseDataModule do
              begin

              // Personalizo un poco cada aplicaci�n

              VentanaInicio := 1;                               // Asientos
              If   AppShortName='TPV'
              then VentanaInicio := 13                          // Tickets de venta
              else If   ( AppShortName='ContableComercial' ) or
                        ( AppShortName='Comercial' ) or
                        ( AppShortName='Preventa' )
                   then VentanaInicio := 11;                    // Albaranes de venta

              SoloContable := AppShortName='Contable';

              If   DmUsuarioTable.FindKey( [ '01' ] )
              then try
                     DmUsuarioTable.Edit;
                     DmUsuarioFields.VentanaInicio.Value := VentanaInicio;
                     DmUsuarioTable.Post;
                   except
                     DmUsuarioTable.Cancel;
                     raise;
                     end;

              try

                ShowProgressBar;

                UpdateDatabase( '999' );

                // Ahora actualizo los campos espec�ficos de un ejercicio

                With UserDatabase, EnterpriseDataModule do
                  try

                    AsientoTable.Open;
                    AsientoTable.Last;
                    If   AsientoTable.Found
                    then begin
                         EjercicioReferencia := AsientoTableEjercicio.Value;
                         Intervalo := YearOf( ApplicationContainer.TodayDate ) - EjercicioReferencia;
                         If   Intervalo<>0
                         then begin

                              AddMsg( ntInformation, RsMsg4 );

                              StartTransaction;

                              ExecQuery( Format( 'UPDATE Asiento SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR, FechaDocumento=FechaDocumento+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE Apunte SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE EfectoCobrar SET Ejercicio=Ejercicio+%0:d, FechaVencimiento=FechaVencimiento+INTERVAL ''%0:d'' YEAR, FechaCobro=FechaCobro+INTERVAL ''%0:d'' YEAR, FechaEmision=FechaEmision+INTERVAL ''%0:d'' YEAR, ' +
                                         'FechaLibramiento=FechaLibramiento+INTERVAL ''%0:d'' YEAR, FechaEmision=FechaEmision+INTERVAL ''%0:d'' YEAR, ' +
                                         'FechaCancelacion=FechaCancelacion+INTERVAL ''%0:d'' YEAR, FechaImpagado=FechaImpagado+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE EfectoPagar SET Ejercicio=Ejercicio+%0:d, FechaVencimiento=FechaVencimiento+INTERVAL ''%0:d'' YEAR, FechaPago=FechaPago+INTERVAL ''%0:d'' YEAR, FechaEmision=FechaEmision+INTERVAL ''%0:d'' YEAR, ' +
                                         'FechaLibramiento=FechaLibramiento+INTERVAL ''%0:d'' YEAR, FechaEmision=FechaEmision+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE MovimientoCaja SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE Remesa SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR, FechaVtoInicial=FechaVtoInicial+INTERVAL ''%0:d'' YEAR, FechaVtoFinal=FechaVtoFinal+INTERVAL ''%0:d'' YEAR, ' +
                                         'FechaCobro=FechaCobro+INTERVAL ''%0:d'' YEAR, FechaAceptacion=FechaAceptacion+INTERVAL ''%0:d'' YEAR, FechaDescuento=FechaDescuento+INTERVAL ''%0:d'' YEAR, FechaCancelacion=FechaCancelacion+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE RemesaPago SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR, FechaVtoInicial=FechaVtoInicial+INTERVAL ''%0:d'' YEAR, FechaVtoFinal=FechaVtoFinal+INTERVAL ''%0:d'' YEAR, ' +
                                         'FechaPago=FechaPago+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                              ExecQuery( Format( 'UPDATE Saldos SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                              // ExecQuery( Format( 'UPDATE TiposIVA SET Ejercicio=Ejercicio+%0:d WHERE Ejercicio=%1:d', [ Intervalo, EjercicioReferencia ] );

                              If   not SoloContable
                              then begin
                                   ExecQuery( Format( 'UPDATE ArticuloDatEcon SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE ClienteDatEcon SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE ConsumoCompras SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE ConsumosCliente SET Fecha=Fecha+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE ConsumoVentas SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE Efecto SET Ejercicio=Ejercicio+%0:d, FechaFactura=FechaFactura+INTERVAL ''%0:d'' YEAR, FechaVencimiento=FechaVencimiento+INTERVAL ''%0:d'' YEAR, FechaEmision=FechaEmision+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE FacturaCompras SET Ejercicio=Ejercicio+%0:d, FechaRecepcion=FechaRecepcion+INTERVAL ''%0:d'' YEAR, Fecha=Fecha+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE FacturaVentas SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR, FechaValor=FechaValor+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE GrupoLineaMovimiento SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE LineaMovimiento SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE Movimiento SET Ejercicio=Ejercicio+%0:d, Fecha=Fecha+INTERVAL ''%0:d'' YEAR, FechaAplicacion=FechaAplicacion+INTERVAL ''%0:d'' YEAR, FechaEmision=FechaEmision+INTERVAL ''%0:d'' YEAR, FechaAuxiliar=FechaAuxiliar+INTERVAL ''%0:d'' YEAR, ' +
                                                      'EjercicioFactura=EjercicioFactura+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE ProveedorDatEcon SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE Stock SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   ExecQuery( Format( 'UPDATE VendedorDatEcon SET Ejercicio=Ejercicio+%0:d', [ Intervalo ] ) );
                                   end;

                              Commit;
                              end;
                         end;

                       except
                         Rollback;
                         AddMsg( ntError, RsMsg5 );
                         Abort;
                         end;

              finally
                HideProgressBar;
                AsientoTable.Close;

                end;

              With Configuracion do
                begin
                Configuracion.ParametrosGlbRec.EmpresaDemostracionActualizada := True;
                GuardaParametrosGlobales( ParametrosGlbRec );
                ActualizaParametros( True );
                end;

              CloseAllDataModules;  // Por si acaso
              end;

       end;
end;

end.
