
unit Gdm30Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, dxSkinsCore,
  dxSkinsdxBarPainter, dxBar, cxClasses, dxSkinsDefaultPainters, dxBarExtItems,
  dxGDIPlusClasses, cxImage, cxBarEditItem,

  AppManager,
  AppForms,
  AppContainer, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics,
  GestwinSkin;

type
  TGds30Frm = class(TFrame)
    ComprasAppSection: TgAppSection;
    VentasAppSection: TgAppSection;
    ResultadosAppSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
    Proveedores1Item: TdxBarButton;
    GruposProveedoresItem: TdxBarButton;
    FormasPagoItem: TdxBarButton;
    TarifasCompraHeader: TdxBarSubItem;
    TarifasProveedorItem: TdxBarButton;
    TarifasClasesComprasItem: TdxBarButton;
    RelacionesContablesCompraHeader: TdxBarSubItem;
    RelacionesGenericasComprasItem: TdxBarButton;
    RelacionesFamiliasComprasItem: TdxBarButton;
    FicherosComprasMenuItem: TdxBarSubItem;
    MantenimientoOfertasItem: TdxBarButton;
    Ofertas1: TdxBarSubItem;
    MantenimientoPedidosComprasItem: TdxBarButton;
    PendienteRecibirItem: TdxBarButton;
    PedidosCompraItem: TdxBarSubItem;
    MantenimientoAlbaranesComprasItem: TdxBarButton;
    CarteraArticulosComprasItem: TdxBarButton;
    EtiquetasRecepcionArticulosItem: TdxBarButton;
    AlbaranesItem: TdxBarSubItem;
    MantenimientoFacturasComprasItem: TdxBarButton;
    EmisionFacturasComprasItem: TdxBarButton;
    RelacionFacturasComprasItem: TdxBarButton;
    ImpresionDocumentosPagoItem: TdxBarButton;
    CierreComprasItem: TdxBarButton;
    FacturacionItem: TdxBarSubItem;
    Infexternos1Item: TdxBarSubItem;
    RecuperacionFrasCompraItem: TdxBarButton;
    ExportImportComprasItem: TdxBarButton;
    ProcesosComprasMenuItem: TdxBarSubItem;
    VentasMenuBar: TdxBar;
    MntClientes2Item: TdxBarButton;
    RegistroAuxiliarClientesItem: TdxBarButton;
    GruposClientesItem: TdxBarButton;
    MntVendedores1Item: TdxBarButton;
    TablaComisionHeader: TdxBarSubItem;
    TablaComisionArticuloItem: TdxBarButton;
    TablaComisionFamiliaItem: TdxBarButton;
    CodigosTarifaItem: TdxBarButton;
    TarifaVentaArticuloItem: TdxBarButton;
    TarifaVentaFamiliaItem: TdxBarButton;
    TarifasClienteArticuloItem: TdxBarButton;
    TarifaClienteFamiliaItem: TdxBarButton;
    TarifasCantidadItem: TdxBarButton;
    TarifasClienteClasesVentasItem: TdxBarButton;
    RutasItem: TdxBarButton;
    ConsumosItem: TdxBarButton;
    GeneracionConsumosItem: TdxBarButton;
    EquiposMovilesItem: TdxBarButton;
    PreventaItem: TdxBarSubItem;
    TransportistasItem: TdxBarButton;
    SeriesFacturacionItem: TdxBarButton;
    FormasCobroItem: TdxBarButton;
    RelacionesGenericasVentasItem: TdxBarButton;
    RelacionesGruposItem: TdxBarButton;
    RelacionesFamiliasVentasItem: TdxBarButton;
    MenuItem5: TdxBarSubItem;
    VentasPeriodicasItem: TdxBarButton;
    FicherosVentasMenuItem: TdxBarSubItem;
    MantPresupuestosItem: TdxBarButton;
    RentabilidadVentasPresupuestoItem: TdxBarButton;
    PresupuestosITem: TdxBarSubItem;
    MantenimientoPedidosVentasItem: TdxBarButton;
    RentabilidadVentasPedidoItem: TdxBarButton;
    PendienteServirItem: TdxBarButton;
    GeneracionAlbaranesSalidaItem: TdxBarButton;
    PedidosVentaItem: TdxBarSubItem;
    MantenimientoAlbaranesVentasItem: TdxBarButton;
    RentabilidadVentasAlbaranItem: TdxBarButton;
    CarteraArticulosVentasItem: TdxBarButton;
    CargaEnviosAlbaranesItem: TdxBarButton;
    PendienteCobroItem: TdxBarButton;
    EtiquetasEnvioArticulosItem: TdxBarButton;
    GeneracionVentasPeriodicasItem: TdxBarButton;
    MenuItem38: TdxBarSubItem;
    MantenimientoFacturasVentasItem: TdxBarButton;
    GeneracionFacturasVentasItem: TdxBarButton;
    RelacionFacturasVentasItem: TdxBarButton;
    LiquidacionComisionesItem: TdxBarButton;
    ImpresionDocumentosCobroItem: TdxBarButton;
    DiarioRecibosITem: TdxBarButton;
    CierreVentasItem: TdxBarButton;
    MenuItem43: TdxBarSubItem;
    RecuperacionFrasVentaItem: TdxBarButton;
    SupresionHeader: TdxBarSubItem;
    SupresionFacturasItem: TdxBarButton;
    SupAlbaranesItem: TdxBarButton;
    ExportImporVentasItem: TdxBarButton;
    CargaEquiposMovilesItem: TdxBarButton;
    DescargaRutasItem: TdxBarButton;
    ProcesoPreventaItem: TdxBarSubItem;
    ProcesosVentasMenuItem: TdxBarSubItem;
    BarManagerBar3: TdxBar;
    RelacionDocumentosProveedorItem: TdxBarButton;
    RelacionConsumosProveedorItem: TdxBarButton;
    DatEconProveedoresItem: TdxBarButton;
    ConsumoArticulosProveedorItem: TdxBarButton;
    ListadoordenadoporcomprasABC1: TdxBarButton;
    GraficosProveedoresItem: TdxBarButton;
    ResultadosProveedoresItem: TdxBarSubItem;
    Relacindedocumentos1: TdxBarButton;
    RelacionConsumosItem: TdxBarButton;
    ConsultaDatEconCliItem: TdxBarButton;
    ConsumoArticulosClienteItem: TdxBarButton;
    ListadoABCClienteItem: TdxBarButton;
    GraficosClientesItem: TdxBarButton;
    MenuItem22: TdxBarSubItem;
    ConsultaDatEconVenItem: TdxBarButton;
    ListadoConsumoVendedorItem: TdxBarButton;
    GraficosVendedoresItem: TdxBarButton;
    MenuItem58: TdxBarSubItem;
    ConsultaDatEconArtItem: TdxBarButton;
    ListadoABCComprasArticulosItem: TdxBarButton;
    ListadoABCVentasArticulosItem: TdxBarButton;
    ConsumoAProveedoresItem: TdxBarButton;
    ConsumoPorClienteItem: TdxBarButton;
    GraficosArticulosItem: TdxBarButton;
    MenuItem59: TdxBarSubItem;
    ReconstruccionItem: TdxBarButton;
    CierreComercialItem: TdxBarButton;
    ProcesosResultadosItem: TdxBarSubItem;
    TarifasVentaHeader: TdxBarSubItem;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    GruposDocumentoItem: TdxBarButton;
    ProcesosPreventaHeader: TdxBarSubItem;
    PreventaAutoventaHeader: TdxBarSubItem;
    RelacionesContablesVentaHeader: TdxBarSubItem;
    CargasItem: TdxBarSubItem;
    HojasCargaPedidoItem: TdxBarButton;
    CargaEnviosPedidosItem: TdxBarButton;
    EstadoArticulosPendientesItem: TdxBarButton;
    HojasCargaAlbaranItem: TdxBarButton;
    PackingListItem: TdxBarButton;
    RegistroAuxiliarProveedoresItem: TdxBarButton;
    FormasEnvioItem: TdxBarButton;
    SupPedidosItem: TdxBarButton;
    AlmacenAppSection: TgAppSection;
    ArticulosItem: TdxBarButton;
    FamiliasItem: TdxBarButton;
    ClaseAItem: TdxBarButton;
    ClaseBItem: TdxBarButton;
    ClaseCItem: TdxBarButton;
    CodigoBarrasItem: TdxBarButton;
    AlmacenesItem: TdxBarButton;
    UbicacionesItem: TdxBarButton;
    TiposMovAlmacenItem: TdxBarButton;
    ListasMaterialesItem: TdxBarButton;
    FicherosAlmacenMenuItem: TdxBarSubItem;
    MovimientosItem: TdxBarButton;
    FichasArticulosITem: TdxBarButton;
    MovimientosMenu: TdxBarSubItem;
    ExistenciasActualesItem: TdxBarButton;
    ExistenciasMensualesItem: TdxBarButton;
    ListadoExistenciasItem: TdxBarButton;
    ListadoUbicacionItem: TdxBarButton;
    ListadoMinimosItem: TdxBarButton;
    ExistenciasItem: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    CambioPreciosItem: TdxBarButton;
    ActualizacionDatosArticulosItem: TdxBarButton;
    ExportImportMovAlmacenItem: TdxBarButton;
    ProcesosAlmacenMenuItem: TdxBarSubItem;
    Ventana1: TdxBarSubItem;
    TiposEnvaseItem: TdxBarButton;
    CapturadoresItem: TdxBarButton;
    CargaDatosCapturadoresItem: TdxBarButton;
    DescargaDatosCapturadoresItem: TdxBarButton;
    TiposLineaMovimientoItem: TdxBarButton;
    OperariosItem: TdxBarButton;
    SincronizacionDatosTiendaMagentoItem: TdxBarButton;
    DescargaPedidosTiendaItem: TdxBarButton;
    CategoriasItem: TdxBarButton;
    GeneracionPedidosCompraItem: TdxBarButton;
    ExportImportArticulosItem: TdxBarButton;
    ExportacionImportacionCaptionItem: TdxBarSubItem;
    ExportacionDatosArticulosItem: TdxBarButton;
    DatosArticulosCaptionItem: TdxBarSubItem;
    TrazabilidadComponenteItem: TdxBarButton;
    ConsolidacionMovimientosItem: TdxBarButton;
    ImpresionOrdenesFabricacionItem: TdxBarButton;
    ImportacionPozosItem: TdxBarButton;
    DocumentoControlMercancias: TdxBarButton;
    FabricasItem: TdxBarButton;
    ImportacionEuropastryItem: TdxBarButton;
    ImportacionFacturasItem: TdxBarButton;
    OrganismosPublicosItem: TdxBarButton;
    TiposCambioItem: TdxBarButton;
    TiposVentasPeriodicasItem: TdxBarButton;
    VentasPeriodicasHeader: TdxBarSubItem;
    PruebasTiendaItem: TdxBarButton;
    VentasPeriodicasArticuloItem: TdxBarButton;
    SituacionHojasPedidoItem: TdxBarButton;
    CostesHojasPedidoItem: TdxBarButton;
    TiposIVAArticuloPaisItem: TdxBarButton;
    ImportacionFacturaEItem: TdxBarButton;
    RegistroFacturaEItem: TdxBarButton;
    TarifasCodigoTarifaClasesVentasItem: TdxBarButton;
    ClasesPorArticuloItem: TdxBarButton;
    SuministroVerifactuItem: TdxBarButton;
    procedure Relacindedocumentos1Click(Sender: TObject);
    procedure RelacionDocumentosProveedorItemClick(Sender: TObject);
    procedure MantenimientoOfertasItemClick(Sender: TObject);
    procedure AcercaClick(Sender: TObject);
    procedure FormasPagoItemClick(Sender: TObject);
    procedure MntProveedoresItemClick(Sender: TObject);
    procedure TarifasProveedorItemClick(Sender: TObject);
    procedure TarifasClasesComprasItemClick(Sender: TObject);
    procedure RelacionesGenericasComprasItemClick(Sender: TObject);
    procedure RelacionesFamiliasComprasItemClick(Sender: TObject);
    procedure MantenimientoPedidosComprasItemClick(Sender: TObject);
    procedure MantenimientoAlbaranesComprasItemClick(Sender: TObject);
    procedure MantenimientoFacturasComprasItemClick(Sender: TObject);
    procedure CierreComprasItemClick(Sender: TObject);
    procedure RecuperacionFrasCompraItemClick(Sender: TObject);
    procedure EmisionFacturasComprasItemClick(Sender: TObject);
    procedure RelacionFacturasComprasItemClick(Sender: TObject);
    procedure PendienteRecibirItemClick(Sender: TObject);
    procedure etiquetasRecepcionArticulosItemClick(Sender: TObject);
    procedure CarteraArticulosComprasItemClick(Sender: TObject);
    procedure ImpresionDocumentosPagoItemClick(Sender: TObject);
    procedure MainMenu30_1Update;
    procedure MantenimientoPedidosVentasItemClick(Sender: TObject);
    procedure TarifasCantidadItemClick(Sender: TObject);
    procedure RegistroAuxiliarClientesItemClick(Sender: TObject);
    procedure FormasCobroItemClick(Sender: TObject);
    procedure GruposClientesItemClick(Sender: TObject);
    procedure CodigosTarifaItemClick(Sender: TObject);
    procedure MntClientes1ItemClick(Sender: TObject);
    procedure MntVendedores1ItemClick(Sender: TObject);
    procedure SeriesFacturacionItemClick(Sender: TObject);
    procedure RelacionesGenericasVentasItemClick(Sender: TObject);
    procedure RelacionesGruposItemClick(Sender: TObject);
    procedure RelacionesFamiliasVentasItemClick(Sender: TObject);
    procedure MantPresupuestosItemClick(Sender: TObject);
    procedure VentasPeriodicasItemClick(Sender: TObject);
    procedure TarifasClienteClasesVentasItemClick(Sender: TObject);
    procedure MantenimientoAlbaranesVentasItemClick(Sender: TObject);
    procedure MantenimientoFacturasVentasItemClick(Sender: TObject);
    procedure GeneracionFacturasVentasItemClick(Sender: TObject);
    procedure CierreVentasItemClick(Sender: TObject);
    procedure RecuperacionFrasVentaItemClick(Sender: TObject);
    procedure GeneracionVentasPeriodicasItemClick(Sender: TObject);
    procedure SupresionFacturasItemClick(Sender: TObject);
    procedure PendienteServirItemClick(Sender: TObject);
    procedure CargaEnviosAlbaranesItemClick(Sender: TObject);
    procedure PendienteCobroItemClick(Sender: TObject);
    procedure CarteraArticulosVentasItemClick(Sender: TObject);
    procedure EtiquetasEnvioArticulosItemClick(Sender: TObject);
    procedure LiquidacionComisionesItemClick(Sender: TObject);
    procedure ImpresionDocumentosCobroItemClick(Sender: TObject);
    procedure DiarioRecibosITemClick(Sender: TObject);
    procedure SupAlbaranesItemClick(Sender: TObject);
    procedure RutasItemClick(Sender: TObject);
    procedure ConsumosItemClick(Sender: TObject);
    procedure GeneracionConsumosItemClick(Sender: TObject);
    procedure EquiposMovilesItemClick(Sender: TObject);
    procedure DescargaRutasItemClick(Sender: TObject);
    procedure CargaEquiposMovilesItemClick(Sender: TObject);
    procedure MainMenu30_2Update;
    procedure ConsultaDatEconCliItemClick(Sender: TObject);
    procedure DatEconProveedoresItemClick(Sender: TObject);
    procedure ConsultaDatEconVenItemClick(Sender: TObject);
    procedure ConsultaDatEconArtItemClick(Sender: TObject);
    procedure ConsumoArticulosProveedorItemClick(Sender: TObject);
    procedure ReconstruccionItemClick(Sender: TObject);
    procedure ConsumoArticulosClienteItemClick(Sender: TObject);
    procedure ListadoordenadoporcomprasABC1Click(Sender: TObject);
    procedure ListadoABCClienteItemClick(Sender: TObject);
    procedure CierreComercialItemClick(Sender: TObject);
    procedure ListadoABCComprasArticulosItemClick(Sender: TObject);
    procedure ListadoABCVentasArticulosItemClick(Sender: TObject);
    procedure ConsumoAProveedoresItemClick(Sender: TObject);
    procedure ConsumoPorClienteItemClick(Sender: TObject);
    procedure RelacionConsumosItemClick(Sender: TObject);
    procedure MenuItem71Click(Sender: TObject);
    function ComprasAppSectionSetAccess: Boolean;
    function VentasAppSectionSetAccess: Boolean;
    function ResultadosAppSectionSetAccess: Boolean;
    procedure RentabilidadVentasAlbaranItemClick(Sender: TObject);
    function ComprasAppSectionSetUserOption: Boolean;
    function VentasAppSectionSetUserOption: Boolean;
    procedure ListadoConsumoVendedorItemClick(Sender: TObject);
    procedure GruposProveedoresItemClick(Sender: TObject);
    procedure ExportImportComprasItemClick(Sender: TObject);
    procedure TarifaVentaArticuloItemClick(Sender: TObject);
    procedure TarifaVentaFamiliaItemClick(Sender: TObject);
    procedure TarifasClienteArticuloItemClick(Sender: TObject);
    procedure TarifaClienteFamiliaItemClick(Sender: TObject);
    procedure TablaComisionArticuloItemClick(Sender: TObject);
    procedure TablaComisionFamiliaItemClick(Sender: TObject);
    procedure RentabilidadVentasPedidoItemClick(Sender: TObject);
    procedure RentabilidadVentasPresupuestoItemClick(Sender: TObject);
    procedure ExportImporVentasItemClick(Sender: TObject);
    procedure RelacionConsumosProveedorItemClick(Sender: TObject);
    procedure GraficosProveedoresItemClick(Sender: TObject);
    procedure GraficosClientesItemClick(Sender: TObject);
    procedure GraficosVendedoresItemClick(Sender: TObject);
    procedure GraficosArticulosItemClick(Sender: TObject);
    procedure RelacionFacturasVentasItemClick(Sender: TObject);
    procedure ComprasAppSectionUpdateMainMenu;
    procedure VentasAppSectionUpdateMainMenu;
    procedure ResultadosAppSectionUpdateMainMenu;
    procedure GruposDocumentoItemClick(Sender: TObject);
    procedure CargaEnviosPedidosItemClick(Sender: TObject);
    procedure RegistroAuxiliarProveedoresItemClick(Sender: TObject);
    procedure FormasEnvioItemClick(Sender: TObject);
    procedure SupPedidosItemClick(Sender: TObject);
    procedure ExistenciasActualesItemClick(Sender: TObject);
    procedure ExistenciasMensualesItemClick(Sender: TObject);
    procedure ContenidoItemClick(Sender: TObject);
    function AlmacenAppSectionSetAccess: Boolean;
    procedure ArticulosItemClick(Sender: TObject);
    procedure FamiliasItemClick(Sender: TObject);
    procedure ListasMaterialesItemClick(Sender: TObject);
    procedure MovimientosItemClick(Sender: TObject);
    procedure TiposMovAlmacenItemClick(Sender: TObject);
    procedure FichasArticulosITemClick(Sender: TObject);
    procedure Almacenes1ItemClick(Sender: TObject);
    procedure UbicacionesItemClick(Sender: TObject);
    procedure ClaseAItemClick(Sender: TObject);
    procedure ClaseBItemClick(Sender: TObject);
    procedure ClaseCItemClick(Sender: TObject);
    procedure CambioPreciosItemClick(Sender: TObject);
    procedure ListadoMinimosItemClick(Sender: TObject);
    procedure ExportImportMovAlmacenItemClick(Sender: TObject);
    procedure ActualizacionDatosArticulosItemClick(Sender: TObject);
    procedure CodigoBarrasItemClick(Sender: TObject);
    procedure ListadoUbicacionItemClick(Sender: TObject);
    function AlmacenAppSectionSetUserOption: Boolean;
    procedure ListadoExistenciasItemClick(Sender: TObject);
    procedure EtiquetasArticulosItemClick(Sender: TObject);
    procedure AlmacenAppSectionUpdateMainMenu;
    procedure TransportistasItemClick(Sender: TObject);
    procedure TiposEnvaseItemClick(Sender: TObject);
    procedure TiposLineaMovimientoItemClick(Sender: TObject);
    procedure CapturadoresItemClick(Sender: TObject);
    procedure OperariosItemClick(Sender: TObject);
    procedure ExportImportArticulosItemClick(Sender: TObject);
    procedure ExportacionDatosArticulosItemClick(Sender: TObject);
    procedure ConsolidacionMovimientosItemClick(Sender: TObject);
    procedure TiposCambioItemClick(Sender: TObject);
    procedure TiposVentasPeriodicasItemClick(Sender: TObject);
    procedure VentasPeriodicasArticuloItemClick(Sender: TObject);
    procedure TiposIVAArticuloPaisItemClick(Sender: TObject);
    procedure TarifasCodigoTarifaClasesVentasItemClick(Sender: TObject);
    procedure ClasesPorArticuloItemClick(Sender: TObject);
    procedure SuministroVerifactuItemClick(Sender: TObject);
  private
    // fOnMovimientosCaja  : TMovimientosCajaEvent;
  public
    class var
    ComprasSection,
    VentasSection,
    ResultadosSection,
    AlmacenSection : TgAppSection;
    // property  OnMovimientosCaja : TMovimientosCajaEvent  read fOnMovimientosCaja write fOnMovimientosCaja;
  end;

