
unit Gdm101Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses,
  dxSkinsDefaultPainters, dxBarExtItems,

  AppManager,
  AppContainer,
  AppForms;

type
  TGds101Frm = class(TFrame)
    HormigonerasSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
    Clientes1: TdxBarButton;
    Artculos1: TdxBarButton;
    CodigosTarifaItem: TdxBarButton;
    Tarifasdeventa1: TdxBarButton;
    Tarifas1: TdxBarSubItem;
    ParametrosItem: TdxBarButton;
    FicherosMenu: TdxBarSubItem;
    ImpAlbaranesItem: TdxBarButton;
    MntAlbaranesItem: TdxBarButton;
    Caja1: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    SectionsBarButton: TdxBarButton;
    procedure SalirItemClick(Sender: TObject);
    procedure OrdenarIconosItemClick(Sender: TObject);
    procedure ContenidoItemClick(Sender: TObject);
    procedure cerrarVentanasItemClick(Sender: TObject);
    function HormigonerasSectionSetAccess: Boolean;
    procedure ParametrosItemClick(Sender: TObject);
    procedure MntAlbaranesItemClick(Sender: TObject);
    procedure ImpAlbaranesItemClick(Sender: TObject);
    procedure CodigosTarifaItemClick(Sender: TObject);
    procedure Tarifasdeventa1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Artculos1Click(Sender: TObject);
    procedure AcercaDeGESTWINClick(Sender: TObject);
    procedure Secciones1ItemClick(Sender: TObject);

  private

  public

  end;

var  Gds101Frm : TGds101Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       Gdm00Dm,

       dmi_mov,

       dm_pga,
       dm_mov,

       a_cli,
       a_art,
       a_cdt,
       a_tva,

       a_pg101,

       b_iav101,
       a_mve;

procedure TGds101Frm.SalirItemClick(Sender: TObject);
begin
     PrgExit( true );
end;

procedure TGds101Frm.Secciones1ItemClick(Sender: TObject);
begin
     ApplicationForm.ShowSectionsMenu;
end;

procedure TGds101Frm.CerrarVentanasItemClick(Sender: TObject);
begin
     ApplicationContainer.CanCloseAllForms;
end;

procedure TGds101Frm.OrdenarIconosItemClick(Sender: TObject);
begin
     ApplicationForm.arrangeIcons;
end;

procedure TGds101Frm.ContenidoItemClick(Sender: TObject);
begin
     ShowHelp;
end;

function TGds101Frm.HormigonerasSectionSetAccess: Boolean;
begin
     result := true;
end;

procedure TGds101Frm.AcercaDeGESTWINClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( true );
end;

// ....

procedure TGds101Frm.ParametrosItemClick(Sender: TObject);
begin
     mntParametros;
end;

procedure TGds101Frm.MntAlbaranesItemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmVenta ] );
end;

procedure TGds101Frm.ImpAlbaranesItemClick(Sender: TObject);
begin
     ImportacionAlbaranesVenta;
end;

procedure TGds101Frm.CodigosTarifaItemClick(Sender: TObject);
begin
     mntCodigosTarifa( [] );
end;

procedure TGds101Frm.Tarifasdeventa1Click(Sender: TObject);
begin
     MntTarifasVentaArticulo( [] );
end;

procedure TGds101Frm.Clientes1Click(Sender: TObject);
begin
     MntClientes( [] );
end;

procedure TGds101Frm.Artculos1Click(Sender: TObject);
begin
     mntArticulos( [] );
end;


// ....

procedure SectionSetup;
begin
     Gds101Frm := TGds101Frm.create( application );
     If   Assigned( Gds101Frm )
     then ApplicationContainer.AddAppSection( Gds101Frm.HormigonerasSection );
end;

initialization
     AddProcedure( imOptionalSectionModule, 101, SectionSetup );

end.

