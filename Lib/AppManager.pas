{$WARN SYMBOL_PLATFORM OFF}

unit AppManager;

interface

uses   System.UITypes,
       System.UIConsts,
       WinAPI.Windows,
       WinAPI.Messages,
       Vcl.StdCtrls,
       Vcl.ExtCtrls,
       Vcl.Graphics,

       Classes,
       Controls,
       SysUtils,

       Forms,
       LibUtils

       {$IFNDEF SERVERAPP}
       ,
       cxGraphics,
       cxTreeView,
       cxBarEditItem,
       dxGDIPlusClasses,
       dxBar,
       dxBarExtItems,
       dxNavBarCollns,
       cxButtons

       {$ENDIF}
       ;

 type
     TProcItemType = ( imInitialize,              // Antes de que se inicie la base de datos global, se ajustan los punteros de configuración de cada unit
                       imStartup,                 // Iniciando las bases de datos de cada módulo
                       imSectionModule,           // Iniciando las secciones principales ...
                       imOptionalSectionModule,   // y las opcionales
                       imGetParamConf,
                       imProcedure,
                       imOnCreateComponent,
                       imOnDestroyComponent,
                       imOnEnterpriseAccess );    // Cuando se a inicializado la base de datos de la Empresa y se accede a ella (b_uee)

      TNotificationType = ( ntInformation,           // Estos 7 primeros tienen icono en el ProcessFrame
                            ntRecordInformation,
                            ntWarning,
                            ntError,
                            ntCorrect,
                            ntFailed,
                            ntStop,
                            ntExceptionError,
                            ntAbort,                 // Solo se muestra si no ha habido ningún error previo
                            ntRecord,

                            ntQuestion,              // Cuidado, estos mensajes bloquean los procesos al solicitar una respuesta del usuario
                            ntQuestionWarning,
                            ntAcceptCancel,          //..

                            ntNone,
                            ntHeader,
                            ntLinkInformation,
                            ntHeaderInformation,

                            ntStartSubprocess,       // Si no existe una ventana de proceso se inicia una de subproceso
                            ntEndSubprocess,
                            ntProcessCanceled,
                            ntUpdateDatabase,        // Se notifica al cliente de que es necesario actualizar la base de datos
                            ntInitializeDatabase,
                            ntCloseSession,
                            ntCheckSession );

      TModuloOpcional    = ( moNinguno = 0,          // La numeración debe coincidir con la del fichero .idd
                             moFacturaElectronica = 1,
                             moTrazabilidad = 2,
                             moPartidasPresupuestarias = 3,
                             moEnvases = 4,
                             moExportacion = 5,
                             moTabletaFirma = 6,
                             moReservado = 7,
                             moTiendaVirtual = 8,
                             moSuministroInmediatoInformacion = 9,
                             moServidor64bits = 10 );

      TRootCategory = ( rcDatabase = 0,
                        rcServer = 1,
                        rcStatistics = 2,
                        rcRoot = 3 );

      TModulosOpcionales = set of TModuloOpcional;

      TDataModuleClass   = class of TDataModule;

      TFormType = ( fmUnassigned, fmEdit, fmQuery, fmReport, fmGrid, fmBackground, fmSelector );
      TSimpleEvent = procedure of object;
      TCheckEvent = function : Boolean of object;
      TShowProgressEvent = procedure( ProgMessage : String = ''; Percent : Integer = -1 ) of object;
      TProcessLogEvent = procedure( Caption, Msg : String ) of object;

      TShowException = procedure( E : Exception; Component : TComponent = nil );

      TShowHintMessage = procedure( MsgStr           : String;
                                    DescStr          : String;
                                    Control          : TWinControl = nil;
                                    NotificationType : TNotificationType = ntExceptionError );

      TShowNotification = function( NotificationType  : TNotificationType;
                                    Header            : String;
                                    Description       : String = '';
                                    SystemMessage     : String = '';
                                    ForceBoxMsg       : Boolean = False ) : TModalResult;

      TPrgExitNotification = function( RequestForExit : Boolean;
                                       Force          : Boolean = False;
                                       SilentMode     : Boolean = False  ) : Boolean;


      TProcedureItem = class
       protected

         FItemType : TProcItemType;
         FID : Integer;     // Identificador. Si es un módulo de seccion, por ejemplo, el número del módulo.
         FInitProc,
         FProc,
         FFinishProc : TProcedure;

       public

         constructor Create( ItemType    : TProcItemType;
                             ID          : Integer;
                             Proc        : TProcedure );  overload;

         constructor Create( ItemType    : TProcItemType;
                             ID          : Integer;
                             InitProc,
                             Proc,
                             FinishProc  : TProcedure );  overload;

         procedure DoInitProc;
         procedure DoProc;
         procedure DoFinishProc;

         property ItemType : TProcItemType read  FItemType;
         property ID : Integer read FID;
         end;

      TProcedureList = class( TList )
       public
         procedure Clear; override;
         function  FindByTypeAndID( AnItemType : TProcItemType; AnID : Integer ) : TProcedureItem;
         end;

      TProtectionRec = packed record
        LocalDiskID,
        SerialNumber,
        ActivationKey : Int64;
        RegNumber,
        ProgramNumber,
        ProgramVersion,
        ProgramRelease,
        ServerConnections : Integer;       // 5, 10, 15, 20 o 50
        Suscription,
        Evaluation : Boolean;
        UserCode : String[ 5 ];
        UserName : String[ 40 ];
        ApplicationPath : String[ 200 ];
        OptionalModules : Word;            // Cada módulo activa un bit de OptionalModules
        Reservado : Array[ 0..44 ] of Byte;
        Caducity : TDateTime;
        end;

      TSuscriptionRec = packed record
        LastCheck : TDateTime;
        LastState : Integer;
        CheckCount : Integer;
        end;
      
      TProtecFileType = ( pfServer, pfClient, pfControlCenter, pfInstaller );
      TDataAccesMode  = ( dmLocal, dmRemote );
      TDataAccessTransport = ( dtNamedPipe, dtWinsock );
      TClientType = ( ctLicensing, ctWindows, ctRPC, ctWeb, ctServer );

      TVersionInfo = packed record
        case Byte of
          0 : ( MinorVersion,
                MajorVersion,
                Build,
                Release : Word );
          1 : ( MsValue,
                LsValue : LongInt );
          end;

      TApplicationManager = class(TDataModule)
        {$IFNDEF SERVERAPP}
        procedure DoOnException( Sender : TObject; E : Exception );
        {$ENDIF}
        end;
            
     {$IFNDEF SERVERAPP}
       
      TgAppSection = class( TComponent )
        private

          FMainMenuBar : TdxBar;
          FMainMenuBarFontFixed : Boolean;
          FContentTreeView : TcxTreeView;
          FCaption : String;
          FGlyph: TBitmap;
          FSmartGlyph: TdxSmartGlyph;
          FSetupSection,                        // Seccion de configuración
          FNewGroup : Boolean;
          FOnInitialize,
          FOnSelected,
          FOnUpdateSelector,
          FOnUpdateMainMenu : TSimpleEvent;
          FOnSetAccess,
          FOnSetUserOption : TCheckEvent;
          {$IFDEF APPSECTIONSPANEL}
          FSectionsMenuItem : TcxButton;
          {$ELSE}
          FSectionsMenuItem : TdxBarButton;
          {$ENDIF}
          FEnabled : Boolean;
          FHidden : Boolean;
          FHelpFile : String;

        protected

          procedure Notification( AComponent : TComponent; Operation : TOperation );  override;
          procedure SetGlyph( Value : TBitmap );
          procedure SetSmartGlyph(Value: TdxSmartGlyph);
          procedure SetEnabled( Value : Boolean );

        public

          constructor Create( AOwner : TComponent ); override;
          destructor Destroy; override;

          procedure UpdateMainMenu;
          procedure UpdateSelector;

          procedure DoOnInitialize;
          procedure DoOnSelected;

          {$IFDEF APPSECTIONSPANEL}
          property  SectionsMenuItem : TcxButton read FSectionsMenuItem write FSectionsMenuItem;
          {$ELSE}
          property  SectionsMenuItem : TdxBarButton read FSectionsMenuItem write FSectionsMenuItem;
          {$ENDIF}

        published
          property Caption : String read FCaption write FCaption;
          property Enabled : Boolean read FEnabled write SetEnabled;
          property Hidden : Boolean read FHidden write FHidden;
          property HelpFile : String read FHelpFile write FHelpFile ;
          property Glyph: TBitmap read FGlyph write SetGlyph;
          property SmartGlyph: TdxSmartGlyph read FSmartGlyph write SetSmartGlyph;
          property MainMenuBar : TdxBar read FMainMenuBar write FMainMenuBar;
          property MainMenuBarFontFixed : Boolean read FMainMenuBarFontFixed write FMainMenuBarFontFixed;
          property ContentTreeView : TcxTreeView read FContentTreeView write FContentTreeView;
          property NewGroup : Boolean read FNewGroup write FNewGroup;
          property SetupSection : Boolean read FSetupSection write FSetupSection;

          property OnInitialize : TSimpleEvent read FOnInitialize write FOnInitialize;
          property OnSelected : TSimpleEvent read FOnSelected write FOnSelected;
          property OnSetAccess: TCheckEvent read FOnSetAccess write FOnSetAccess;
          property OnSetUserOption: TCheckEvent read FOnSetUserOption write FOnSetUserOption;
          property OnUpdateMainMenu : TSimpleEvent read FOnUpdateMainMenu write FOnUpdateMainMenu;
          property OnUpdateSelector : TSimpleEvent read FOnUpdateSelector write FOnUpdateSelector;
          end;

      {$ENDIF}

