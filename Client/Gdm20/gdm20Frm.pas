
unit Gdm20Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses,
  dxSkinsDefaultPainters, dxBarExtItems, cxImage, cxBarEditItem,

  AppManager,
  AppForms,
  AppContainer;

type
  TGds20Frm = class(TFrame)
    TPVSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
    Clientes1: TdxBarButton;
    SeriesFacturacionItem: TdxBarButton;
    FormasCobroItem: TdxBarButton;
    TipoIVAItem: TdxBarButton;
    FicherosMenu: TdxBarSubItem;
    PedidosVentaItem: TdxBarButton;
    MntTickecksItem: TdxBarButton;
    Facturas1: TdxBarButton;
    Pagosporcaja1: TdxBarButton;
    GeneracionFrasItem: TdxBarButton;
    Arqueo1: TdxBarButton;
    Caja1: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    ExportacionImportacionItem: TdxBarButton;
    ProcesosItem: TdxBarSubItem;
    procedure ContenidoItemClick(Sender: TObject);
    function TPVSectionSetAccess: Boolean;
    procedure AcercaItemClick(Sender: TObject);
    procedure MntTickecksItemClick(Sender: TObject);
    procedure Cajas1Click(Sender: TObject);
    procedure Facturas1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Artculos1Click(Sender: TObject);
    procedure Pagosporcaja1Click(Sender: TObject);
    procedure Arqueo1Click(Sender: TObject);
    procedure GeneracionFrasItemClick(Sender: TObject);
    function TPVSectionSetUserOption: Boolean;
    procedure PedidosVentaItemClick(Sender: TObject);
    procedure FormasCobroItemClick(Sender: TObject);
    procedure SeriesFacturacionItemClick(Sender: TObject);
    procedure TipoIVAItemClick(Sender: TObject);
    procedure ExportacionImportacionItemClick(Sender: TObject);
    procedure TPVSectionUpdateMainMenu;
  private

  public

  end;

var  Gds20Frm : TGds20Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,
       
       Gdm00Dm,
       Gdm30Dm,

       dmi_mov,

       dm_cls,
       dm_pga,
       dm_mov,

       a_cli,
       a_art,
       a_sdf,
       a_fco,
       a_iva,
       a_mve,
       a_tck,
       a_fdv,
       a_mdc,
       a_arq,
       b_efv,
       b_emv;

procedure TGds20Frm.SeriesFacturacionItemClick(Sender: TObject);
begin
     MntSeriesFacturacion( [] );
end;

procedure TGds20Frm.ContenidoItemClick(Sender: TObject);
begin
     ShowHelp;
end;

function TGds20Frm.TPVSectionSetAccess: Boolean;
begin
     Result := True;
end;

procedure TGds20Frm.AcercaItemClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

// ....

procedure TGds20Frm.PedidosVentaItemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmPedidoVenta ] );
end;

procedure TGds20Frm.MntTickecksItemClick(Sender: TObject);
begin
     MntTickets( [] );
end;

procedure TGds20Frm.Cajas1Click(Sender: TObject);
begin
     MntSeriesFacturacion( [] );
end;

procedure TGds20Frm.Facturas1Click(Sender: TObject);
begin
     MntFacturasVenta( [] );
end;

procedure TGds20Frm.FormasCobroItemClick(Sender: TObject);
begin
     MntFormasCobro( [] );
end;

procedure TGds20Frm.Clientes1Click(Sender: TObject);
begin
     MntClientes( [] );
end;

procedure TGds20Frm.Artculos1Click(Sender: TObject);
begin
     MntArticulos( [] );
end;

procedure TGds20Frm.TipoIVAItemClick(Sender: TObject);
begin
     MntTiposIVA( False );
end;

procedure TGds20Frm.Pagosporcaja1Click(Sender: TObject);
begin
     MntMovimientosCaja( [] );
end;

procedure TGds20Frm.Arqueo1Click(Sender: TObject);
begin
     ArqueoCaja;
end;

procedure TGds20Frm.GeneracionFrasItemClick(Sender: TObject);
begin
     EmisionFacturasVenta;
end;

procedure TGds20Frm.ExportacionImportacionItemClick(Sender: TObject);
begin
     ExportImportMovimientosVenta( [ tmPedidoVenta, tmVenta ] );
end;

function TGds20Frm.TPVSectionSetUserOption: Boolean;
begin
     Result := False;
     If   ProgramNumber=2   // Es el Módulo de T.P.V.
     then begin
          MntTickets( [] );
          Result := True;
          end;
end;

procedure TGds20Frm.TPVSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

       // Control de accesos

       SetBarItemVisible( PedidosVentaItem, ParametrosTPVRec.EdicionPedidos );

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( ProcesosItem, AcCAProcesos.Value<>0 );
         end;

     finally
       BarManager.EndUpdate;
     end;
end;

procedure SectionSetup;
begin
     Gds20Frm := TGds20Frm.Create( Application );
     If   Assigned( Gds20Frm )
     then ApplicationContainer.AddAppSection( Gds20Frm.TPVSection );
end;

initialization
     AddProcedure( imOptionalSectionModule, 20, SectionSetup );

end.

