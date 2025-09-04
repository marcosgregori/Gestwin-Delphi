unit cm_fvi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, dxBar,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  AppForms, nxdb, DataManager,

  Gim10Fields;

  { Módulo de conexión.
    Conecta el módulo contable con el comercial para mostrar los registros comerciales
    desde la contabilidad
    }

type
  TCmdFviModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private

    FOnRelacionMenuPopup : TNotifyEvent;
    FFacturaVentaMenuItem : TdxBarButton;

    procedure DoOnAstClickFactura( Sender : TObject );
    procedure DoOnFviClickFactura( Sender : TObject );

    procedure DoOnRelacionesMenuPopup( Sender: TObject );
    procedure MuestraFactura(AsientoFields: TAsientoFields);

  public
  end;

var CmdFviModule : TCmdFviModule = nil;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess,

     dmi_ast,

     dm_fdv,

     a_ast,
     a_fvi,
     a_fdv;

{$R *.dfm}

resourceString
     RsMsg1 = 'Factura de venta';
     RsMsg2 = 'No existe el registro de esta factura en la gestión comercial.';

procedure SetupFviModule;

var  MenuItem : TdxBarButton;

begin
     If   Assigned( MntFviForm )
     then begin
          CreateDataModule( TCmdFviModule, CmdFviModule, MntFviForm );
          If   Assigned( CmdFviModule )
          then With MntFviForm, CmdFviModule do
                 begin
                 MenuItem := MntFviForm.BarManager.AddButton;
                 If   Assigned( MenuItem )
                 then begin
                      MenuItem.Caption := RsMsg1;
                      MenuItem.OnClick := CmdFviModule.DoOnFviClickFactura;
                      RelacionesPopupMenu.ItemLinks.Add( MenuItem );
                      end;
                 end;
          end;
end;

procedure SetupAstModule;

var  MenuItem : TdxBarButton;

begin
     If   Assigned( MntAstForm )
     then begin
          CreateDataModule( TCmdFviModule, CmdFviModule );
          If   Assigned( CmdFviModule )
          then With MntAstForm, CmdFviModule do
                 begin
                 MenuItem := MntAstForm.BarManager.AddButton;
                 If   Assigned( MenuItem )
                 then With MenuItem do
                        begin
                        Caption := RsMsg1;
                        OnClick := CmdFviModule.DoOnAstClickFactura;
                        RelacionesPopupMenu.ItemLinks.Add.Item := MenuItem;
                        end;
                 FFacturaVentaMenuItem := MenuItem;
                 FOnRelacionMenuPopup := RelacionesPopupMenu.OnPopup;
                 RelacionesPopupMenu.OnPopup := DoOnRelacionesMenuPopup;
                 end;
          end;
end;

procedure TCmdFviModule.DoOnRelacionesMenuPopup( Sender: TObject );
begin
     If   Assigned( FOnRelacionMenuPopup )
     then FOnRelacionMenuPopup( Sender );
     SetBarItemsVisible( [ FFacturaVentaMenuItem ], MntAstForm.AsientoFields.TipoAsiento.Value=taFraEmitida );
end;

procedure TCmdFviModule.DoOnFviClickFactura( Sender : TObject );
begin
     MuestraFactura( MntFviForm.AsientoFields );
end;

procedure TCmdFviModule.DoOnAstClickFactura( Sender : TObject );
begin
     MuestraFactura( MntAstForm.AsientoFields )
end;

procedure TCmdFviModule.MuestraFactura( AsientoFields : TAsientoFields );
begin
     With AsientoFields do
       If   FacturaVentas.Obten( Ejercicio.Value, Serie.Value, NroFactura.Value )
       then MntFacturasVenta( [ Ejercicio.Value, Serie.Value, NroFactura.Value ] )
       else ShowNotification( ntStop, RsMsg2 );
end;

procedure TCmdFviModule.DataModuleDestroy(Sender: TObject);
begin
     CmdFviModule := nil;
end;

initialization
   AddProcedure( imOnCreateComponent, idMntAstForm, SetupAstModule );
   AddProcedure( imOnCreateComponent, idMntFviForm, SetupFviModule );

end.
