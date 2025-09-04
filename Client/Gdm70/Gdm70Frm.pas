
unit Gdm70Frm;

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
  TGds70Frm = class(TFrame)
    ProduccionAppSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar: TdxBar;
    ListasDeMaterialesItem: TdxBarButton;
    OperariosTipoItem: TdxBarButton;
    MaquinasTipoItem: TdxBarButton;
    OperacionesItem: TdxBarButton;
    TransportistasItem: TdxBarButton;
    FicherosMenuItem: TdxBarSubItem;
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
    MaquinasMenuItem: TdxBarSubItem;
    CosdigosCosteMAquinaItem: TdxBarButton;
    OperariosMaquinaItem: TdxBarButton;
    TurnosCalendarioItem: TdxBarSubItem;
    TurnosItem: TdxBarButton;
    TiposJornadaItem: TdxBarButton;
    CalendarioLaboralItem: TdxBarButton;
    LanzamientoItem: TdxBarSubItem;
    SeguimientoItem: TdxBarSubItem;
    NotificacionesItem: TdxBarSubItem;
    ProcesosItem: TdxBarSubItem;
    CierreProduccionItem: TdxBarButton;
    ProcesosEspecialesHeader: TdxBarSubItem;
    ReconstruccionDatosItem: TdxBarButton;
    ReaperturaOrdenesItem: TdxBarButton;
    SustitucionComponentesItem: TdxBarButton;
    InformesFabricacionitem: TdxBarButton;
    InformeOrdenesMaquinaItem: TdxBarButton;
    PartesIncidenciasItem: TdxBarButton;
    NotificacionesEntradaSalidaItem: TdxBarButton;
    EntradaOrdenesMaquinasItem: TdxBarButton;
    SituacionOrdenItem: TdxBarButton;
    TareasOrdenItem: TdxBarButton;
    TareasMaquinaItem: TdxBarButton;
    ListadoTareasPendientesItem: TdxBarButton;
    ListadoSeguimientoMaquinasItem: TdxBarButton;
    CalendarioOcupacionItem: TdxBarButton;
    OrdenesFabricacionItem: TdxBarButton;
    OrdenesPedidoItem: TdxBarButton;
    RegistrosLanzamientoItem: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    OperariosMenuItem: TdxBarSubItem;
    OperariosItem: TdxBarButton;
    MaquinasItem: TdxBarButton;
    OperacionesMenuItem: TdxBarSubItem;
    CosteOperacionesExternas: TdxBarButton;
    TipoDefectoTaraItem: TdxBarButton;
    TiposIncidenciaItem: TdxBarButton;
    GeneracionPedidosCompraItem: TdxBarButton;
    NecesidadaesAprovisionamientoItem: TdxBarButton;
    DiasgramaTareasPendientesItem: TdxBarButton;
    ReajusteTareasItem: TdxBarButton;
    procedure ContenidoItemClick(Sender: TObject);
    function ProduccionAppSectionSetAccess: Boolean;
    procedure AcercaItemClick(Sender: TObject);

    //..

    procedure ListasDeMaterialesItemClick(Sender: TObject);
    procedure ListadoDisponibilidadItemClick(Sender: TObject);
    procedure MaquinasTipoItemClick(Sender: TObject);
    procedure OperariosTipoItemClick(Sender: TObject);
    procedure CalculoCosteItemClick(Sender: TObject);
    procedure OperacionesItemClick(Sender: TObject);
    procedure ListadoNecesidadesItemClick(Sender: TObject);
    procedure PedidoVentasITemClick(Sender: TObject);
    procedure HojasCargaItemClick(Sender: TObject);
    procedure TransportistasItemClick(Sender: TObject);
    procedure GeneracionSalidaItemClick(Sender: TObject);
    procedure ListadoDisponibilidadNecesidadesItemClick(Sender: TObject);
    procedure ProduccionAppSectionUpdateMainMenu;
    procedure EstadoArticulosPendientesItemClick(Sender: TObject);
    procedure GeneracionReubicacionItemClick(Sender: TObject);
    procedure GeneracionPedidosCompraItemClick(Sender: TObject);
    procedure MaquinasItemClick(Sender: TObject);
    procedure TurnosItemClick(Sender: TObject);
    procedure CosdigosCosteMAquinaItemClick(Sender: TObject);
    procedure TiposJornadaItemClick(Sender: TObject);
    procedure OperariosItemClick(Sender: TObject);
    procedure CosteOperacionesExternasClick(Sender: TObject);
    procedure OrdenesFabricacionItemClick(Sender: TObject);
    procedure CalendarioLaboralItemClick(Sender: TObject);
    procedure TipoDefectoTaraItemClick(Sender: TObject);
    procedure TiposIncidenciaItemClick(Sender: TObject);
    procedure InformesFabricacionitemClick(Sender: TObject);
    procedure OperariosMaquinaItemClick(Sender: TObject);
    procedure CierreProduccionItemClick(Sender: TObject);
    procedure ReconstruccionDatosItemClick(Sender: TObject);
    procedure OrdenesPedidoItemClick(Sender: TObject);
    procedure NecesidadaesAprovisionamientoItemClick(Sender: TObject);
    procedure ReaperturaOrdenesItemClick(Sender: TObject);
    procedure SituacionOrdenItemClick(Sender: TObject);
    procedure EntradaOrdenesMaquinasItemClick(Sender: TObject);
    procedure TareasOrdenItemClick(Sender: TObject);
    procedure TareasMaquinaItemClick(Sender: TObject);
    procedure ListadoTareasPendientesItemClick(Sender: TObject);
    procedure InformeOrdenesMaquinaItemClick(Sender: TObject);
    procedure DiasgramaTareasPendientesItemClick(Sender: TObject);
    procedure CalendarioOcupacionItemClick(Sender: TObject);
    procedure ReajusteTareasItemClick(Sender: TObject);

  private

  public
  class var
    ProduccionSection : TgAppSection;

  end;