var  Gds30Frm : TGds30Frm = nil;

implementation

{$R *.dfm}

Uses AppForm,

     Gdm00Dm,
     Gdm30Dm,

     dmi_pga,
     dmi_mov,

     dm_usr,
     dm_pga,
     dm_cls,
     dm_mov,
     dm_rac,
     dm_rap,
     dm_ope,
     dm_rpf,

     b_msg,
     b_uee,
     b_upd,

     //Compras

     a_pro,
     a_rap,
     a_gdp,
     a_tpp,
     a_tcc,
     a_fpa,
     a_rcc,
     a_rcf,

     a_mco,

     l_cpr,
     l_cac,
     a_fdc,
     b_efc,
     l_lfp,
     i_dpa,
     b_ccc,
     b_emc,
     b_rfc,

     r_mov,

     // Ventas

     a_cli,
     a_rac,
     a_gdc,
     a_tvp,
     a_vpe,
     b_vpa,
     a_ven,
     a_tcoa,
     a_tcof,
     a_cdt,
     a_tca,
     a_tva,
     a_tvf,
     a_tla,
     a_tlf,
     a_tcv,
     a_tct,
     a_tcn,
     a_fde,
     b_suf,

     a_rut,
     a_chc,
     b_gcc,
     a_eqm,

     a_fco,
     a_sdf,
     a_gdo,

     a_rvv,
     a_rgc,
     a_rvf,

     a_mve, cx_mve,

     l_cps,
     l_cpe,
     l_pco,
     l_cav,
     b_rmv,
     e_mov,
     b_gvp,

     a_fdv,
     b_efv,
     l_lfc,
     l_lcv,
     i_dco,
     l_dco,

     b_ccv,
     b_sfv,
     b_sua,
     b_sup,
     b_rfv,
     b_emv,
     b_iea,
     b_drc,
     b_cem,

     // Resultados

     b_rdp,
     b_rcp,
     d_pro,
     g_dep,

     b_cap,
     l_oco,
     b_rdc,
     d_cli,
     g_dec,

     b_cac,
     b_rcc,
     l_ove,
     d_ven,
     l_cva,
     g_dev,

     d_art,
     l_aoc,
     l_aov,
     l_cap,
     l_ccl,
     g_dea,

     b_rdr,
     b_cec,

     // Almacén

     a_art, e_art,
     a_tip,
     a_fam,
     a_cls,
     a_clsa,
     a_tde,
     a_lma,
     a_alm,
     a_ubi,
     a_tma,
     a_tlm,
     a_cdb,
     a_tra,
     a_cpt,
     a_ope,

     a_mov,
     b_fda,

     b_eda,
     b_eea,
     l_eda,
     l_uba,
     l_abm,

     a_cdp,
     b_cmr,
     b_iar,
     b_ear,
     b_ema;