const CM_SERVERNOTIFICATION = CM_BASE + 200;
      CM_LATEFOCUS = CM_BASE + 201;

      IMAGE_FILE_NET_RUN_FROM_SWAP = $0800;

      MainFormClassName = 'WSMFClass';
      ServerClassName = 'FMTGServerForm';

      LicenseCheckDays = 15;
      LicenseCheckCount = 5; //20;
      ProtectFileExt = '.gdf';

      RsWebPage = 'https://www.gestwin.com/soporte/solicitud-de-asistencia-tecnica';
      RsForumPage = 'https://www.gestwin.net/index.php?option=com_kunena&Itemid=77';  // De momento no se utiliza

      RsCopyRight = 'Copyright © 1989-%d WinStation, S.L.';
      RsGestwin  = 'Gestwin';

      DEF_SUSCRIPTION_PATH = '\Software\Classes\Interface\{F2EB36CA-02E4-415D-868B-4F3BE09C39D2}';
      TERMINAL_SERVER_KEY = 'SYSTEM\CurrentControlSet\Control\Terminal Server';

      ClientTypeNames : array[ ctLicensing..ctServer ] of String = ( 'Licencias', 'Windows', 'RPC', 'Web', 'Servidor' );

      NombreModuloOpcional : Array[ moNinguno..moServidor64bits ] of String = ( 'Ninguno',
                                                                                'Factura electrónica',
                                                                                'Trazabilidad',
                                                                                'Partidas presupuestarias',
                                                                                'Envases y contenedores',
                                                                                'Exportación',
                                                                                'Tableta de firma',
                                                                                'Reservado',
                                                                                'Tienda virtual Magento',
                                                                                'Suministro inmediato de información',
                                                                                'Servidor de 64bits' );

var   OnShowException : TShowException = nil;
      OnShowHintMessage : TShowHintMessage = nil;
      OnShowNotification : TShowNotification = nil;
      OnPrgExitNotification : TPrgExitNotification = nil;
      OnUpdateDatabase : TProcedure = nil;
      OnProcessLog : TProcessLogEvent = nil;

      SpSerialNumber,
      SpRegNumber,
      SpActivationKey : Int64;
      SpServerConnections : SmallInt;
      SpSuscription,
      SpEvaluation : Boolean;
      SpUserCode,
      SpUserName : AnsiString;
      // SpCounter : SmallInt;
      SpLastCheck : TDateTime;
      SpLastLicenseState : SmallInt;
      SpCaducity : TDateTime;
      SpOptionalModules : Word;
      Sp64BitsServer : Boolean;

      ProgramNumber,
      ProgramVersion,
      ProgramRelease : Word;                    // Los valores leídos desde el fichero de configuración

      DebugApp : Boolean;

      LocalProtectionRec,
      ProtectionRec : TProtectionRec;
      SuscriptionRec : TSuscriptionRec;

      DefaultModules,                           // Modulos principales. Contable=00,01,10 (gdm00.bpl, etc..)
      OptionalModules,                          // Modulos opcionales
      Dictionaries : String;                    // Diccionarios. Contable=00,10 (dm00 Y dm10)

      ShowQueryWithEditor,                      // Cuando se muestra un mantenimiento se debe incluir la rejilla de consulta
      AllowMultipleInstances,
      // ReportEditor,
      CantDeleteRecords : Boolean;              // El usuario no puede suprimir registros (de cualquier tipo)
      AnchuraVentana,
      AlturaVentana,                            // Tamaño inicial de la ventana principal (fijado en el fichero de configuración gd_Aplicacion.ini)

      FMonitorDPI : Integer;
      FuenteAnotaciones : String = 'Segoe UI';  // Anotaciones
      TamañoFuenteAnotaciones : SmallInt = 10;

      WebSoporte,
      ForoSoporte : String;
      NroRegistroAplicacion : Integer = 0;      // Uso interno
      ComprobarActualizaciones : Boolean;       // Si debe comprobarse si existen nuevas versiones en la Web
      VersionInfo : TVersionInfo;               // La versión actual de la aplicación
      ApplicationDpiAware : Boolean;            // Indica si el sistema soporta HighDPI
      ComparableAppVersion : String;            // Una cadena comparable de la forma MMmmRR(BB)
      PuertoWinsock : Integer = 16000;
      PuertoLocal : Integer = 16000;

      ApplicationParams,
      ApplicationServerName,
      ApplicationRemotePath,
      ApplicationDataPath,
      ApplicationImportsPath,
      ApplicationExportsPath : String;           // Gd.exe F:\Gestwin
                                                 // Gd.exe -R Gestwin@192.168.0.5

      FixedRemotePath : Boolean;                 // Indica que debe usarse el path almacenado en ApplicationDataPath en la conexión remota

      ClientName : String;

      Restarting,
      BetaVersion,
      DeveloperVersion,
      VirtualUIApp,
      TabletApp,
      WebApp : Boolean;

      DataAccessMode : TDataAccesMode;
      DataAccessTransport : TDataAccessTransport;

      TemporalDataInMemory,
      TemporalDataRemote : Boolean;

      ServerApplication : Boolean = False;          // Indica que la aplicación es un servidor sin interacción del usuario (posiblemente un servicio)
      ServerStarted : Boolean = False;              // Si se ha iniciado el servidor

      TouchApplication : Boolean = False;           // Indica que la aplicación es táctil. La composición de la ventana principal difiere considerablemente de la estándar y utiliza AppFrames como librería principal.

      RPCAccessPort : LongWord;
      MaxPacketSize : Integer = 6000;               // El número máximo de registros por paquete en las transferencias de datos
      ServerWindowHandle : HWND;
      TCPIPAccessPort : LongWord;
      ServerSessionDataModuleID : Integer = -1;     // El identificador (índice en un array) de la TSessionDataModule en el servidor. Cada aplicación cliente solo puede iniciar una sesión remota de trabajo.

      UnProtectedApp,
      UpgradeAvailable : Boolean;                   // Indica que hay una versión nueva disponible en el servidor de distribución

      DatabaseUpdateRequested : Boolean  = False;   // Indica que se ha solicitado la reestructuración de la base de datos
      ApplicationInitialized : Boolean = False;
      InitializationError : Boolean = False;
      ReleasingApplication : Boolean = False;
      ApplicationReleased  : Boolean = False;
      RunningProcess : Boolean = False;
      PreparingReport : Boolean = False;            // Hay un informe en preparación
      ServerLocked : Boolean = False;

      FuenteDefecto : String = 'Segoe UI';
      TamañoFuenteDefecto : SmallInt = 10;

      IsDesignTime : Boolean = False;

      ApplicationPath : String = '';
      ApplicationName : String = '';
      ApplicationDataDirectory  : String = '';

      TemporalDataPath : String = '';
      WindowsDirectory  : String = '';

      AppShortName : String = '';                // Contable, Comercial, etc..

      DontReadCommandLineOptions : Boolean = False;

      LowestDateTime,
      HighestDateTime : TDateTime;

       // Datos de Empresa y usuario

      CodigoEmpresaActual : String;
      CodigoUsuarioActual : String;
      CodigoClienteActual : String;

      UsuarioMaestro : Boolean = False;
      SuperUsuario : Boolean = False;

const CR = #$D#$A;
      HtmlCR = ''#13'';

resourceString
      RsRegistroInexistente = '< Registro inexistente >';
      RsRegistroBloqueado = 'Registro bloqueado por otro usuario o proceso.';
      RsProcesoInterrumpido = 'Se ha interrumpido el proceso.'#13'Debido al uso de transacciones no deberían haber datos inconsistentes.'#13'Repítalo cuando lo considere oportuno.';
      RsErrorCopiaRegistro = 'Se ha producido un error durante la copia del registro.';

      RsgMsg118  = 'Hay un proceso de selección de registros en curso.';
      RsgMsg119  = 'Espere a que finalice (o cancélelo) y reintente la operación.';
      

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}

procedure ShowException( E : Exception; Component : TComponent = nil );

procedure ShowHintMsg( const MsgStr           : String;
                        const DescStr          : String = '';
                              Control          : TWinControl = nil;
                              NotificationType : TNotificationType = ntExceptionError );

function ShowNotification( NotificationType  : TNotificationType;
                           Header            : String;
                           Description       : String = '';
                           SystemMessage     : String = '' ) : TModalResult;

procedure PostNotification( NotificationType  : TNotificationType;
                            Header            : String;
                            Description       : String );

function PrgExit ( RequestForExit : Boolean;
                   Force          : Boolean = False;
                   SilentMode     : Boolean = False  ) : Boolean;

procedure UpdateDatabase;

procedure CloseAllDataModules( IncludingPersistentOnes : Boolean = False );
procedure CloseDataModules( DataModules : array of TDataModule );

function GetComponentId( Component : TComponent ) : TGuid;

procedure CreateDataModule( DataModuleClass : TDataModuleClass; var Reference; AOwner : TForm = nil );

function AddProcedure( ItemType : TProcItemType; ID : Integer; Proc : TProcedure = nil; Priorize : Boolean = False ) : TProcedureItem; overload;
function AddProcedure( ItemType : TProcItemType; ID : Integer; InitProc, Proc, FinishProc : TProcedure ) : TProcedureItem; overload;
function ExecuteProcedures( AnItemType : TProcItemType; IDArray : array of Integer ) : TIntegerArray;
procedure ExecComponentProcedures( ID : Integer; ItemType : TProcItemType );

function ProcedureList : TProcedureList;

function ExceptionMessage( E : Exception; AbortMessage : Boolean = False ) : String;
procedure ProcessLog( Caption, Msg : String );
procedure Initialize;