var  Gds70Frm : TGds70Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       Gdm00Dm,
       Gdm30Frm,

       dmi_mov,

       dm_pga,
       dm_mov,

       a_pde7,

       a_cdc,
       a_lmp,
       a_opt,
       a_opr,
       a_coe,
       a_mat,
       a_maq,
       a_def,
       a_inc,
       a_tur,
       b_tdj,
       b_cla,

       a_opc,
       a_opm,
       a_tra,

       b_gpc,
       b_nda,

       l_edn,
       l_ccf,
       l_nfa,
       l_dnf,
       l_tpe,

       a_mve,
       a_odf,
       b_odp,

       b_eom,
       b_odf,
       b_tof,
       b_tmq,
       b_dtp,
       b_com,

       a_idf,
       a_hdc,
       b_ipm,

       b_gas,
       b_gmr,
       b_eap,

       b_rof,
       b_rtp,
       b_ccf,
       b_rdi,

       b_msg;

procedure TGds70Frm.ContenidoItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds70Frm.CosdigosCosteMAquinaItemClick(Sender: TObject);
begin
     MntCodigosCoste( [] );
end;

procedure TGds70Frm.CosteOperacionesExternasClick(Sender: TObject);
begin
     MntCosteOperacExternas( [] );
end;

procedure TGds70Frm.DiasgramaTareasPendientesItemClick(Sender: TObject);
begin
     DiagramaTareasPendientes( 0 );
end;

procedure TGds70Frm.GeneracionPedidosCompraItemClick(Sender: TObject);
begin
     GeneracionPedidosCompra;
end;

procedure TGds70Frm.EntradaOrdenesMaquinasItemClick(Sender: TObject);
begin
     EntradaOrdenesEnMaquinas( [] );
end;

procedure TGds70Frm.EstadoArticulosPendientesItemClick(Sender: TObject);
begin
     EstadoArticulosPendientes( [] );
end;

function TGds70Frm.ProduccionAppSectionSetAccess: Boolean;
begin
     Result := DataModule00.DmUsuarioFields.AcGP.Value<>0;
end;

