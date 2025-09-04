unit cm_fcg;

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
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar,
  AppForms, nxdb, DataManager,

  Gim10Fields;

type
  TCmdFcgModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    FOnRelacionMenuPopup : TNotifyEvent;
    FFacturaVentaMenuItem : TdxBarButton;
    ProveedorFields : TProveedorFields;

    procedure DoOnAstClickFactura( Sender : TObject );
    procedure DoOnFcgClickFactura( Sender : TObject );

    procedure DoOnRelacionesMenuPopup( Sender: TObject );
    procedure MuestraFactura(AsientoFields: TAsientoFields);

  public
  end;

var CmdFcgModule : TCmdFcgModule = nil;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess,

     dmi_ast,

     dm_pro,
     dm_fdc,

     a_ast,
     a_fcg,
     a_fdc;

{$R *.dfm}

resourceString
     RsMsg1 = 'Factura de compra';
     RsMsg2 = 'Esta subcuenta no tiene asociada ninguna ficha de proveedor / acreedor.';
     RsMsg3 = 'No existe el registro de esta factura en la gestión comercial.';

procedure SetupFcgModule;

var  MenuItem : TdxBarButton;

begin
     If   Assigned( MntFcgForm )
     then begin
          CreateDataModule( TCmdFcgModule, CmdFcgModule );
          If   Assigned( CmdFcgModule )
          then With MntFcgForm do
                 begin
                 MenuItem := MntFcgForm.BarManager.AddButton;
                 If   Assigned( MenuItem )
                 then begin
                      MenuItem.Caption := RsMsg1;
                      MenuItem.OnClick := CmdFcgModule.DoOnFcgClickFactura;
                      var BarItemLink := { TdxBarItemLink } RelacionesPopupMenu.ItemLinks.Add( MenuItem );
                      BarItemLink.BeginGroup := True;
                      end;

                 end;
          end;
end;

procedure SetupAstModule;

var  MenuItem : TdxBarButton;

begin
     If   Assigned( MntAstForm )
     then begin
          CreateDataModule( TCmdFcgModule, CmdFcgModule, MntAstForm );
          If   Assigned( CmdFcgModule )
          then With MntAstForm, CmdFcgModule do
                 begin

                 MenuItem := MntAstForm.BarManager.AddButton;
                 If   Assigned( MenuItem )
                 then With MenuItem do
                        begin
                        Caption := RsMsg1;
                        // Break := mbBreak;
                        OnClick := CmdFcgModule.DoOnAstClickFactura;
                        RelacionesPopupMenu.ItemLinks.Add.Item := MenuItem;
                        end;

                 FFacturaVentaMenuItem := MenuItem;
                 FOnRelacionMenuPopup := RelacionesPopupMenu.OnPopup;
                 RelacionesPopupMenu.OnPopup := DoOnRelacionesMenuPopup;

                 end;
          end;
end;

procedure TCmdFcgModule.DoOnRelacionesMenuPopup( Sender: TObject );
begin
     If   Assigned( FOnRelacionMenuPopup )
     then FOnRelacionMenuPopup( Sender );
     SetBarItemsVisible( [ FFacturaVentaMenuItem ], MntAstForm.AsientoFields.TipoAsiento.Value=taFraRecibida );
end;

procedure TCmdFcgModule.MuestraFactura(AsientoFields: TAsientoFields);
begin
     With AsientoFields do
       If   Proveedor.ObtenPorSubcuenta( Propietario.Value, ProveedorFields )
       then begin
            If   FacturaCompras.Obten( Ejercicio.Value, ProveedorFields.Codigo.Value, Serie.Value )
            then MntFacturasCompra( [ Ejercicio.Value, ProveedorFields.Codigo.Value, Serie.Value ] )
            else ShowNotification( ntStop, RsMsg3 );
            end
       else ShowNotification( ntStop, RsMsg2 );
end;

procedure TCmdFcgModule.DoOnFcgClickFactura(Sender: TObject);
begin
     MuestraFactura( MntFcgForm.AsientoFields );
end;

procedure TCmdFcgModule.DoOnAstClickFactura(Sender: TObject);
begin
     MuestraFactura( MntAstForm.AsientoFields );
end;

procedure TCmdFcgModule.DataModuleCreate(Sender: TObject);
begin
     ProveedorFields := TProveedorFields.Create( Self );
end;

procedure TCmdFcgModule.DataModuleDestroy(Sender: TObject);
begin
     CmdFcgModule := nil;
end;

initialization
   AddProcedure( imOnCreateComponent, idMntAstForm, SetupAstModule );
   AddProcedure( imOnCreateComponent, idMntFcgForm, SetupFcgModule );

end.
