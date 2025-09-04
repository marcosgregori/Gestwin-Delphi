unit f_mve40;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  AppForms, nxdb, DataManager, cxCurrencyEdit, cxLookAndFeels,

  Gim30Fields,
  Gdm40Dm,
  dm_mov, dxSkinsCore, dxSkinsDefaultPainters;

type
  TMntMve40Module = class(TDataModule)
    procedure HojaCargaButtonClick(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    HojaCargaButton: TgBitBtn;
    procedure DoOnUpdateState;
    procedure DoOnCalcFieldsLineaMovimientoTable;
    procedure DoBeforeDeleteLineaMovimientoTable( TipoMovimientoEdicion : TTipoMovimiento; NroRegistro : LongWord );

  public

  end;

var MntMve40Module : TMntMve40Module = nil;

implementation

uses cxGridCommon,
     cxGridDBDataDefinitions,
     cxRadioGroup,
     LibUtils,

     EnterpriseDataAccess,

     Gim00Fields,
     Gdm30Frm,

     dm_hdc,

     a_mve,
     b_ehc,

     b_msg;

{$R *.dfm}

resourceString
    RsMsg1 = 'Esta línea ha sido incluída en una hoja de carga.';
    RsMsg2 = 'Si desea suprimir la línea localice primero el registro de la hoja de carga nº %d y delo de baja.';
    RsMsg3 = '&Hoja carga';

procedure SetupMovimientoVentas;

var  Bevel : TBevel;
     BitBtn : TgBitBtn;

begin
     CreateDataModule( TMntMve40Module, MntMve40Module );
     If   Assigned( MntMveForm[ tmPedidoVenta ] )
     then begin
          With MntMveForm[ tmPedidoVenta ], MntMve40Module do
            If   not FormManager.FormInitialized
            then begin

                 HojaCargaButton := TgBitBtn.Create( MntMveForm[ tmPedidoVenta ] );
                 With HojaCargaButton do
                   begin
                   GlyphBitmap := gmDocSingle;
                   Width := 85;
                   Height := 30;
                   Caption := '&Hoja carga';
                   Enabled := True;
                   Margin := 4;
                   Spacing := 5;
                   TabOrder := 0;
                   OnClick := HojaCargaButtonClick;
                   Parent := ButtonContainerPanel;
                   Left := 600;
                   Align := alLeft;
                   Margins.Bottom := 0;
                   Margins.Left := 2;
                   Margins.Right := 0;
                   Margins.Top := 0;
                   AlignWithMargins := True;
                   end;

                 ButtonContainerPanel.Width := 435;
                 CenterInParent( ButtonContainerPanel );

                 GridViewCantidadCargada.Visible := True;
                 OnCalcFieldsLineaMovimiento.Add( DoOnCalcFieldsLineaMovimientoTable );
                 OnActualizaEstado := DoOnUpdateState;
                 BeforeDeleteLineaMovimiento.Add( DoBeforeDeleteLineaMovimientoTable );

                 end;
          end
     else If   Assigned( MntMveForm[ tmVenta ] )
          then With MntMveForm[ tmVenta ], MntMve40Module do
                 If   not FormManager.FormInitialized
                 then BeforeDeleteLineaMovimiento := DoBeforeDeleteLineaMovimientoTable;

end;

procedure TMntMve40Module.DataModuleDestroy(Sender: TObject);
begin
     MntMve40Module := nil;
end;

procedure TMntMve40Module.HojaCargaButtonClick(Sender: TObject);
begin
     With MntMveForm[ tmPedidoVenta ] do
       ExportaAHojaCarga( MovimientoFields, LineaMovimientoFields );
end;

procedure TMntMve40Module.DoOnUpdateState;
begin
     With MntMveForm[ tmPedidoVenta ] do
       If   Assigned( MovimientoFields )
       then HojaCargaButton.Enabled := ExportarButton.Enabled and ( MovimientoFields.Situacion.Value<>epProcesado );
end;

procedure TMntMve40Module.DoOnCalcFieldsLineaMovimientoTable;

var  CantidadCargada : Double;

begin
     If   Assigned( MntMveForm[ tmPedidoVenta ] )
     then With MntMveForm[ tmPedidoVenta ] do
            LineaMovimientoTableCantidadCargada.Value := HojaCarga.CantidadCargada( LineaMovimientoTableNroRegistro.Value );
end;

procedure TMntMve40Module.DoBeforeDeleteLineaMovimientoTable( TipoMovimientoEdicion : TTipoMovimiento;
                                                             NroRegistro           : LongWord );
var  Ejercicio : SmallInt;
     NroHojaCarga : LongInt;

begin
     With HojaCarga do
       case TipoMovimientoEdicion of
         tmPedidoVenta : If   ObtenLineaPorNroRegistroOrigen( NroRegistro )
                         then begin
                              ShowNotification( ntStop, RsMsg1, Format( RsMsg2, [ DmLineaHojaCargaFields.NroHoja.Value ] ) );
                              Abort;
                              end;
         tmVenta       : If   ObtenLineaPorNroRegistroDestino( NroRegistro )
                         then begin

                              Ejercicio := DmLineaHojaCargaFields.Ejercicio.Value;
                              NroHojaCarga := DmLineaHojaCargaFields.NroHoja.Value;

                              DmLineaHojaCargaTable.Edit;
                              DmLineaHojaCargaFields.EjercicioDestino.Clear;
                              DmLineaHojaCargaFields.NroOperacionDestino.Clear;
                              DmLineaHojaCargaFields.NroRegistroDestino.Clear;
                              DmLineaHojaCargaTable.Post;

                              RevisaVinculos;

                              end;
         end;
end;

initialization
   ApplicationContainer.AddProcedure( imOnCreateComponent, idMntMveForm, SetupMovimientoVentas );

end.
