
unit gdm207Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses,
  dxSkinsDefaultPainters, dxBarExtItems,

  AppManager,
  AppContainer,
  AppForms, cxImage, cxBarEditItem;

type
  TGds207Frm = class(TFrame)

    BarManager: TdxBarManager;
    BarManagerBar: TdxBar;
    Clientes1: TdxBarButton;
    ExportacionImportacionItem: TdxBarButton;
    FicherosMenu: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    ProcesosItem: TdxBarSubItem;
    ModificacionRegistroItem: TdxBarButton;
    ArticulosTiendaItem: TdxBarButton;
    ClasesAArticuloItem: TdxBarButton;
    ClasesBArticuloItem: TdxBarButton;
    function TiendaVirtualSectionSetAccess: Boolean;
    procedure Clientes1Click(Sender: TObject);
    procedure ExportacionImportacionItemClick(Sender: TObject);
    procedure ModificacionRegistroItemClick(Sender: TObject);
    procedure TiendaVirtualSectionUpdateMainMenu;

  private

  public

   class var TiendaVirtualSection: TgAppSection;

  end;

var  Gds207Frm : TGds207Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       Gdm00Dm,

       dm_pga,
       dm_cls,

       a_cat,

       b_rra,

       b_sdt207;

resourceString
       RsMsg1 = ' por artículo';

procedure TGds207Frm.Clientes1Click(Sender: TObject);
begin
     MntCategorias( [] );
end;

procedure TGds207Frm.ExportacionImportacionItemClick(Sender: TObject);
begin
     SincronizaDatosTienda;
end;

procedure TGds207Frm.ModificacionRegistroItemClick(Sender: TObject);
begin
     ModificaRegistroActualizacion;
end;

function TGds207Frm.TiendaVirtualSectionSetAccess: Boolean;
begin
     Result := True;
end;

procedure TGds207Frm.TiendaVirtualSectionUpdateMainMenu;
begin
      With DataModule00.DmEmpresaFields do
        begin
        SetBarItemVisible( ClasesAArticuloItem, Articulo_ExisteClase[ 1 ].Value );
        ClasesAArticuloItem.Caption := Clase.NombreClase( tcClaseA, True, True ) + RsMsg1;

        SetBarItemVisible( ClasesBArticuloItem, Articulo_ExisteClase[ 2 ].Value );
        ClasesBArticuloItem.Caption := Clase.NombreClase( tcClaseB, True, True )  + RsMsg1;
        end;
end;

procedure SectionSetup;
begin
     Gds207Frm := TGds207Frm.create( application );
     If   Assigned( Gds207Frm )
     then ApplicationContainer.AddAppSection( Gds207Frm.TiendaVirtualSection );
end;

initialization
     AddProcedure( imOptionalSectionModule, 207, SectionSetup );
end.