resourceString
     RsMsg1  = 'Hojas de pedido';

{ Tgds30Frm }

procedure TGds30Frm.AcercaClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

//* ------------------------------------------------------------------------

// Compras

procedure TGds30Frm.FormasPagoItemClick(Sender: TObject);
begin
     MntFormasPago( [] );
end;

procedure TGds30Frm.GruposProveedoresItemClick(Sender: TObject);
begin
     MntGruposProveedores( [] );
end;

procedure TGds30Frm.MntProveedoresItemClick(Sender: TObject);
begin
     MntProveedores( [] );
end;

procedure TGds30Frm.TarifasProveedorItemClick(Sender: TObject);
begin
     MntTarifasProveedor( [] );
end;

procedure TGds30Frm.TarifasClasesComprasItemClick(Sender: TObject);
begin
     MntTarifasClaseCompras;
end;

procedure TGds30Frm.RelacionesGenericasComprasItemClick(Sender: TObject);
begin
     MntRelacionesCompras;
end;

procedure TGds30Frm.RelacionesFamiliasComprasItemClick(Sender: TObject);
begin
     MntRelacionesFamiliasCompras;
end;

procedure TGds30Frm.MantenimientoOfertasItemClick(Sender: TObject);
begin
     MntMovimientosCompra( [ tmOferta ] );
