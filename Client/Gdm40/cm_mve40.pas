
unit cm_mve40;

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

  Gdm40Dm,

  Gim30Fields,
  Gim40Fields,

  dmi_mov;

type
  TCmdMve40Module = class(TDataModule)
    DmLineaMovimientoTable: TnxeTable;
    DmHojaCargaTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmHojaCargaFields : THojaCargaFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;

    procedure HojaCargaButtonClick(Sender: TObject);
    procedure DoOnCalcFieldsLineaMovimientoQuery;
    procedure DoBeforeDeleteMovimiento( MovimientoFields : TMovimientoFields );

  public

  end;

var CmdMve40Module : TCmdMve40Module = nil;

implementation

uses cxGridCommon,
     cxGridDBDataDefinitions,
     cxRadioGroup,
     LibUtils,
     nxdbBase,

     EnterpriseDataAccess,
     AppManager,

     Gim00Fields,
     Gdm30Frm,

     dm_hdc,

     a_mve,
     a_mov,

     b_ehc,

     b_msg;

{$R *.dfm}

resourceString
    
    RsMsg3 = '&Hoja carga';
    RsMsg4 = 'La hoja de carga que originó este documento está en uso.';
    RsMsg5 = 'Desbloquee el registro antes de intentar suprimir el movimiento de reubicación.';

procedure SetupMovimientoVentas;

var  Bevel : TBevel;
     BitBtn : TgBitBtn;

begin
     CreateDataModule( TCmdMve40Module, CmdMve40Module );
     If   Assigned( MntMveForm[ tmPedidoVenta ] ) and
          ( TipoMovimientoCreado=tmPedidoVenta )
     then begin
          With MntMveForm[ tmPedidoVenta ], CmdMve40Module do
            If   not FormManager.FormInitialized
            then begin
                 HojaCargaButton.OnClick := HojaCargaButtonClick;
                 GridViewCantidadCargada.Visible := True;
                 OnCalcFieldsLineaMovimiento.Add( DoOnCalcFieldsLineaMovimientoQuery );
                 end;
          end;
end;

procedure SetupMovimiento;
begin
     CreateDataModule( TCmdMve40Module, CmdMve40Module );
     If   Assigned( MntMovForm )
     then If   not MntMovForm.FormManager.FormInitialized
          then MntMovForm.BeforeDeleteMovimiento.Add( CmdMve40Module.DoBeforeDeleteMovimiento );
end;

procedure TCmdMve40Module.DataModuleCreate(Sender: TObject);
begin
     DmHojaCargaFields := THojaCargaFields.Create( DmHojaCargaTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
end;

procedure TCmdMve40Module.DataModuleDestroy(Sender: TObject);
begin
     CmdMve40Module := nil;
end;

procedure TCmdMve40Module.HojaCargaButtonClick(Sender: TObject);
begin
     With MntMveForm[ tmPedidoVenta ] do
       ExportaAHojaCarga( MovimientoFields, LineaMovimientoFields );
end;

procedure TCmdMve40Module.DoOnCalcFieldsLineaMovimientoQuery;

var  CantidadCargada : Decimal;

begin
     If   Assigned( MntMveForm[ tmPedidoVenta ] )
     then With MntMveForm[ tmPedidoVenta ] do
            LineaMovimientoTableCantidadCargada.Value := HojaCarga.ObtenCantidadCargada( LineaMovimientoTableNroRegistro.Value );
end;

procedure TCmdMve40Module.DoBeforeDeleteMovimiento( MovimientoFields : TMovimientoFields );
begin
     try
       If   DmHojaCargaTable.FindKey( [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value ] )
       then begin
            DmHojaCargaTable.Edit;
            DmHojaCargaFields.EjercicioReubicacion.Clear;
            DmHojaCargaFields.NroOperacionReubicacion.Clear;
            DmHojaCargaTable.Post;
            end;
     except on E : EnxDatabaseError do
       begin
       ShowNotification( ntStop, RsMsg4, RsMsg5 );
       Abort;
       end
     else raise;
     end;

end;

procedure InitializeModule;
begin
     HojaCarga; // Se inicializa también en el servidor
end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );

   AddProcedure( imOnCreateComponent, idMntMveForm, SetupMovimientoVentas );
   AddProcedure( imOnCreateComponent, idMntMovForm, SetupMovimiento );

end.
