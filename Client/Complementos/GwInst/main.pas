unit main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, FileCtrl, Mask,

  DdeMan,
  ShellAnimations,
  Menus,

  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxImage,
  cxLabel,
  cxProgressBar,
  dxGDIPlusClasses,
  cxButtons,
  cxCheckBox,
  dxBarBuiltInMenu,
  cxPC,
  cxGroupBox,

  InstallerClass,
  AppManager,
  ServiceManager, dxUIAClasses, dxFormattedLabel;

type

  TInstallForm = class(TForm)
    Label4: TcxLabel;
    Label6: TcxLabel;
    Image2: TcxImage;
    Image3: TcxImage;
    CopyrightLabel: TcxLabel;
    Label2: TcxLabel;
    Label1: TcxLabel;
    cancelBtn: TcxButton;
    DemoLabel: TcxLabel;
    PreviousBtn: TcxButton;
    nextBtn: TcxButton;
    AppNameLabel: TcxLabel;
    PageControl: TcxPageControl;
    PresentacionTS: TcxTabSheet;
    TipoInstalacionTS: TcxTabSheet;
    OpcionesTS: TcxTabSheet;
    Label26: TcxLabel;
    Label28: TcxLabel;
    Image4: TcxImage;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    destinoBtn: TcxButton;
    DestinoEdit: TEdit;
    Label31: TcxLabel;
    Label32: TcxLabel;
    FacturaElectronicaCtrl: TcxCheckBox;
    ProteccionTS: TcxTabSheet;
    CopiaFicherosTS: TcxTabSheet;
    Label16: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label18: TcxLabel;
    Label24: TcxLabel;
    Label5: TcxLabel;
    nroSerieLabel: TcxLabel;
    Label17: TcxLabel;
    claveActivacionCtrl: TEdit;
    numeroRegistroCtrl: TEdit;
    conexionesServidorCtrl: TEdit;
    Label12: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    SourceLabel: TcxLabel;
    Label22: TcxLabel;
    TargetLabel: TcxLabel;
    ProcessLabel: TcxLabel;
    procesoCopiaLabel: TcxLabel;
    tipoInstalacionCtrl: TComboBox;
    nroDiscoLabel: TcxLabel;
    Animate: TAnimate;
    TrazabilidadCtrl: TcxCheckBox;
    PartidasPresupuestariasCtrl: TcxCheckBox;
    EnvasesCtrl: TcxCheckBox;
    ExportacionCtrl: TcxCheckBox;
    ProgressBar: TcxProgressBar;
    CaptionPanel: TPanel;
    Image1: TcxImage;
    Shape2: TShape;
    Label3: TcxLabel;
    Shape9: TShape;
    OpenDialog: TFileOpenDialog;
    TabletaFirmaCtrl: TcxCheckBox;
    Shape4: TShape;
    cxLabel1: TcxLabel;
    Shape1: TShape;
    cxLabel2: TcxLabel;
    Servidor64bitsCtrl: TcxCheckBox;
    TiendaVirtualCtrl: TcxCheckBox;
    SuministroInmediatoCtrl: TcxCheckBox;
    GlobalProcessLabel: TcxLabel;
    Shape5: TShape;
    Shape3: TShape;
    Shape6: TShape;
    OpcionesInstalacionPageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    servidorLabel: TcxLabel;
    directorioLabel: TcxLabel;
    Label34: TcxLabel;
    ServidorCtrl: TEdit;
    DirectorioCtrl: TEdit;
    InstalarServicioCtrl: TcxCheckBox;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxImage1: TcxImage;
    cxImage2: TcxImage;
    MainPanel: TcxGroupBox;
    Panel3: TcxGroupBox;
    dxFormattedLabel1: TdxFormattedLabel;
    dxFormattedLabel2: TdxFormattedLabel;
    dxFormattedLabel3: TdxFormattedLabel;
    procedure terminalServerCtrlClick(Sender: TObject);
    procedure DestinoEditExit(Sender: TObject);
    procedure destinoBtnClick(Sender: TObject);
    procedure okButtonClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
    procedure redBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nextBtnClick(Sender: TObject);
    procedure PreviousBtnClick(Sender: TObject);
    procedure ComprobarButtonClick(Sender: TObject);
    procedure TipoInstalacionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FacturaElectronicaCtrlClick(Sender: TObject);
    procedure TrazabilidadCtrlClick(Sender: TObject);
    procedure PartidasPresupuestariasCtrlClick(Sender: TObject);
    procedure ExportacionCtrlClick(Sender: TObject);
    procedure EnvasesCtrlClick(Sender: TObject);
    procedure TabletaFirmaCtrlClick(Sender: TObject);
    procedure TiendaVirtualCtrlClick(Sender: TObject);
    procedure SuministroInmediatoCtrlClick(Sender: TObject);
    procedure Servidor64bitsCtrlClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure InstalarServicioCtrlClick(Sender: TObject);
	
  private

    Installer : TInstaller;

    TargetRootPath,
    // remoteDrive,
    ServerAddress,
    ServerPath,
    CommandLine,
    InstallPath : String;

    ErrorMsg,
    DescErrorMsg : String;
    ErrorStatus,
    ErrorCount,
    CurrentDisk : SmallInt;
    Correct,
    AppDirectoryExists,
    ProcessCanceled : Boolean;
    SearchRec : TSearchRec;
    dataLine,
    MacroString,
    UpperMacroString,
    SourcePathAndName,
    TargetPathAndName,
    TargetPath,
    TargetName,
    ServerFileName : String;

    WarningResult : TModalResult;
    StartUpInfo : TStartUpInfo;
    ProcessInformation : TProcessInformation;
    ServiceManager : TServiceManager;
    ServerServiceInfo : TServiceInfo;
    SuscriptionValidated : Boolean;

    StringList : TStringList;
    Command,
    FolderName,
    ApplicationName,
    Arguments,
    IconName,
    LinkName,
    FileName,
    ModuleNumber : String;

    OptionalModuleNumber : Integer;
    OptionalInstallableModules : TModulosOpcionales;

    ServerServiceWasRunning,
    IniFileReaded : Boolean;

    NormalColor: TColor;
    procedure DoShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo);
    function RegisterOCX( FileName : string ) : Boolean;
    procedure ShowGlobalProcessMessage(Value: String = '');

  protected

     NextActivePage : TcxTabSheet;

    constructor Create( AOwner : TComponent );            override;
    destructor  Destroy;                                  override;

  public

    procedure UpdateButtons;
    procedure FocusPageControl;
    procedure StartInstall;

    // procedure CheckSuscription;
    procedure OptionalModule( Module : TModuloOpcional; Add : Boolean );
    function GetAppDisplayName( ApplicationName : String = '' ) : String;
  end;