end;

procedure TGds30Frm.MantenimientoPedidosComprasItemClick(Sender: TObject);
begin
     MntMovimientosCompra( [ tmPedidoCompra ] );
end;

procedure TGds30Frm.MantenimientoAlbaranesComprasItemClick(Sender: TObject);
begin
     MntMovimientosCompra( [ tmCompra ] );
end;

procedure TGds30Frm.MantenimientoFacturasComprasItemClick(Sender: TObject);
begin
     MntFacturasCompra( [] );
end;

procedure TGds30Frm.CierreComprasItemClick(Sender: TObject);
begin
     CierreCicloCompras;
end;

procedure TGds30Frm.RecuperacionFrasCompraItemClick(Sender: TObject);
begin
     RecuperacionFacturasCompra;
end;

procedure TGds30Frm.EmisionFacturasComprasItemClick(Sender: TObject);
begin
     EmisionFacturasCompra;
end;

procedure TGds30Frm.RelacionFacturasComprasItemClick(Sender: TObject);
begin
     ListadoRelacionFrasProveedores;
end;

procedure TGds30Frm.RelacionFacturasVentasItemClick(Sender: TObject);
begin
     ListadoRelacionFrasClientes;
end;

procedure TGds30Frm.PendienteRecibirItemClick(Sender: TObject);
begin
     ConsultaPendienteRecibir;
end;

procedure TGds30Frm.EtiquetasRecepcionArticulosItemClick(Sender: TObject);
begin
     EtiquetasArticulosDesdeMovimientos( tmCompra, '', 0, '' );
end;

procedure TGds30Frm.CarteraArticulosComprasItemClick(Sender: TObject);
begin
     ListadoCarteraAlbaranesCompra;
end;

procedure TGds30Frm.ImpresionDocumentosPagoItemClick(Sender: TObject);
begin
     ImpresionDocumentosPago( '', '' );
end;

procedure TGds30Frm.MainMenu30_1Update;
begin

end;

// Ventas

procedure TGds30Frm.MantenimientoPedidosVentasItemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmPedidoVenta ] );
end;

procedure TGds30Frm.TablaComisionArticuloItemClick(Sender: TObject);
begin
     MntTablaComisionesArticulo( [] );
end;

procedure TGds30Frm.TablaComisionFamiliaItemClick(Sender: TObject);
begin
     MntTablaComisionesFamilia( [] );
end;

procedure TGds30Frm.TarifaClienteFamiliaItemClick(Sender: TObject);
begin
     MntTarifasClienteFamilia( [] );
end;

procedure TGds30Frm.TarifasCantidadItemClick(Sender: TObject);
begin
     MntTarifasVentaConsumo( [] );
end;

