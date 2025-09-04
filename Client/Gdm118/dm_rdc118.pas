unit dm_rdc118;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, System.Generics.Collections,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  AppForms, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
  cxNavigator, cxCheckBox, cxVGrid, cxDBVGrid, cxInplaceContainer, cxLabel,
  cxCheckGroup, cxDBCheckGroup, cxCheckComboBox, cxDBCheckComboBox,

  Gim10Fields,
  Gim30Fields,

  dmi_mov;

type
  TFerroDataModule = class(TDataModule)
    DmFacturaComprasTable: TnxeTable;
    DmEfectoPagarTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    DmAsientoFields : TAsientoFields;
    DmFacturaComprasFields : TFacturaComprasFields;
    DmEfectoPagarFields : TEfectoPagarFields;
    DsProveedorFields : TProveedorFields;
    DsClienteFields : TClienteFields;

    procedure CompruebaEfecto( EfectoPagarFields: TEfectoPagarFields; MuestraDatosEfecto : Boolean = False );

  protected

   procedure DoOnAfterEditEfectoPagar;
   procedure DoOnAfterEditRemesaPago;
   procedure DoOnCambiaEstadoEfecto( EfectoPagarFields : TEfectoPagarFields );
   procedure DoBeforeUpdateMovimiento( TipoMovimiento : TTipoMovimiento; CodigoPropietario : String );

  public

  end;

var FerroDataModule : TFerroDataModule = nil;

implementation

uses Math,
     EnterpriseDataAccess,
     AppManager,
     LibUtils,
     Files,

     dmi_ast,

     dm_pro,
     dm_cli,
     dm_mov,

     a_ape,
     a_rdp,
     a_par,

     b_cma;

{$R *.dfm}

resourceString
     RsPagoBloqueado = 'El pago está bloqueado';
     RsPagoBloqueadoEfecto = 'El pago del efecto %s - %d del proveedor %s está bloqueado.';
     RsClienteBloqueado = 'Este cliente tiene bloqueadas las entregas de material.';

function Ferro : TFerroDataModule;
begin
     CreateDataModule( TFerroDataModule, FerroDataModule );
     Result := FerroDataModule;
end;

procedure SetupMntApeForm;
begin
     If   Assigned( MntApeForm ) and
          Assigned( FerroDataModule  )
     then MntApeForm.OnAfterEditEfectoPagar := FerroDataModule.DoOnAfterEditEfectoPagar;
end;

procedure SetupMntRdpForm;
begin
     If   Assigned( MntRdpForm ) and
          Assigned( FerroDataModule  )
     then MntRdpForm.OnCambiaEstadoEfecto.Add( FerroDataModule.DoOnCambiaEstadoEfecto );
end;

procedure SetupMntParForm;
begin
     If   Assigned( MntParForm ) and
          Assigned( FerroDataModule  )
     then MntParForm.OnAfterEditRemesaPago.Add( FerroDataModule.DoOnAfterEditRemesaPago );
end;

procedure SetupMovimientoModule;
begin
     If   Assigned( MovimientoModule ) and
          Assigned( FerroDataModule  )
     then MovimientoModule.BeforeUpdateMovimiento.Add( FerroDataModule.DoBeforeUpdateMovimiento );
end;

{ TFerroDataModule }

procedure TFerroDataModule.DataModuleCreate(Sender: TObject);
begin
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmFacturaComprasFields := TFacturaComprasFields.Create( DmFacturaComprasTable );
     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );

     DsProveedorFields := TProveedorFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
end;

procedure TFerroDataModule.DataModuleDestroy(Sender: TObject);
begin
     FerroDataModule := nil;
end;

procedure TFerroDataModule.DoOnAfterEditRemesaPago;
begin
    With MntParForm, DmEfectoPagarTable do
       begin
       // EjercicioRemesa;NroRemesa;FechaVencimiento
       With RemesaPagoFields do
         SetRange( [ Ejercicio.Value, NroRemesa.Value ] );
       First;
       While not Eof do
         begin
         CompruebaEfecto( DmEfectoPagarFields, True );
         Next;
         end;
       end;