function GetFileVersion(const AFileName: String ): TVersionInfo;
function GetComparableVersion( AMajorVersion, AMinorVersion, ARelease : SmallInt; ABuild : SmallInt = -1 ) : String;
function GetAppComparableVersion( IncludeBuild : Boolean = True ) : String;
procedure GetComputerAndUserName( out ComputerName : String; out UserName : String );

function GetIniFileName : String;
function GetWindowsUsername : String;
procedure ReadCommandLineOptions;
procedure ReadIniFile;
procedure UpdateIniFile;

function GetMFClassName : String;
procedure CheckInstance( MainForm : TForm; AllowMultipleInstances : Boolean = True );
function MakeActivationKey( ID : Int64 ) : Int64;
function GetDiskID( Disk : String ) : Int64;
procedure WriteProtectionData( ProtecFileType : TProtecFileType; SerialNumber : Int64 = 0 );
function GetProtectionData( ProtecFileType : TProtecFileType; SerialNumber : Int64 = 0; PreserveData : Boolean = False ) : Boolean;
function GetProtectionKey( AddCaducity : Boolean = False ) : Int64;
procedure CheckProtection( Notify : Boolean; ClientLocation : Boolean );
function IsOptionalModuleActive( Value : Word; Module : TModuloOpcional ) : Boolean;

// procedure CompruebaSuscripcion( EstadoSuscripcionBox : TgBox = nil );
// procedure MuestraEstadoSuscripcion( EstadoSuscripcionBox : TgBox = nil );
// function  GetSuscriptionData : Boolean;
// procedure UpdateSuscriptionData( LastState : Integer );

function IsCurrentSessionRemoteable : Boolean;
procedure SetMinMaxAnimation( Value : Boolean = False );

function GetUserReportsRootPath : String;
function GetMainInfoFileName : String;
function GetAppVersionString( FileName : String = '' ) : String;
function GetAppInfoString( FileName : String = '' ) : String;
function ExistsDictionary( DictionaryNumber : SmallInt ) : Boolean;
procedure LogMessage( Msg : String );

{$IFNDEF SERVERAPP}
procedure SetAppScale( Value : SmallInt );  // En porcentaje
function GetLastAppScaleDPI : SmallInt;
function AppScaleDPI : Integer;
function SystemScaleDPI : Integer;
function SystemScaled : Boolean;
function ApplicationScaled : Boolean;
function ScaledToCurrent( Valor : Double ) : Integer;
function GetSystemScaledMenuFontSize : SmallInt;
procedure UpdateDPIAwarenessInfo;
{$ENDIF}

function ApplicationManager : TApplicationManager;

function WTSDisconnectSession( hServer : THandle; SessionID : DWORD; bWait : BOOL ): Boolean; stdcall;

const  WTS_CURRENT_SERVER_HANDLE : THandle = 0;

implementation

{$R *.dfm}

uses  WinAPI.ShellAPI,
      WinAPI.ShlObj,
      WinAPI.TlHelp32,
      System.Variants,
      System.TypInfo,

      nxdbBase,
      nxllBDE,
      nxllException,

      Math,

      {$IFNDEF SERVERAPP}
      cxGeometry,
      cxEdit,
      dxDPIAwareUtils,
      {$ENDIF}

      {$IFDEF VIRTUALUI}
      VirtualUI_SDK,
      {$ENDIF}

      Registry,
      IniFiles,
      Files,

      DataManager,

      SessionIntf;

resourceString
      RsgMsg1  = 'INICIO DE SESION';
      RsgMsg2  = 'FIN DE SESION';
      RsgMsg3  = 'Está a punto de abandonar la aplicación';
      RsgMsg4  = 'Recuerde : Haga [Color=Maroon][B]COPIAS DE SEGURIDAD[/B][/Color] de sus datos. '#13'Solo así podrá recuperar la información (y el trabajo realizado) en caso de fallo del equipo.';
      RsgMsg5  = 'Se ha producido una excepción.';

      RsgMsg102  = 'Falta un parámetro en la linea de comandos.';

      // RsgMsg103  = 'Debe especificar el directorio de trabajo remoto.'#13'Por ejemplo : Z:\Gd.exe -R Gestwin@192.168.0.1 F:\Administracion\Gestwin';
      RsgMsg171  = 'Error en la lectura del fichero de configuración [B]gd_%s.ini[/B].';
      RsgMsg172  = 'Error en la escritura del fichero de configuración [B]gd_%s.ini[/B].';
      RsgMsg415  = 'No se han podido %s las opciones y parámetros iniciales de la aplicación.[Color=Maroon]Notifique a su proveedor este extremo.[/Color]'#13''#13'Fichero : %s';
      RsgMsg440  = 'No se ha podido obtener un número de serie válido. Error de Windows nº %d.';
      RsgMsg344  = 'No he conseguido inicializar el sistema de protección (Error nº %d).';

var  FProcedureList : TProcedureList = nil;    // Lista de procedimientos diferidos
     FApplicationManager : TApplicationManager = nil;

     FLastAppScaleDPI,
     FAppScaleDPI : Integer;                   // En puntos por pulgada
     FScaledByCommandLine : Boolean = False;

function WTSDisconnectSession; external wtsapi32 name 'WTSDisconnectSession' delayed;

function ApplicationManager : TApplicationManager;
begin
     If   not Assigned( FApplicationManager )
     then FApplicationManager := TApplicationManager.Create( nil );
     Result := FApplicationManager;
end;


function GetComponentId( Component : TComponent ) : TGuid;
begin
     If   Component.ClassInfo=nil
     then Result := TGuid.Empty
     else Result := PTypeInfo( Component.ClassInfo )^.TypeData.GUID;
end;

procedure CreateDataModule(       DataModuleClass : TDataModuleClass;
                            var   Reference;
                                  AOwner          : TForm = nil );

var  Instance : TComponent;

begin
     If   ReleasingApplication
     then begin
          Application.Terminate;   // Suele olvidarse
          Abort;
          end
     else If   not Assigned( TDataModule( Reference ) )
          then begin
               Instance := TComponent( DataModuleClass.NewInstance );
               TComponent( Reference ) := Instance;
               try

                  // Con esta opción puedo vincular un módulo a un Form de forma
                  // que su ciclo de vida termine cuando se destruya el mismo

                  If   AOwner=nil
                  then AOwner := Application.MainForm;

                  Instance.Create( AOwner );

                  // var Id := GetComponentId( Instance );

               except on E : Exception do
                   begin
                   TDataModule( Reference ) := nil;
                   If   Assigned( Instance )
                   then With Instance do
                          If   not ( csDestroying in ComponentState )
                          then Free;
                   If   not DatabaseUpdateRequested and
                        not ( E is EAbort )
                   then ShowException( E, nil );
                   Abort;
                   end;
                 end;

               end;

end;

function ProcedureList : TProcedureList;
begin
     If   not Assigned( FProcedureList )
     then FProcedureList := TProcedureList.Create;
     Result := FProcedureList;
end;

function AddProcedure( ItemType : TProcItemType;
                       ID       : Integer;
                       Proc     : TProcedure = nil;
                       Priorize : Boolean = False ) : TProcedureItem;

begin
     Result := nil;
     If   not IsDesignTime
     then With ProcedureList do
            begin
            Result := TProcedureItem.Create( ItemType, ID, Proc );
            If   Priorize
            then Insert( 0, Result )
            else Add( Result );
            end;
end;

function AddProcedure( ItemType   : TProcItemType;
                       ID         : Integer;
                       InitProc,
                       Proc,
                       FinishProc : TProcedure ) : TProcedureItem;

begin
     Result := TProcedureItem.Create( ItemType, ID, InitProc, Proc, FinishProc );
     ProcedureList.Add( Result );
end;

function ExecuteProcedures( AnItemType : TProcItemType;
                            IDArray    : array of Integer ) : TIntegerArray;

var  I,
     TargetIndex : Integer;
     ProcItem  : TProcedureItem;

{
function IsInIDArray( anID : Integer ) : Boolean;

var  I  : Integer;

begin
     Result := False;
     For I := 0 to High( IDArray ) do
       If   IDArray[ I ]=anID
       then begin
            Result := True;
            Break;
            end;
end;
}

begin
     TargetIndex := 0;
     With ProcedureList do
       If   High( IDArray )>=0
       then begin
            For I := 0 to High( IDArray ) do
              begin
              ProcItem := FindByTypeAndID( AnItemType, IDArray[ I ] );
              If   Assigned( ProcItem )
              then begin
                   try
                     ProcItem.DoProc;
                   except on E : Exception do If   not ( E is EAbort )
                                              then raise;
                     end;
                   SetLength( Result, TargetIndex + 1 );
                   Result[ TargetIndex ] := IDArray[ I ];
                   Inc( TargetIndex );
                   end;
              end;
            end
       else For I := 0 to Count - 1 do
              begin
              ProcItem := TProcedureItem( Items[ I ] );
              If   Assigned( ProcItem )
              then With ProcItem do
                     If   ItemType=AnItemType
                     then begin
                          try
                            DoProc;
                          except on E : Exception do If   not ( E is EAbort )
                                                     then raise;
                            end;
                          SetLength( Result, TargetIndex + 1 );
                          Result[ TargetIndex ] := Integer( Items[ I ] );
                          Inc( TargetIndex );
                          end;
              end;
end;

procedure ExecComponentProcedures( ID       : Integer;
                                   ItemType : TProcItemType );

var I : Integer;
    ProcItem : TProcedureItem;

