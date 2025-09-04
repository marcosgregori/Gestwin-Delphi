program GServer64;

{$I GSERVERDEFINE.INC}

uses
  nxReplacementMemoryManager,
  nxReplacementMove,
  nxsdServerEngine,
  SysUtils,
  ComObj,
  Windows,
  Forms,
  Winapi.ActiveX,
  System.Classes,
  nxllUtils,
  nxllComponent,
  nxlgWinEventLog,
  dm_cnd in 'Gsm00\dm_cnd.pas' {ContadoresModule: TDataModule},
  dm_reg in 'Gsm00\dm_reg.pas' {RegistroModule: TDataModule},
  dm_pai in 'Gsm00\dm_pai.pas' {PaisModule: TDataModule},
  dm_pga in 'Gsm00\dm_pga.pas' {ConfiguracionModule: TDataModule},
  dm_prv in 'Gsm00\dm_prv.pas' {ProvinciaModule: TDataModule},
  dm_sch in 'Gsm00\dm_sch.pas' {SchedulerModule: TServerDataModule},
  Gsm00Dm in 'Gsm00\Gsm00Dm.pas' {DataModule00: TDataModule},
  Gim00Fields in '..\Interface\Gim00\Gim00Fields.pas',
  dm_art in 'Gsm30\dm_art.pas' {ArticuloModule: TServerDataModule},
  dm_eqm in 'Gsm30\dm_eqm.pas' {EquipoMovilModule: TServerDataModule},
  dm_fdc in 'Gsm30\dm_fdc.pas' {FacturaComprasModule: TServerDataModule},
  dm_fdv in 'Gsm30\dm_fdv.pas' {FacturaVentasModule: TServerDataModule},
  dm_mov in 'Gsm30\dm_mov.pas' {MovimientoModule: TServerDataModule},
  dm_sto in 'Gsm30\dm_sto.pas' {StockAlmacenModule: TServerDataModule},
  gsm30Dm in 'Gsm30\gsm30Dm.pas' {DataModule30: TDataModule},
  dm_cli in 'Gsm10\dm_cli.pas' {ClienteModule: TServerDataModule},
  dm_iva in 'Gsm10\dm_iva.pas' {TasaModule: TServerDataModule},
  dm_sdf in 'Gsm10\dm_sdf.pas' {SerieFacturacionModule: TServerDataModule},
  gsm10Dm in 'Gsm10\gsm10Dm.pas' {DataModule10: TDataModule},
  dm_ven in 'Gsm30\dm_ven.pas' {VendedorModule: TServerDataModule},
  CapturadorServiceUnit in 'Services\CapturadorServiceUnit.pas' {CapturadorService},
  EnterpriseData in 'Lib\EnterpriseData.pas' {EnterpriseDataModule: TDataModule},
  LibUtils in '..\Lib\LibUtils.pas',
  MainData in 'Lib\MainData.pas' {MainDataModule: TDataModule},
  dm_sub in 'Gsm10\dm_sub.pas' {CuentaModule: TServerDataModule},
  dm_sal in 'Gsm10\dm_sal.pas' {SaldosModule: TServerDataModule},
  dm_ast in 'Gsm10\dm_ast.pas' {AsientoModule: TServerDataModule},
  SessionData in 'SessionData.pas' {SessionDataModule: TEnterpriseDataModule},
  ServerDataModule in 'Lib\ServerDataModule.pas',
  Gim10Fields in '..\Interface\Gim10\Gim10Fields.pas',
  Gim30Fields in '..\Interface\Gim30\Gim30Fields.pas',
  SessionIntf in '..\Interface\Lib\SessionIntf.pas',
  SessionService in 'SessionService.pas',
  dmi_ast in '..\Interface\Gim10\dmi_ast.pas',
  dm_ecp in 'Gsm10\dm_ecp.pas' {EfectoPagarModule: TServerDataModule},
  dm_rem in 'Gsm10\dm_rem.pas' {RemesaModule: TServerDataModule},
  dm_ban in 'Gsm10\dm_ban.pas' {BancoModule: TServerDataModule},
  dm_rdi in 'Gsm10\dm_rdi.pas' {RelacionesDivisaModule: TDataModule},
  dm_fpa in 'Gsm10\dm_fpa.pas' {FormaPagoModule: TServerDataModule},
  dm_fco in 'Gsm10\dm_fco.pas' {FormaCobroModule: TDataModule},
  dmi_rem in '..\Interface\Gim10\dmi_rem.pas',
  dmi_lma in '..\Interface\Gim30\dmi_lma.pas',
  ApunteIntf in '..\Interface\Gim10\ApunteIntf.pas',
  HojaCargaIntf in '..\Interface\Gim40\HojaCargaIntf.pas',
  RemesaIntf in '..\Interface\Gim10\RemesaIntf.pas',
  EfectoCobrarIntf in '..\Interface\Gim10\EfectoCobrarIntf.pas',
  dmi_art in '..\Interface\Gim30\dmi_art.pas',
  dm_rdp in 'Gsm10\dm_rdp.pas' {RemesaPagoModule: TDataModule},
  dmi_ecp in '..\Interface\Gim10\dmi_ecp.pas',
  EfectoPagarIntf in '..\Interface\Gim10\EfectoPagarIntf.pas',
  dmi_rdp in '..\Interface\Gim10\dmi_rdp.pas',
  RemesaPagoIntf in '..\Interface\Gim10\RemesaPagoIntf.pas',
  dm_cls in 'Gsm30\dm_cls.pas' {ClaseModule: TDataModule},
  dm_cdi in 'Gsm00\dm_cdi.pas' {divisaModule: TServerDataModule},
  dmi_ecc in '..\Interface\Gim10\dmi_ecc.pas',
  dm_ecc in 'Gsm10\dm_ecc.pas' {EfectoCobrarModule: TServerDataModule},
  nxAdminWebServerServiceSettings in 'Lib\nxAdminWebServerServiceSettings.pas',
  nxdmServer in 'Lib\nxdmServer.pas' {DatabaseServerModule: TDataModule},
  dm_cec in 'Gsm30\dm_cec.pas' {CierreComercialModule: TServerDataModule},
  dmi_rda in '..\Interface\Gim10\dmi_rda.pas',
  dm_rda in 'Gsm10\dm_rda.pas' {RenumeracionAsientosModule: TServerDataModule},
  dm_vec in 'Gsm10\dm_vec.pas' {VerificacionContabilidadModule: TServerDataModule},
  dmi_sds in '..\Interface\Gim10\dmi_sds.pas',
  dm_sds in 'Gsm10\dm_sds.pas' {SustitucionSubcuentasModule: TServerDataModule},
  dmi_cde in '..\Interface\Gim10\dmi_cde.pas',
  f_sec in 'Gsm10\f_sec.pas' {secuenciaMesModule: TDataModule},
  dm_cde in 'Gsm10\dm_cde.pas' {ConsolidacionEmpresasModule: TServerDataModule},
  dm_ric in 'Gsm10\dm_ric.pas' {RegularizacionIVAModule: TServerDataModule},
  dmi_vec in '..\Interface\Gim10\dmi_vec.pas',
  dmi_sal in '..\Interface\Gim10\dmi_sal.pas',
  ParametrosFacturacionIntf in '..\Interface\Gim30\ParametrosFacturacionIntf.pas',
  SectionData in 'Lib\SectionData.pas' {SectionDataModule: TDataModule},
  dm_fac in 'Gsm10\dm_fac.pas' {FacturaModule: TServerDataModule},
  dmi_fac in '..\Interface\Gim10\dmi_fac.pas',
  dmi_mov in '..\Interface\Gim30\dmi_mov.pas',
  LineaHojaCargaIntf in '..\Interface\Gim40\LineaHojaCargaIntf.pas',
  dm_rcl in 'Gsm30\dm_rcl.pas' {RelacionesClienteModule: TServerDataModule},
  dm_vpe in 'Gsm30\dm_vpe.pas' {VentasPeriodicasModule: TServerDataModule},
  dm_pro in 'Gsm10\dm_pro.pas' {ProveedorModule: TServerDataModule},
  dm_efe in 'Gsm30\dm_efe.pas' {EfectoModule: TServerDataModule},
  dm_hdc in 'Gsm40\dm_hdc.pas' {HojaCargaModule: TServerDataModule},
  dmi_fdv in '..\Interface\Gim30\dmi_fdv.pas',
  dm_rdr in 'Gsm30\dm_rdr.pas' {ReconstruccionResultadosModule: TServerDataModule},
  gsm40Dm in 'Gsm40\gsm40Dm.pas' {DataModule40: TServerDataModule},
  dm_lma in 'Gsm30\dm_lma.pas' {ListaMaterialesModule: TServerDataModule},
  Gim40Fields in '..\Interface\Gim40\Gim40Fields.pas',
  dmi_fdc in '..\Interface\Gim30\dmi_fdc.pas',
  dm_fam in 'Gsm30\dm_fam.pas' {FamiliaModule: TServerDataModule},
  dm_emp in 'Gsm00\dm_emp.pas' {EmpresaModule: TDataModule},
  dm_pve in 'Gsm30\dm_pve.pas' {PreventaModule: TDataModule},
  SuscriptionConsts in '..\Interface\Lib\SuscriptionConsts.pas',
  dm_lic in 'Gsm91\dm_lic.pas' {LicenciasModule: TServerDataModule},
  gsm101Dm in 'Gsm101\gsm101Dm.pas' {DataModule101: TServerDataModule},
  UpdateService in 'Services\UpdateService.pas' {UpdateService: TkbmMWFileService},
  nxwsBasicAuthentication in 'Lib\nxwsBasicAuthentication.pas' {TnxBasicAuthentication: TDataModule},
  BaseServerContainer in 'Lib\BaseServerContainer.pas' {BaseServerContainerModule: TDataModule},
  nxServerSettings in 'Lib\nxServerSettings.pas',
  dmi_iva in '..\Interface\Gim10\dmi_iva.pas',
  dm_gaa in 'Gsm10\dm_gaa.pas' {GeneracionAmortizacionesModule: TServerDataModule},
  MovimientoIntf in '..\Interface\Gim30\MovimientoIntf.pas',
  ApplicationServiceUnit in 'Services\ApplicationServiceUnit.pas' {ApplicationService: TkbmMWQueryService},
  dm_rpr in 'Gsm30\dm_rpr.pas' {RelacionesProveedorModule: TServerDataModule},
  dmi_sto in '..\Interface\Gim30\dmi_sto.pas',
  Gim207Fields in '..\Interface\Gim207\Gim207Fields.pas',
  gsm207Dm in 'Gsm207\gsm207Dm.pas' {DataModule207: TServerDataModule},
  dm_sen in 'Gsm203\dm_sen.pas' {StockEnvasesModule: TDataModule},
  dm_rea207 in 'Gsm207\dm_rea207.pas' {RegistroActualizacionModule: TServerDataModule},
  dmi_sdt in '..\Interface\Gim207\dmi_sdt.pas',
  nxFileServiceSettings in 'Lib\nxFileServiceSettings.pas',
  BaseSessionData in 'Lib\BaseSessionData.pas' {BaseSessionDataModule: TDataModule},
  dm_alm in 'Gsm30\dm_alm.pas' {AlmacenModule: TServerDataModule},
  dm_tma in 'Gsm30\dm_tma.pas' {TipoMovAlmacenModule: TServerDataModule},
  dmi_vpe in '..\Interface\Gim30\dmi_vpe.pas',
  dm_ccn in 'Gsm10\dm_ccn.pas' {CierreContableModule: TServerDataModule},
  dm_iav101 in 'Gsm101\dm_iav101.pas' {ImportacionAlbaranesVenta101Module: TServerDataModule},
  gsm91Dm in 'Gsm91\gsm91Dm.pas' {DataModule91: TServerDataModule},
  dmi_iav101 in '..\Interface\Gim101\dmi_iav101.pas',
  Gim101Fields in '..\Interface\Gim101\Gim101Fields.pas',
  gsm201Dm in 'Gsm201\gsm201Dm.pas' {DataModule201: TServerDataModule},
  gsm200Dm in 'Gsm200\gsm200Dm.pas' {DataModule200: TServerDataModule},
  gsm202Dm in 'Gsm202\gsm202Dm.pas' {DataModule202: TServerDataModule},
  Gim203Fields in '..\Interface\Gim203\Gim203Fields.pas',
  gsm203Dm in 'Gsm203\gsm203Dm.pas' {DataModule203: TServerDataModule},
  gsm204Dm in 'Gsm204\gsm204Dm.pas' {DataModule204: TServerDataModule},
  Gim204Fields in '..\Interface\Gim204\Gim204Fields.pas',
  gsm205Dm in 'Gsm205\gsm205Dm.pas' {DataModule205: TServerDataModule},
  gsm206Dm in 'Gsm206\gsm206Dm.pas' {DataModule206: TServerDataModule},
  gsm90Dm in 'Gsm90\gsm90Dm.pas' {DataModule90: TServerDataModule},
  dm_iav103 in 'Gsm103\dm_iav103.pas' {ImportacionAlbaranesVenta103Module: TServerDataModule},
  gsm103Dm in 'Gsm103\gsm103Dm.pas' {DataModule117: TServerDataModule},
  dmi_iav103 in '..\Interface\Gim103\dmi_iav103.pas',
  Gim103Fields in '..\Interface\Gim103\Gim103Fields.pas',
  dmi_hdc in '..\Interface\Gim40\dmi_hdc.pas',
  AsientoIntf in '..\Interface\Gim10\AsientoIntf.pas',
  LineaMovimientoIntf in '..\Interface\Gim30\LineaMovimientoIntf.pas',
  dmi_ccn in '..\Interface\Gim10\dmi_ccn.pas',
  dm_mdc in 'Gsm10\dm_mdc.pas' {MovimientoCajaModule: TServerDataModule},
  dm_ifv117 in 'Gsm117\dm_ifv117.pas' {ImportacionFacturasVenta117Module: TServerDataModule},
  gsm117Dm in 'Gsm117\gsm117Dm.pas' {DataModule103: TServerDataModule},
  dmi_ifv117 in '..\Interface\Gim117\dmi_ifv117.pas',
  dmi_cec in '..\Interface\Gim30\dmi_cec.pas',
  ClienteIntf in '..\Interface\Gim10\ClienteIntf.pas',
  dm_sdt in 'Gsm207\dm_sdt.pas' {SincronizacionTiendaModule: TServerDataModule},
  dmi_sen in '..\Interface\Gim203\dmi_sen.pas',
  Gsm105Dm in 'Gsm105\Gsm105Dm.pas' {DataModule105: TServerDataModule},
  dm_cop in 'Gsm00\dm_cop.pas' {CodigoPostalModule: TServerDataModule},
  dmi_gaa in '..\Interface\Gim10\dmi_gaa.pas',
  Gsm70Dm in 'Gsm70\Gsm70Dm.pas' {DataModule70: TServerDataModule},
  dm_odf in 'Gsm70\dm_odf.pas' {OrdenFabricacionModule: TServerDataModule},
  dm_cpr in 'Gsm70\dm_cpr.pas' {ContenedorModule: TServerDataModule},
  dm_maq in 'Gsm70\dm_maq.pas' {MaquinaModule: TServerDataModule},
  dm_cla in 'Gsm70\dm_cla.pas' {CalendarioModule: TServerDataModule},
  dmi_odf in '..\Interface\Gim70\dmi_odf.pas',
  Gim70Fields in '..\Interface\Gim70\Gim70Fields.pas',
  dm_pde4 in 'Gsm40\dm_pde4.pas' {ConfiguracionAprovisionamientoModule: TServerDataModule},
  dm_pde7 in 'Gsm70\dm_pde7.pas' {ConfiguracionProduccionModule: TServerDataModule},
  dmi_cpr in '..\Interface\Gim70\dmi_cpr.pas',
  OrdenFabricacionIntf in '..\Interface\Gim70\OrdenFabricacionIntf.pas',
  dm_rla in 'Gsm70\dm_rla.pas' {LanzamientoModule: TServerDataModule},
  dm_lmp in 'Gsm70\dm_lmp.pas' {ListaMaterialesProcesosModule: TServerDataModule},
  dmi_lmp in '..\Interface\Gim70\dmi_lmp.pas',
  dmi_cla in '..\Interface\Gim70\dmi_cla.pas',
  dmi_maq in '..\Interface\Gim70\dmi_maq.pas',
  dm_idf in 'Gsm70\dm_idf.pas' {InformeFabricacionModule: TServerDataModule},
  InformeFabricacionIntf in '..\Interface\Gim70\InformeFabricacionIntf.pas',
  dmi_idf in '..\Interface\Gim70\dmi_idf.pas',
  dm_ccf in 'Gsm70\dm_ccf.pas' {CierreCicloFabricacionModule: TServerDataModule},
  dmi_ccf in '..\Interface\Gim70\dmi_ccf.pas',
  dmi_rdip in '..\Interface\Gim70\dmi_rdip.pas',
  dm_rdip in 'Gsm70\dm_rdip.pas' {ReconstruccionDatosInternosModule: TServerDataModule},
  Gim105Fields in '..\Interface\Gim105\Gim105Fields.pas',
  nxRPCServicesSettings in 'Lib\nxRPCServicesSettings.pas',
  PreventaDataModule in 'Services\PreventaDataModule.pas' {PreventaDataModule: TServerDataModule},
  CapturadorDataModule in 'Services\CapturadorDataModule.pas' {CapturadorDataModule: TServerDataModule},
  PreventaServiceUnit in 'Services\PreventaServiceUnit.pas' {PreventaService: TkbmMWQueryService},
  dmi_cnd in '..\Interface\Gim00\dmi_cnd.pas',
  gsm114Dm in 'Gsm114\gsm114Dm.pas' {DataModule114: TServerDataModule},
  dm_dcm114 in 'Gsm114\dm_dcm114.pas' {DocumentoControlMercanciasModule: TServerDataModule},
  dmi_dcm114 in '..\Interface\Gim114\dmi_dcm114.pas',
  Gim114Fields in '..\Interface\Gim114\Gim114Fields.pas',
  dmi_nda in '..\Interface\Gim40\dmi_nda.pas',
  dm_nda in 'Gsm40\dm_nda.pas' {NecesidadesAprovisionamientoModule: TServerDataModule},
  dmi_pve in '..\Interface\Gim30\dmi_pve.pas',
  Gsm60Dm in 'Gsm60\Gsm60Dm.pas' {DataModule60: TServerDataModule},
  gsm119Dm in 'Gsm119\gsm119Dm.pas' {DataModule119: TServerDataModule},
  dm_fde in 'Gsm30\dm_fde.pas' {FormaEnvioModule: TServerDataModule},
  ServerContainer in 'ServerContainer.pas' {ServerContainerModule: TBaseServerContainerModule},
  AdminServerService in 'Services\AdminServerService.pas' {AdminServerServiceDataModule: TDataModule},
  WebService in 'Services\WebService.pas' {WebServiceDataModule: TDataModule},
  nxWebServerServiceSettings in 'Lib\nxWebServerServiceSettings.pas',
  Gim90Fields in '..\Interface\Gim90\Gim90Fields.pas',
  Server in 'Server.pas' {ServerForm},
  nxServiceApp in 'Lib\nxServiceApp.pas' {WindowsService: TService},
  nxsrServerMutex in 'Lib\nxsrServerMutex.pas',
  AppManager in '..\Lib\AppManager.pas',
  ServerUtils in 'Lib\ServerUtils.pas',
  nxPatchPPL in '..\Lib\NexusDB4\nxPatchPPL.pas',
  dmi_cri116 in '..\Interface\Gim116\dmi_cri116.pas',
  dm_cri116 in 'Gsm116\dm_cri116.pas' {Cristaleria116Module: TServerDataModule},
  gsm116Dm in 'Gsm116\gsm116Dm.pas' {DataModule116: TServerDataModule},
  dmi_cfg105 in '..\Interface\Gim105\dmi_cfg105.pas',
  dm_cfg105 in 'Gsm105\dm_cfg105.pas' {Configuracion105Module: TServerDataModule},
  FacturaIntf in '..\Interface\Gim10\FacturaIntf.pas',
  dmi_pga in '..\Interface\Gim00\dmi_pga.pas',
  dm_pde207 in 'Gsm207\dm_pde207.pas' {ConfiguracionTiendaVirtualModule: TServerDataModule},
  dm_usr in 'Gsm00\dm_usr.pas' {UsuarioModule: TServerDataModule},
  Gim116Fields in '..\Interface\Gim116\Gim116Fields.pas',
  dmi_ifv121 in '..\Interface\Gim121\dmi_ifv121.pas',
  Gsm121dm in 'Gsm121\Gsm121dm.pas' {DataModule121: TServerDataModule},
  Dm_Ifv121 in 'Gsm121\Dm_Ifv121.pas' {ImportacionFacturas121Module: TServerDataModule},
  dm_cat in 'Gsm207\dm_cat.pas' {CategoriaModule: TServerDataModule},
  dmi_rdr in '..\Interface\Gim30\dmi_rdr.pas',
  dm_rpf in 'Gsm10\dm_rpf.pas' {RegistroPresentacionModule: TServerDataModule},
  FacturaComprasIntf in '..\Interface\Gim30\FacturaComprasIntf.pas',
  FacturaVentasIntf in '..\Interface\Gim30\FacturaVentasIntf.pas',
  dmi_ric in '..\Interface\Gim10\dmi_ric.pas',
  dmi_cls in '..\Interface\Gim30\dmi_cls.pas',
  dm_pde209 in 'Gsm209\dm_pde209.pas' {ConfiguracionPedidosOnlineModule: TServerDataModule},
  dmi_rpf in '..\Interface\Gim10\dmi_rpf.pas',
  dmi_cpo in '..\Interface\Gim209\dmi_cpo.pas';

