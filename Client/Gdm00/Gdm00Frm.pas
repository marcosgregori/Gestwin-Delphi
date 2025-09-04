
unit Gdm00Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  nxllComponent,
  nxllPluginBase,
  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginClient, dxSkinsCore, dxSkinsdxBarPainter,
  dxBar, cxClasses, dxBarExtItems, dxSkinsDefaultPainters, dxGDIPlusClasses,
  cxImage, cxBarEditItem,

  AppManager,
  AppForms,
  AppContainer, cxFontNameComboBox, cxDropDownEdit, cxColorComboBox;

type
  TGds00Frm = class(TFrame)
    ConfigurationSection: TgAppSection;
    BarManager: TdxBarManager;
    ConfigurationMenuBar: TdxBar;
    EmpresasItem: TdxBarButton;
    UsuariosItem: TdxBarButton;
    PaisesItem: TdxBarButton;
    ProvinciasItem: TdxBarButton;
    Cdigospostales1: TdxBarButton;
    Paisesyprovincias1: TdxBarSubItem;
    CodigoDivisaItem: TdxBarButton;
    TipoCambioItem: TdxBarButton;
    DivisasItem: TdxBarSubItem;
    DireccionesCorreoItem: TdxBarButton;
    ImpresosEInformesHeader: TdxBarSubItem;
    ImpresosItem: TdxBarButton;
    InformesExternosItem: TdxBarButton;
    EditorInformesItem: TdxBarButton;
    EstructuraItem: TdxBarButton;
    LocalizacionFicherosItem: TdxBarButton;
    ParmetrosGeneralesItem: TdxBarButton;
    FicherosItem: TdxBarSubItem;
    OpcionesUsuarioItem: TdxBarButton;
    ControlDeAccesosItem: TdxBarButton;
    Configuracion0Item: TdxBarSubItem;
    Informes0: TdxBarSubItem;
    CopiasSeguridadItem: TdxBarButton;
    RegeneracionFicherosItem: TdxBarButton;
    ExportImportFicherosItem: TdxBarButton;
    ActualizacionFicherosItem: TdxBarButton;
    ControlVersionesItem: TdxBarButton;
    SupresionDatosItem: TdxBarButton;
    DiarioProcesosItem: TdxBarButton;
    GestorSuscripcionesItem: TdxBarButton;
    Procesos0: TdxBarSubItem;
    ConfiguracionSeguridadItem: TdxBarButton;
    ComprobarActualizacionesItem: TdxBarButton;
    DivisasHeader: TdxBarSubItem;
    NombreSeccionItem: TdxBarStatic;
    EntidadesFinancierasItem: TdxBarButton;
    StartAppSection: TgAppSection;
    MenuItem1: TdxBarSubItem;
    ConfiguracionProduccionItem: TdxBarButton;
    ConfiguracionTiendaVirtualItem: TdxBarButton;
    ConfiguracionContableItem: TdxBarButton;
    ConfiguracionArticulosItem: TdxBarButton;
    ConfiguracionClientesItem: TdxBarButton;
    ConfiguracionProveedoresItem: TdxBarButton;
    dxBarButton1: TdxBarButton;
    ConfiguracionComprasItem: TdxBarButton;
    ConfiguracionVentasItem: TdxBarButton;
    ConfiguracionAlmacenItem: TdxBarButton;
    ConfiguracionTPVItem: TdxBarButton;
    ReconstruccionResultadosItem: TdxBarButton;
    ConfiguracionEmpresasItem: TdxBarSubItem;
    ConfiguracionCorreoItem: TdxBarButton;
    ConfiguracionPedidosOnlineItem: TdxBarButton;
    procedure CopiasSeguridadItemClick(Sender: TObject);
    procedure DiarioProcesosItemClick(Sender: TObject);
    procedure ParmetrosGeneralesItemClick(Sender: TObject);
    procedure empresasItemClick(Sender: TObject);
    procedure usuariosItemClick(Sender: TObject);
    procedure RegeneracionFicherosItemClick(Sender: TObject);
    procedure ControlDeAccesosItemClick(Sender: TObject);
    procedure Contenido0ItemClick(Sender: TObject);
    procedure CodigoDivisaItemClick(Sender: TObject);
    procedure TipoCambioItemClick(Sender: TObject);
    procedure PaisesItemClick(Sender: TObject);
    procedure ProvinciasItemClick(Sender: TObject);
    procedure InformesExternosItemClick(Sender: TObject);
    procedure ImpresosItemClick(Sender: TObject);
    procedure ControlVersionesItemClick(Sender: TObject);
    procedure ActualizacionFicherosItemClick(Sender: TObject);
    procedure OpcionesUsuarioItemClick(Sender: TObject);
    procedure SupresionDatosItemClick(Sender: TObject);
    procedure DireccionesCorreoItemClick(Sender: TObject);
    procedure ExportImportFicherosItemClick(Sender: TObject);
    function ConfigurationSectionSetAccess: Boolean;
    procedure ConfigurationSectionInitialize;
    procedure LocalizacionFicherosItemClick(Sender: TObject);
    procedure ConfigurationSectionSelected;
    procedure EstructuraItemClick(Sender: TObject);
    procedure IndiceAlfabetico0ItemClick(Sender: TObject);
    procedure Cdigospostales1Click(Sender: TObject);
    procedure EditorInformesItemClick(Sender: TObject);
    procedure Sobre0ItemClick(Sender: TObject);
    procedure GestorSuscripcionesItemClick(Sender: TObject);
    procedure ListadoPaisesItemClick(Sender: TObject);
    procedure ListadoEmpresasItemClick(Sender: TObject);
    procedure ListadoUsuariosItemClick(Sender: TObject);
    procedure ListadoProvinciasItemClick(Sender: TObject);
    procedure Listadodecdigospostales1Click(Sender: TObject);
    procedure ListadoCodigosDivisaItemClick(Sender: TObject);
    procedure ListadoTiposCambioItemClick(Sender: TObject);
    procedure ListadoDireccionesCorreoItemClick(Sender: TObject);
    procedure ListadoImpresosItemClick(Sender: TObject);
    procedure ListadoInformesExternosItemClick(Sender: TObject);
    procedure ConfigurationSectionUpdateMainMenu;
    procedure ComprobarActualizacionesItemClick(Sender: TObject);
    procedure EntidadesFinancierasItemClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure ConfiguracionSeguridadItemClick(Sender: TObject);
    procedure ConfiguracionCorreoItemClick(Sender: TObject);

  private
    FOnSupresionDatos,
    FOnOpcionesUsuario : TProcedure;
    FDisableInitialization : boolean;

  public

  property DisableInitialization : Boolean read FDisableInitialization write FDisableInitialization;
  property OnSupresionDatos : TProcedure read FOnSupresionDatos write FOnSupresionDatos;
  property OnOpcionesUsuario : TProcedure read FOnOpcionesUsuario write FOnOpcionesUsuario;
  end;