procedure TGds30Frm.RegistroAuxiliarClientesItemClick(Sender: TObject);
begin
     MntAuxiliarClientes( [] );
end;

procedure TGds30Frm.RegistroAuxiliarProveedoresItemClick(Sender: TObject);
begin
     MntAuxiliarProveedores( [] );
end;

procedure TGds30Frm.FormasCobroItemClick(Sender: TObject);
begin
     MntFormasCobro( [] );
end;

procedure TGds30Frm.FormasEnvioItemClick(Sender: TObject);
begin
     MntFormasEnvio( [] );
end;

procedure TGds30Frm.GraficosArticulosItemClick(Sender: TObject);
begin
     GraficosArticulos;
end;

procedure TGds30Frm.GraficosClientesItemClick(Sender: TObject);
begin
     GraficosClientes;
end;

procedure TGds30Frm.GraficosProveedoresItemClick(Sender: TObject);
begin
     GraficosProveedores;
end;

procedure TGds30Frm.GraficosVendedoresItemClick(Sender: TObject);
begin
     GraficosVendedores;
end;

procedure TGds30Frm.GruposClientesItemClick(Sender: TObject);
begin
     MntGruposCliente( [] );
end;

procedure TGds30Frm.GruposDocumentoItemClick(Sender: TObject);
begin
     MntGruposDocumento( [] );
end;

procedure TGds30Frm.CodigosTarifaItemClick(Sender: TObject);
begin
     MntCodigosTarifa( [] );
end;

procedure TGds30Frm.TarifaVentaArticuloItemClick(Sender: TObject);
begin
     MntTarifasVentaArticulo( [] );
end;

procedure TGds30Frm.TarifaVentaFamiliaItemClick(Sender: TObject);
begin
     MntTarifasVentaFamilia( [] );
end;

procedure TGds30Frm.mntClientes1ItemClick(Sender: TObject);
begin
     MntClientes( [] );
end;

procedure TGds30Frm.MntVendedores1ItemClick(Sender: TObject);
begin
     MntVendedores( [] );
end;

procedure TGds30Frm.SeriesFacturacionItemClick(Sender: TObject);
begin
     MntSeriesFacturacion( [] );
end;

procedure TGds30Frm.RelacionesGenericasVentasItemClick(Sender: TObject);
begin
     MntRelacionesVentas;
end;

procedure TGds30Frm.RelacionesGruposItemClick(Sender: TObject);
begin
     MntRelacionesGruposClientes;
end;

procedure TGds30Frm.RelacionesFamiliasVentasItemClick(Sender: TObject);
begin
     MntRelacionesFamiliasVentas;
end;

procedure TGds30Frm.MantPresupuestosItemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmPresupuesto ] );
end;

procedure TGds30Frm.VentasPeriodicasArticuloItemClick(Sender: TObject);
begin
     VentasPeriodicasArticulo;
end;

procedure TGds30Frm.VentasPeriodicasItemClick(Sender: TObject);
begin
     MntVentasPeriodicas( [] );
end;

procedure TGds30Frm.TarifasClienteClasesVentasItemClick(Sender: TObject);
begin
     MntTarifasClienteClaseVentas;
end;

procedure TGds30Frm.TarifasCodigoTarifaClasesVentasItemClick(Sender: TObject);
begin
     MntTarifasCodigoTarifaClaseVentas;
end;

procedure TGds30Frm.TarifasClienteArticuloItemClick(Sender: TObject);
begin
     MntTarifasClienteArticulo( [] );
end;

procedure TGds30Frm.MantenimientoAlbaranesVentasItemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmVenta ] );
end;

procedure TGds30Frm.MantenimientoFacturasVentasItemClick(Sender: TObject);
begin
     MntFacturasVenta( [] );
end;

procedure TGds30Frm.GeneracionFacturasVentasItemClick(Sender: TObject);
begin
     EmisionFacturasVenta;
end;

procedure TGds30Frm.CierreVentasItemClick(Sender: TObject);
begin
     CierreCicloVentas;
end;

procedure TGds30Frm.RecuperacionFrasVentaItemClick(Sender: TObject);
begin
     RecuperacionFacturasVenta;
end;

procedure TGds30Frm.GeneracionVentasPeriodicasItemClick(Sender: TObject);
begin
     GeneracionVentasPeriodicas;
end;

procedure TGds30Frm.SupresionFacturasItemClick(Sender: TObject);
begin
     SupresionFacturasVenta;
end;

procedure TGds30Frm.PendienteServirItemClick(Sender: TObject);
begin
     ListadoPendienteServir;
end;

procedure TGds30Frm.CargaEnviosAlbaranesItemClick(Sender: TObject);
begin
     ListadoCargaEnvios( tmVenta );
end;

procedure TGds30Frm.CargaEnviosPedidosItemClick(Sender: TObject);
begin
     ListadoCargaEnvios( tmPedidoVenta );
end;

procedure TGds30Frm.PendienteCobroItemClick(Sender: TObject);
begin
     ListadoPendienteCobro;
end;

procedure TGds30Frm.CarteraArticulosVentasItemClick(Sender: TObject);
begin
     ListadoCarteraAlbaranesVenta;
end;

procedure TGds30Frm.EtiquetasEnvioArticulosItemClick(Sender: TObject);
begin
     EtiquetasArticulosDesdeMovimientos( tmVenta, '', 0, '' );
end;

procedure TGds30Frm.LiquidacionComisionesItemClick(Sender: TObject);
begin
     LiquidacionComisiones;
end;

procedure TGds30Frm.impresionDocumentosCobroItemClick(Sender: TObject);
begin
     ImpresionDocumentosCobro( ApplicationContainer.Ejercicio, '', 0 );
end;

procedure TGds30Frm.DiarioRecibosITemClick(Sender: TObject);
begin
     ListadoDocumentosCobro( '', 0 )
end;

procedure TGds30Frm.ExportacionDatosArticulosItemClick(Sender: TObject);
begin
     ExportacionDatosArticulos;
end;

procedure TGds30Frm.ExportImporVentasItemClick(Sender: TObject);
begin
     ExportImportMovimientosVenta( [] );
end;

procedure TGds30Frm.SuministroVerifactuItemClick(Sender: TObject);
begin
     SuministroFacturasVerifactu;
end;

procedure TGds30Frm.SupAlbaranesItemClick(Sender: TObject);
begin
     SupresionAlbaranesVenta;
end;

procedure TGds30Frm.SupPedidosItemClick(Sender: TObject);
begin
     SupresionPedidosVenta;
end;

procedure TGds30Frm.ExportImportArticulosItemClick(Sender: TObject);
begin
     ExportImportArticulos;
end;

procedure TGds30Frm.ExportImportComprasItemClick(Sender: TObject);
begin
     ExportImportMovimientosCompra;
end;

procedure TGds30Frm.RutasItemClick(Sender: TObject);
begin
     MntRutas( [] );
end;

procedure TGds30Frm.ConsumosItemClick(Sender: TObject);
begin
     MntConsumosCliente( [] );
end;

procedure TGds30Frm.GeneracionConsumosItemClick(Sender: TObject);
begin
     GeneraConsumos( '', nil );
end;