{$R *.res}

// Estas opciones hacen que se cargue toda la aplicación en memoria y evita que se lean páginas desde el servidor cuando se necesitan (entre otras cosas)

const  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;

{$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}

resourceString
   RsMsg1 = 'Ya se está ejecutando la aplicación como un servicio.';
   RsMsg2 = 'Ya existe una instancia de la aplicación en ejecución.';

begin

     CoInitFlags := COINIT_MULTITHREADED;

     ServerApplication := True;

     {$IFDEF DEBUGAPP}
     ReportMemoryLeaksOnShutdown := True;
     NeverSleepOnMMThreadContention := True;
     {$ENDIF}

     If   nxRunningAsService or ( ParamCount=0 ) OR nxFindCmdLineSwitch( csInteractive )
     then try
            CreateServerMutex;
          except
            on E : Exception do
               begin
               WriteWinLogEntry( 'System', e.Message, 1, lpError );
               If   not nxRunningAsService
               then MessageBox( 0, PChar( E.Message ), 'Error', mb_ok + MB_ICONERROR );
               Exit;
               end;
            end;

     If   CheckApplicationService
     then Exit
     else If   not IsServiceRunning and
               ( ProcessExists( 'GServer.exe' ) or ProcessExists( 'GServer64.exe' ) )
          then begin
               MessageBox( 0, PChar( RsMsg2 ), 'Error', mb_ok + MB_ICONERROR );
               Exit;
               end;

     Application.Initialize;

     try
       CreateTrayMutex;
     except on e : Exception do
       begin
       MessageBox(0, PChar(e.message), 'Error', mb_ok + MB_ICONERROR );
       exit;
       end;
     end;

     If   not IsServiceRunning
     then begin
          ServerContainerModule := TServerContainerModule.Create( Application );
          ServerContainerModule.Setup( { LoadSettings } True );
          end;

     Application.ShowMainForm := False;
     Application.CreateForm(TServerForm, ServerForm);
  Application.Run;

end.