begin
     If   ID<>0
     then With ProcedureList do
            For I := 0 to Count - 1 do
              begin
              ProcItem := TProcedureItem( Items[ I ] );
              If   Assigned( ProcItem )
              then If   ( ProcItem.ItemType=ItemType ) and ( ProcItem.ID=ID )
                   then If   Assigned( ProcItem )
                        then ProcItem.DoProc;
              end;
end;

// TProcedureItem

constructor TProcedureItem.Create( ItemType  : TProcItemType;
                                   ID        : Integer;
                                   Proc      : TProcedure );
begin
     inherited Create;
     FItemType := ItemType;
     FID := ID;
     FProc := Proc;
end;

constructor TProcedureItem.Create( ItemType   : TProcItemType;
                                   ID         : Integer;
                                   InitProc,
                                   Proc,
                                   FinishProc : TProcedure );
begin
     Create( ItemType, ID, Proc );
     FInitProc := InitProc;
     FFinishProc := FinishProc;
end;

procedure TProcedureItem.DoInitProc;
begin
     If   Assigned( FInitProc )
     then FInitProc;
            end;

procedure TProcedureItem.DoProc;
begin
     If   Assigned( FProc )
     then FProc;
end;

procedure TProcedureItem.DoFinishProc;
begin
     If   Assigned( FFinishProc )
     then FFinishProc;
end;

// TProcedureList

procedure TProcedureList.Clear;

var  I : Integer;

begin
     For I := 0 to Count - 1 do
       TProcedureItem( Items[ I ] ).Free;
     inherited;
end;

function TProcedureList.FindByTypeAndID( AnItemType  : TProcItemType;
                                         anID        : Integer       ) : TProcedureItem;

var  I : Integer;
     ProcItem : TProcedureItem;

begin
     Result := nil;
     For I := 0 to Count - 1 do
       begin
       ProcItem := TProcedureItem( Items[ I ] );
       If   Assigned( ProcItem )
       then If   ( ProcItem.ItemType=AnItemType ) and ( ProcItem.ID=anID )
            then begin
                 Result := ProcItem;
                 Break;
                 end;
       end;
end;

//..

{$IFNDEF SERVERAPP}

procedure TApplicationManager.DoOnException( Sender : TObject;
                                             E      : Exception );

var  ErrorMessage,
     ErrorDescription : String;
     Control  : TWinControl;

begin
     try

        If   not ReleasingApplication and
             not IsDesignTime
        then If   E is EcxEditValidationError
             then begin
                  Control := nil;
                  SplitMessage( E.Message, ErrorMessage, ErrorDescription );
                  // En algunos casos se puede pasar un control no válido (ya no existe o no es del tipo adecuado)
                  try
                    If   Sender is TWinControl
                    then begin
                         Control := Sender as TWinControl;
                         If   not Control.HandleAllocated  or
                              ( WinAPI.Windows.GetParent( Control.Handle )=NULL )
                         then Abort;
                         end
                    else Abort;
                  except
                    end;

                  If   Assigned( Application.MainForm ) and ( Application.MainForm.FormStyle=fsMDIForm )
                  then ShowHintMsg( ErrorMessage, ErrorDescription, Control )
                  else ShowNotification( ntExceptionError, ErrorMessage, ErrorDescription );

                  end
             else If   E is EnxBaseException
                  then begin
                       If   Pos( '[EAbort]', E.Message )=0      // Las excepciones generados en el servidor son siempre convertidas en EnxBaseException por NexusDB, incluso un simple Abort
                       then ShowDatabaseError( nil, e as EnxBaseException );
                       end
                  else {$IFDEF DEBUGAPP }
                       ShowNotification( ntExceptionError, RsgMsg5, E.Message );
                       {$ELSE}
                       ;  // No muestro las excepciones no capturadas en modo release, porque solo sirven para dar la impresión de que no algo no funciona (que es cierto, pero no hace falta alterar al personal)
                       {$ENDIF}

     except     // Una Excepción no capturada aquí provoca directamente una excepción del sistema (Windows.Exception)
       end;

end;

{$ENDIF}

procedure ProcessLog( Caption, Msg : String );
begin
     If   Assigned( OnProcessLog)
     then OnProcessLog( Caption, Msg );
end;

procedure ShowException( E : Exception; Component : TComponent = nil );
begin
     If   Assigned( OnShowException )
     then OnShowException( E, Component )
     else SysUtils.ShowException( E, {ExceptAddr} nil );
end;

procedure ShowHintMsg( const MsgStr           : String;
                       const DescStr          : String = '';
                             Control          : TWinControl = nil;
                             NotificationType : TNotificationType = ntExceptionError );
begin
     If   Assigned( OnShowHintMessage )
     then OnShowHintMessage( MsgStr, DescStr, Control, NotificationType );
end;

function ExceptionMessage( E            : Exception;
                           AbortMessage : Boolean = False ) : String;
begin
     Result := '';
     If   E is EAbort
     then begin
          If   AbortMessage
          then Result := 'Proceso interrumpido';
          end
     else If   E is EnxDatabaseError
          then With E as EnxDatabaseError do
                 case ErrorCode of
                   DBIERR_LOCKED :
                     Result := RsRegistroBloqueado;
                   else
                     Result := E.Message;
                 end
          else Result := E.Message;
end;

function ShowNotification( NotificationType  : TNotificationType;
                           Header            : String;
                           Description       : String = '';
                           SystemMessage     : String = '' ) : TModalResult;
begin
     If   Assigned( OnShowNotification )
     then Result := OnShowNotification( NotificationType, Header, Description, SystemMessage )
     else Result := mrCancel;
end;

procedure PostNotification( NotificationType  : TNotificationType;
                            Header            : String;
                            Description       : String );

var  HeaderAtom,
     DescriptionAtom : Atom;

begin
     HeaderAtom := AddAtom( PWideChar( Header ) );
     If   Description=''
     then DescriptionAtom := 0
     else DescriptionAtom := AddAtom( PWideChar( Description ) );
     If   not PostMessage( Application.MainForm.Handle, CM_SERVERNOTIFICATION, Ord( NotificationType ), MAKELPARAM( HeaderAtom, DescriptionAtom ) )
     then begin  // No se ha podido postear el mensaje
          DeleteAtom( HeaderAtom );
          DeleteAtom( DescriptionAtom );
          end;

     // El procedimiento que reciba el mensaje debe liberar la memoria de los atoms usando DeleteAtom
end;

procedure UpdateDatabase;
begin
     If   Assigned( OnUpdateDatabase )
     then OnUpdateDatabase;
end;

function PrgExit ( RequestForExit : Boolean;
                   Force          : Boolean = False;
                   SilentMode     : Boolean = False  ) : Boolean;
begin
     If   Assigned( OnPrgExitNotification )
     then Result := OnPrgExitNotification( RequestForExit, Force, SilentMode )
     else begin
          Application.Terminate;
          Result := True;
          end;
end;

function InternalPrgExit( RequestForExit : Boolean;
                          Force          : Boolean = False;
                          SilentMode     : Boolean = False  ) : Boolean;
begin
     If   not ServerStarted
     then ShowNotification( ntInformation, RsgMsg3, RsgMsg4 );
     LogMessage( RsgMsg2 );
     Application.Terminate;
     Result := True;
end;

procedure CloseAllDataModules( IncludingPersistentOnes : Boolean = False );

var  I : SmallInt;

begin
     If   Assigned( Application.MainForm )
     then With Application.MainForm do
            If   not ( csDestroying in ComponentState )
            then begin
                 // Application.ProcessMessages;
                 For I := ComponentCount - 1 downto 0 do
                   If   Components[ I ] is TDataModule
                   then With TDataModule( Components[ I ] ) do
                          If   IncludingPersistentOnes or ( Tag<>0 )
                          then Free;
                 end;
end;

procedure CloseDataModules( DataModules : array of TDataModule );

var   I : SmallInt;

begin
     For I := 0 to High( DataModules ) do
       If   Assigned( DataModules[ I ] )
       then DataModules[ I ].Free;
end;

{$IFNDEF SERVERAPP}

procedure SetAppScaleDPI( Value : SmallInt );
begin
     FLastAppScaleDPI := FAppScaleDPI;
     FAppScaleDPI := Value;
end;

procedure SetAppScale( Value : SmallInt );
begin

     // Si el sistema está escalado no se puede utilizar escala de aplicación en versiones de Windows sin HighDPI

     If   not ( SystemScaled and not ApplicationDpiAware )
     then If   ( Value=100 ) or not ( Value in [ 80..150 ] )
          then SetAppScaleDPI( 96 )
          else SetAppScaleDPI( ( 96 * Value ) div 100 );
end;

function GetLastAppScaleDPI : SmallInt;
begin
     Result := FLastAppScaleDPI;
end;

function AppScaleDPI : Integer;
begin
     Result := FAppScaleDPI;
end;

function SystemScaleDPI : Integer;
begin
     If   Assigned( Application.MainForm )
     then Result := dxGetMonitorDPI( Application.MainForm.Monitor )
     else Result := dxGetSystemDPI;
end;

function SystemScaled : Boolean;
begin
     Result := SystemScaleDPI<>USER_DEFAULT_SCREEN_DPI;
end;

function ApplicationScaled : Boolean;
begin
     Result := FAppScaleDPI<>USER_DEFAULT_SCREEN_DPI;
end;

function ScaledToCurrent( Valor : Double ) : Integer;
begin
     // Solo le afecta la escala del sistema
     Result := Trunc( ( Valor * SystemScaleDPI ) / USER_DEFAULT_SCREEN_DPI );
end;

function GetSystemScaledMenuFontSize : SmallInt;
begin
    Result := TamañoFuenteDefecto;
    If   SystemScaled and not ApplicationDpiAware
    then Result := MulDiv( Result, SystemScaleDPI, USER_DEFAULT_SCREEN_DPI ) - 1;