var  Gds00Frm : TGds00Frm = nil;

implementation

{$R *.dfm}

uses   System.Threading,

       FrxDesgn,

       LibUtils,
       DataManager,
       DataAccess,
       ReportManager,
       AppForm,

       Gdm00Dm,

       Presentacion,

       dm_ine,
       dm_pga,
       dm_cnd,

       b_upd,
       b_bck,
       b_msg,
       b_uee,

       // b_lic,

       l_usr,
       a_emp, l_emp,
       a_prv, l_prv,
       a_pai, l_pai,
       a_cop, l_cop,
       a_cdi, l_cdi,
       a_enf,
       a_efx,
       a_tca, l_tca,
       a_ddc, l_ddc,
       a_acc,
       // b_qry,

       a_pga,
       a_ine, l_ine,
       a_imp, l_imp,
       a_fic,
       a_cer,
       a_ccr,

       b_afr,
       b_rdf,
       // b_rcs,
       b_efm,
       b_ddp;

resourceString
       RsMsg1   = 'El editor de informes de GESTWIN debería ser usado únicamente por su técnico de soporte.';
       RsMsg2   = 'Si utiliza el editor puede alterar de forma irrecuperable informes o formularios existentes.' + #13 +
                  '¿Está seguro de que desea utilizar el editor de informes?';

procedure TGds00Frm.ParmetrosGeneralesItemClick(Sender: TObject);
begin
     MntParametrosAplicacion;