var
  InstallForm: TInstallForm;

implementation

{$R *.DFM}

uses  ShellAPI,
      Files,
      DateUtils,
      LibUtils,

      WindowsServiceManager,
      ShlObj,
      ActiveX,
      ComObj,
      UnInstall,
      Math,
      MessageBox,

      InfoInstall,
      RpcInstall;

resourceString
      RsMsg3   = 'Inserte la unidad de instalación número %d en la unidad [%s:].';
      RsMsg4   = 'Pulse <Intro> o haga clic en el botón aceptar cuando este listo.';
      RsMsg5   = 'No ha insertado la unidad solicitada.';
      RsMsg6   = 'El proceso de instalación NO ha finalizado satisfactoriamente.';
      RsMsg7   = 'Debe realizar la instalación de nuevo.';
      RsMsg8   = 'Instalación realizada satisfactoriamente.';
      RsMsg9   = 'Para acceder al programa localice la entrada [Aplicaciones GESTWIN] en el Menu [Inicio][Programas] de Windows.';
      RsMsg10  = 'El fichero %s no se encuentra en el directorio de distribución.';
      RsMsg11  = '¿Desea reintentar la copia de este fichero? ' + #13 + 'Si se omite la copia de un fichero puede que la instalación no se realice satisfactoriamente.';
      // RsMsg12  = 'Copyright © 1989-%d WinStation, S.L.';
      RsMsg13  = 'Limpiando datos de versiones anteriores.';
      RsMsg14  = 'Se ha producido un error al intentar compilar el fichero %s.';
      RsMsg15  = 'Compilando ficheros extensos. Espere un momento por favor ...';
      RsMsg16  = 'Creando accesos directos en la carpeta de aplicaciones de GESTWIN.';
      RsMsg17  = 'No he podido crear el fichero destino %s. Es posible que el fichero esté bloqueado por otra aplicación.';
      RsMsg18  = 'Se ha producido un fallo durante la copia del fichero %s.';
      RsMsg19  = 'Espere mientras se copian los ficheros de la aplicación en la unidad seleccionada.';
      RsMsg20  = 'A continuación el programa de instalación le irá solicitando, una a una, las unidades de distribución (Disquette, CD-ROM, etc..) de la aplicación.';
      RsMsg21  = '¿Esta seguro de que desea interrumpir el proceso de instalación?';
      // RsMsg22  = 'No puede instalar la aplicación desde una dirección UNC como %s.';
      // RsMsg23  = 'Asigne una letra de unidad al directorio y reintente la operación.';
      RsMsg24  = 'No se ha podido obtener un número de identificación válido.';
      RsMsg25  = 'Si está realizando una instalación CLIENTE asegúrese de que el path remoto al directorio GESTWIN es correcto.';
      RsMsg26  = 'Clave de activación no válida.';
      RsMsg27  = 'Actualizando el registro de Windows ...';
      RsMsg28  = 'Se produjo un error al intentar modificar el registro de Windows.';
      // RsMsg29  = 'Error en el fichero de configuración [gwinst.idd].';
      // RsMsg30  = 'Está instalando una copia de actualización de GESTWIN.';
      // RsMsg31  = '¿Desea actualizar los ficheros del gestor de base de datos?';
      RsMsg32  = 'No se han podido introducir en el registro el parche que habilita las ayudas en entornos de red.';
      // RsMsg33  = 'No se ha podido registrar el control ActiveX de funciones de GESTWIN.';
      RsMsg34  = 'Esto puede provocar que su aplicación no funcione correctamente.' + #13 + 'Consulte a su proveedor.';
      RsMsg35  = 'No se ha podido iniciar el programa de des-instalación del servidor de base de datos como servicio.';
      RsMsg36  = 'Puede des-instalarlo manualmente utilizando la línea de comando [GServer.exe /uninstall]';
      RsMsg37  = 'No se ha podido iniciar el programa de instalación del servidor de base de datos como servicio.';
      RsMsg38  = 'Puede instalarlo manualmente utilizando la línea de comando [GServer.exe /install]';
      RsMsg39  = 'Ha ocurrido un error durante la creación de los enlaces a la aplicación.';
      RsMsg40  = 'Los datos de la suscripción no son válidos.';
      RsMsg41  = 'Revise los datos introducidos y reintente el proceso.';
      RsMsg42  = 'Se han producido demasiados errores de copia de ficheros.';
      RsMsg43  = 'Se cancela el proceso de instalación.';
      RsMsg44  = 'Se va a proceder a una actualización desde la versión 10.2 de GESTWIN.';
      RsMsg45  = 'Si sigue adelante se renombrará el directorio de Gestwin como Gestwin.cs y se copiarán todos los datos al nuevo directorio.'#13'¿Desea continuar con el proceso de actualización?';
      RsMsg46  = 'No he podido renombrar el directorio %s.';
      RsMsg47  = 'Compruebe si está siendo usuado por una aplicación y libérelo antes de seguir con la instalación.';
      RsMsg48  = 'No puede actualizar desde una versión de GESTWIN anterior a la 10.2.';
      RsMsg49  = 'Actualice su aplicación a la versión 10.2.';
      RsMsg50  = 'Registrando el centro de control.';
      RsMsg51  = 'Datos necesarios';
      RsMsg52  = 'En instalaciones cliente debe indicar tanto la dirección del servidor como el directorio de acceso remoto a los datos.';
      RsMsg53  = 'No se ha podido registrar la librería [%s]';
      RsMsg54  = 'Las funciones que dependan de la misma no estarán disponibles.';
      RsMsg55  = 'No se ha podido detener el servicio del servidor de GESTWIN.';
      RsMsg56  = 'Para poder realizar la instalación o actualización es necesario que el servicio no esté funcionando.'#13'Averigue la causa del problema y reintente el proceso más adelante.';
      RsMsg57  = 'Deteniendo el servicio del servidor';
      RsMsg58  = 'Reiniciando el servicio del servidor';
      RsMsg59  = 'No se ha podido instalar el centro de control';