procedure TGds70Frm.ProduccionAppSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

       SetBarItemsVisible( [ GeneracionSalidaItem ], ParametrosAprovisionamientoRec.DocumentoHojaCarga=0 );

       {$IFDEF DEBUGAPP}
       SetBarItemsVisible( [ TareasMaquinaItem,
                             ListadoTareasPendientesItem,
                             ListadoSeguimientoMaquinasItem,
                             CalendarioOcupacionItem,
                             InformeOrdenesMaquinaItem,
                             DiasgramaTareasPendientesItem,
                             PartesIncidenciasItem,
                             NotificacionesEntradaSalidaItem ],
                             True );
       {$ENDIF}

       // Modificaciones en el menú de la gestión comercial

       If   Assigned( Gds30Frm )
       then With Gds30Frm do
              begin

               With DataModule00.DmUsuarioFields do
                 begin
                 SetBarItemVisible( FicherosMenuItem, AcGPFicheros.Value<>0 );
                 SetBarItemVisible( ListasDeMaterialesItem, AcGPRelaciones.Value<>0 );
                 SetBarItemVisible( OperariosMenuItem, AcGPOperarios.Value<>0 );
                 SetBarItemVisible( MaquinasMenuItem, AcGPMaquinas.Value<>0 );
                 SetBarItemVisible( OperacionesMenuItem, AcGPOperaciones.Value<>0 );
                 SetBarItemVisible( TurnosCalendarioItem, AcGPTurnos.Value<>0 );
                 SetBarItemVisible( PrevisionItem, AcGPPrevision.Value<>0 );
                 SetBarItemVisible( LanzamientoItem, AcGPLanzamiento.Value<>0 );
                 SetBarItemVisible( SeguimientoItem, AcGPSeguimiento.Value<>0 );
                 SetBarItemVisible( NotificacionesItem, AcGPNotificaciones.Value<>0 );
                 SetBarItemVisible( ProcesosItem, AcGPProcesos.Value<>0 );
                 SetBarItemVisible( CargaItem, AcGPPrevision.Value<>0 );  // Carga y Prevision utilizan la misma opción
                 end;

              SetBarItemsVisible( [ HojasCargaPedidoItem, EstadoArticulosPendientesItem, GeneracionPedidosCompraItem, GeneracionAlbaranesSalidaItem ], ParametrosAprovisionamientoRec.DocumentoHojaCarga=0 );
              SetBarItemsVisible( [ HojasCargaAlbaranItem ], ParametrosAprovisionamientoRec.DocumentoHojaCarga=1 );

              case ParametrosAprovisionamientoRec.DocumentoHojaCarga of
                 0 : begin
                     HojasCargaPedidoItem.OnClick := Gds70Frm.HojasCargaItemClick;
                     EstadoArticulosPendientesItem.OnClick := Gds70Frm.EstadoArticulosPendientesItemClick;
                     GeneracionAlbaranesSalidaItem.OnClick := Gds70Frm.GeneracionSalidaItemClick;
                     GeneracionPedidosCompraItem.OnClick := Gds70Frm.GeneracionPedidosCompraItemClick;
                     end;
                 1 : HojasCargaAlbaranItem.OnClick := Gds70Frm.HojasCargaItemClick;
                 end;

              end;

     finally
       BarManager.EndUpdate;
     end;
end;

procedure TGds70Frm.ReajusteTareasItemClick(Sender: TObject);
begin
     ReajusteTareasPendientes;
end;

procedure TGds70Frm.ReaperturaOrdenesItemClick(Sender: TObject);
begin
     ReaperturaOrdenes;
end;

procedure TGds70Frm.ReconstruccionDatosItemClick(Sender: TObject);
begin
     ReconstruccionDatosProduccion;
end;

procedure TGds70Frm.SituacionOrdenItemClick(Sender: TObject);
begin
     SituacionOrdenFabricacion( [] );
end;

procedure TGds70Frm.AcercaItemClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

// ....

procedure TGds70Frm.ListasDeMaterialesItemClick(Sender: TObject);
begin
     MntRelacionMaterialesProcesos( [] );
end;

procedure TGds70Frm.ListadoDisponibilidadItemClick(Sender: TObject);
begin
     ListadoDisponibilidad;
end;

procedure TGds70Frm.ListadoDisponibilidadNecesidadesItemClick(Sender: TObject);
begin
     ListadoDiponibilidadNecesidades;
end;

procedure TGds70Frm.MaquinasItemClick(Sender: TObject);
begin
     MntMaquinas( [] );
end;

