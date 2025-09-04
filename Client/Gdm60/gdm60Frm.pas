
unit gdm60Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses,
  dxSkinsDefaultPainters, dxBarExtItems, cxImage, cxBarEditItem,

  AppManager,
  AppContainer,
  AppForms;

type
  TGds60Frm = class(TFrame)
    PreventaAppSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar: TdxBar;
    Clientes1: TdxBarButton;
    ConsumosHabitualesItem: TdxBarButton;
    ArtculosItem: TdxBarButton;
    ParametrosItem: TdxBarButton;
    FicherosMenu: TdxBarSubItem;
    RutasDistibucionItem: TdxBarButton;
    Mantenimientodepedidos1: TdxBarButton;
    Mantenimientodealbaranesdeventa1: TdxBarButton;
    Mantenimientodefacturasdeventa1: TdxBarButton;
    Rut1: TdxBarSubItem;
    DocumentosClientesItem: TdxBarButton;
    Consultas1: TdxBarSubItem;
    CargaDatosItem: TdxBarButton;
    DescargaDatosItem: TdxBarButton;
    Caja1: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    procedure Clientes1Click(Sender: TObject);
    procedure ArtculosItemClick(Sender: TObject);
    procedure DocumentosClientesItemClick(Sender: TObject);
    procedure DescargaDatosItemClick(Sender: TObject);
    procedure ContenidoItemClick(Sender: TObject);
    function PreventaAppSectionSetAccess: Boolean;
    procedure AcercaDeGESTWINClick(Sender: TObject);
    procedure ConsumosHabitualesItemClick(Sender: TObject);
    procedure ParametrosItemClick(Sender: TObject);
    procedure RutasDistibucionItemClick(Sender: TObject);
    procedure CargaDatosItemClick(Sender: TObject);
    procedure Mantenimientodepedidos1Click(Sender: TObject);
    procedure Mantenimientodealbaranesdeventa1Click(Sender: TObject);
    procedure Mantenimientodefacturasdeventa1Click(Sender: TObject);
    procedure PreventaAppSectionUpdateMainMenu;
    function PreventaAppSectionSetUserOption: Boolean;

  private

  public
    class var
    PreventaSection : TgAppSection;

  end;

var  Gds60Frm : TGds60Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       Gdm00Dm,

       dmi_mov,

       dm_pga,
       dm_mov,

       a_chc,
       a_cli,
       a_art,
       a_pg60,

       a_rdd,
       b_cdd,
       b_ddd,

       a_mve,
       a_fdv,

       b_rdc;

procedure TGds60Frm.ContenidoItemClick(Sender: TObject);
begin
     ShowHelp;
end;

function TGds60Frm.PreventaAppSectionSetAccess: Boolean;
begin
     Result := True;
end;

function TGds60Frm.PreventaAppSectionSetUserOption: Boolean;
begin
     case DataModule00.DmUsuarioFields.VentanaInicio.Value of
       10 : MntMovimientosVenta( [ tmPedidoVenta ] );
       11 : MntMovimientosVenta( [ tmVenta ] );
       end;
     Result := DataModule00.DmUsuarioFields.VentanaInicio.Value in [ 10, 11 ];
end;

procedure TGds60Frm.PreventaAppSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

     finally
       BarManager.EndUpdate;
     end;
end;

procedure TGds60Frm.AcercaDeGESTWINClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

procedure TGds60Frm.ConsumosHabitualesItemClick(Sender: TObject);
begin
     MntConsumosCliente( [] );
end;

procedure TGds60Frm.ParametrosItemClick(Sender: TObject);
begin
     MntParametros;
end;

procedure TGds60Frm.RutasDistibucionItemClick(Sender: TObject);
begin
     MntRutasDistribucion( [] );
end;

procedure TGds60Frm.CargaDatosItemClick(Sender: TObject);
begin
     CargaDatos;
end;

procedure TGds60Frm.Mantenimientodepedidos1Click(Sender: TObject);
begin
     MntMovimientosVenta( [ tmPedidoVenta ] );
end;

procedure TGds60Frm.Mantenimientodealbaranesdeventa1Click(Sender: TObject);
begin
     MntMovimientosVenta( [ tmVenta ] );
end;

procedure TGds60Frm.Mantenimientodefacturasdeventa1Click(Sender: TObject);
begin
     MntFacturasVenta( [] );
end;

procedure TGds60Frm.DescargaDatosItemClick(Sender: TObject);
begin
     DescargaDatos;
end;

procedure TGds60Frm.DocumentosClientesItemClick(Sender: TObject);
begin
     RelacionDocumentosClientes( [] );
end;

procedure TGds60Frm.Clientes1Click(Sender: TObject);
begin
     MntClientes( [] );
end;


procedure TGds60Frm.ArtculosItemClick(Sender: TObject);
begin
     MntArticulos( [] );
end;

procedure SectionSetup;
begin
     Gds60Frm := TGds60Frm.Create( Application );
     If   Assigned( Gds60Frm )
     then begin
          TGds60Frm.PreventaSection := Gds60Frm.PreventaAppSection;
          ApplicationContainer.AddAppSection( Gds60Frm.PreventaAppSection );
          Gds60Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
          end;
end;

initialization
     AddProcedure( imOptionalSectionModule, 60, SectionSetup );
end.