end;

procedure TGds00Frm.empresasItemClick(Sender: TObject);
begin
     MntEmpresas( [] );
end;

procedure TGds00Frm.UsuariosItemClick(Sender: TObject);
begin
     ApplicationContainer.DoOnEdicionUsuarios;
end;

procedure TGds00Frm.ControlDeAccesosItemClick(Sender: TObject);
begin
     ControlAccesos;
end;

procedure TGds00Frm.ConfiguracionSeguridadItemClick(Sender: TObject);
begin
     MntConfiguracionSeguridad;
end;

procedure TGds00Frm.RegeneracionFicherosItemClick(Sender: TObject);
begin
     RegeneracionFicheros;
end;

procedure TGds00Frm.CodigoDivisaItemClick(Sender: TObject);
begin
     MntCodigosDivisa( [] );
end;

procedure TGds00Frm.TipoCambioItemClick(Sender: TObject);
begin
     MntTiposCambio;
end;

procedure TGds00Frm.PaisesItemClick(Sender: TObject);
begin
     MntPaises( [] );
end;

procedure TGds00Frm.ProvinciasItemClick(Sender: TObject);
begin
     MntProvincias( [] );
end;

procedure TGds00Frm.InformesExternosItemClick(Sender: TObject);
begin
     MntInformesExternos( [] );
end;

procedure TGds00Frm.ImpresosItemClick(Sender: TObject);
begin
     MntImpresos( [] );
end;

procedure TGds00Frm.ControlVersionesItemClick(Sender: TObject);
begin
     UpdateDictionaries( CodigoEmpresaActual, False );
end;

procedure TGds00Frm.CopiasSeguridadItemClick(Sender: TObject);
begin
     CopiaSeguridad;
end;

procedure TGds00Frm.ActualizacionFicherosItemClick(Sender: TObject);
begin
     actualizacionFicherosRemotos;
end;

procedure TGds00Frm.OpcionesUsuarioItemClick(Sender: TObject);
begin
     If   Assigned( FOnOpcionesUsuario )
     then FOnOpcionesUsuario;
end;

procedure TGds00Frm.DireccionesCorreoItemClick(Sender: TObject);
begin
     MntDireccionesCorreo( [] );
end;

procedure TGds00Frm.ConfiguracionCorreoItemClick(Sender: TObject);
begin
     MntConfiguracionCorreo( [] );
end;

procedure TGds00Frm.SupresionDatosItemClick(Sender: TObject);
begin
     If   Assigned( FOnSupresionDatos )
     then FOnSupresionDatos;
end;

procedure TGds00Frm.ExportImportFicherosItemClick(Sender: TObject);
begin
     ExportImportFicherosMaestros;
end;

procedure TGds00Frm.ListadoCodigosDivisaItemClick(Sender: TObject);
begin
     ListadoCodigosDivisa;
end;

procedure TGds00Frm.Listadodecdigospostales1Click(Sender: TObject);
begin
     ListadoCodigosPostales;
end;

procedure TGds00Frm.ListadoDireccionesCorreoItemClick(Sender: TObject);
begin
     ListadoDireccionesCorreo;
end;

procedure TGds00Frm.ListadoEmpresasItemClick(Sender: TObject);
begin
     ListadoEmpresas;
end;

procedure TGds00Frm.ListadoImpresosItemClick(Sender: TObject);
begin
     ListadoImpresos;
end;

procedure TGds00Frm.ListadoInformesExternosItemClick(Sender: TObject);
begin
     ListadoInformesExternos;
end;

procedure TGds00Frm.ListadoPaisesItemClick(Sender: TObject);
begin
     ListadoPaises;
end;

procedure TGds00Frm.ListadoProvinciasItemClick(Sender: TObject);
begin
     ListadoProvincias;
end;

procedure TGds00Frm.ListadoTiposCambioItemClick(Sender: TObject);
begin
     ListadoTiposCambio;
end;

procedure TGds00Frm.ListadoUsuariosItemClick(Sender: TObject);
begin
     ListadoUsuarios;
end;

procedure TGds00Frm.LocalizacionFicherosItemClick(Sender: TObject);
begin
     MntLocalizacionFicheros;
