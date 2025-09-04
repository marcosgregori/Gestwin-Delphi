
unit f_cnf70;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Menus, cxLookAndFeelPainters, cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  nxdb, DataManager, cxCurrencyEdit, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters,

  AppContainer,
  AppForms,

  Gdm70Dm,

  Gim30Fields,
  Gim70Fields,

  dmi_mov;

type
  TProduccionModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    { 03.02.2023 He quitado el bloqueo a petición del cliente }

    // FSavedOnCanEditRecord : TDataSetCheckEvent;

    FOldActivateRelatedDocsButton : TQueryEvent;

    DsOrdenFabricacionFields : TOrdenFabricacionFields;

    procedure LanzarButtonClick(Sender: TObject);
    procedure DoOnConfiguracionProduccionClick(Sender: TObject);
    function DoOnActivateRelatedDocsButton : Boolean;
    function DoOnObtenArticuloFinal( MovimientoFields : TMovimientoFields; var LineaMovimientoFields: TLineaMovimientoFields) : Boolean;

  public

    // function DoOnCanEditRecord( Dataset : TDataset ) : Boolean;

    procedure DoOnOrdenesPedidoClick( Sender : TObject );

    // property SavedOnCanEditRecord : TDataSetCheckEvent read FSavedOnCanEditRecord write FSavedOnCanEditRecord;

  end;

var ProduccionModule : TProduccionModule = nil;

function Produccion : TProduccionModule;

implementation

uses cxGridCommon,
     cxGridDBDataDefinitions,
     cxRadioGroup,
     dxBar,

     LibUtils,
     DateUtils,
     nxdbBase,

     EnterpriseDataAccess,
     AppManager,

     Gim00Fields,
     dmi_odf,

     Gdm00Frm,
     Gdm30Frm,

     dm_odf,
     dm_mov,

     a_pde7,
     a_mve,

     b_odp,
     b_lan;

{$R *.dfm}

function Produccion : TProduccionModule;
begin
     CreateDataModule( TProduccionModule, ProduccionModule );
     Result := ProduccionModule;
end;

procedure SetupMovimientoVentas;

var  Bevel : TBevel;
     BitBtn : TgBitBtn;
     OrdenesPedidoItem : TdxBarButton;

begin
     If   Assigned( ProduccionModule ) and
          Assigned( MntMveForm[ tmPedidoVenta ] ) and
          ( TipoMovimientoCreado=tmPedidoVenta )
     then With MntMveForm[ tmPedidoVenta ] do
            If   not FormManager.FormInitialized
            then begin
                 LanzarButton.OnClick := ProduccionModule.LanzarButtonClick;
                 {
                 ProduccionModule.SavedOnCanEditRecord := MovimientoTable.OnCanEditRecord;
                 MovimientoTable.OnCanEditRecord := ProduccionModule.DoOnCanEditRecord;
                 }

                 OrdenesPedidoItem := RelacionesPopupMenu.BarManager.AddButton;
                 OrdenesPedidoItem.Caption := 'Órdenes de fabricación del pedido';
                 OrdenesPedidoItem.OnClick := ProduccionModule.DoOnOrdenesPedidoClick;

                 RelacionesPopupMenu.ItemLinks.Add.Item := OrdenesPedidoItem;

                 ProduccionModule.FOldActivateRelatedDocsButton := FormManager.OnActivateRelatedDocsButton;
                 FormManager.OnActivateRelatedDocsButton := ProduccionModule.DoOnActivateRelatedDocsButton;
                 end;
end;

procedure SetupListadoTrazabilidad;
begin
     Movimiento;  // Puede que no se haya inicializado antes
     If   Assigned( ProduccionModule ) and
          Assigned( MovimientoModule )
     then MovimientoModule.OnObtenArticuloFinal.Add( ProduccionModule.DoOnObtenArticuloFinal );
end;

procedure TProduccionModule.DataModuleCreate(Sender: TObject);
begin
     DsOrdenFabricacionFields := TOrdenFabricacionFields.Create( Self );
end;

procedure TProduccionModule.DataModuleDestroy(Sender: TObject);
begin
     ProduccionModule := nil;
end;

function TProduccionModule.DoOnActivateRelatedDocsButton : Boolean;
begin
     If   Assigned( FOldActivateRelatedDocsButton )
     then FOldActivateRelatedDocsButton;  // Solo para que se actualice la lista de elementos del menú
     Result := True;
end;

procedure TProduccionModule.DoOnOrdenesPedidoClick( Sender : TObject );
begin
     With MntMveForm[ tmPedidoVenta ].MovimientoFields do
       ConsultaOrdenesPedido( [ tmPedidoVenta, Ejercicio.Value, Serie.Value, NroDocumento.Value ] );
end;

{
function TProduccionModule.DoOnCanEditRecord(Dataset: TDataset): Boolean;
begin
     With MntMveForm[ tmPedidoVenta ].MovimientoFields do
       Result := not OrdenFabricacion.PedidoLanzado( Ejercicio.Value, Serie.Value, NroDocumento.Value );
     If   Result
     then If   Assigned( FSavedOnCanEditRecord )
          then Result := FSavedOnCanEditRecord( Dataset );
end;
}

procedure TProduccionModule.DoOnConfiguracionProduccionClick(Sender: TObject);
begin
     MntConfiguracionProduccion;
end;

procedure TProduccionModule.LanzarButtonClick(Sender: TObject);
begin
     With MntMveForm[ tmPedidoVenta ] do
       begin
       // FormManager.CheckDetailRecords;
       FormManager.PostCurrentRecord;
       LanzamientoPedido( MovimientoFields.Serie.Value, MovimientoFields.NroDocumento.Value );
       end;
end;

function TProduccionModule.DoOnObtenArticuloFinal(     MovimientoFields      : TMovimientoFields;
                                                   var LineaMovimientoFields : TLineaMovimientoFields ) : Boolean;
begin
     Result := False;
     If   ( MovimientoFields.TipoMovimiento.Value=tmDispFabricacion ) and
          ( MovimientoFields.NroDocumento.Value<>0 )
     then If   OrdenFabricacion.Obten( YearOf( MovimientoFields.Fecha.Value ),
                                       moOrden,
                                       MovimientoFields.NroDocumento.Value,
                                       DsOrdenFabricacionFields )
          then begin

               // Se supone en modo Edit, puesto que es un MemoryDataset

               LineaMovimientoFields.CodigoArticulo.Value := DsOrdenFabricacionFields.CodigoArticulo.Value;
               LineaMovimientoFields.CodigoClaseA.Value := DsOrdenFabricacionFields.CodigoClaseA.Value;
               LineaMovimientoFields.CodigoClaseB.Value := DsOrdenFabricacionFields.CodigoClaseB.Value;
               LineaMovimientoFields.CodigoClaseC.Value := DsOrdenFabricacionFields.CodigoClaseC.Value;
               LineaMovimientoFields.LoteFabricacion.Value := DsOrdenFabricacionFields.Lote.Value;

               Result := True;
               end;
end;

procedure InitializeModule;
begin
    
     Produccion;

     If   Assigned( ProduccionModule )
     then begin

          If   Assigned( Gds00Frm )
          then begin
               SetBarItemVisible( Gds00Frm.ConfiguracionProduccionItem, True );
               Gds00Frm.ConfiguracionProduccionItem.OnClick := ProduccionModule.DoOnConfiguracionProduccionClick;
               end;

          end;
end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );

   AddProcedure( imOnCreateComponent, idMntMveForm, SetupMovimientoVentas );
   AddProcedure( imOnCreateComponent, idRptTcmForm, SetupListadoTrazabilidad );

end.