// const ObsoleteFiles : array[ 0..7 ] of String = ( 'SecureBBox.bpl', 'VCLGLib.bpl', 'RPCLib.bpl', 'FastReport.bpl', 'TeeChart.bpl', 'NexusDB3.bpl', 'DevExp.bpl', 'DevExpPS.bpl' );

const  tiLocal = 0;
       tiServidor = 1;
       tiCliente = 2;

procedure TInstallForm.OkButtonClick(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TInstallForm.ComprobarButtonClick(Sender: TObject);
begin
     // CheckSuscription;
end;

constructor TInstallForm.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     Installer := TInstaller.Create;
end;

destructor TInstallForm.Destroy;
begin
     Installer.Free;
     inherited Destroy;
end;

procedure TInstallForm.EnvasesCtrlClick(Sender: TObject);
begin
     OptionalModule( moEnvases, EnvasesCtrl.Checked );
end;

procedure TInstallForm.ExportacionCtrlClick(Sender: TObject);
begin
     OptionalModule( moExportacion, ExportacionCtrl.Checked );
end;

procedure TInstallForm.OptionalModule( Module : TModuloOpcional;
                                       Add    : Boolean );

var  Value : Word;

begin
     Value := Trunc( Power( 2, Ord( Module ) ) );
     If   Add
     then begin
          SpOptionalModules := SpOptionalModules + Value;
          OptionalInstallableModules := OptionalInstallableModules + [ Module ];
          end
     else begin
          SpOptionalModules := SpOptionalModules - Value;
          OptionalInstallableModules := OptionalInstallableModules - [ Module ];
          end;
end;

procedure TInstallForm.FacturaElectronicaCtrlClick(Sender: TObject);
begin
     OptionalModule( moFacturaElectronica, FacturaElectronicaCtrl.Checked );
     OptionalModule( moReservado, FacturaElectronicaCtrl.Checked ); // Para mantener la compatibilidad con versiones anteriores
end;

procedure TInstallForm.FocusPageControl;
begin
     PostMessage( Handle, WM_NEXTDLGCTL, PageControl.ActivePage.Handle, 1 );
     PostMessage( Handle, WM_NEXTDLGCTL, 0, 0 );
end;

procedure TInstallForm.CancelBtnClick(Sender: TObject);
begin
     ProcessCanceled := ShowNotification( ntQuestion, RsMsg21, '' )=mrYes;
     If   ProcessCanceled
     then If   PageControl.ActivePage=CopiaFicherosTS
          then Abort
          else Application.Terminate;
end;
procedure TInstallForm.Servidor64BitsCtrlClick(Sender: TObject);
begin
     OptionalModule( moServidor64bits, Servidor64BitsCtrl.Checked );
end;

function TInstallForm.RegisterOCX( FileName : string ) : Boolean;
begin
     Result := ProcessExecute( ProcessInformation, 'regsvr32.exe /s ' + FileName, '', SW_SHOWMINIMIZED, True );
end;

function TInstallForm.GetAppDisplayName( ApplicationName : String = '' ) : String;
begin
     If   ApplicationName=''
     then ApplicationName := AppShortName;
     ApplicationName := UpperCase( ApplicationName );
     If   ApplicationName='CONTABLE'
     then Result := 'Gestion contable y financiera'
     else If   ApplicationName='COMERCIAL'
          then Result := 'Gestion comercial'
          else If   ApplicationName='CONTABLECOMERCIAL'
               then Result := 'Gestion contable, financiera y comercial'
               else If   ApplicationName='TPV'
                    then Result := 'Terminal Punto de Venta'
                    else If   ApplicationName='PREVENTA'
                         then Result := 'Gestion de preventa y autoventa'
                         else If   ApplicationName='PREVISION'
                              then Result := 'Prevision de la produccion';
     Result := 'GESTWIN ' + Result;
end;

procedure TInstallForm.InstalarServicioCtrlClick(Sender: TObject);
begin
     TipoInstalacionCtrlPropertiesEditValueChanged(nil);
end;

procedure TInstallForm.ShowGlobalProcessMessage( Value : String = '' );
begin
     GlobalProcessLabel.Caption := Value;
     Application.ProcessMessages;
end;
procedure TInstallForm.SuministroInmediatoCtrlClick(Sender: TObject);
begin
     OptionalModule( moSuministroInmediatoInformacion, SuministroInmediatoCtrl.Checked  );
end;

procedure TInstallForm.TabletaFirmaCtrlClick(Sender: TObject);
begin
     OptionalModule( moTabletaFirma, TabletaFirmaCtrl.Checked );
end;

procedure TInstallForm.RedBtnClick(Sender: TObject);
begin
     WNetConnectionDialog( Handle, RESOURCETYPE_DISK );
     // TargetDriveCtrl.TextCase := tcLowerCase;  // refresca la lista de unidades
end;

procedure TInstallForm.FormCreate(Sender: TObject);
begin
     ServiceManager := TServiceManager.Create;
     ServiceManager.Active := True;
     try
       ServerServiceInfo := ServiceManager.ServiceByName[ DefaultServiceName ];
     except
       ServerServiceInfo := nil;
       end;
end;

procedure TInstallForm.FormDestroy(Sender: TObject);
begin
     ServiceManager.Free;
end;

procedure TInstallForm.DoShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo);
begin
     HintInfo.HintMaxWidth := 300;