end;

procedure TGds00Frm.Sobre0ItemClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

procedure TGds00Frm.DiarioProcesosItemClick(Sender: TObject);
begin
     DiarioProcesos;
end;

procedure Start;
begin
     If   not DatabaseUpdateRequested
     then If   not( csDestroying in Application.MainForm.ComponentState )
          then begin
               If   ( CodigoUsuarioActual='' ) and not Configuracion.ParametrosGlbRec.OcultarVentanaPresentacion
               then MuestraVentanaPresentacion;
               CambioEmpresa;
               end;
end;

function TGds00Frm.ConfigurationSectionSetAccess: Boolean;
begin
     Result := UsuarioMaestro;
end;

procedure TGds00Frm.ConfigurationSectionUpdateMainMenu;
begin

     BarManager.BeginUpdate;
     try

       SetBarItemVisible( OpcionesUsuarioItem, Assigned( FOnOpcionesUsuario ) );
       SetBarItemVisible( SupresionDatosItem, Assigned( FOnSupresionDatos ) );
       SetBarItemVisible( UsuariosItem, Assigned( ApplicationContainer.OnEdicionUsuarios ) );

       SetBarItemsVisible( [ DivisasHeader, CodigoDivisaItem, TipoCambioItem ], DataModule00.DmEmpresaFields.Contable_Divisas.Value );

       // DivisasHeader.Style := ApplicationContainer.MenuHeaderStyle;
       // ImpresosEInformesHeader.Style := ApplicationContainer.MenuHeaderStyle;

       SetBarItemVisible( EditorInformesItem, Configuracion.ParametrosGlbRec.EditorInformes );
       SetBarItemVisible( GestorSuscripcionesItem, SpSuscription );

     finally
       BarManager.EndUpdate;
     end;

end;

procedure TGds00Frm.ConfigurationSectionInitialize;
begin
     If   not DisableInitialization
     then ApplicationContainer.OnStart := Start;
end;

procedure TGds00Frm.ConfigurationSectionSelected;
begin
     With ApplicationContainer do
       If   not UpdatingAppSections
       then If   TryToCloseAll{ ( False ) }=mrOk   // Si no se cierran todos los módulos no se podrá, por ejemplo, actualizar las tablas
            then UpdateAppSections( True )
            else Abort;
end;

procedure TGds00Frm.GestorSuscripcionesItemClick(Sender: TObject);
begin
     // CompruebaEstadoLicencia;
end;

procedure TGds00Frm.EntidadesFinancierasItemClick(Sender: TObject);
begin
     MntEntidadesFinancieras( [] );
end;

procedure TGds00Frm.EstructuraItemClick(Sender: TObject);
begin
     MntEstructuraFicherosExternos( [] );
end;

procedure TGds00Frm.Contenido0ItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds00Frm.IndiceAlfabetico0ItemClick(Sender: TObject);
begin
     ShowHelpForm( 'hs00', 'alfabetico' );
end;

procedure TGds00Frm.Cdigospostales1Click(Sender: TObject);
begin
     MntCodigosPostales( [] );
end;

procedure TGds00Frm.EditorInformesItemClick(Sender: TObject);
begin
     {
     If   ShowNotification( ntQuestionWarning, rsMsg1, rsMsg2 )=mrYes
     then begin
     }
          If   ApplicationContainer.TryToCloseAll=mrOk
          then ReportManagerDataModule.DesignReport;
     {
          end;
     }
end;

procedure TGds00Frm.ComprobarActualizacionesItemClick(Sender: TObject);
begin
     ApplicationContainer.ShowUpgradeForm;
end;

procedure TGds00Frm.MenuItem2Click(Sender: TObject);
begin
     ShowHelp;
end;

procedure TGds00Frm.MenuItem3Click(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

procedure SectionSetup;
begin
     Gds00Frm := Tgds00Frm.Create( Application );
     If   Assigned( Gds00Frm )
     then With ApplicationContainer do
            begin
            AddAppSection( Gds00Frm.StartAppSection );
            AddAppSection( Gds00Frm.ConfigurationSection );

            Gds00Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
            end;
end;

initialization
     AddProcedure( imSectionModule, 0, SectionSetup );
end.