procedure TGds30Frm.EquiposMovilesItemClick(Sender: TObject);
begin
     MntEquiposMoviles( [] );
end;

procedure TGds30Frm.DescargaRutasItemClick(Sender: TObject);
begin
     DescargaRutasyConsumos;
end;

procedure TGds30Frm.CargaEquiposMovilesItemClick(Sender: TObject);
begin
     CargaEquiposMoviles;
end;

procedure TGds30Frm.MainMenu30_2Update;
begin
end;

// Resultados y estadísticas

procedure TGds30Frm.ConsultaDatEconCliItemClick(Sender: TObject);
begin
     DatosEconomicosClientes( [] );
end;

procedure TGds30Frm.DatEconProveedoresItemClick(Sender: TObject);
begin
     DatosEconomicosProveedores( [] );
end;

procedure TGds30Frm.ConsultaDatEconVenItemClick(Sender: TObject);
begin
     DatosEconomicosVendedores( [] );
end;

procedure TGds30Frm.ConsolidacionMovimientosItemClick(Sender: TObject);
begin
     ConsolidacionMovimientosRegularizacion;
end;

procedure TGds30Frm.ConsultaDatEconArtItemClick(Sender: TObject);
begin
     DatosEconomicosArticulos( [] );
end;

procedure TGds30Frm.ConsumoArticulosProveedorItemClick(Sender: TObject);
begin
     ConsultaConsumoProveedores;
end;

procedure TGds30Frm.ReconstruccionItemClick(Sender: TObject);
begin
     ProcesoReconstruccionResultados;
end;

procedure TGds30Frm.ConsumoArticulosClienteItemClick(Sender: TObject);
begin
     ConsultaConsumoClientes;
end;

procedure TGds30Frm.ListadoordenadoporcomprasABC1Click(Sender: TObject);
begin
     ListadoABCProveedores;
end;

procedure TGds30Frm.ListadoABCClienteItemClick(Sender: TObject);
begin
     ListadoABCClientes;
end;

procedure TGds30Frm.CierreComercialItemClick(Sender: TObject);
begin
     CierreEjercicioComercial;
end;

procedure TGds30Frm.ListadoABCComprasArticulosItemClick(Sender: TObject);
begin
     ListadoABCArticulosCompras;
end;

procedure TGds30Frm.Relacindedocumentos1Click(Sender: TObject);
begin
     RelacionDocumentosClientes( [] );
end;

procedure TGds30Frm.RelacionConsumosItemClick(Sender: TObject);
begin
     RelacionConsumoClientes( [] );
end;

procedure TGds30Frm.RelacionConsumosProveedorItemClick(Sender: TObject);
begin
     RelacionConsumoProveedores( [] );
end;

procedure TGds30Frm.RelacionDocumentosProveedorItemClick(Sender: TObject);
begin
     RelacionDocumentosProveedores( [] );
end;

procedure TGds30Frm.ListadoABCVentasArticulosItemClick(Sender: TObject);
begin
     ListadoABCArticulosVentas;
end;

procedure TGds30Frm.ConsumoAProveedoresItemClick(Sender: TObject);
begin
     ListadoConsumoProveedores( True );
end;

procedure TGds30Frm.ConsumoPorClienteItemClick(Sender: TObject);
begin
     ListadoConsumoClientes( True );
end;

procedure TGds30Frm.MenuItem71Click(Sender: TObject);
begin
     ShowHelp;
end;

function TGds30Frm.ComprasAppSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.acCO.Value<>0;
end;

function TGds30Frm.VentasAppSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.acVE.Value<>0;
end;

function TGds30Frm.ResultadosAppSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.acRE.Value<>0;
end;

procedure TGds30Frm.ResultadosAppSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

       With DataModule00.DmEmpresaFields do
          begin
          SetBarItemVisible( ListadoConsumoVendedorItem, not Vendedor_ComPorCli.Value );
          end;

     finally
       BarManager.EndUpdate;
     end;
end;

procedure TGds30Frm.RentabilidadVentasPedidoItemClick(Sender: TObject);
begin
     ConsultaRentabilidadMovimientosVenta( [ tmPedidoVenta ] );
end;

procedure TGds30Frm.RentabilidadVentasPresupuestoItemClick(Sender: TObject);
begin
     ConsultaRentabilidadMovimientosVenta( [ tmPresupuesto ] );
end;

procedure TGds30Frm.RentabilidadVentasAlbaranItemClick(Sender: TObject);
begin
     ConsultaRentabilidadMovimientosVenta( [ tmVenta ] );
end;

procedure TGds30Frm.ListadoConsumoVendedorItemClick(Sender: TObject);
begin
     ListadoConsumoVendedores;
end;

function TGds30Frm.ComprasAppSectionSetUserOption: Boolean;
begin
     case DataModule00.DmUsuarioFields.VentanaInicio.Value of
       7 : MntMovimientosCompra( [ tmPedidoCompra ] );
       8 : MntMovimientosCompra( [ tmCompra ] );
       end;
     Result := DataModule00.DmUsuarioFields.VentanaInicio.Value in [ 7, 8 ];
end;

procedure TGds30Frm.ComprasAppSectionUpdateMainMenu;
begin

     BarManager.BeginUpdate;
     try

       // Control de accesos

       {
       TarifasCompraHeader.Style := ApplicationContainer.MenuHeaderStyle;
       RelacionesContablesCompraHeader.Style := ApplicationContainer.MenuHeaderStyle;
       }

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( FicherosComprasMenuItem, UsuarioMaestro or ( AcCOFicheros.Value<>0 ) );
         SetBarItemVisible( ProcesosComprasMenuItem, UsuarioMaestro or ( AcCOProcesos.Value<>0 ) );
         SetBarItemVisible( RecuperacionFrasCompraItem, UsuarioMaestro or ( ( AcProcesosCriticos.Value<>0 ) and ( AcGC.Value<>0 ) ) );
         end;

       With DataModule00.DmEmpresaFields do
         begin
         SetBarItemsVisible( [ RelacionesContablesCompraHeader, RelacionesGenericasComprasItem, RelacionesFamiliasComprasItem ], UsuarioMaestro );

         SetBarItemVisible( RegistroAuxiliarProveedoresItem, Proveedor_RegAuxiliar.Value );
         If   Proveedor_RegAuxiliar.Value
         then RegistroAuxiliarProveedoresItem.Caption := NombreAuxiliarProveedor( True, True, True );

         SetBarItemVisible( GruposProveedoresItem, Proveedor_Grupos.Value );
         SetBarItemVisible( TarifasClasesComprasItem, Articulo_TarifaClase.Value );
         SetBarItemVisible( EmisionFacturasComprasItem, Compras_EmitirFras.Value );
         end;

     finally
       BarManager.EndUpdate;
       end;

end;

function TGds30Frm.VentasAppSectionSetUserOption: Boolean;
begin
     case DataModule00.DmUsuarioFields.VentanaInicio.Value of
        9 : MntMovimientosVenta( [ tmPresupuesto ] );
       10 : MntMovimientosVenta( [ tmPedidoVenta ] );
       11 : MntMovimientosVenta( [ tmVenta ] );
       end;
     Result := DataModule00.DmUsuarioFields.VentanaInicio.Value in [ 9, 10, 11 ];