end;

procedure TInstallForm.FormShow(Sender: TObject);
begin
     try

       Installer.GetInfFileName;
       AppNameLabel.Caption  := GetAppDisplayName( Installer.ApplicationName );
       CopyRightLabel.Caption := Format( CopyRightLabel.Caption, [ YearOf( Now ) ] );
       DestinoEdit.Text := 'C:\';
       // PostMessage( Handle, WM_NEXTDLGCTL, 0, 0 );

       Info.StopServer;

     except
       Application.Terminate;
       end;
end;


procedure TInstallForm.NextBtnClick(Sender: TObject);

var   St1,
      St2,
      St3 : string;

procedure CreaDirectorios;

var  InstallationPath : String;
     Version,
     Release : SmallInt;

{
procedure CopyDirectories( DirBaseName : String );

var  SearchRec : TSearchRec;

begin
     If   FindFirst( InstallationPath + '_cs\' + DirBaseName + '*', faDirectory, SearchRec )=0
     then try
            repeat
              CopyDirectory( InstallationPath + '_cs\' + SearchRec.Name, InstallationPath + '\' + SearchRec.Name );
            until FindNext( SearchRec )<>0;
          finally
            SysUtils.FindClose( SearchRec );
            end;

end;
}

begin

     { Creo el directorio \GESTWIN, pero antes compruebo si ya existe }

     InstallationPath := RemovePathDelim( ApplicationPath );
     AppDirectoryExists := DirectoryExists( InstallationPath );
     IniFileReaded := False;

     If   TipoInstalacionCtrl.ItemIndex in [ tiLocal, tiServidor ]
     then begin

          If   AppDirectoryExists and FileExists( GetIniFileName )
          then try

                 Version := ProgramVersion;
                 Release := ProgramRelease;

                 ReadIniFile;

                 If   ( Version=10 ) and ( Release=3 )
                 then If   ( ProgramVersion<10 ) or ( ( ProgramVersion=10 ) and ( ProgramRelease<2 ) )
                      then begin
                           ShowNotification( ntStop, RsMsg48, RsMsg49 );
                           Application.Terminate;
                           Abort;
                           end;

                 IniFileReaded := True;

               finally
                 ProgramVersion := Version;
                 ProgramRelease := Release;
                 end;

          CreateDirPath( InstallationPath );

          // CreateDirPath( ApplicationPath + 'data' );  // No hay que crear data porque sino el servidor cree que ya existe e intenta actualizar la base de datos en lugar de inicializarla.

          end;

end;

procedure GetProtectRecord;
begin
     GetProtectionData( pfServer );

     SpRegNumber := ProtectionRec.RegNumber;
     SpServerConnections := ProtectionRec.ServerConnections;
     SpActivationKey := ProtectionRec.ActivationKey;

end;

procedure CheckProtecRecord;
begin
     If   ( SpRegNumber=0 ) or
          ( SpActivationKey<>MakeActivationKey( SpSerialNumber +
                                                SpRegNumber    +
                                                SpServerConnections +
                                                ProgramNumber      +
                                                ProgramVersion +
                                                ProgramRelease +
                                                SpOptionalModules ) )
     then begin
          ShowNotification( ntStop, RsMsg26, '' );
          Abort;
          end;
end;

procedure CompruebaProteccionCliente;
begin
     If   TipoInstalacionCtrl.ItemIndex=tiCliente
     then try

            // Aprovecho para garantizar el acceso al directorio ProgramData a todo el mundo

            GrantAllAccessToDirectory( Installer.ApplicationDataDirectory );

            If   ProtectionRec.Suscription
            then begin

                 // Comprobaciones de una instalacion cliente de suscripción (si las hay)

                 end
            else begin

                 If   ProtectionRec.SerialNumber=0
                 then begin
                      ShowNotification( ntStop, RsMsg24, RsMsg25 );
                      Abort;
                      end;

                 SpSerialNumber := ProtectionRec.SerialNumber;
                 SpEvaluation := False;

                 CheckProtecRecord;

                 WriteProtectionData( pfClient, SpSerialNumber );

                 end;

          except on E : Exception do
            begin
            ShowException( E );
            Abort;
            end;
          end;

end;

function OpcionActiva( Valor  : Word;
                       Module : TModuloOpcional ) : Boolean;
begin
     Result := ( Valor and Trunc( Power( 2, Ord( Module ) ) ) )<>0;
end;

procedure SetupOptions;
begin
     GetProtectRecord;

     If   TipoInstalacionCtrl.ItemIndex<>tiCliente
     then SpSerialNumber := GetDiskID( TargetRootPath );

     SpSuscription := False;
     SpEvaluation := False;
     NumeroRegistroCtrl.Text := '';
     ClaveActivacionCtrl.Text := '';
     If   ProtectionRec.RegNumber<>0
     then begin
          NumeroRegistroCtrl.Text := IntToStr( SpRegNumber );
          ConexionesServidorCtrl.Text := IntToStr( SpServerConnections );
          ClaveActivacionCtrl.Text := IntToStr( SpActivationKey );
          end;
     NroSerieLabel.Caption := IntToStr( spSerialNumber );
     FacturaElectronicaCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moFacturaElectronica );
     TrazabilidadCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moTrazabilidad );
     PartidasPresupuestariasCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moPartidasPresupuestarias );
     EnvasesCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moEnvases );
     ExportacionCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moExportacion );
     TabletaFirmaCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moTabletaFirma );
     TiendaVirtualCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moTiendaVirtual );
     SuministroInmediatoCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moSuministroInmediatoInformacion );

     Servidor64BitsCtrl.Checked := OpcionActiva( ProtectionRec.OptionalModules, moServidor64bits );