end;

{

function AjustaAEscala( Valor : Integer ) : Integer;
begin
     Result := Trunc( Valor * ( 1 + ( ( AppScaleDPI - 90 ) / 100 ) ) );
end;

type  TOSVersionInfoEx = packed record
        dwOSVersionInfoSize: DWORD;
        dwMajorVersion: DWORD;
        dwMinorVersion: DWORD;
        dwBuildNumber: DWORD;
        dwPlatformId: DWORD;
        szCSDVersion: array[0..127] of Char;
        wServicePackMajor: WORD;
        wServicePackMinor: WORD;
        wSuiteMask: WORD;
        wProductType: Byte;
        wReserved: Byte;
        end;
}

procedure UpdateDPIAwarenessInfo;
begin
     ApplicationDpiAware := dxGetProcessDpiAwareness<>pdaUnaware;
end;

{$ENDIF}


function GetUserReportsRootPath : String;
begin
     Result := ApplicationPath;
end;

function GetIniFileName : String;
begin
     Result := ApplicationPath + 'gd_' + AppShortName + '.ini';
end;

function GetWindowsUsername : String;

const UNLEN = 256; // Maximum user name length

var  UserName : string;
     UserNameLen : Dword;
begin
     UserNameLen := UNLEN;
     SetLength(UserName, UserNameLen) ;
     If   GetUserName( PChar( UserName ), UserNameLen )
     then Result := Copy( UserName, 1, UserNameLen - 1 )
     else Result := '';
end;


function GetUserSidFromPID( ProcessId : DWORD ) : String;

type PTOKEN_USER = ^TOKEN_USER;
     _TOKEN_USER = record
       User: TSidAndAttributes;
       end;
     TOKEN_USER = _TOKEN_USER;

var  hToken: THandle;
     cbBuf: Cardinal;
     ptiUser : PTOKEN_USER;
     ProcessHandle: THandle;
     bSuccess: Boolean;
     StringSid : LPWSTR;

begin
     Result := '';
     ProcessHandle := OpenProcess( PROCESS_QUERY_INFORMATION, False, ProcessId );
     If   ProcessHandle<>0
     then begin

          If   OpenProcessToken( ProcessHandle, TOKEN_QUERY, hToken )
          then begin
               bSuccess := GetTokenInformation(hToken, TokenUser, nil, 0, cbBuf);
               ptiUser  := nil;
               While ( not bSuccess ) and ( GetLastError=ERROR_INSUFFICIENT_BUFFER ) do
                 begin
                 ReallocMem( ptiUser, cbBuf );
                 bSuccess := GetTokenInformation( hToken, TokenUser, ptiUser, cbBuf, cbBuf );
                 end;
               CloseHandle( hToken );

               If   not bSuccess
               then Exit;

               ConvertSidToStringSid( ptiUser.User.Sid, StringSid );
               Result := PChar( StringSid );

               FreeMem( ptiUser );

               end;

          CloseHandle(ProcessHandle);
          end;
end;

function ProcessExists( ExeFileName : String ) : Boolean;

var  ContinueLoop : BOOL;
     FSnapshotHandle : THandle;
     FProcessEntry32 : TProcessEntry32;
     CurrentUserSid,
     UserSid : String;

begin
     CurrentUserSid := GetUserSidFromPID( GetCurrentProcessId );
     FSnapshotHandle := CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS, 0 );
     FProcessEntry32.dwSize := SizeOf( FProcessEntry32 );
     ContinueLoop := Process32First( FSnapshotHandle, FProcessEntry32 );
     try
       Result := False;
       While Integer( ContinueLoop )<>0 do
         begin
         If   ( ( UpperCase( SysUtils.ExtractFileName( FProcessEntry32.szExeFile ) )=UpperCase( ExeFileName ) ) or
              ( UpperCase( FProcessEntry32.szExeFile )=UpperCase( ExeFileName ) ) )
         then begin
              UserSid := GetUserSidFromPID( FProcessEntry32.th32ProcessID );
              Result := UserSid=CurrentUserSid;
              Exit;
              end;
         ContinueLoop := Process32Next( FSnapshotHandle, FProcessEntry32 );
         end;
     finally
       CloseHandle( FSnapshotHandle );
       end;
end;

 // Incluido el uso de parámetros
 //      Por ejemplo : Gd.exe Contable -mxc gestwin@servidor2
 //      Todos los parámetros (una letra por cada uno) van juntos y detrás del guión.

procedure ReadCommandLineOptions;
begin

     DataAccessMode := dmLocal;
     DataAccessTransport := dtNamedPipe;
     ApplicationDataPath := ApplicationPath;
     FixedRemotePath := False;
     ClientName := GetEnvironmentVariable( 'CLIENTNAME' );         // En modo local el valor está vacío
     {$IFDEF VIRTUALUI}
     VirtualUIApp := VirtualUI.Active;
     WebApp := VirtualUIApp and ( VirtualUI.BrowserInfo.Location<>'' );
     {$ELSE}
     VirtualUIApp := IsCurrentSessionRemoteable;
     WebApp := VirtualUIApp and ( Copy( ClientName, 1, 1 )='.' );  // Ts-Plus crea un ClientName con un punto delante cuando se accede a través del navegador
     {$ENDIF}
     If   ParamCount>1
     then begin
          ApplicationParams := ParamStr( 2 );
          If   Copy( ApplicationParams, 1, 1 )='-'  // Es una lista de parámetros
          then begin

               ApplicationParams := UpperCase( Copy( ApplicationParams, 2, 10 ) );

               TemporalDataInMemory := Pos( 'M', ApplicationParams )<>0;
               TemporalDataRemote := Pos( 'D', ApplicationParams )<>0;
               Restarting := Pos( 'E', ApplicationParams )<>0;
               BetaVersion := Pos( 'B', ApplicationParams )<>0;
               DeveloperVersion := Pos( 'P', ApplicationParams )<>0;
               TabletApp := Pos( 'T', ApplicationParams )<>0;
               WebApp := WebApp or ( Pos( 'I', ApplicationParams )<>0 );
               VirtualUIApp := VirtualUIApp or ( Pos( 'V', ApplicationParams )<>0 ) or WebApp;

               If   Pos( 'R', ApplicationParams )<>0
               then begin
                    DataAccessMode := dmRemote;
                    DataAccessTransport := dtWinsock;
                    end;

               If   Pos( 'W', ApplicationParams )<>0
               then DataAccessTransport := dtWinsock;
                    
               If   Pos( 'N', ApplicationParams )<>0   // Se puede utilizar NamedPipe de forma remota dentro de la red
               then DataAccessTransport := dtNamedPipe;

               {$IFNDEF SERVERAPP}
               var Sp := Pos( 'S', ApplicationParams );
               If   Sp<>0
               then begin
                    var ScaleLevel := ( StrToIntDef( Copy( ApplicationParams, Sp + 1, 1 ), 0 ) * 5 ) + 100;
                    SetAppScale( ScaleLevel );
                    FScaledByCommandLine := True;
                    end;
               {$ENDIF}

               {
               Sp := Pos( 'U', ApplicationParams );
               If   Sp<>0
               then CodigoUsuarioActual := Copy( ApplicationParams, Sp + 1, 2 );
               }

               If   DataAccessMode=dmRemote
               then begin
                    ApplicationServerName := ParamStr( 3 );  // Si existen
                    ApplicationRemotePath := ParamStr( 4 );
                    end;

               If   ApplicationRemotePath<>''
               then begin
                    ApplicationDataPath := ApplicationRemotePath;
                    FixedRemotePath := True;
                    end;

               end;


          end;

end;

function GetMFClassName : String;
begin
     Result := MainFormClassName + '_' + AppShortName;
end;


procedure CheckInstance( MainForm               : TForm;
                         AllowMultipleInstances : Boolean = True );

var  MainWndHandle  : HWnd;

begin
     If   Assigned( MainForm )
     then begin
          MainWndHandle := FindWindowEx( 0, MainForm.Handle, PChar( GetMFClassName ), nil );
          If   MainWndHandle<>0
          then If   not AllowMultipleInstances
               then begin
                    ShowWindow( MainWndHandle, sw_restore );
                    Application.Terminate;
                    InitializationError := True;
                    Abort;
                    end;
          end;
end;

procedure ReadIniFile;

var  IniFile : TMemIniFile;
     OptionsList : TStringList;