end;

procedure TGds30Frm.VentasAppSectionUpdateMainMenu;
begin

     BarManager.BeginUpdate;
     try

       {
       TablaComisionHeader.Style := ApplicationContainer.MenuHeaderStyle;
       TarifasVentaHeader.Style := ApplicationContainer.MenuHeaderStyle;
       SupresionHeader.Style := ApplicationContainer.MenuHeaderStyle;
       PreventaAutoventaHeader.Style := ApplicationContainer.MenuHeaderStyle;
       RelacionesContablesVentaHeader.Style := ApplicationContainer.MenuHeaderStyle;
       VentasPeriodicasHeader.Style := ApplicationContainer.MenuHeaderStyle;
       ProcesosPreventaHeader.Style := ApplicationContainer.MenuHeaderStyle;
       TiendaVirtualHeader.Style := ApplicationContainer.MenuHeaderStyle;
       }

       // Control de accesos

       With DataModule00, DmEmpresaFields, DataModule00.DmUsuarioFields do
         begin

         // Ficheros

         SetBarItemVisible( FicherosVentasMenuItem, UsuarioMaestro or ( AcVEFicheros.Value<>0 ) );

         SetBarItemVisible( RegistroAuxiliarClientesItem, Cliente_RegAuxiliar.Value );
         If   Cliente_RegAuxiliar.Value
         then RegistroAuxiliarClientesItem.Caption := NombreAuxiliarCliente( True, True, True );

         SetBarItemVisible( GruposClientesItem, Cliente_GruposFac.Value );
         SetBarItemVisible( FormasEnvioItem, Ventas_FormaEnvio.Value );
         SetBarItemsVisible( [ VentasPeriodicasHeader, TiposVentasPeriodicasItem, VentasPeriodicasItem, VentasPeriodicasArticuloItem ], Cliente_VenPeriodica.Value );

         SetBarItemsVisible( [ TablaComisionHeader, TablaComisionArticuloItem, TablaComisionFamiliaItem ], not Vendedor_ComPorCli.Value );

         SetBarItemVisible( TransportistasItem, Ventas_Transportista.Value );

         SetBarItemVisible( OperariosItem, Ventas_Operarios.Value );
         If   Ventas_Operarios.Value
         then OperariosItem.Caption := NombreOperarios( True, True );

         SetBarItemsVisible( [ PreventaAutoventaHeader, RutasItem, ConsumosItem, GeneracionConsumosItem, EquiposMovilesItem ], Ventas_PreAutoVenta.Value<>0 );
         SetBarItemsVisible( [ CodigosTarifaItem, TarifaVentaArticuloItem, TarifaVentaFamiliaItem ], Cliente_TarCodigo.Value );
         SetBarItemVisible( GruposDocumentoItem, DataModule00.PartidasPresupuestarias );
         SetBarItemVisible( TarifasClienteArticuloItem, Cliente_Referencias.Value );
         SetBarItemVisible( TarifasCantidadItem, Cliente_TarConsumo.Value );
         SetBarItemsVisible( [ TarifasClienteClasesVentasItem, TarifasCodigoTarifaClasesVentasItem ], Articulo_TarifaClase.Value );
         SetBarItemsVisible( [ RelacionesContablesVentaHeader, RelacionesGenericasVentasItem, RelacionesGruposItem, RelacionesFamiliasVentasItem ], UsuarioMaestro );
         SetBarItemVisible( TiposCambioItem, Contable_Divisas.Value );

         // Presupuesto

         SetBarItemVisible( RentabilidadVentasPresupuestoItem, Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRentabilidad, Ventas_MostrarRentabilidad ) and not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value );

         // Pedidos

         SetBarItemVisible( CargaEnviosPedidosItem, Articulo_Bultos.Value );
         SetBarItemVisible( RentabilidadVentasPedidoItem, Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRentabilidad, Ventas_MostrarRentabilidad ) and not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value );

         If   ApplicationContainer.IsModuleActive( [ 120 ] )
         then MantenimientoPedidosVentasItem.Caption := RsMsg1;

         // Albaranes

         SetBarItemVisible( CargaEnviosAlbaranesItem, Articulo_Bultos.Value );
         SetBarItemVisible( RentabilidadVentasAlbaranItem, Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRentabilidad, Ventas_MostrarRentabilidad ) and not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value );
         SetBarItemVisible( GeneracionVentasPeriodicasItem, Cliente_VenPeriodica.Value );

         // Facturas

         SetBarItemVisible( SuministroVerifactuItem, EntornoVerifactu );

         // Procesos

         SetBarItemVisible( ProcesosVentasMenuItem, UsuarioMaestro or ( AcVEProcesos.Value<>0 ) or ( AcVETiendaVirtual.Value<>0 ) );
         SetBarItemsVisible( [ SupresionHeader, ExportImporVentasItem ], UsuarioMaestro or ( AcVEProcesos.Value<>0 ) );
         SetBarItemVisible( SincronizacionDatosTiendaMagentoItem, UsuarioMaestro or ( AcVETiendaVirtual.Value<>0 ) );
         SetBarItemsVisible( [ SupresionHeader, SupAlbaranesItem, SupPedidosItem, SupresionFacturasItem ], ( UsuarioMaestro or ( AcProcesosCriticos.Value<>0 ) ) );
         SetBarItemsVisible( [ RecuperacionFrasVentaItem ], ( UsuarioMaestro or ( ( AcProcesosCriticos.Value<>0 ) and ( AcGC.Value<>0 ) ) ) );

         SetBarItemsVisible( [ ProcesosPreventaHeader, CargaEquiposMovilesItem, DescargaRutasItem ], UsuarioMaestro  or ( ( Ventas_PreAutoVenta.Value<>0 ) and ( AcVEProcesos.Value<>0 ) ) );
         end;

     finally
       BarManager.EndUpdate;
     end;

end;

procedure TGds30Frm.OperariosItemClick(Sender: TObject);
begin
     MntOperarios( [] );
end;

procedure TGds30Frm.ContenidoItemClick(Sender: TObject);
begin
     ShowHelp;
end;

function TGds30Frm.AlmacenAppSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.acAL.Value<>0;
end;

// ....

procedure TGds30Frm.ArticulosItemClick(Sender: TObject);
begin
     MntArticulos( [] );
end;

procedure TGds30Frm.FamiliasItemClick(Sender: TObject);
begin
     MntFamilias( [] );
end;

procedure TGds30Frm.ListasMaterialesItemClick(Sender: TObject);
begin
     MntListaMateriales( [] );
end;

procedure TGds30Frm.MovimientosItemClick(Sender: TObject);
begin
     MntMovimientosAlmacen( [] );
end;

procedure TGds30Frm.TiposCambioItemClick(Sender: TObject);
begin
     MntTiposCambio;
end;

procedure TGds30Frm.TiposEnvaseItemClick(Sender: TObject);
begin
     MntTiposEnvase( [] );
end;

procedure TGds30Frm.TiposIVAArticuloPaisItemClick(Sender: TObject);
begin
     MntTiposIVAArticuloPais( [] );
end;

