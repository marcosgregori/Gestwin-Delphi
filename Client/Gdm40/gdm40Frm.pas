
unit gdm40Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  dxSkinsCore,
  dxSkinsdxBarPainter,
  dxBar,
  cxClasses,
  dxSkinsDefaultPainters,
  dxBarExtItems,
  cxImage,
  cxBarEditItem,

  AppManager,
  AppContainer,
  AppForms;

type
  TGds40Frm = class(TFrame)
    PrevisionAppSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar: TdxBar;
    ListasDeMaterialesItem: TdxBarButton;
    OperariosTipoItem: TdxBarButton;
    MaquinasTipoItem: TdxBarButton;
    OperacionesItem: TdxBarButton;
    TransportistasItem: TdxBarButton;
    ParametrosGenerales: TdxBarButton;
    FicherosMenu: TdxBarSubItem;
    ListadoDisponibilidadItem: TdxBarButton;
    ListadoNecesidadesItem: TdxBarButton;
    ListadoDisponibilidadNecesidadesItem: TdxBarButton;
    CalculoCosteItem: TdxBarButton;
    PrevisionItem: TdxBarSubItem;
    PedidoVentasITem: TdxBarButton;
    HojasCargaItem: TdxBarButton;
    GeneracionSalidaItem: TdxBarButton;
    CargaItem: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    EstadoArticulosPendientesItem: TdxBarButton;
    GeneracionReubicacionItem: TdxBarButton;
    GeneracionPedidosCompraItem: TdxBarButton;
    NecesidadaesAprovisionamientoItem: TdxBarButton;
    procedure ContenidoItemClick(Sender: TObject);
    function PrevisionAppSectionSetAccess: Boolean;
    procedure AcercaItemClick(Sender: TObject);
    procedure PedidoVentasITemClick(Sender: TObject);
    procedure HojasCargaItemClick(Sender: TObject);
    procedure TransportistasItemClick(Sender: TObject);
    procedure GeneracionSalidaItemClick(Sender: TObject);
    procedure ParametrosGeneralesClick(Sender: TObject);
    procedure PrevisionAppSectionUpdateMainMenu;
    procedure EstadoArticulosPendientesItemClick(Sender: TObject);
    procedure GeneracionReubicacionItemClick(Sender: TObject);
    procedure GeneracionPedidosCompraItemClick(Sender: TObject);
    procedure NecesidadaesAprovisionamientoItemClick(Sender: TObject);

  private

  public
    class var
    PrevisionSection : TgAppSection;

  end;

var  Gds40Frm : TGds40Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       Gdm00Dm,
       Gdm30Frm,

       dmi_mov,

       dm_pga,
       dm_mov,

       a_tra,
       a_pde4,

       a_mve,

       a_hdc,
       b_gpc,
       b_gas,
       b_gmr,
       b_eap,
       b_nda,

       b_msg;

procedure TGds40Frm.ContenidoItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds40Frm.GeneracionPedidosCompraItemClick(Sender: TObject);
begin
     GeneracionPedidosCompra;
end;

procedure TGds40Frm.EstadoArticulosPendientesItemClick(Sender: TObject);
begin
     EstadoArticulosPendientes( [] );
end;

function TGds40Frm.PrevisionAppSectionSetAccess: Boolean;
begin
     result := DataModule00.DmUsuarioFields.acAL.Value<>0;
end;

procedure TGds40Frm.PrevisionAppSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

       SetBarItemsVisible( [ GeneracionSalidaItem ], ParametrosAprovisionamientoRec.DocumentoHojaCarga=0 );

       // Modificaciones en el menú de la gestión comercial

       If   Assigned( Gds30Frm )
       then With Gds30Frm do
              begin
              SetBarItemsVisible( [ HojasCargaPedidoItem, EstadoArticulosPendientesItem, GeneracionPedidosCompraItem, GeneracionAlbaranesSalidaItem ], ParametrosAprovisionamientoRec.DocumentoHojaCarga=0 );
              SetBarItemsVisible( [ HojasCargaAlbaranItem ], ParametrosAprovisionamientoRec.DocumentoHojaCarga=1 );

              case ParametrosAprovisionamientoRec.DocumentoHojaCarga of
                 0 : begin
                     HojasCargaPedidoItem.OnClick := Gds40Frm.HojasCargaItemClick;
                     EstadoArticulosPendientesItem.OnClick := Gds40Frm.EstadoArticulosPendientesItemClick;
                     GeneracionAlbaranesSalidaItem.OnClick := Gds40Frm.GeneracionSalidaItemClick;
                     GeneracionPedidosCompraItem.OnClick := Gds40Frm.GeneracionPedidosCompraItemClick;
                     end;
                 1 : HojasCargaAlbaranItem.OnClick := Gds40Frm.HojasCargaItemClick;
                 end;

              end;

     finally
       BarManager.EndUpdate;
     end;
end;

procedure TGds40Frm.AcercaItemClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

// ....

procedure TGds40Frm.PedidoVentasITemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmPedidoVenta ] );
end;

procedure TGds40Frm.HojasCargaItemClick(Sender: TObject);
begin
     MntHojasCarga( [] );
end;

procedure TGds40Frm.NecesidadaesAprovisionamientoItemClick(Sender: TObject);
begin
     GeneracionNecesidadesAprovisionamiento;
end;

procedure TGds40Frm.TransportistasItemClick(Sender: TObject);
begin
     MntTransportistas( [] );
end;

procedure TGds40Frm.GeneracionReubicacionItemClick(Sender: TObject);
begin
     GeneracionMovimientosReubicacion;
end;

procedure TGds40Frm.GeneracionSalidaItemClick(Sender: TObject);
begin
     GeneracionAlbaranesSalida;
end;

procedure TGds40Frm.ParametrosGeneralesClick(Sender: TObject);
begin
     MntParametros;
end;

procedure SectionSetup;

var  SubItem : TdxBarSubItem;

begin
     Gds40Frm := TGds40Frm.Create( Application );
     If   Assigned( Gds40Frm )
     then begin
          ApplicationContainer.AddAppSection( Gds40Frm.PrevisionAppSection );
          TGds40Frm.PrevisionSection := Gds40Frm.PrevisionAppSection;
          Gds40Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
          end;
end;

initialization
     AddProcedure( imOptionalSectionModule, 40, SectionSetup );

end.