end;

procedure TFerroDataModule.DoOnCambiaEstadoEfecto( EfectoPagarFields : TEfectoPagarFields );
begin
     If   ValueIsEmpty( EfectoPagarFields.NroRemesa.Value ) // Se está intenta incluirlo en una remesa
     then CompruebaEfecto( EfectoPagarFields );
end;

procedure TFerroDataModule.CompruebaEfecto( EfectoPagarFields  : TEfectoPagarFields;
                                            MuestraDatosEfecto : Boolean = False );

var  PagoBloqueado : Boolean;
     MensajeError,
     MotivoBloqueo : String;

begin

     PagoBloqueado := False;
     MotivoBloqueo := '';

     With EfectoPagarFields do
       If   Proveedor.Obten( CodigoProveedor.Value, SubcuentaProveedor.Value, DsProveedorFields, True )
       then begin

            PagoBloqueado := DsProveedorFields.Pago_Bloqueado.Value;
            If   PagoBloqueado
            then MotivoBloqueo := DsProveedorFields.Pago_MotivoBloqueo.Value
            else begin

                 If   DmFacturaComprasTable.FindKey( [ Ejercicio.Value, DsProveedorFields.Codigo.Value, Serie.Value ]  )
                 then begin
                      PagoBloqueado := DmFacturaComprasFields.PagoBloqueado.Value;
                      If   PagoBloqueado
                      then MotivoBloqueo := DmFacturaComprasFields.MotivoBloqueoPago.Value;
                      end;

                 If   not PagoBloqueado
                 then If   DmAsientoTable.FindKey( [ taFraRecibida, Ejercicio.Value, DsProveedorFields.Subcuenta.Value, Serie.Value, 0, NroEfectoRegistroFactura ]  )
                      then begin
                           PagoBloqueado := DmAsientoFields.Bloqueado.Value;
                           If   PagoBloqueado
                           then MotivoBloqueo := DmAsientoFields.MotivoBloqueo.Value;
                           end;

                 end;

            If   PagoBloqueado
            then begin

                 If   MuestraDatosEfecto
                 then MensajeError := Format( RsPagoBloqueadoEfecto, [ Serie.Value, NroEfecto.Value, CodigoProveedor.Value ] )
                 else MensajeError := RsPagoBloqueado;

                 ShowHintMsg( MensajeError, MotivoBloqueo );
                 Abort;
                 end;

            end;
end;

procedure TFerroDataModule.DoBeforeUpdateMovimiento( TipoMovimiento : TTipoMovimiento; CodigoPropietario : String );
begin
     If   ( TipoMovimiento=tmVenta ) and
          Cliente.Obten( CodigoPropietario, '', DsClienteFields, True )
     then If   DsClienteFields.Envios_Bloqueado.Value
          then begin
               ShowHintMsg( RsClienteBloqueado, DsClienteFields.Envios_MotivoBloqueo.Value );
               Abort;
               end;
end;

procedure TFerroDataModule.DoOnAfterEditEfectoPagar;
begin
    CompruebaEfecto( MntApeForm.EfectoPagarFields  );
end;

procedure InitializeModule;
begin
     
     Ferro;

     ApplicationContainer.LogRecordDataChanges := True;
end;

initialization

   AddProcedure( imOptionalSectionModule, 118 );

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );

   AddProcedure( imOnCreateComponent, idMntApeForm, SetupMntApeForm );
   AddProcedure( imOnCreateComponent, idMntRdpForm, SetupMntRdpForm );
   AddProcedure( imOnCreateComponent, idMntParForm, SetupMntParForm );
   AddProcedure( imOnCreateComponent, idMovimientoModule, SetupMovimientoModule );

end.