procedure TGds30Frm.TiposLineaMovimientoItemClick(Sender: TObject);
begin
     MntTiposLineaMovimiento( [] );
end;

procedure TGds30Frm.TiposMovAlmacenItemClick(Sender: TObject);
begin
     MntTiposMovimientoAlmacen( [] );
end;

procedure TGds30Frm.TiposVentasPeriodicasItemClick(Sender: TObject);
begin
     MntTiposVentasPeriodicas( [] );
end;

procedure TGds30Frm.TransportistasItemClick(Sender: TObject);
begin
     MntTransportistas( [] );
end;

procedure TGds30Frm.ListadoUbicacionItemClick(Sender: TObject);
begin
     ListadoUbicacion;
end;

procedure TGds30Frm.FichasArticulosITemClick(Sender: TObject);
begin
     FichaArticulos( [] );
end;

procedure TGds30Frm.Almacenes1ItemClick(Sender: TObject);
begin
     MntAlmacenes( [] );
end;

procedure TGds30Frm.UbicacionesItemClick(Sender: TObject);
begin
     MntUbicaciones( [] );
end;

procedure TGds30Frm.ClaseAItemClick(Sender: TObject);
begin
     MntClases( [ tcClaseA, '' ] )
end;

procedure TGds30Frm.ClaseBItemClick(Sender: TObject);
begin
     MntClases( [ tcClaseB, '' ] )
end;

procedure TGds30Frm.ClaseCItemClick(Sender: TObject);
begin
     MntClases( [ tcClaseC, '' ] )
end;

procedure TGds30Frm.ClasesPorArticuloItemClick(Sender: TObject);
begin
     MntClasesPorArticulo;
end;

procedure TGds30Frm.ExistenciasMensualesItemClick(Sender: TObject);
begin
     ConsultaExistenciasMensuales;
end;

procedure TGds30Frm.EtiquetasArticulosItemClick(Sender: TObject);
begin
     EtiquetasArticulos( '' );
end;

procedure TGds30Frm.ExistenciasActualesItemClick(Sender: TObject);
begin
     ConsultaExistenciasActuales;
end;

procedure TGds30Frm.CambioPreciosItemClick(Sender: TObject);
begin
     MntCambioPrecios;
end;

procedure TGds30Frm.CapturadoresItemClick(Sender: TObject);
begin
     MntCapturadores(  [] );
end;

procedure TGds30Frm.ListadoExistenciasItemClick(Sender: TObject);
begin
     ListadoExistenciasArticulos;
end;

procedure TGds30Frm.ListadoMinimosItemClick(Sender: TObject);
begin
     ListadoBajoMinimosExceso;
end;

procedure TGds30Frm.ExportImportMovAlmacenItemClick(Sender: TObject);
begin
     ExportImportMovAlmacen;
end;

procedure TGds30Frm.ActualizacionDatosArticulosItemClick( Sender: TObject);
begin
     ActualizacionDatosArticulos;
end;

procedure TGds30Frm.CodigoBarrasItemClick(Sender: TObject);
begin
     MntCodigosBarras( [] );
end;

function TGds30Frm.AlmacenAppSectionSetUserOption: Boolean;
begin
     Result :=  False;
     If   DataModule00.DmUsuarioFields.VentanaInicio.Value=12
     then begin
          MntMovimientosAlmacen( [] );
          Result := True;
          end;
end;

procedure TGds30Frm.AlmacenAppSectionUpdateMainMenu;
begin

     BarManager.BeginUpdate;
     try

       // Control de accesos

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( FicherosAlmacenMenuItem, UsuarioMaestro  or ( AcALFicheros.Value<>0 ) );
         SetBarItemVisible( ProcesosAlmacenMenuItem, UsuarioMaestro  or ( AcALProcesos.Value<>0 ) or ( acALCambioPrecios.Value<>0 ) );
         end;

       // TiendaVirtualAlmacenHeader.Style := ApplicationContainer.MenuHeaderStyle;

       With DataModule00.DmEmpresaFields do
         begin

         SetBarItemVisible( TiposIVAArticuloPaisItem, Contable_VentasOnlineIntracomunitarias.Value );
         SetBarItemVisible( UbicacionesItem, Stock_MultiAlmacen.Value and Stock_Ubicaciones.Value );

         SetBarItemVisible( ClaseAItem, Articulo_ExisteClase[ 1 ].Value );
         ClaseAItem.Caption := Clase.NombreClase( tcClaseA, True, True );

         SetBarItemVisible( ClaseBItem, Articulo_ExisteClase[ 2 ].Value );
         ClaseBItem.Caption := Clase.NombreClase( tcClaseB, True, True );

         SetBarItemVisible( ClaseCItem, Articulo_ExisteClase[ 3 ].Value );
         ClaseCItem.Caption := Clase.NombreClase( tcClaseC, True, True );

         SetBarItemVisible( TiposLineaMovimientoItem, Stock_TiposLineaMovimiento.Value );
         end;

       // Se puede mostrar la opción de 'Cambio de precios de artículos' sin tener activado el acceso a los procesos de la sección.

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( CambioPreciosItem, UsuarioMaestro  or ( acALCambioPrecios.Value<>0 ) or ( AcProcesosCriticos.Value<>0 ) );
         SetBarItemVisible( ExportImportMovAlmacenItem, UsuarioMaestro  or ( AcProcesosCriticos.Value<>0 ) );

         SetBarItemsVisible( [ ConsolidacionMovimientosItem, 
                               DatosArticulosCaptionItem,
                               ActualizacionDatosArticulosItem,
                               ExportacionDatosArticulosItem,
                               ExportacionImportacionCaptionItem,
                               ExportImportMovAlmacenItem,
                               ExportImportArticulosItem ], UsuarioMaestro  or ( AcALProcesos.Value<>0 ) );
                                                                       
         end;

       SetBarItemVisible( TiposEnvaseItem, DataModule00.Envases );
       {$IFDEF DEBUGAPP}
       SetBarItemVisible( ClasesPorArticuloItem, DataModule00.TiendaVirtual and DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value );
       {$ENDIF}

     finally
       BarManager.EndUpdate;
       end;
end;

procedure SectionSetup;
begin
     Gds30Frm := TGds30Frm.Create( Application );
     If   Assigned( Gds30Frm )
     then With ApplicationContainer do
            begin

            TGds30Frm.ComprasSection := Gds30Frm.ComprasAppSection;
            TGds30Frm.VentasSection := Gds30Frm.VentasAppSection;
            TGds30Frm.ResultadosSection := Gds30Frm.ResultadosAppSection;
            TGds30Frm.AlmacenSection := Gds30Frm.AlmacenAppSection;

            If   ProgramNumber in [ pnDesarrollo, pnComercial, pnContableComercial, pnDemostracion ]
            then begin
                 AddAppSection( Gds30Frm.ComprasAppSection );
                 AddAppSection( Gds30Frm.VentasAppSection );
                 AddAppSection( Gds30Frm.ResultadosAppSection );
                 end;

            AddAppSection( Gds30Frm.AlmacenAppSection );

            Gds30Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;

            end;
end;

initialization
     AddProcedure( imSectionModule, 30, SectionSetup );

end.