end;

begin
     With PageControl do
       begin

       If   ActivePage=PresentacionTS
       then ActivePage := TipoInstalacionTS
       else If   ActivePage=TipoInstalacionTS
            then begin

                 If   DirectoryExists( DestinoEdit.Text )
                 then begin
                      If   ( Copy( DestinoEdit.Text, 1, 2 )='\\' ) and
                           ( TipoInstalacionCtrl.ItemIndex in [ tiLocal, tiServidor ] )
                      then begin
                           ShowNotification( ntStop, 'No puede especificar paths UNC para instalaciones locales o servidor.',
                                                     'Debe indicar un path del tipo C:\Datos, es decir, que contenga una letra de unidad.' );
                           DestinoEdit.SetFocus;
                           Abort;
                           end;

                      end
                 else begin
                      ShowNotification( ntStop, 'El directorio destino no existe.', '' );
                      DestinoEdit.SetFocus;
                      Abort;
                      end;

                 TargetRootPath := AddPathDelim( DestinoEdit.Text );

                 ServerAddress := ServidorCtrl.Text;
                 ServerPath := DirectorioCtrl.Text;

                 ApplicationPath := TargetRootPath + 'Gestwin\';

                 Installer.ReadConfigFile;

                 AppShortName := Installer.ApplicationName;

                 If   TipoInstalacionCtrl.ItemIndex=tiCliente
                 then begin

                      If   ( ServerAddress='' ) or ( ServerPath='' )
                      then begin
                           ShowNotification( ntStop, RsMsg51, RsMsg52 );
                           If   ServerAddress=''
                           then ServidorCtrl.SetFocus
                           else DirectorioCtrl.SetFocus;
                           Exit;
                           end;

                      SetupOptions;

                      NextActivePage := CopiaFicherosTS;
                      end
                 else begin

                      try

                        If   Assigned( ServerServiceInfo )
                        then begin
                             ServerServiceInfo.Live := True;
                             If   ServerServiceInfo.State=ssRunning
                             then begin
                                  ServerServiceWasRunning := True;
                                  ShowGlobalProcessMessage( RsMsg57 );
                                  ServerServiceInfo.ServiceStop( True );
                                  If   ServerServiceInfo.State<>ssStopped
                                  then Abort;
                                  end;
                             ShowGlobalProcessMessage;
                             end;
                      except
                        ShowGlobalProcessMessage;
                        ShowNotification( ntStop, RsMsg55, RsMsg56 );
                        Application.Terminate;
                        Abort;
                        end;

                      If   Installer.Evaluation
                      then NextActivePage := CopiaFicherosTS
                      else begin
                           SetupOptions;
                           NextActivePage := ProteccionTS;
                           end;

                      end;

                  With PageControl do
                    If   ProgramNumber in [ 1, 3, 5 ]
                    then begin
                         ActivePage := OpcionesTS;

                         FacturaElectronicaCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         TrazabilidadCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         PartidasPresupuestariasCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         EnvasesCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         ExportacionCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         TabletaFirmaCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         TiendaVirtualCtrl.Enabled := ProgramNumber in [ 3, 5 ];
                         SuministroInmediatoCtrl.Enabled := ProgramNumber in [ 1, 3, 5 ];

                         end
                    else begin
                         CompruebaProteccionCliente;
                         ActivePage := NextActivePage;
                         end;

                 end
            else If   ActivePage=OpcionesTS
                 then begin
                      CompruebaProteccionCliente;
                      PageControl.ActivePage := NextActivePage;
                      end
                 else If   ActivePage=ProteccionTS
                      then begin

                           CreaDirectorios;

                           SpEvaluation := True;

                           St1 := Trim( NumeroRegistroCtrl.Text );
                           St2 := Trim( ConexionesServidorCtrl.Text );
                           St3 := Trim( ClaveActivacionCtrl.Text );

                           If   ( St1<>'' ) and
                                ( St2<>'' ) and
                                ( St3<>'' )
                           then begin

                                SpRegNumber := StrToInt( St1 );
                                SpServerConnections := StrToInt( St2 );
                                SpActivationKey := StrToInt( St3 );

                                CheckProtecRecord;

                                SpEvaluation := False;

                                WriteProtectionData( pfServer );

                                With Rpc do
                                  try
                                    try
                                      Connect( 2 );  // Solo 6 segundos de Timeout para evitar parones excesivos
                                      RegisterInstallation;
                                    except
                                      // Si no se puede conectar o no se puede enviar el registro no pasa nada (de momento)
                                      end;
                                  finally
                                    Disconnect;
                                    end;

                                end;

                           PageControl.ActivePage := CopiaFicherosTS;
                           end;

       UpdateButtons;
       FocusPageControl;

       If   ActivePage=CopiaFicherosTS
       then StartInstall;

       end;
end;

procedure TInstallForm.CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TInstallForm.PartidasPresupuestariasCtrlClick(Sender: TObject);
begin
     OptionalModule( moPartidasPresupuestarias, PartidasPresupuestariasCtrl.Checked );
end;

procedure TInstallForm.PreviousBtnClick(Sender: TObject);
begin
     With PageControl do
       If   ( ActivePage=ProteccionTS ) or ( ActivePage=OpcionesTS )
       then ActivePage := TipoInstalacionTS
       else If   ActivePage=TipoInstalacionTS
            then ActivePage := PresentacionTS;

     UpdateButtons;
     FocusPageControl;
end;

procedure TInstallForm.UpdateButtons;

var  FirstPage,
     LastPage,
     MoveFocus : Boolean;