begin
     If   AppShortName<>''
     then try

            OptionsList := TStringList.Create;

            IniFile := TMemIniFile.Create( GetIniFileName );

            try

              IniFile.ReadSectionValues( 'Aplicacion', OptionsList );

              ProgramNumber := StrToInt( OptionsList.Values[ 'NroAplicacion' ] );
              DefaultModules := OptionsList.Values[ 'Modulos' ];
              Dictionaries := OptionsList.Values[ 'Diccionarios' ];
              OptionalModules := OptionsList.Values[ 'Opciones' ];
              ProgramVersion := StrToInt( OptionsList.Values[ 'Version' ] );
              ProgramRelease := StrToInt( OptionsList.Values[ 'Entrega' ] );
              AllowMultipleInstances := UpperCase( OptionsList.Values[ 'MultiplesInstancias' ] )='SI';
              // ReportEditor := UpperCase( OptionsList.Values[ 'EditorInformes' ] )='SI';
              AnchuraVentana := StrToIntDef( OptionsList.Values[ 'AnchuraVentana' ], 0 );
              AlturaVentana := StrToIntDef( OptionsList.Values[ 'AlturaVentana' ], 0 );

              {$IFNDEF SERVERAPP}
              If   not FScaledByCommandLine
              then begin
                   var ValorEscala := OptionsList.Values[ 'Escala' ];
                   var Pp :=  Pos( '%', ValorEscala );   // Expresado en porcentaje o en DPIs
                   If   Pp<>0
                   then SetAppScale( CheckIntRange( StrToIntDef( Copy( ValorEscala, 1, Pp - 1  ), 100 ), 100, 145, { ResetValue } 100   ) )
                   else SetAppScaleDPI( CheckIntRange( StrToIntDef( ValorEscala, USER_DEFAULT_SCREEN_DPI ), 85, 180, { ResetValue } USER_DEFAULT_SCREEN_DPI ) );
                   end;
              {$ENDIF}
              WebSoporte := GetStrDef( OptionsList.Values[ 'WebSoporte' ], RsWebPage );
              ForoSoporte := GetStrDef( OptionsList.Values[ 'ForoSoporte' ], RsForumPage );
              ComprobarActualizaciones := UpperCase( OptionsList.Values[ 'ComprobarActualizaciones' ] )<>'NO';  // Por defecto es SI
              NroRegistroAplicacion := StrToIntDef( OptionsList.Values[ 'NroRegistroAplicacion' ], 0 );  // Uso interno

              PuertoWinsock := StrToIntDef( OptionsList.Values[ 'PuertoWinsock' ], 16000 );
              PuertoLocal:= StrToIntDef( OptionsList.Values[ 'PuertoLocal' ], 16000 );

              // Esto solo sirve para indicar la intención de que se desea utilizar el servidor de 64 bits. En realidad siempre se se comprobará
              // si la licencia es de 64bits cuando el usuario se actualice. En el caso de aplicaciones sin protección (de casa) sí que resulta útil para
              // obligar a la aplicación a utilizar la versión de 64bits.

              Sp64BitsServer := UpperCase( OptionsList.Values[ 'Servidor64bits' ] )='SI';

            finally
              OptionsList.Free;
              IniFile.Free;
              end;

          except
            ShowNotification( ntStop, Format( RsgMsg171, [ AppShortName ] ), Format( RsgMsg415, [ 'leer', GetIniFileName ] )  );
            Abort;
            end;
end;

procedure UpdateIniFile;

const SectionName = 'Aplicacion';

var   IniFile : TMemIniFile;

function StrBoolean( Valor : Boolean ) : String;
begin
     If   Valor
     then Result := 'Si'
     else Result := 'No';
end;

begin
     If   AppShortName<>''
     then try
            IniFile := TMemIniFile.Create( GetIniFileName );
            With IniFile do
              try

                WriteInteger( SectionName, 'NroAplicacion', ProgramNumber );
                WriteString( SectionName, 'Modulos', DefaultModules );
                WriteString( SectionName, 'Diccionarios', Dictionaries );
                WriteString( SectionName, 'Opciones', OptionalModules );
                WriteInteger( SectionName, 'Version', ProgramVersion );
                WriteInteger( SectionName, 'Entrega', ProgramRelease );
                WriteString( SectionName, 'MultiplesInstancias', StrBoolean( AllowMultipleInstances ) );
                // WriteString( SectionName, 'EditorInformes', StrBoolean( ReportEditor ) );
                If   AnchuraVentana<>0
                then WriteInteger( SectionName, 'AnchuraVentana', AnchuraVentana );
                If   AlturaVentana<>0
                then WriteInteger( SectionName, 'AlturaVentana', AlturaVentana );
                {$IFNDEF SERVERAPP}
                If   AppScaleDPI<>USER_DEFAULT_SCREEN_DPI
                then WriteInteger( SectionName, 'Escala', AppScaleDPI );
                {$ENDIF}
                If   WebSoporte<>''
                then WriteString( SectionName, 'WebSoporte', RsWebPage );
                If   ForoSoporte<>''
                then WriteString( SectionName, 'ForoSoporte', RsForumPage );
                WriteString( SectionName, 'ComprobarActualizaciones', StrBoolean( ComprobarActualizaciones ) );

                UpdateFile;

              finally
                Free;
                end;

          except
            ShowNotification( ntStop, Format( RsgMsg172, [ AppShortName ] ), Format( RsgMsg415, [ 'guardar', GetIniFileName ] ) );
            Abort;
            end;
end;

// File versioning

function GetFileVersion( const AFileName : String ): TVersionInfo;

var  FileName : String;
     InfoSize,
     Wnd : DWORD;
     VerBuf : Pointer;
     FI : PVSFixedFileInfo;
     VerSize : DWORD;

