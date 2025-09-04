
unit Gdm10Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, dxSkinsCore,
  dxSkinsdxBarPainter, ToolWin, cxClasses,
  dxBar, dxBarExtItems, ImgList, cxGraphics, cxLabel, cxBarEditItem,
  dxSkinsDefaultPainters, cxImage,

  AppManager,
  AppContainer, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, cxStyles;

type
  TGds10Frm = class(TFrame)
    FContableSection: TgAppSection;
    FLibrosIVASection: TgAppSection;
    FCobrosPagosSection: TgAppSection;
    FInmovilizadoSection: TgAppSection;
    BarManager: TdxBarManager;
    ContabilidadBar: TdxBar;
    LibrosIVABar: TdxBar;
    ContenidoItem: TdxBarButton;
    PGC1Item: TdxBarButton;
    MenuItem28: TdxBarSubItem;
    FicherosMenu: TdxBarSubItem;
    AsientosItem: TdxBarSubItem;
    Listados1Item: TdxBarSubItem;
    InformesExternos1Item: TdxBarSubItem;
    ProcesosContableItem: TdxBarSubItem;
    Ficheros2MenuItem: TdxBarSubItem;
    VentasItem: TdxBarSubItem;
    ComprasItem: TdxBarSubItem;
    InformesExternos2Item: TdxBarSubItem;
    ProcesosIVAItem: TdxBarSubItem;
    SubcuentasItem: TdxBarButton;
    ConceptosItem: TdxBarButton;
    AsientosTipoItem: TdxBarButton;
    CentrosCosteItem: TdxBarButton;
    ClientesDeudoresItem: TdxBarButton;
    ProveedoresAcreedoresItem: TdxBarButton;
    TiposIVAItem: TdxBarButton;
    TablaRetencionesItem: TdxBarButton;
    RelacionesDivisasItem: TdxBarButton;
    MantenimientoAsientosItem: TdxBarButton;
    MntExtractosItem: TdxBarButton;
    PunteoItem: TdxBarButton;
    ConsultaSaldosItem: TdxBarButton;
    DiarioItem: TdxBarButton;
    DiarioResumenItem: TdxBarButton;
    ListadoExtractosItem: TdxBarButton;
    SaldosDAItem: TdxBarButton;
    BalancePeriodoItem: TdxBarButton;
    BalanceSumasItem: TdxBarButton;
    PerdidasyGanancias1990Item: TdxBarButton;
    BalanceSituacion1990Item: TdxBarButton;
    CuadroFinanciacion1990Item: TdxBarButton;
    VariacionCapital1990Item: TdxBarButton;
    PerdidasyGananciasAnalitica1990Item: TdxBarButton;
    CuentaPyGItem: TdxBarButton;
    BalanceSituacionItem: TdxBarButton;
    EstadoCambiosPatrimonioItem: TdxBarButton;
    GraficosSaldosItem: TdxBarButton;
    BalancesInformesItem: TdxBarButton;
    NotaListadoInformesItem: TdxBarButton;
    ExistenciasItem: TdxBarButton;
    Consolidacindeempresas1: TdxBarButton;
    CierreEjercicioItem: TdxBarButton;
    ProcesosEspecialesItem: TdxBarSubItem;
    ReconstruccionSaldosItem: TdxBarButton;
    RenumeracionItem: TdxBarButton;
    ImportExportAsientosItem: TdxBarButton;
    EnlaceA3Item: TdxBarButton;
    SustitucionSubcuentasItem: TdxBarButton;
    VerificacionItem: TdxBarButton;
    LiquidacionIVAItem: TdxBarButton;
    Declaracion347Item: TdxBarButton;
    MntFrasEmitidasItem: TdxBarButton;
    Impresindellibroregistro1: TdxBarButton;
    RelacionOperacionesClienteItem: TdxBarButton;
    RetencionesPracticadasItem: TdxBarButton;
    MntFrasRecibidasItem: TdxBarButton;
    Impresindellibroregistro2: TdxBarButton;
    Relacindeoperacionesporproveedor1: TdxBarButton;
    RetencionesSoportadasItem: TdxBarButton;
    PrevisionBar: TdxBar;
    BancosItem: TdxBarButton;
    DisponibilidadItem: TdxBarButton;
    FormasPagoItem: TdxBarButton;
    FormasCobroItem: TdxBarButton;
    Ficheros3MenuItem: TdxBarSubItem;
    MntEfectosCobroItem: TdxBarButton;
    AnotacionCobroItem: TdxBarButton;
    ReleacionEfectosClienteItem: TdxBarButton;
    TablaEfectosCobrarItem: TdxBarButton;
    FrasPendientesCobroItem: TdxBarButton;
    ImpresionRecibosItem: TdxBarButton;
    RemesasHeader: TdxBarSubItem;
    MntRemesasItem: TdxBarButton;
    CobroItem: TdxBarButton;
    DescuentoItem: TdxBarButton;
    ImpagadosItem: TdxBarButton;
    CancelacionRemesasHeader: TdxBarSubItem;
    CancelacionRemesaItem: TdxBarButton;
    CancelacionEfectoItem: TdxBarButton;
    CancelacionAutomaticaItem: TdxBarButton;
    RecibosRemesaItem: TdxBarButton;
    CobrosItem: TdxBarSubItem;
    MntEfectosPagarItem: TdxBarButton;
    AnotacionPagoItem: TdxBarButton;
    TablaEfectosPagarItem: TdxBarButton;
    FrasPendientesPagoItem: TdxBarButton;
    ImpresionDocPagoItem: TdxBarButton;
    RemesasPagoHeader: TdxBarSubItem;
    MntRemesasPagoItem: TdxBarButton;
    Listado1: TdxBarButton;
    Impresindecartadepago1: TdxBarButton;
    EmisionDocumentosPagoRemesaItem: TdxBarButton;
    Pago1: TdxBarButton;
    EmisionDocPagoItem: TdxBarButton;
    PagosItem: TdxBarSubItem;
    RiesgoBancosItem: TdxBarButton;
    RiesgoClientesItem: TdxBarButton;
    ListadoEvolucionItem: TdxBarButton;
    ListadoAntiguedadItem: TdxBarButton;
    RiesgoItem: TdxBarSubItem;
    InmovilizadoBar: TdxBar;
    ElementosItem: TdxBarButton;
    Ficheros4MenuItem: TdxBarSubItem;
    ListadoSituacionItem: TdxBarButton;
    FichasItem: TdxBarButton;
    ListadosItem: TdxBarSubItem;
    GeneracionAmortizacionItem: TdxBarButton;
    ProcesosInmovilizadoItem: TdxBarSubItem;
    PGC4Item: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarSeparator1: TdxBarSeparator;
    SeriesFacturacionItem: TdxBarButton;
    ProcesosEspecialesHeader: TdxBarSubItem;
    AceptacionItem: TdxBarButton;
    InformeAplazamientoPagoItem: TdxBarButton;
    NombreSeccion1Item: TdxBarStatic;
    CuentasAnaliticasItem: TdxBarButton;
    BalanceFinancieroAnaliticoItem: TdxBarButton;
    RegularizacionIVACCItem: TdxBarButton;
    ListadoGestionCobroItem: TdxBarButton;
    ExportacionFicherosItem: TdxBarButton;
    PruebasCargaItem: TdxBarButton;
    SuministroFrasEmitidasItem: TdxBarButton;
    SuministroFrasRecibidasItem: TdxBarButton;
    ProcesosCobrosPagosItem: TdxBarSubItem;
    ConsultaCuentasEntidadesItem: TdxBarButton;
    Declaracion349Item: TdxBarButton;
    ImportacionFacturasItem: TdxBarButton;
    procedure SubcuentasItemClick(Sender: TObject);
    procedure AcercaDeGESTWIN1Click(Sender: TObject);
    procedure PGC1ItemClick(Sender: TObject);
    procedure ConceptosItemClick(Sender: TObject);
    procedure AsientosTipoItemClick(Sender: TObject);
    procedure CentrosCosteItemClick(Sender: TObject);
    procedure MantenimientoAsientosItemClick(Sender: TObject);
    procedure ReconstruccionSaldosItemClick(Sender: TObject);
    procedure MntExtractosItemClick(Sender: TObject);
    procedure PunteoItemClick(Sender: TObject);
    procedure ConsultaSaldosItemClick(Sender: TObject);
    procedure Contenido1ItemClick(Sender: TObject);
    procedure DiarioItemClick(Sender: TObject);
    procedure DiarioResumenItemClick(Sender: TObject);
    procedure SaldosDAItemClick(Sender: TObject);
    procedure BalancePeriodoItemClick(Sender: TObject);
    procedure BalanceSumasItemClick(Sender: TObject);
    procedure CuentaPyGItemClick(Sender: TObject);
    procedure BalanceSituacionItemClick(Sender: TObject);
    procedure RenumeracionItemClick(Sender: TObject);
    procedure ExistenciasItemClick(Sender: TObject);
    procedure CierreEjercicioItemClick(Sender: TObject);
    procedure ImportExportAsientosItemClick(Sender: TObject);
    procedure EnlaceA3ItemClick(Sender: TObject);
    procedure SustitucionSubcuentasItemClick(Sender: TObject);
    procedure ListadoExtractosItemClick(Sender: TObject);
    procedure Consolidacindeempresas1Click(Sender: TObject);
    procedure VerificacionItemClick(Sender: TObject);
    procedure ClientesDeudoresItemClick(Sender: TObject);
    procedure TiposIVAItemClick(Sender: TObject);
    procedure TablaRetencionesItemClick(Sender: TObject);
    procedure MntFrasEmitidasItemClick(Sender: TObject);
    procedure ProveedoresAcreedoresItemClick(Sender: TObject);
    procedure MntFrasRecibidasItemClick(Sender: TObject);
    procedure RelacionOperacionesClienteItemClick(Sender: TObject);
    procedure RelacionesDivisasItemClick(Sender: TObject);
    procedure Impresindellibroregistro1Click(Sender: TObject);
    procedure RetencionesPracticadasItemClick(Sender: TObject);
    procedure Impresindellibroregistro2Click(Sender: TObject);
    procedure Relacindeoperacionesporproveedor1Click(Sender: TObject);
    procedure RetencionesSoportadasItemClick(Sender: TObject);
    procedure LiquidacionIVAItemClick(Sender: TObject);
    procedure Contenido1Click(Sender: TObject);
    procedure Declaracion347ItemClick(Sender: TObject);
    procedure DisponibilidadItemClick(Sender: TObject);
    procedure ListadoEvolucionItemClick(Sender: TObject);
    procedure FormasCobroItemClick(Sender: TObject);
    procedure FormasPagoItemClick(Sender: TObject);
    procedure MntEfectosCobroItemClick(Sender: TObject);
    procedure AnotacionCobroItemClick(Sender: TObject);
    procedure MntEfectosPagarItemClick(Sender: TObject);
    procedure AnotacionPagoItemClick(Sender: TObject);
    procedure MntRemesasItemClick(Sender: TObject);
    procedure BancosItemClick(Sender: TObject);
    procedure ImpagadosItemClick(Sender: TObject);
    procedure CobroItemClick(Sender: TObject);
    procedure DescuentoItemClick(Sender: TObject);
    procedure CancelacionRemesaItemClick(Sender: TObject);
    procedure CancelacionEfectoItemClick(Sender: TObject);
    procedure ListadoAntiguedadItemClick(Sender: TObject);
    procedure TablaEfectosCobrarItemClick(Sender: TObject);
    procedure TablaEfectosPagarItemClick(Sender: TObject);
    procedure FrasPendientesCobroItemClick(Sender: TObject);
    procedure FrasPendientesPagoItemClick(Sender: TObject);
    procedure RiesgoBancosItemClick(Sender: TObject);
    procedure RiesgoClientesItemClick(Sender: TObject);
    procedure Contenido3ItemClick(Sender: TObject);
    procedure MntRemesasPagoItemClick(Sender: TObject);
    procedure Pago1Click(Sender: TObject);
    function FContableSectionSetAccess: Boolean;
    function FContableSectionSetUserOption: Boolean;
    function FLibrosIVASectionSetAccess: Boolean;
    function FLibrosIVASectionSetUserOption: Boolean;
    function FCobrosPagosSectionSetAccess: Boolean;
    function FCobrosPagosSectionSetUserOption: Boolean;
    procedure ElementosItemClick(Sender: TObject);
    procedure ListadoSituacionItemClick(Sender: TObject);
    procedure FichasItemClick(Sender: TObject);
    procedure GeneracionAmortizacionItemClick(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    function FInmovilizadoSectionSetAccess: Boolean;
    procedure CancelacionAutomaticaItemClick(Sender: TObject);
    procedure EstadoCambiosPatrimonioItemClick(Sender: TObject);
    procedure GraficosSaldosItemClick(Sender: TObject);
    procedure ImpresionDocumentosCobroItemClick(Sender: TObject);
    procedure EmisionDocumentosCobroRemesaItemClick(Sender: TObject);
    procedure ImpresionDocumentosPagoItemClick(Sender: TObject);
    procedure EmisionDocumentosPagoRemesaItemClick(Sender: TObject);
    procedure ReleacionEfectosClienteItemClick(Sender: TObject);
    procedure FContableSectionUpdateMainMenu;
    procedure FLibrosIVASectionUpdateMainMenu;
    procedure FCobrosPagosSectionUpdateMainMenu;
    procedure FInmovilizadoSectionUpdateMainMenu;
    procedure SeriesFacturacionItemClick(Sender: TObject);
    procedure AceptacionItemClick(Sender: TObject);
    procedure InformeAplazamientoPagoItemClick(Sender: TObject);
    procedure CuentasAnaliticasItemClick(Sender: TObject);
    procedure RegularizacionIVACCItemClick(Sender: TObject);
  private
    FOnMovimientosCaja,
    FOnEfectosACobrar : TMantenimientoEvent;

  public

  class var
     ContableSection,
     LibrosIVASection,
     CobrosPagosSection,
     InmovilizadoSection : TgAppSection;

     property  OnMovimientosCaja : TMantenimientoEvent  read fOnMovimientosCaja write fOnMovimientosCaja;
     property  OnEfectosACobrar  : TMantenimientoEvent  read fOnEfectosACobrar  write fOnEfectosACobrar;
  end;

var  Gds10Frm : TGds10Frm = nil;

implementation

{$R *.dfm}

Uses LibUtils,
     AppForms,

     Gdm00Dm,
     Gim00Fields,

     AppForm,

     dmi_pga,

     dm_pga,

     b_msg,
     b_uee,
     b_upd,

     a_sub,
     a_con,
     a_tas,
     a_cco,
     a_can,

     a_ast,
     b_ext,
     b_pun,
     b_sal,

     l_dia,
     l_dir,
     l_ext,
     l_sda,
     l_bmp,
     l_bss,
     p_con,

     l_pyg,
     l_bsi,
     l_cpn,

     g_sal,

     a_exi,
     b_rsa,
     b_rda,
     b_ccn,
     b_iex,
     b_ea3,
     b_sds,
     b_cde,
     b_vec,


     // Libros registro del I.V.A.


     a_cli,
     a_pro,
     a_iva,
     a_ret,
     a_sdf,
     a_rdi,

     a_fvi,
     l_lfe,
     l_roc,
     l_lrp,

     a_fcg,
     l_lfr,
     l_rop,
     l_lrs,

     l_liv,
     b_ric,
     b_rop,

     // Previsión de cobros y pagos

     a_ban,
     a_fpa,
     a_fco,
     a_dcf,

     a_ecc,
     a_ace,
     d_rec,
     l_tec,
     l_fpc,

     a_rem,
     a_aim,
     a_cor,
     a_are,
     a_dre,
     a_cre,
     a_cde,
     b_car,
     i_rdr,

     i_ecc,

     a_ecp,
     a_ape,
     l_tep,
     l_fpp,
     i_ecp,

     a_rdp,
     a_par,
     i_rrp,

     d_reb,
     d_rdc,
     l_esf,
     l_adu,
     l_adp,

     // Gestión del inmovilizado

     a_edi,
     l_sei,
     l_fei,
     b_gaa,


     //Módulos

     dm_ast;

procedure TGds10Frm.Contenido1ItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds10Frm.PGC1ItemClick(Sender: TObject);
begin
     ShowHelpForm( 'pgc', 'Contenido' );
end;

procedure TGds10Frm.SeriesFacturacionItemClick(Sender: TObject);
begin
     MntSeriesFacturacion( [] );
end;

procedure TGds10Frm.AceptacionItemClick(Sender: TObject);
begin
     MntAceptacionRemesas( [] );
end;

procedure TGds10Frm.AcercaDeGESTWIN1Click(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( true );
end;

procedure TGds10Frm.SubcuentasItemClick(Sender: TObject);
begin
     MntCuentas( [] );
end;

procedure TGds10Frm.ConceptosItemClick(Sender: TObject);
begin
     MntConceptosApunte( [] );
end;

procedure TGds10Frm.AsientosTipoItemClick(Sender: TObject);
begin
     MntAsientosTipo( [] );
end;

procedure TGds10Frm.CentrosCosteItemClick(Sender: TObject);
begin
     MntCentrosCoste( [] );
end;

procedure TGds10Frm.MantenimientoAsientosItemClick(Sender: TObject);
begin
     MntAsientos( [] );
end;

procedure TGds10Frm.ReconstruccionSaldosItemClick(Sender: TObject);
begin
     ReconstruccionSaldos;
end;

procedure TGds10Frm.RegularizacionIVACCItemClick(Sender: TObject);
begin
     RegularizacionIVACC;
end;

procedure TGds10Frm.MntExtractosItemClick(Sender: TObject);
begin
     ExtractoCuentas( [], True );
end;

procedure TGds10Frm.PunteoItemClick(Sender: TObject);
begin
     PunteoCuentas( [] );
end;

procedure TGds10Frm.ConsultaSaldosItemClick(Sender: TObject);
begin
     SaldoCuentas( True );
end;

procedure TGds10Frm.DiarioItemClick(Sender: TObject);
begin
     DiarioContable;
end;

procedure TGds10Frm.DiarioResumenItemClick(Sender: TObject);
begin
     DiarioResumenMensual;
end;

procedure TGds10Frm.SaldosDAItemClick(Sender: TObject);
begin
     SaldosDeudoresAcreedores;
end;

procedure TGds10Frm.BalancePeriodoItemClick(Sender: TObject);
begin
     BalanceMovimientos;
end;

procedure TGds10Frm.BalanceSumasItemClick(Sender: TObject);
begin
     BalanceSumasySaldos;
end;

procedure TGds10Frm.CuentaPyGItemClick(Sender: TObject);
begin
     CuentaPerdidasyGanancias;
end;

procedure TGds10Frm.CuentasAnaliticasItemClick(Sender: TObject);
begin
     MntCuentaAnalitica( [] );
end;

procedure TGds10Frm.BalanceSituacionItemClick(Sender: TObject);
begin
     BalanceSituacion;
end;

procedure TGds10Frm.RenumeracionItemClick(Sender: TObject);
begin
     RenumeraAsientos;
end;

procedure TGds10Frm.ExistenciasItemClick(Sender: TObject);
begin
     MntExistencias;
end;

procedure TGds10Frm.CierreEjercicioItemClick(Sender: TObject);
begin
     CierreEjercicioContable;
end;

procedure TGds10Frm.ImportExportAsientosItemClick(Sender: TObject);
begin
     ExportacionImportacionAsientos;
end;

procedure TGds10Frm.EnlaceA3ItemClick(Sender: TObject);
begin
     EnlaceA3;
end;

procedure TGds10Frm.EstadoCambiosPatrimonioItemClick(Sender: TObject);
begin
     EstadoCambiosPatrimonio;
end;

procedure TGds10Frm.SustitucionSubcuentasItemClick(Sender: TObject);
begin
     SustituyeSubcuentas;
end;

procedure TGds10Frm.ListadoExtractosItemClick(Sender: TObject);
begin
     ListadoExtractos;
end;

procedure TGds10Frm.Consolidacindeempresas1Click(Sender: TObject);
begin
     ConsolidaEmpresas;
end;

procedure TGds10Frm.VerificacionItemClick(Sender: TObject);
begin
     VerificaContabilidad;
end;

// Libros registro del I.V.A.

procedure TGds10Frm.ClientesDeudoresItemClick(Sender: TObject);
begin
     MntClientes( [] );
end;

procedure TGds10Frm.TiposIVAItemClick(Sender: TObject);
begin
     MntTiposIVA( False );
end;

procedure TGds10Frm.TablaRetencionesItemClick(Sender: TObject);
begin
     MntRetenciones( False );
end;

procedure TGds10Frm.MntFrasEmitidasItemClick(Sender: TObject);
begin
     MntFacturasEmitidas( [] );
end;

procedure TGds10Frm.ProveedoresAcreedoresItemClick(Sender: TObject);
begin
     MntProveedores( [] );
end;

procedure TGds10Frm.MntFrasRecibidasItemClick(Sender: TObject);
begin
     MntFacturasRecibidas( [] );
end;

procedure TGds10Frm.RelacionOperacionesClienteItemClick(Sender: TObject);
begin
     RelacionOperacionesClientes;
end;

procedure TGds10Frm.ReleacionEfectosClienteItemClick(Sender: TObject);
begin
     RelacionEfectosCobrar;
end;

procedure TGds10Frm.RelacionesDivisasItemClick(Sender: TObject);
begin
     MntRelacionesDivisa( [] );
end;

procedure TGds10Frm.ImpresinDelLibroregistro1Click(Sender: TObject);
begin
     LibroRegistroVentas;
end;

procedure TGds10Frm.RetencionesPracticadasItemClick(Sender: TObject);
begin
     LibroRetencionesPracticadas;
end;

procedure TGds10Frm.Impresindellibroregistro2Click(Sender: TObject);
begin
     LibroRegistroCompras;
end;

procedure TGds10Frm.Relacindeoperacionesporproveedor1Click(Sender: TObject);
begin
     RelacionOperacionesProveedores;
end;

procedure TGds10Frm.RetencionesSoportadasItemClick(Sender: TObject);
begin
     LibroRetencionesACuenta;
end;

procedure TGds10Frm.LiquidacionIVAItemClick(Sender: TObject);
begin
     LiquidacionIVA;
end;

procedure TGds10Frm.Contenido1Click(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds10Frm.Declaracion347ItemClick(Sender: TObject);
begin
     DeclaracionModelo347;
end;

// Previsión de cobros y pagos

procedure TGds10Frm.DisponibilidadItemClick(Sender: TObject);
begin
     MntDisponibilidad( [] );
end;

procedure TGds10Frm.InformeAplazamientoPagoItemClick(Sender: TObject);
begin
     InformeAplazamientoPago;
end;

procedure TGds10Frm.ListadoEvolucionItemClick(Sender: TObject);
begin
     ListadoEvolucionFinanciera;
end;

procedure TGds10Frm.FormasCobroItemClick(Sender: TObject);
begin
     MntFormasCobro( [] );
end;

procedure TGds10Frm.FormasPagoItemClick(Sender: TObject);
begin
     MntFormasPago( [] );
end;

procedure TGds10Frm.MntEfectosCobroItemClick(Sender: TObject);
begin
     If   Assigned( FOnEfectosACobrar )
     then FOnEfectosACobrar( [] )
     else MntEfectosCobrar( [] );
end;

procedure TGds10Frm.AnotacionCobroItemClick(Sender: TObject);
begin
     MntAnotacionCobroEfectos( [] );
end;

procedure TGds10Frm.MntEfectosPagarItemClick(Sender: TObject);
begin
     MntEfectosPagar( [] );
end;

procedure TGds10Frm.AnotacionPagoItemClick(Sender: TObject);
begin
     MntAnotacionPagoEfectos( [] );
end;

procedure TGds10Frm.MntRemesasItemClick(Sender: TObject);
begin
     MntRemesas( [] );
end;

procedure TGds10Frm.BancosItemClick(Sender: TObject);
begin
     MntBancos( [] );
end;

procedure TGds10Frm.ImpagadosItemClick(Sender: TObject);
begin
     MntAnotacionImpagados( [] );
end;

procedure TGds10Frm.CobroItemClick(Sender: TObject);
begin
     MntAnotacionCobroRemesas( [] );
end;

procedure TGds10Frm.DescuentoItemClick(Sender: TObject);
begin
     MntDescuentoRemesas( [] );
end;

procedure TGds10Frm.CancelacionRemesaItemClick(Sender: TObject);
begin
     MntCancelacionRemesas( [] );
end;

procedure TGds10Frm.CancelacionEfectoItemClick(Sender: TObject);
begin
     MntCancelacionEfectos( [] );
end;

procedure TGds10Frm.TablaEfectosCobrarItemClick(Sender: TObject);
begin
     TablaEfectosCobrar;
end;

procedure TGds10Frm.TablaEfectosPagarItemClick(Sender: TObject);
begin
     TablaEfectosPagar;
end;

procedure TGds10Frm.FrasPendientesCobroItemClick(Sender: TObject);
begin
     FacturasPendientesCobro;
end;

procedure TGds10Frm.FrasPendientesPagoItemClick(Sender: TObject);
begin
     FacturasPendientesPago;
end;

procedure TGds10Frm.ImpresionDocumentosCobroItemClick(Sender: TObject);
begin
     ImpresionDocumentosCobro( '', 0, 0 );
end;

procedure TGds10Frm.ImpresionDocumentosPagoItemClick(Sender: TObject);
begin
     ImpresionDocumentosPago( '', '', 0, '' );
end;

procedure TGds10Frm.RiesgoBancosItemClick(Sender: TObject);
begin
     RiesgoEnBancos;
end;

procedure TGds10Frm.RiesgoClientesItemClick(Sender: TObject);
begin
     RiesgoClientes;
end;

procedure TGds10Frm.Contenido3ItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds10Frm.MntRemesasPagoItemClick(Sender: TObject);
begin
     MntRemesasPago( [] );
end;

procedure TGds10Frm.Pago1Click(Sender: TObject);
begin
     MntAnotacionPagoRemesas( [] );
end;

procedure TGds10Frm.EmisionDocumentosCobroRemesaItemClick(Sender: TObject);
begin
     EmisionRecibosRemesa( 0 );
end;

procedure TGds10Frm.EmisionDocumentosPagoRemesaItemClick(Sender: TObject);
begin
     EmisionDocumentosRemesaPago( 0 );
end;

procedure TGds10Frm.ListadoAntiguedadItemClick(Sender: TObject);
begin
     ListadoAntiguedadDeuda;
end;

function TGds10Frm.FContableSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.acGC.Value<>0;
end;

function TGds10Frm.FContableSectionSetUserOption: Boolean;
begin
     If   DataModule00.DmUsuarioFields.VentanaInicio.Value=1
     then MntAsientos( [] );
     Result := DataModule00.DmUsuarioFields.VentanaInicio.Value in [ 0, 1 ];
end;

procedure TGds10Frm.FContableSectionUpdateMainMenu;

var  PGC2008 : Boolean;

begin

     BarManager.BeginUpdate;
     try

       // Control de accesos

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( AsientosItem, AcGCAsientos.Value<>0 );
         SetBarItemVisible( Listados1Item, AcGCListados.Value<>0 );

         SetBarItemsVisible( [ ProcesosEspecialesHeader, ReconstruccionSaldosItem, RenumeracionItem, ImportExportAsientosItem, EnlaceA3Item, SustitucionSubcuentasItem, VerificacionItem ], AcGCProcesos.Value<>0 );
         If   AcGCProcesos.Value<>0
         then SetBarItemsVisible( [ RenumeracionItem, SustitucionSubcuentasItem ], ( Codigo.Value='00' ) or ( AcProcesosCriticos.Value<>0 ) );
         end;

       // ProcesosEspecialesHeader.Style := ApplicationContainer.MenuHeaderStyle;

       // Parámetros de la empresa activa

       SetBarItemVisible( CentrosCosteItem, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );

       SetBarItemVisible( ExistenciasItem, not DataModule00.DmEmpresaFields.Contable_NoUsarExistencias.Value );

       //* 02.08.2004  Comprobando ejercicios cerrados

       {
       If   ApplicationContainer.CambioDeEmpresa
       then Asiento.CompruebaEjercicioCerrado( False );
       }

     finally
       BarManager.EndUpdate;
       end;
end;

function TGds10Frm.FLibrosIVASectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.acLI.Value<>0;
end;

function TGds10Frm.FLibrosIVASectionSetUserOption: Boolean;
begin
     case DataModule00.DmUsuarioFields.VentanaInicio.Value of
       2 : MntFacturasEmitidas( [] );
       3 : MntFacturasRecibidas( [] );
       end;
     Result := DataModule00.DmUsuarioFields.VentanaInicio.Value in [ 2, 3 ];
end;

procedure TGds10Frm.FLibrosIVASectionUpdateMainMenu;
begin

     BarManager.BeginUpdate;
     try

       // Control de accesos

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( Ficheros2MenuItem, AcLIFicheros.Value<>0 );
         end;

       With DataModule00.DmEmpresaFields do
         begin
         SetBarItemVisible( RetencionesPracticadasItem, Contable_Retenciones.Value );
         SetBarItemVisible( RelacionesDivisasItem, Contable_Divisas.Value or Compras_Divisas.Value or Ventas_Divisas.Value );
         SetBarItemVisible( RegularizacionIVACCItem, ( RegimenEspecialCriterioCaja.Value or Asiento.ExistenApuntesTraspasoIVA or Asiento.EjercicioTransicionCriterioCaja ) and ( ApplicationContainer.Ejercicio>2014 ) );
         end;

     finally
       BarManager.EndUpdate;
     end;
end;

function TGds10Frm.FCobrosPagosSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.AcPC.Value<>0;
end;

function TGds10Frm.FCobrosPagosSectionSetUserOption: Boolean;
begin
     case DataModule00.DmUsuarioFields.VentanaInicio.Value of
       4 : MntEfectosCobrar( [] );
       5 : MntEfectosPagar( [] );
       6 : MntRemesas( [] );
       end;
     Result := DataModule00.DmUsuarioFields.VentanaInicio.Value in [ 4, 5, 6 ];
end;

procedure TGds10Frm.FCobrosPagosSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

       // Control de accesos

       {
       RemesasHeader.Style := ApplicationContainer.MenuHeaderStyle;
       CancelacionRemesasHeader.Style := ApplicationContainer.MenuHeaderStyle;
       RemesasPagoHeader.Style := ApplicationContainer.MenuHeaderStyle;
       }

       SetBarItemVisible( Ficheros3MenuItem, DataModule00.DmUsuarioFields.AcPCFicheros.Value<>0 );

     finally
        BarManager.EndUpdate;
     end;
end;

procedure TGds10Frm.ElementosItemClick(Sender: TObject);
begin
     MntElementosInmovilizado( [] );
end;

procedure TGds10Frm.ListadoSituacionItemClick(Sender: TObject);
begin
     ListadoSituacionElementos;
end;

procedure TGds10Frm.FichasItemClick(Sender: TObject);
begin
     FichasElementosInmovilizado;
end;

procedure TGds10Frm.GeneracionAmortizacionItemClick(Sender: TObject);
begin
     generaAsientosAmortizacion;
end;

procedure TGds10Frm.GraficosSaldosItemClick(Sender: TObject);
begin
     GraficoSaldos;
end;

procedure TGds10Frm.MenuItem19Click(Sender: TObject);
begin
     ShowHelp;
end;

function TGds10Frm.FInmovilizadoSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.AcEI.Value<>0;
end;

procedure TGds10Frm.FInmovilizadoSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

       // Control de accesos

       With DataModule00.DmUsuarioFields do
         begin
         SetBarItemVisible( Ficheros4MenuItem, AcEIFicheros.Value<>0 );
         end;

     finally
       BarManager.EndUpdate;
     end;
end;

procedure TGds10Frm.CancelacionAutomaticaItemClick(Sender: TObject);
begin
     CancelacionAutomaticaRemesas;
end;

procedure SectionSetup;
begin
     Gds10Frm := TGds10Frm.Create( Application );
     If   Assigned( Gds10Frm )
     then With ApplicationContainer do
            begin

            TGds10Frm.ContableSection := Gds10Frm.FContableSection;
            TGds10Frm.LibrosIVASection := Gds10Frm.FLibrosIVASection;
            TGds10Frm.CobrosPagosSection := Gds10Frm.FCobrosPagosSection;
            TGds10Frm.InmovilizadoSection := Gds10Frm.FInmovilizadoSection;

            If   ProgramNumber in [ pnDesarrollo, pnContable, pnContableComercial, pnDemostracion ]
            then AddAppSection( Gds10Frm.ContableSection );
            AddAppSection( Gds10Frm.LibrosIVASection );
            AddAppSection( Gds10Frm.CobrosPagosSection );
            If   ProgramNumber in [ pnDesarrollo, pnContable, pnContableComercial, pnDemostracion ]
            then AddAppSection( Gds10Frm.InmovilizadoSection );

            Gds10Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
            end;
end;

initialization
     AddProcedure( imSectionModule, 10, SectionSetup );
end.