begin
     MoveFocus := PreviousBtn.Focused;
     With PageControl do
       begin
       FirstPage := ActivePage=PresentacionTS;
       LastPage := ActivePage=CopiaFicherosTS;
       end;
     If   FirstPage and MoveFocus
     then NextBtn.SetFocus;
     PreviousBtn.Enabled := not FirstPage and not LastPage;
     MoveFocus := NextBtn.Focused;
     If   LastPage and MoveFocus
     then CancelBtn.SetFocus;
     NextBtn.Enabled := not LastPage;

     Application.ProcessMessages;
end;

procedure TInstallForm.TipoInstalacionCtrlPropertiesEditValueChanged(Sender: TObject);

var  ActivarConfiguracionCliente : Boolean;

begin
     ActivarConfiguracionCliente := TipoInstalacionCtrl.ItemIndex=tiCliente;

     ServidorLabel.Enabled := ActivarConfiguracionCliente;
     ServidorCtrl.Enabled := ActivarConfiguracionCliente;
     DirectorioLabel.Enabled := ActivarConfiguracionCliente;
     DirectorioCtrl.Enabled := ActivarConfiguracionCliente;

     OpcionesInstalacionPageControl.ActivePageIndex := TipoInstalacionCtrl.ItemIndex;
end;


procedure TInstallForm.TrazabilidadCtrlClick(Sender: TObject);
begin
     OptionalModule( moTrazabilidad, TrazabilidadCtrl.Checked );
end;

procedure TInstallForm.destinoBtnClick(Sender: TObject);
begin
     OpenDialog.DefaultFolder := DestinoEdit.Text;
     If   OpenDialog.Execute
     then begin
          DestinoEdit.Text := AddPathDelim( OpenDialog.FileName );
          DestinoEdit.setFocus;
          end;
end;

procedure TInstallForm.DestinoEditExit(Sender: TObject);
begin
     DestinoEdit.Text := AddPathDelim( DestinoEdit.Text );
     If   Copy( DestinoEdit.Text, 1, 2 )='\\'
     then DirectorioCtrl.Text := DestinoEdit.Text;
end;

procedure TInstallForm.StartInstall;

var   I : SmallInt;
      FileNotCopied : Boolean;
      UninstallAppInfo : TUninstallAppInfo;

procedure SaveIniFile;
begin
      If   TipoInstalacionCtrl.ItemIndex in [ tiLocal, tiServidor ]
      then begin
           If   not IniFileReaded
           then ReadIniFile;
           Dictionaries := Dictionaries + ',' + Installer.GetOptionalDictionariesString( OptionalModules, OptionalInstallableModules );
           OptionalModules := Installer.GetOptionalModulesString( OptionalModules, OptionalInstallableModules );
           UpdateIniFile;
           end;
end;