begin
     Result.MsValue := 0;
     Result.LsValue := 0;
     FileName := AFileName;
     UniqueString( FileName );
     InfoSize := GetFileVersionInfoSize( PChar( FileName ), Wnd );
     If   InfoSize<>0
     then begin
          GetMem( VerBuf, InfoSize );
          try
            If   GetFileVersionInfo( PChar( FileName ), Wnd, InfoSize, VerBuf )
            then If   VerQueryValue( VerBuf, '\', Pointer( FI ), verSize )
                 then begin
                      Result.MsValue := FI.dwFileVersionMS;
                      Result.LsValue := FI.dwFileVersionLS;
                      end;
          Finally
            FreeMem( VerBuf );
            end;
          end;

end;

function GetAppComparableVersion( IncludeBuild : Boolean = True ) : String;

var  ABuild : SmallInt;

begin
     With VersionInfo do
       begin
       If   IncludeBuild
       then ABuild := Build
       else ABuild := -1;
       Result := GetComparableVersion( MajorVersion, MinorVersion, Release, ABuild );
       end;
end;

function GetComparableVersion( AMajorVersion,
                               AMinorVersion,
                               ARelease       : SmallInt;
                               ABuild         : SmallInt = -1 ) : String;
var  VersionStr : String;

begin
     VersionStr := StrIntPadded( AMajorVersion, 2 ) + StrIntPadded( AMinorVersion, 2 ) + StrIntPadded( ARelease, 4 );
     If   ABuild<>-1
     then StrAdd( VersionStr, StrIntPadded( ABuild, 2 ) );
     Result := VersionStr;
end;

function GetVersionString( FileName      : String;
                           VersionString : TVersionString ) : String;

var  zero,
     VersionInfoSize : DWORD;
     VersionInfoPtr : Pointer;
     VersionValue : array[ 0..255 ] of Char;
     VersionValuePtr : PChar;
     vvLen : UINT;

begin
     Result := '';
     VersionInfoSize := GetFileVersionInfoSize( PChar( FileName ), zero );
     If   VersionInfoSize<>0
     then begin
          GetMem( VersionInfoPtr, VersionInfoSize );
          try

            If   Assigned( VersionInfoPtr )
            then If   getFileVersionInfo( PChar( FileName ), 0, VersionInfoSize, VersionInfoPtr )
                 then begin
                      VersionValuePtr := PChar( @VersionValue );
                      VersionValuePtr := '';
                      VvLen := 255;
                      case VersionString of
                        vsEndUSerName : VerQueryValue( VersionInfoPtr, '\\StringFileInfo\\0C0A04E4\\EndUserName', Pointer( VersionValuePtr ), vvLen );
                        vsFileVersion : VerQueryValue( VersionInfoPtr, '\\StringFileInfo\\0C0A04E4\\FileVersion', Pointer( VersionValuePtr ), vvLen );
                        end;
                      Result := VersionValuePtr;
                      end;
          finally
            FreeMem( VersionInfoPtr );
            end;
          end;
end;

procedure GetComputerAndUserName( out ComputerName : String;
                                  out UserName     : String );

const MAX_COMPUTERNAME_LENGTH = 68;

var  NameBuffer : Array[ 0..MAX_COMPUTERNAME_LENGTH ] of Char;
     NSize : DWORD;

begin
     try
       NSize := MAX_COMPUTERNAME_LENGTH;
       If   WinAPI.Windows.GetComputerNameEx( ComputerNamePhysicalNetBIOS, @NameBuffer, NSize )
       then ComputerName := NameBuffer;
       If   WinAPI.Windows.GetUserName( @NameBuffer, NSize )
       then UserName := NameBuffer;
     except
      end;
end;

function MakeActivationKey( ID : Int64 ) : Int64;

const MaxIDLen   = 10;
      Peso : array[ 1..MaxIDLen ] of Byte = ( 1, 5, 2, 2, 6, 8, 3, 7, 2, 4 );

var   I : SmallInt;
      Value : Byte;
      StrID : String;

begin
     Str( ID, StrID );
     Result := 0;
     For I := 1 to Length( StrID ) do
       begin
       Value := Ord( StrID[ I ] );
       Inc( Result, Value * Peso[ I ] );
       end;
     Result := 61332 * Result;
end;

function GetDiskID( Disk : String ) : Int64;

var  LPVolumeNameBuffer,
     LPFileSystemNameBuffer : array[ 0..255 ] of Char;
     LPMaximumComponentLength,
     LPFileSystemFlags,
     LPVolumeSerialNumber,
     Error : DWORD;

begin
     Result := 0;
     Disk := IncludeTrailingBackslash( ExtractFileDrive( Disk ) );   // Unidad : C:\ o drive UNC : \\Desarrollo\Web\
     If   GetVolumeInformation( PChar( Disk ),
                                LPVolumeNameBuffer,
                                255,
                                Pointer( @LpVolumeSerialNumber ),
                                LPMaximumComponentLength,
                                LPFileSystemFlags,
                                LPFileSystemNameBuffer,
                                255 )
     then Result := LPVolumeSerialNumber
     else begin
          Error := GetLastError;
          ShowNotification( ntStop, Format( RsgMsg440, [ Error ] ), '' );
          Abort;
          end;
end;

{  Las cuatro localizaciones de los ficheros de protección :

   pfServer         Fichero básico de protección de instalaciones servidor y local
   pfClient         Fichero de instalación cliente
   pfControlCenter  Datos del centro de control
   pfInstaller      Datos sobre la aplicación a instalar que intercambian el centro de control y el instalador

}

function GetProtectionFileName( ProtecFileType : TProtecFileType;
                                SerialNumber   : Int64 = 0 ) : String;

var  Prefix,
     PfnStr : String;

begin
     If   ProtecFileType in [ pfServer, pfClient ]
     then Prefix := 'P'
     else Prefix := 'I';

     PfnStr := Prefix + StrIntPadded( ProgramNumber, 3 ) + StrIntPadded( ProgramVersion, 2 ) + StrIntPadded( ProgramRelease, 2 );

     //* 21.12.2004  El Fichero de protección para instalaciones cliente incluye ahora el número de serie
     //              del servidor. De esta forma se pueden crear clientes de varios servidores en el
     //              mismo equipo.

     // En un fichero cliente, el número de serie es el de la instalación servidor

     case ProtecFileType of
       pfServer        : Result := ApplicationPath + PfnStr + ProtectFileExt;
       pfClient        : Result := ApplicationDataDirectory + PfnStr + '_' + IntToStr( SerialNumber ) + ProtectFileExt;
       pfControlCenter : Result := ApplicationDataDirectory + 'ICC' + ProtectFileExt;
       pfInstaller     : Result := ApplicationDataDirectory + PfnStr + ProtectFileExt;
       end;

end;

procedure WriteProtectionData( ProtecFileType : TProtecFileType;
                               SerialNumber   : Int64 = 0 );

var  DataFile : File of TProtectionRec;
     IOState : Integer;
     FileName : String;

begin
     {$I-}
     FileName := GetProtectionFileName( ProtecFileType, SerialNumber );
     EraseFile( FileName, False );
     AssignFile( DataFile, FileName );
     Rewrite( DataFile );
     IoState := IOresult;
     If   IOState=0
     then begin

          If   SerialNumber<>0  // es un cliente
          then ProtectionRec.LocalDiskID := GetDiskID( WindowsDirectory );

          ProtectionRec.SerialNumber := SpSerialNumber;
          ProtectionRec.RegNumber := SpRegNumber;
          ProtectionRec.ActivationKey := SpActivationKey;
          ProtectionRec.ProgramNumber := ProgramNumber;
          ProtectionRec.ServerConnections := SpServerConnections;
          ProtectionRec.ProgramVersion := ProgramVersion;
          ProtectionRec.ProgramRelease := ProgramRelease;
          ProtectionRec.Suscription := SpSuscription;
          ProtectionRec.Evaluation := SpEvaluation;
          ProtectionRec.UserCode := SpUserCode;
          ProtectionRec.UserName := SpUserName;
          {
          ProtectionRec.LastCheck := SpLastCheck;
          ProtectionRec.LastState := SpLastLicenseState;
          }
          ProtectionRec.ApplicationPath := AnsiString( ApplicationPath );
          ProtectionRec.Caducity := SpCaducity;
          ProtectionRec.OptionalModules := SpOptionalModules;

          Write( DataFile, ProtectionRec );
          CloseFile( DataFile );
          end
     else begin
          ShowNotification( ntStop, Format( RsgMsg344, [ IOState ] ) );
          Abort;
          end;
     {$I+}
end;

function GetProtectionData( ProtecFileType : TProtecFileType;
                            SerialNumber   : Int64 = 0;
                            PreserveData   : Boolean = False ) : Boolean;

var  DataFile : File of TProtectionRec;
     FileName : String;

begin
     {$I-}
     Result := False;
     If   not PreserveData
     then If   ProtecFileType=pfClient
          then FillChar( LocalProtectionRec, SizeOf( LocalProtectionRec ), #0 )
          else FillChar( ProtectionRec, SizeOf( ProtectionRec ), #0 );
     FileName := GetProtectionFileName( ProtecFileType, SerialNumber );
     FileMode := fmOpenRead;
     AssignFile( DataFile, FileName );
     Reset( DataFile );
     If   IoResult=0
     then begin
          If   ProtecFileType=pfClient
          then Read( DataFile, LocalProtectionRec )
          else Read( DataFile, ProtectionRec );
          CloseFile( DataFile );
          Result := True;
          end;
     {$I+}
end;

function GetSuscriptionKey : String;
begin
     Result := 'ID' + StrIntPadded( ProgramNumber, 3 ) + StrIntPadded( ProgramVersion, 2 ) + StrIntPadded( ProgramRelease, 2 );
end;

{
function GetSuscriptionData : Boolean;

var Reg : TRegistry;
    RecSize : Integer;

begin
     Result := False;
     Reg := TRegistry.Create;
     If   Assigned( Reg )
     then try
            Reg.RootKey := HKEY_LOCAL_MACHINE;
            If   Reg.OpenKeyReadOnly( DEF_SUSCRIPTION_PATH )
            then begin
                 RecSize := Reg.ReadBinaryData( GetSuscriptionKey, SuscriptionRec, SizeOf( SuscriptionRec ) );
                 Reg.CloseKey;
                 Result := True;
                 end;
          finally
            Reg.Free;
            end;
end;

procedure UpdateSuscriptionData( LastState : Integer );

var Reg : TRegistry;
    RecSize : Integer;

begin
     Reg := TRegistry.Create;
     try
       Reg.RootKey := HKEY_LOCAL_MACHINE;
       If   Reg.OpenKey( DEF_SUSCRIPTION_PATH, True )
       then begin
            SuscriptionRec.LastCheck := Now;
            SuscriptionRec.LastState := LastState;
            If   SuscriptionRec.CheckCount>LicenseCheckCount
            then SuscriptionRec.CheckCount := 0
            else Inc( SuscriptionRec.CheckCount );
            Reg.WriteBinaryData( GetSuscriptionKey, SuscriptionRec, SizeOf( SuscriptionRec ) );
            Reg.CloseKey;
            end;
     finally
       Reg.Free;
       end;
end;
}

function IsCurrentSessionRemoteable : Boolean;

var   Reg : TRegistry;
      GlassSessionId,
      CurrentSessionId : DWORD;

const GLASS_SESSION_ID = 'GlassSessionId';

begin
     Result := False;
     Reg := TRegistry.Create;
     If   Assigned( Reg )
     then try
            try
              Reg.RootKey := HKEY_LOCAL_MACHINE;
              If   Reg.OpenKeyReadOnly( TERMINAL_SERVER_KEY )
              then begin
                   GlassSessionId := Reg.ReadInteger( GLASS_SESSION_ID );
                   If   ProcessIdToSessionId( GetCurrentProcessId, &CurrentSessionId )
                   then Result := CurrentSessionId<>GlassSessionId;
                   Reg.CloseKey;
                   end;
            finally
              Reg.Free;
              end;
          except
            end;

end;

function GetProtectionKey( AddCaducity : Boolean = False ) : Int64;
begin
     Result := ProtectionRec.SerialNumber +
               ProtectionRec.RegNumber +
               ProtectionRec.ServerConnections +
               ProtectionRec.ProgramNumber +
               ProtectionRec.ProgramVersion +
               ProtectionRec.ProgramRelease +
               ProtectionRec.OptionalModules;
     If   AddCaducity
     then Result := Result + Trunc( ProtectionRec.Caducity );  // Solo la parte entera, que es la fecha
end;

procedure CheckProtection( Notify         : Boolean;
                           ClientLocation : Boolean  );

var  Correct : Boolean;

begin

     try

        SpEvaluation := True;

        SpSerialNumber := GetDiskID( ApplicationPath );
        // ClientLocation := DataAccessMode=dmRemote;

        GetProtectionData( pfServer );

        // Comprobando el tipo de licencia : suscripción o clave de activación

        (*

        If   ProtectionRec.Suscription
        then begin

             // Sistema de protección por suscripción

             ApplicationContainer.SpSuscription := True;

             If   ProtectionRec.Evaluation
             then Exit;

             Randomize;

             If   ( ProtectionRec.UserCode<>'' ) and ( ProtectionRec.UserName<>'' )
             then begin
                  If   GetSuscriptionData
                  then If   ( SuscriptionRec.LastState<>CCL_CORRECTA ) or
                            ( ( Now - SuscriptionRec.LastCheck )>LicenseCheckDays ) or
                            ( SuscriptionRec.CheckCount>LicenseCheckCount ) or
                            ( Random( LicenseCheckCount )=0 )
                       then CompruebaEstadoLicencia; // CompruebaSuscripcion;

                  case SuscriptionRec.LastState of
                    CCL_CORRECTA : begin
                                   UpdateSuscriptionData( CCL_CORRECTA );
                                   Exit;
                                   end;
                    CCL_CADUCADA : begin
                                   ShowNotification( mbStop, RsgMsg110, RsgMsg111 );
                                   Exit;
                                   end;
                    end;

                  end;

             end
        else begin
        *)

             // Sistema de protección por clave de activación

             SpSuscription := False;

             If   ProtectionRec.Evaluation
             then Exit;

             If   ClientLocation
             then begin
                  GetProtectionData( pfClient, ProtectionRec.SerialNumber );
                  Correct := ( LocalProtectionRec.LocalDiskID=GetDiskID( WindowsDirectory ) ) and
                             ( ProtectionRec.SerialNumber=LocalProtectionRec.SerialNumber );
                  end
             else Correct := ProtectionRec.SerialNumber=SpSerialNumber;

             If   Correct and
                  ( ProtectionRec.ActivationKey=MakeActivationKey( GetProtectionKey ) ) and
                  ( ProtectionRec.ProgramNumber=ProgramNumber ) and
                  ( ProtectionRec.ProgramVersion=ProgramVersion ) and
                  ( ProtectionRec.ProgramRelease=ProgramRelease )
             then begin
                  SpSerialNumber := ProtectionRec.SerialNumber;
                  SpRegNumber := ProtectionRec.RegNumber;
                  SpActivationKey := ProtectionRec.ActivationKey;
                  SpServerConnections := ProtectionRec.ServerConnections;
                  SpOptionalModules := ProtectionRec.OptionalModules;
                  Sp64BitsServer := IsOptionalModuleActive( ProtectionRec.OptionalModules, moServidor64bits );
                  SpEvaluation := False;
                  Exit;
                  end;

        //   end;

     except
       end;

     {
     If   Notify
     then ShowNotification( mbStop, RsgMsg114, RsgMsg115 );
     }
end;

function IsOptionalModuleActive( Value  : Word;
                                 Module : TModuloOpcional ) : Boolean;
begin
     Result := ( Value and Trunc( Power( 2, Ord( Module ) ) ) )<>0;
end;

function GetMainInfoFileName : String;
begin
     Result := ApplicationPath + 'gd.ini';
end;

function GetAppVersionString( FileName : String = '' ) : String;

var  LibFileName : String;

begin
     If   FileName=''
     then FileName := ApplicationName;
     LibFileName := ApplicationPath + FileName;
     Result := GetVersionString( LibFileName, vsFileVersion ) + ' (' + GetFileAgeStamp( LibFileName ) + ')' {$IFDEF CPUX64} + ' 64bit' {$ENDIF};
end;

function GetAppInfoString( FileName : String = '' ) : String;

var  LibFileName : String;

begin
     If   FileName=''
     then FileName := ApplicationName;
     LibFileName := ApplicationPath + FileName;
     Result := GetVersionString( LibFileName, vsFileVersion ) + ' (' + GetFileAgeStamp( LibFileName ) + ')' {$IFDEF CPUX64} + ' 64bit' {$ENDIF};
end;

procedure SetMinMaxAnimation( Value : Boolean = False );

var  AnimationInfo : TAnimationInfo;

begin
     AnimationInfo.cbSize := SizeOf( TAnimationInfo );
     AnimationInfo.iMinAnimate := Byte( Value );
     SystemParametersInfo( SPI_SETANIMATION, SizeOf( AnimationInfo ), @AnimationInfo, SPIF_SENDWININICHANGE );
end;

function ExistsDictionary( DictionaryNumber : SmallInt ) : Boolean;
begin
     Result := DirectoryExists( ApplicationPath + 'dm' + IntToStr( DictionaryNumber ) );
end;

procedure Initialize;

var   StrC : array[ 0..MAX_PATH ] of Char;

begin

     ApplicationInitialized := False;
     InitializationError := False;

     {$IFNDEF SERVERAPP}
     UpdateDPIAwarenessInfo;
     {$ENDIF}

     LowestDateTime := EncodeDate( 1, 1, 1 );
     HighestDateTime := EncodeDate( 3000, 12, 31 );

     // El tamaño de la fuente no es configurable. Hay que utilizar Escala para que las ventanas se redimensionen de forma adecuada

     {$IFNDEF SERVERAPP}
     SetAppScaleDPI( USER_DEFAULT_SCREEN_DPI );
     // TamañoFuente := TamañoFuenteDefecto;
     {$ENDIF}

     SpSuscription := False;
     SpEvaluation := True;
     SpLastLicenseState := -1; // Error

     Randomize;

     // El directorio de la aplicación es en el que se encuentra el ejecutable

     ApplicationPath := IncludeTrailingPathDelimiter( ExtractFilePath( ParamStr( 0 ) ) );
     ApplicationName := SysUtils.ExtractFileName( ParamStr( 0 ) );

     GetTempPath( MAX_PATH, StrC );
     TemporalDataPath := AddPathDelim( StrC );
     WindowsDirectory := String( GetSpecialFolder( CSIDL_WINDOWS ) );
     ApplicationDataDirectory := String( GetSpecialFolder( CSIDL_COMMON_APPDATA ) + '\Gestwin\' );

     AppShortName := ParamStr( 1 );  // El nombre : Contable, Comercial, TPV, etc..

     DataAccessMode := dmLocal;

     If   not ServerApplication and 
	 	      not DontReadCommandLineOptions
		      and not IsDesignTime
     then ReadCommandLineOptions;

     // Determino el Path a la base de datos global (raiz)

     ApplicationImportsPath := ApplicationPath + 'imports\';
     ApplicationExportsPath := ApplicationPath + 'exports\';

     { He reunificado las diferentes versiones en una sola. Ahora la versión de la base de datos es la
       de la aplicación y se extrae del ejecutable principal (en GESTWIN desktop es gd.exe) }

     VersionInfo := GetFileVersion( ApplicationPath + ApplicationName );
	   ComparableAppVersion := GetAppComparableVersion;
	
end;

procedure LogMessage( Msg : String );

var   LogFile     : textFile;
      LogFileName : String;
      Status      : SmallInt;

begin
     {$I-}
     If   AppShortName=''
     then LogFileName := ChangeFileExt( ApplicationName, '.log' )
     else LogFileName := AppShortName + '.log';
     LogFileName := ApplicationPath + LogFileName;
     AssignFile( LogFile, LogFileName );
     Append( LogFile );
     Status := IoResult;
     If   Status<>0
     then Rewrite( LogFile );
     Status := IoResult;
     If   Status=0
     then begin
          WriteLn( LogFile, DateTimeToStr( Now ) + ' - ' + CleanStr( Msg ) );
          CloseFile( LogFile );
          end;
     {$I+}
end;

{$IFNDEF SERVERAPP}

{ TgAppSection }

constructor TgAppSection.Create(AOwner: TComponent);
begin
     inherited;
     FGlyph := cxCreateBitmap( 0, 0, cxDoubleBufferedBitmapPixelFormat );
     FSmartGlyph := TdxSmartGlyph.Create;
end;

destructor TgAppSection.Destroy;
begin
     FreeAndNil( FGlyph );
     FreeAndNil( FSmartGlyph );
     inherited;
end;

procedure TgAppSection.Notification( AComponent : TComponent;
                                     Operation  : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FMainMenuBar
          then FMainMenuBar := nil;
          {
          else If   AComponent=FGlyph
               then FGlyph := nil;
          }
          end;
end;

procedure TgAppSection.SetGlyph( Value : TBitmap );
begin
     FGlyph.Assign( Value );
end;

procedure TgAppSection.SetSmartGlyph(Value: TdxSmartGlyph);
begin
  FSmartGlyph.Assign(Value);
end;

procedure TgAppSection.SetEnabled( Value : Boolean );
begin
     FEnabled := Value;
end;

procedure TgAppSection.UpdateMainMenu;
begin
     If   Assigned( FOnUpdateMainMenu )
     then FOnUpdateMainMenu;
end;

procedure TgAppSection.UpdateSelector;
begin
     If   Assigned( FOnUpdateSelector )
     then FOnUpdateSelector;
end;

procedure TgAppSection.DoOnInitialize;
begin
     If   Assigned( FOnInitialize )
     then FOnInitialize;
end;

procedure TgAppSection.DoOnSelected;
begin
     If   Assigned( FOnSelected )
     then FOnSelected;
end;

(*
function PrgExit( RequestForExit : Boolean;
                  Force          : Boolean = False;
                  SilentMode     : Boolean = False  ) : Boolean;

begin
     Result := False;

     If   IsDesignTime or ( ServerApplication and not RequestForExit )
     then Exit;

     If   ReleasingApplication
     then begin
          Application.Terminate;
          Exit;
          end;

     If   not Force
     then If   RunningProcess
          then begin
               ShowNotification( ntStop, RsgMsg118, RsgMsg119 );
               Exit;
               end;

     If   RequestForExit
     then begin
          If   ShowNotification( ntQuestion, RsgMsg116, RsgMsg106 )=mrYes
          then begin
               If   not CanCloseAllForms( False )
               then Exit;
               If   ( CodigoUsuarioActual='00' ) and not ApplicationContainer.DontAskForBackup
               then If   ShowNotification( ntQuestionWarning, RsgMsg105, RsgMsg109 )=mrYes
                    then ApplicationContainer.DoOnBackupDatabase;
               end
          else Exit;
          end
     else begin
          If   not ApplicationContainer.CanCloseAllForms( False )
          then Exit;
          If   not SilentMode
          then ShowNotification( ntInformation, RsgMsg105, RsgMsg106 );
          end;

     ReleasingApplication := True;

     // Esto es solo para evitar un molesto saltito de la barra inferior al desaparecer el menú principal

     If   Assigned( Application.MainForm )
     then begin
          Application.MainForm.Menu := ApplicationContainer.DefaultMenu;
          CloseAllDataModules;
          end;

     LogMessage( RsgMsg108 );

     // Application.ProcessMessages;

     // Rpc.CierraSesion;

     Result := True;

     Application.Terminate;
end;

*)
{$ENDIF}

initialization

   OnPrgExitNotification := InternalPrgExit;

   RegisterClasses( [ TApplicationManager ] );

   DebugApp := False;

   {$IFDEF SERVERAPP}
   ServerApplication := True;
   ServerSide := True;
   {$ELSE}
   RegisterClasses( [ TgAppSection ] );
   {$ENDIF}
   Initialize;

finalization
   FreeAndNil( FProcedureList );
   FreeAndNil( FApplicationManager );

end.