procedure TGds70Frm.MaquinasTipoItemClick(Sender: TObject);
begin
     MntMaquinasTipo( [] );
end;

procedure TGds70Frm.NecesidadaesAprovisionamientoItemClick(Sender: TObject);
begin
     GeneracionNecesidadesAprovisionamiento;
end;

procedure TGds70Frm.OperariosItemClick(Sender: TObject);
begin
     MntOperarios( [] );
end;

procedure TGds70Frm.OperariosMaquinaItemClick(Sender: TObject);
begin
     MntOperariosPorMaquina( [] );
end;

procedure TGds70Frm.OperariosTipoItemClick(Sender: TObject);
begin
     MntOperariosTipo( [] );
end;

procedure TGds70Frm.OrdenesFabricacionItemClick(Sender: TObject);
begin
     MntOrdenesFabricacion( [] );
end;

procedure TGds70Frm.OrdenesPedidoItemClick(Sender: TObject);
begin
     ConsultaOrdenesPedido( [] );
end;

procedure TGds70Frm.CalculoCosteItemClick(Sender: TObject);
begin
     ListadoCostesFabricacion;
end;

procedure TGds70Frm.CalendarioLaboralItemClick(Sender: TObject);
begin
     CalendarioLaboral;
end;

procedure TGds70Frm.CalendarioOcupacionItemClick(Sender: TObject);
begin
     CalendarioOcupacionMaquinas;
end;

procedure TGds70Frm.CierreProduccionItemClick(Sender: TObject);
begin
     ProcesaCierreCicloFabricacion;
end;

procedure TGds70Frm.OperacionesItemClick(Sender: TObject);
begin
     MntOperaciones( [] );
end;

procedure TGds70Frm.ListadoNecesidadesItemClick(Sender: TObject);
begin
     ListadoNecesidadesFuturas;
end;

procedure TGds70Frm.ListadoTareasPendientesItemClick(Sender: TObject);
begin
     ListadoTareasPendientes;
end;

procedure TGds70Frm.PedidoVentasITemClick(Sender: TObject);
begin
     MntMovimientosVenta( [ tmPedidoVenta ] );
end;

procedure TGds70Frm.HojasCargaItemClick(Sender: TObject);
begin
     MntHojasCarga( [] );
end;

procedure TGds70Frm.InformeOrdenesMaquinaItemClick(Sender: TObject);
begin
     InformesPorMaquina( [] );
end;

procedure TGds70Frm.InformesFabricacionitemClick(Sender: TObject);
begin
     MntInformesFabricacion( [] );
end;

procedure TGds70Frm.TareasMaquinaItemClick(Sender: TObject);
begin
     ConsultaTareasMaquina;
end;

procedure TGds70Frm.TareasOrdenItemClick(Sender: TObject);
begin
     ConsultaTareasOrden( [] );
end;

procedure TGds70Frm.TipoDefectoTaraItemClick(Sender: TObject);
begin
     MntDefectos( [] );
end;

procedure TGds70Frm.TiposIncidenciaItemClick(Sender: TObject);
begin
     MntIncidencias( [] );
end;

procedure TGds70Frm.TiposJornadaItemClick(Sender: TObject);
begin
     FijaTipoJornada( Now, 0, True );
end;

procedure TGds70Frm.TransportistasItemClick(Sender: TObject);
begin
     MntTransportistas( [] );
end;

procedure TGds70Frm.TurnosItemClick(Sender: TObject);
begin
     MntTurnos( [] );
end;

procedure TGds70Frm.GeneracionReubicacionItemClick(Sender: TObject);
begin
     GeneracionMovimientosReubicacion;
end;

procedure TGds70Frm.GeneracionSalidaItemClick(Sender: TObject);
begin
     GeneracionAlbaranesSalida;
end;

procedure SectionSetup;

var  SubItem : TdxBarSubItem;

begin

     Gds70Frm := TGds70Frm.Create( Application );
     If   Assigned( Gds70Frm )
     then begin
          ApplicationContainer.AddAppSection( Gds70Frm.ProduccionAppSection );
          TGds70Frm.ProduccionSection := Gds70Frm.ProduccionAppSection;
          Gds70Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
          end;
end;

initialization
     AddProcedure( imOptionalSectionModule, 70, SectionSetup );

end.