begin
     try

       try

         DemoLabel.Visible := SpEvaluation;

         If   Servidor64BitsCtrl.Checked
         then ServerFileName := 'GServer64.exe'
         else ServerFileName := 'GServer.exe';
         Animate.Visible := True;
         Animate.Active := True;

         UpdateButtons;

         CurrentDisk := 0;
         ErrorCount := 0;
         IniFileReaded := False;
         ProcessCanceled := False;

         If   TipoInstalacionCtrl.ItemIndex in [ tiLocal, tiServidor ]
         then begin
              EraseDirectory( ApplicationPath + 'DataServer' );     // Borro el directorio DataServer para evitar que se pueda seguir utilizando el viejo servidor
              // EraseListOfFiles( InstallPath + 'Gestwin\', ObsoleteFiles, False );
              end;

         // Empieza la copia de ficheros

         With Installer, FileList do
           begin

           If   NumOfDisks=1
           then ProcesoCopiaLabel.Caption := RsMsg19
           else ProcesoCopiaLabel.Caption := RsMsg20;

           I := 0;
           While ( I<Count ) and not ProcessCanceled do
              With TFileComponent( Items[ I ] ) do
                begin

                If   ( NumOfDisks<>1 ) and ( CurrentDisk<>Disk )
                then begin

                     NroDiscoLabel.Caption := IntToStr( Disk );

                     If   Disk<>1
                     then repeat
                            Correct := False;
                            If   ShowNotification( ntWarning, Format( RsMsg3, [ Disk, SourceInstallPath ] ), RsMsg4 )=mrOk
                            then begin
                                 Application.ProcessMessages;
                                 If   FindFirst( SourceInstallPath + 'Disk' + IntToStr( Disk ), faArchive, SearchRec )=0
                                 then Correct := True
                                 else ShowNotification( ntStop, RsMsg5, '' );
                                 end
                            else ProcessCanceled := True;
                           until Correct or ProcessCanceled;
                     CurrentDisk := Disk;
                     end;

                Application.ProcessMessages;

                If   not ProcessCanceled and

                     ( ( opAll in InstallOption ) or
                       ( ( opServer in InstallOption ) and ( TipoInstalacionCtrl.ItemIndex in [ tiLocal, tiServidor ] ) ) or
                       ( ( opClient in InstallOption ) and ( TipoInstalacionCtrl.ItemIndex=tiCliente ) ) ) and

                     // ( ( FileWinVersion=wvUnknown ) or ( FileWinVersion=WinVersion ) ) and

                     ( ( OptionalModule=0 ) or ( TModuloOpcional( OptionalModule ) in OptionalInstallableModules ) ) and

                     // Si se instala la versión de 64 bits no es necesario copiar el servidor de 32bits, porque se descargaría cada vez que el usuario
                     // realizara una actualización.

                     not ( ServerFile and ( OptionalModule=0 ) and Servidor64BitsCtrl.Checked ) and

                     // La versión de evaluación no permite el servidor de 64 bits.

                     not ( ServerFile and ( OptionalModule=10 ) and SpEvaluation )

                then begin

                     TargetPathAndName := ExpandPathAndName( TargetRootPath, PathAndName, FpTarget );

                     TargetPath := RemovePathDelim( ExtractFilePath( TargetPathAndName ) );
                     TargetName := ExtractFileName( TargetPathAndName );

                     CreateDirPath( TargetPath );

                     SourcePathAndName := ExpandPathAndName( SourceInstallPath, PathAndName, FpDistribution );

                     SourceLabel.Caption := SourcePathAndName;
                     TargetLabel.Caption := TargetPathAndName;
                     ProgressBar.Position := ( I * 100 ) div ( Count - 1 );
                     Application.ProcessMessages;

                     If   not ProcessCanceled
                     then repeat

                            FileNotCopied := False;

                            If   TargetName=''   // es un directorio
                            then begin
                                 Correct := True;
                                 If   DirectoryExists( RemovePathDelim( SourcePathAndName ) )
                                 then CopyDirectory( SourcePathAndName, TargetPathAndName );
                                 end
                            else begin
                                 Correct := CopyCompressedFile( SourcePathAndName, TargetPathAndName, ErrorStatus, OverWrite );
                                 If   not Correct
                                 then begin
                                      case ErrorStatus of
                                        lzErrorOpeningSource : begin
                                                               ErrorMsg := Format( RsMsg10, [ SourcePathAndName ] );
                                                               DescErrorMsg := RsMsg11;
                                                               end;
                                        lzErrorOpeningTarget : begin
                                                               ErrorMsg := Format( RsMsg17, [ TargetPathAndName ] );
                                                               DescErrorMsg := RsMsg11;
                                                               end;
                                        lzErrorCopyingFile   : begin
                                                               ErrorMsg := Format( RsMsg18, [ SourcePathAndName ] );
                                                               DescErrorMsg := RsMsg11;
                                                               end;
                                        end;
                                      WarningResult := ShowNotification( ntQuestionWarning, ErrorMsg, DescErrorMsg );
                                      ProcessCanceled := WarningResult=mrCancel;
                                      Correct := WarningResult=mrNo;
                                      FileNotCopied := True;
                                      end;
                                 end;
                          until ProcessCanceled or Correct;

                     If   FileNotCopied
                     then begin
                          Inc( ErrorCount );
                          If   ErrorCount>2
                          then begin
                               ShowNotification( ntError, RsMsg42, RsMsg43 );
                               ProcessCanceled := True;
                               end;
                          end;

                     end;

                Inc( I );
                end;

           end;

         If   ProcessCanceled
         then Abort
         else begin

              ProgressBar.Position := 100;
              ProcessLabel.Caption := RsMsg15;
              Application.ProcessMessages;
              With Installer, CommandList do
                For I := 0 to Count - 1 do
                  begin
                  If   Copy( Strings[ I ], 1 ,1 )='0'  { Es un comando JOIN }
                  then begin
                       LineText := Copy( Strings[ I ], 3, Length( Strings[ I ] ) );
                       ReadParamList;
                       ExpandPathAndName( TargetRootPath, ParamList[ 0 ], FpTarget );
                       If   not JoinFile( ParamList[ 0 ], StrToInt( ParamList[ 1 ] ) )
                       then begin
                            ShowNotification( ntStop, Format( RsMsg14, [ ParamList[ 0 ] ] ), RsMsg6 );
                            Abort;
                            end;
                       end;
                  end;

              (*  Lo dejo como ejemplo de registro de un parche en Windows

              // Actualizando el registro

              ProcessLabel.Caption := RsMsg27;
              Application.ProcessMessages;

              {$I+}

              If   WinVersion=wvWinXP
              then try

                     // Quitando la restricción de archivos HTML remotos

                     MacroString  := 'RegEdit.exe /s ' + AddPathDelim( Installer.TemporalDirectory ) + 'KB896358_FIX.reg';
                     Correct      := createProcess( nil,
                                                    pChar( MacroString ),
                                                    nil,
                                                    nil,
                                                    True,
                                                    0,
                                                    nil,
                                                    nil,
                                                    StartUpInfo,
                                                    ProcessInformation );

                     If   not Correct
                     then ShowNotification( mbStop, RsMsg32, RsMsg34 );

                   except
                     ShowNotification( mbStop, RsMsg28, '' );
                     Abort;
                     end;

              {$I-}
              *)

              InstallPath := TargetRootPath;

              ProcessLabel.Caption := RsMsg13;

              // Creando accesos directos en la carpeta de aplicaciones de GESTWIN

              ProcessLabel.Caption := RsMsg16;
              Application.ProcessMessages;

              CommandLine := '';

              If   TipoInstalacionCtrl.ItemIndex=tiCliente
              then CommandLine := '-R ' + ServerAddress + ' ' + ServerPath;

              With Installer, CommandList do
                For I := 0 to Count - 1 do
                  begin
                  If   Copy( Strings[ I ], 1 ,1 )='1'  { Es un comando del Shell }
                  then begin
                       MacroString := Copy( Strings[ I ], 3, Length( Strings[ I ] ) );

                       // Cuando se instala como servicio no se añade acceso al programa GServer

                       {
					                  If   ( TipoInstalacionCtrl.ItemIndex=tiServidor ) and InstalarServicioCtrl.Checked
                       then begin
					                  }
                            UpperMacroString := upperCase( MacroString );
                            If   ( Pos( 'INICIO', UpperMacroString )<>0 ) or
                                 ( Pos( ServerFileName, UpperMacroString )<>0 )
                            then Continue;
					                       {
                            end;
					                       }

                       MacroString := StringReplace( MacroString, '<InstallPath>', InstallPath, [ rfReplaceAll, rfIgnoreCase ] );
                       MacroString := StringReplace( MacroString, '<AppDataPath>', Installer.ApplicationDataDirectory, [ rfReplaceAll, rfIgnoreCase ] );
                       MacroString := StringReplace( MacroString, '<CommandLine>', CommandLine,  [ rfReplaceAll, rfIgnoreCase ] );
                       MacroString := StringReplace( MacroString, '<ServerFileName>', ServerFileName,  [ rfReplaceAll, rfIgnoreCase ] );

                       // Sustituido el sistema de macros por el uso de las librerías Shell

                       try
                         StringList := TStringList.Create;
                         ExtractStringList( MacroString, StringList );

                         Command := UpperCase( StringList[ 0 ] );
                         If   Command='CREATEGROUP'
                         then begin
                              FolderName := StringList[ 1 ];
                              CreateSystemFolder( FolderName, CSIDL_PROGRAMS );
                              end
                         else begin
                              ApplicationName := StringList[ 1 ];
                              Arguments := StringList[ 2 ];
                              IconName := StringList[ 3 ];
                              LinkName := StringList[ 4 ];
                              If   StringList.Count=6
                              then FolderName := StringList[ 5 ];
                              If   Command='ADDITEM'
                              then AddShellItem( ApplicationName, Arguments, IconName, LinkName, FolderName, CSIDL_PROGRAMS, TipoInstalacionCtrl.ItemIndex=tiLocal )
                              else If   Command='ADDLINK'
                                   then AddShellItem( ApplicationName, Arguments, IconName, LinkName, '', CSIDL_DESKTOPDIRECTORY, TipoInstalacionCtrl.ItemIndex=tiLocal );
                              end;

                       finally
                         StringList.Free;
                         end;

                       end
                  else If   Copy( Strings[ I ], 1 ,1 )='2'  { Es un comando de registro OCX/Activex }
                       then begin
                            MacroString := Copy( Strings[ I ], 3, Length( Strings[ I ] ) );
                            MacroString := StringReplace( MacroString, '<InstallPath>', InstallPath, [ rfReplaceAll, rfIgnoreCase ] );
                            try
                              StringList := TStringList.Create;
                              ExtractStringList( MacroString, StringList );
                              FileName := StringList[ 0 ];
                              ModuleNumber := StringList[ 1 ];
                              OptionalModuleNumber := StrToIntDef( ModuleNumber, 0 );
                              If   ( OptionalModuleNumber=0 ) or
                                   ( ( OptionalModuleNumber in [ 1..9 ] ) and ( TModuloOpcional( OptionalModuleNumber ) in OptionalInstallableModules ) )
                              then If   not RegisterOCX( FileName )
                                   then ShowNotification( ntExceptionError, Format( RsMsg53, [ FileName ] ), RsMsg54 );
                            finally
                              StringList.Free;
                              end;
                            end;
                  end;

              Delay( 1000 );

              // Actualizando el fichero .ini con la lista de módulos opcionales

              SaveIniFile;

              // Registrando el centro de control (instalación, actualización, des-instalación, etc..)

              If   FileExists( Installer.ApplicationDataDirectory + 'GdInstall.exe' )
              then try

                       ProcessLabel.Caption := RsMsg50;

                       FillChar( UninstallAppInfo, SizeOf( UninstallAppInfo ), #0 );
                       With UninstallAppInfo do
                         begin
                         RegKeyBaseName := 'Gestwin ' + AppShortName;  // ContableComercial
                         AppInstallPath := ApplicationPath;
                         DisplayName := GetAppDisplayName;
                         DisplayIcon := Installer.ApplicationDataDirectory + 'GdInstall.exe';
                         ExeFilename := Installer.ApplicationDataDirectory + 'GdInstall.exe ' + AppShortName;
                         AppVersion := IntToStr( ProgramVersion ) + '.' + IntToStr( ProgramRelease );
                         AppPublisher := 'Winstation, S.L.';
                         AppPublisherURL := 'http://www.gestwin.com';
                         AppSupportPhone := '964460646';
                         AppContact := 'soporte@gestwin.com';
                         AppModifyPath := Installer.ApplicationDataDirectory + 'GdInstall.exe ' + AppShortName + ' /M';
                         end;

                       SetRegisterUninstallInfo( UninstallAppInfo );

                   except on E : Exception do
                     // ShowNotification( ntStop, RsMsg59, E.Message );
                     end;

              ProcessLabel.Caption := '';

              If   ( TipoInstalacionCtrl.ItemIndex=tiServidor ) and InstalarServicioCtrl.Checked
              then begin

                   //  Instalando GServer como un servicio

                   FillChar( ProcessInformation, SizeOf( ProcessInformation ), #0 );

                   MacroString := InstallPath + 'Gestwin\' + ServerFileName + ' /INSTALL /LOCALSYSTEMACCOUNT /SILENT /START';
                   StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
                   Correct  := CreateProcess( nil, PChar( MacroString ), nil, nil, True, 0, nil, nil, StartUpInfo, ProcessInformation );

                   If   not Correct
                   then ShowNotification( ntStop, RsMsg37, RsMsg38 );
                   end;

              If   Assigned( ServerServiceInfo ) and ServerServiceWasRunning
              then begin
                   ShowGlobalProcessMessage( RsMsg58 );
                   ServerServiceInfo.ServiceStart( True );
                   ShowGlobalProcessMessage;
                   end;

              // Aprovecho para borrar el GServer de 32 bits si la instalación es de 64.

              If   Servidor64BitsCtrl.Checked
              then EraseFile( ApplicationPath + 'GServer.exe', False );

              ShowNotification( ntInformation, RsMsg8, RsMsg9 );
              end;

       except
         ShowNotification( ntStop, RsMsg6, RsMsg7 );
         end;

    finally
      Application.Terminate;
      end;
end;

procedure TInstallForm.terminalServerCtrlClick(Sender: TObject);
begin
     TipoInstalacionCtrlPropertiesEditValueChanged(nil);
end;

procedure TInstallForm.TiendaVirtualCtrlClick(Sender: TObject);
begin
     OptionalModule( moTiendaVirtual, TiendaVirtualCtrl.Checked  );
end;

end.
