
{ AppContainer unit ------------------------- © Marcos Gregori ----------------------------------------- }

{$IMPORTEDDATA ON}

Unit    AppContainer;

Interface

uses    System.ImageList,

        Windows,
        SysUtils,
        Dialogs,
        Messages,
        Classes,
        Forms,
        Graphics,
        Controls,
        ExtCtrls,
        ImgList,
        StdCtrls,
        Buttons,
        LibUtils,
        Generics.Collections,
        DB,
        nxDB,

        cxStyles,
        cxClasses,
        cxDateutils,
        cxGridTableView,
        cxLookAndFeels,
        cxLookAndFeelPainters,
        cxButtons,
        cxEdit,
        cxPC,
        cxLabel,
        cxImage,
        cxGroupBox,
        dxPanel,
        dxBar,
        dxBarExtItems,
        dxTabbedMDI,
        // dxStatusBar,
        dxSkinsCore,
        // dxSkinsdxBarPainter,
        dxSkinsDefaultPainters,
        dxSkinsForm,
        cxGraphics,
        cxImageList,
        dxAlertWindow,
		      dxScreenTip,
		      dxCustomHint,
        dxCore,
        dxNavBar,
        dxNavBarCollns,
        dxNavBarBase,
        dxNavBarGroupItems,
		      cxHint,
        cxScrollBox,

        AppManager,
        DataManager,

        // Skins

        GestwinSkin,
        GestwinWhiteSkin,

        dxSkinBasic,
        dxSkinDevExpressDarkStyle,
        dxSkinDevExpressStyle,
        dxSkinFoggy,
        dxSkinPumpkin,
        dxSkinSeven,
        dxSkinSpringTime,
        dxSkinSummer2008,
        dxSkinValentine,
        dxSkinXmas2008Blue, dxCoreClasses, dxRichEdit.NativeApi,
  dxRichEdit.Types, dxRichEdit.PlainText, dxRichEdit.DocumentServer;

const   sbnHelp               =  0;
        sbnEdit               =  1;
        sbnQuery              =  2;
        sbnRelatedDocs        =  3;
        sbnNote               =  4;
        sbnReport             =  5;
        sbnFormReport         =  6;
        sbnLabels             =  7;
        sbnGraphic            =  8;
        sbnFirstRec           =  9;
        sbnPriorRec           = 10;
        sbnRefreshRec         = 11;
        sbnNextRec            = 12;
        sbnLastRec            = 13;
        sbnCopyRec            = 14;
        sbnSaveParams         = 15;
        sbnSearchRec          = 16;
        sbnCancelSrchRec      = 17;
        sbnQueryGrid          = 18;
        sbnInsertRec          = 19;
        sbnExtFunc            = 20;
        sbnEditRec            = 21;
        // sbnReloadRec          = 22;
        sbnDefaultValue       = 23;


        sbnAccept             = 40;
        sbnClose              = 41;
        // sbnDelete             = 43;
        sbnNone               = 49;

        sbnRecordButtons      = 50;


        MaxSectionModuleSize  = 20;
        InitRepeatPause       = 200;
        RepeatPause           = 50;

        // Tipo de registro de configuracion

        ctGlobal              = 0;
        ctEmpresa             = 1;
        ctUsuario             = 2;
        ctParametrosVentana   = 3;
        ctBackup              = 4;
        ctCamposConsulta      = 5;

        //Añadidos nuevos tipos de registro para almacenar parámetros varios

        ctRelFichExp       = 100;     // Relacion de ficheros exportados la última vez
        ctImpAlbExternos   = 101;     // Configuración del proceso de importación de albaranes externos (otras aplicaciones)
        ctRelFichPreventa  = 102;     // Relacion de ficheros que se exportan en preventa
        ctSeguridad        = 103 ;    // Configuración de seguridad : certificados y firma digital
        ctTPV              = 200;     // Configuración del TPV. Independiente del número de programa y diferente para cada Empresa.

        // Colores

        clMenuBackground      = clWhite;
        clMenuBorderHighLight = $00FF9933;    // En Delphi es BGR
        clMenuHighlight       = clSkyBlue;

        clIconRed             = $005f6CEA;
        clIconOrange          = $002896F2;
        clIconGreen           = $0075A261;
        clIconBlue            = $00CB985E;
        clIconYellow          = $0063CEFD;

        clRowHighlight        = clMoneyGreen;

        clMediumGray          = $00C0C0C0;
        clLightGray           = $00E5E5E5;

        clBlue                = $00FF0000;
        clMediumBlue          = $00804000;
        clLightBlue           = $00E2E200;
        clCoolBlue            = $00EFD3C6;
        clSoftBlue            = $00FFF7DF;
        clMediumRed           = $007373E5;
        clLightRed            = $00E8E8FF;
        clLightGreen          = $00C0FFC0;
        clMediumOrange        = $004370FF;
        clLightOrange         = $00DBEBFF;
        clOrange              = $000053FF;
        clSoftYellow          = $00EDF8FF;

        clStateSetKey         = clMediumGray;
        clStateBrowse         = clIconGreen;
        clStateEdit           = clIconOrange;
        clStateInsert         = clIconRed;

        CR                    = #$D#$A;
        HtmlCR                = ''#13'';

        WM_SESSIONSTARTING  = WM_USER + 100;
        WM_SESSIONEND       = WM_USER + 101;
        WM_SESSIONSTARTED   = WM_USER + 102;

        DefaultBlockSize = 16384;  // Tamaño por defecto para transferencia de ficheros a traves de RPC

        // Identificadores de inicialización

        idDashboard = 0100;

type    TSpeedBtnTag = sbnHelp..sbnNone;
        TSpeedBtnTags = set of TSpeedBtnTag;
        TAlertWindowsTags = set of Byte;
        TSaveWndParamsOption = ( wpFields, wpLayout, wpAll, wpDelete, wpOneField );
        TSessionState = ( ssInactive, ssStarting, ssStarted );
        TMDILayout = ( mdiNone, mdiLeftRest, mdiTopRest, mdiHorizontalTile, mdiVerticalTile );
        TConfigRegType = ctGlobal..ctRelFichPreventa;

        TTipoRegistroDiarioProcesos = ( trdGenerico = 0, trdRegistroCambios = 1 );

        TBooleanEvent = procedure( const Value : Boolean ) of object;
        TStringEvent = procedure( const Value : String ) of object;
        TGetStringEvent = function : String of object;

        TUpdateMDILayoutButtonsStateEvent = procedure( const Value : TMDILayout ) of object;
        TSetHintCaptionEvent = procedure( HintControl : TControl; Value : String ) of object;
        TSaveParamsEvent = function( AForm : TForm; ParamList : TStringList; SaveLayout : Boolean = False ) : Boolean of object;
        TReadParamsEvent = function( AForm : TForm; ParamList : TStringList ) : Boolean of object;
        TQueryParamsEvent = function( AQueryPanel : TcxGroupBox ) : Boolean of object;
        TFieldContentEvent = function( AForm : TForm; EditControl : TcxCustomEdit; ParamList : TStringList ) : Boolean of object;
        TDeleteWindowStateEvent = function( AForm : TForm; ConfigRegType : TConfigRegType = ctParametrosVentana ) : Boolean of object;
        TStartProgressionEvent = procedure( AMaxRecordCount : Integer = 100; Cancelable : Boolean = True; Doc : TComponent = nil ) of object;
        TShowProgressionEvent = procedure( ProgMessage : String = ''; Percent : Integer = -1 ) of object;
        TEndProgressionEvent = procedure( Cancel : Boolean = False ) of object;
        TMantenimientoEvent = procedure( KeyValues : array of const );
        TProcessLogEvent = procedure( Caption, Msg : String; Tipo : TTipoRegistroDiarioProcesos = trdGenerico; ValorOpcion : SmallInt = 0 ) of object;
        TButtonEvent = function( Sender : TBitBtn ) : Boolean of object;
        TSpeedBtnEvent = procedure( AnAppSpeedBtn : TSpeedBtnTag ) of object;
        TAccessLevelEvent = function : SmallInt of object;
        TSaveWndParamsEvent = function( Option : TSaveWndParamsOption ) : Boolean of object;

        TUpdateDatabaseProcedure = procedure( CodigoEmpresa : String; Detected : Boolean );
        TInitializeDatabaseProcedure = procedure( OnlyVerifyIfExists : Boolean );
        TShowWebProcedure = procedure ( WebPage : String = ''; Title : String = ''; StandAlone : Boolean = False );

        ESecurityException = class( Exception )
         end;

        EMsgBoxException = class( Exception )
        public

        FDescription : String;
        FNotificationType : TNotificationType;

        constructor Create( NotificationType : TNotificationType; Msg, Description : String );

        property Description : String read FDescription;
        end;

        TRpcInitilizationType = ( rpcInstall = 0, rpcUpgrade = 1 );

        TBitBtnKindSet  = set of TBitBtnKind;

        TGlyphBitmap    = ( gmNone,
                            gmHelp,
                            gmNo,
                            gmOk,
                            gmYes,
                            gmInsert,
                            gmDelete,
                            gmCancel,
                            gmClose,
                            gmWarning,

                            // Genéricos

                            gmAll,
                            gmSetup,
                            gmAddDatabase,
                            gmFields,
                            gmAddField,
                            gmDeleteField,
                            gmAddTable,
                            gmDeleteTable,
                            gmAddQuery,
                            gmNew,
                            gmPrinter,
                            gmPrinterSetup,
                            gmFolder,
                            gmFolderOpen,
                            gmFolderBrowser,
                            gmNetwork,
                            gmCalculator,
                            gmCalendar,
                            gmCardFile,
                            gmDocSingle,
                            gmDocStack,
                            gmExport,
                            gmImport,
                            gmNewDocument,
                            gmGears,
                            gmForm,
                            gmGraph,
                            gmWrite,
                            gmFileSave,
                            gmSelectCard,
                            gmFont,
                            gmBCard,
                            gmEditBCard,
                            gmLeft,
                            gmRight,
                            gmUser,
                            gmUsers,
                            gmPlus,
                            gmMinus,
                            gmEditField,
                            gmRefresh,
                            gmReload,
                            gmMail,
                            gmSendMail,
                            gmWindowColumns,
                            gmWindowDetail,
                            gmWindowList,
                            gmAddForm,
                            gdmDeleteForm,
                            gmEditForm,
                            gmFormHeader,
                            gmFormSide,
                            gmSign,
                            gmLocate,
                            gmLocalization,
                            gmInvoice,
                            gmInvoiceOk,
                            gmComment,
                            gmClipboard,
                            gmCopyDoc );

        TContentType = ( cntQuerySourceColumn,
                         cntEditFixedColumn,
                         cntContentEven,
                         cntMenuNote,
                         cntMenuHeader );

        TAppSectionClass   = class of TFrame;
        TFrameClass        = class of TFrame;

        TFormItem = class
        public

          FormClass : TFormClass;
          FormType : TFormType;
          EntryPoint : TProcedure;

          constructor Create( FormClass : TFormClass; FormType : TFormType; EntryPoint : TProcedure ); overload;
          end;

        TFormList = class( TList )
        public
          procedure Clear; override;
          function  FindByFormClass( AFormClass : TFormClass ) : TFormItem;
          end;

        // - TApplicationContainer ------------------------------------------------------

        TApplicationContainer = class( TFrame )

          SkinController: TdxSkinController;
          ButtonImageList: TcxImageList;
          CheckUpgradeTimer: TTimer;
          StyleRepository: TcxStyleRepository;
          AlertWindowManager: TdxAlertWindowManager;
          HintStyleController: TcxHintStyleController;
          DiagramImageList: TcxImageList;
          QueryContentEvenStyle: TcxStyle;
          QueryContentSourceColumnStyle: TcxStyle;
          EditFixedColumnStyle: TcxStyle;
          MenuNoteStyle: TcxStyle;
          MenuHeaderStyle: TcxStyle;
          QueryGridTableViewStyleSheet: TcxGridTableViewStyleSheet;
          procedure AlertWindowManagerButtonClick(Sender: TObject; AAlertWindow: TdxAlertWindow; AButtonIndex: Integer);
          procedure CheckUpgradeTimerTimer(Sender: TObject);
          procedure HintStyleControllerShowHint(Sender: TObject; var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
          procedure SkinControllerSkinForm(Sender: TObject; AForm: TCustomForm;var ASkinName: string; var UseSkin: Boolean);

         private

          FModuleNamesList,
          FOptionalModuleNamesList : TStringList;
          FModuleList : TList;

          FReportList,                                // Lista de reports activos
          FAppSectionList : TList;                    // Lista de secciones
          FEditFormList : TFormList;                  // Lista de ventanas de edición

          FAppSectionCount : Integer;                 // El número de secciones sin contar la de configuración
          FUpdatingAppSections : Boolean;
          FAppSectionIndex : SmallInt;
          FCurrentSection : TgAppSection;
          FCurrentHintPanelControl : TControl;
          FHintPanel : TcxGroupBox;
          FHintLabel : TcxLabel;

          FAppSectionsPopupMenu : TdxBarPopupMenu;
		        {$IFDEF APPSECTIONSPANEL}
          FAppSectionsPanel : TdxPanel;
          FAppSectionsContentPanel : TcxScrollBox;
          FAppSectionPanelOffset : Integer;
          {$ENDIF}
          FEditButton,
          FQueryGridButton,
          FRelationsButton,
          FQueryButton,
          FNoteButton,
          FReportButton,
          FFormReportButton,
          FLabelButton,
          FGraphicButton,

          FFirstRecButton,
          FPreviousRecButton,
          FRefreshRecButton,
          FReloadRecButton,
          FNextRecButton,
          FLastRecButton,
          FInsertRecButton,
          FCopyRecButton,
          FSearchRecButton,
          FCancelSrchRecButton,
          FNumericKeyboardButton,
          FSchedulerButton,
          FDashboardButton,
          FWordprocessorButton,
          FMailButton,
          FUpgradeButton,
          FCloseMDIButton,
          FSaveParamsButton,

          FSectionsButton : TdxBarLargeButton;

          FTabbedMDIManager : TdxTabbedMDIManager;
          FCurrentMDILayout : TMDILayout;

          FSectionsBarStatic,
          FSessionsBarStatic : TdxBarStatic;

          FMainBarManager : TdxBarManager;

          // FDefaultMenu : TMainMenu;
          FCurrentMainMenuBar ,
          FPadMenuBar : TdxBar;
          FSectionBarStatic : TdxBarStatic;
          FSectionBarButton : TdxBarLargeButton;
          FLockClientWindowUpdateCount: Integer;

          // Tactil

          FDataPanel,
          FQueryPanel,
          FBottomPanel : TcxGroupBox;

          FOnUpdateMDILayoutButtonsState : TUpdateMDILayoutButtonsStateEvent;

          FOnSetHintCaption : TSetHintCaptionEvent;
          FOnSetupMainForm : TSimpleEvent;
          FOnSetupAboutForm,
          FOnInitAppModules : TProcedure;
          FOnSaveWindowState : TSaveParamsEvent;
          FOnReadWindowState : TReadParamsEvent;
          FOnSaveQueryConfig,
          FOnReadQueryConfig : TQueryParamsEvent;
          FOnSaveFieldContent,
          FOnReadFieldContent : TFieldContentEvent;
          FOnDeleteWindowState : TDeleteWindowStateEvent;

          FOnStartProgression : TStartProgressionEvent;
          FOnShowProgression : TShowProgressionEvent;
          FOnEndProgression : TEndProgressionEvent;

          FOnProcessLog : TProcessLogEvent;

          FOnStart,
          FOnBegin,
          FOnEnd,
          FOnExchangeSchedulerForm,
          FOnExchangeDashboardForm,
          FOnExchangeWordprocessorForm,
          FOnBackupDatabase : TProcedure;
          FOnUpdateLookAndFeel : TSimpleEvent;

          FOnUpdateDatabase : TUpdateDatabaseProcedure;
          FOnInitializeDatabase : TInitializeDatabaseProcedure;

          FOnShowWebForm : TShowWebProcedure;

          FOnExternalReport : TNotifyEvent;
          FOnSetupScheduler,
          FOnSetupDashboard,
          FOnShowMailForm,
          FOnShowUpgradeForm : TSimpleEvent;

          FTDI,
          FMaximizeEditForms,
          FDontCloseWindowsWithEsc,
          FShowScheduler,
          FShowDashboard,
          FDeactivateNotifications,   // Las notificaciones automáticas de los eventos de la agenda
          FShowMail : Boolean;
          FStartTimeDelay : TDateTime;

          FUpgradeChecked : Boolean;
          FTryingToCloseAllForms : Boolean;

          // Procedimientos incluídos en módulos opcionales

          FOnEdicionUsuarios : TProcedure;

          procedure AddModule(  Handle : HMODULE );
          function GetReportList : TList;
          function GetEditFormList : TFormList;
          procedure UpdateSkinController;
          procedure HandleException(Sender: TObject);
          procedure ShowMainMenuBar( AppSection : TgAppSection );
          procedure SetCurrentMDILayout( const Value : TMDILayout );

        public

          IOStatus : SmallInt;

          DestroyingMainForm,
          HelpFormActive,
          WebFormActive,
          WarningActive : Boolean;                      // La ventana de avisos o cualquier otra ventana modal con notificaciones
          MainPanelsHeight : Integer;

          SchedulerActive,
          SchedulerFormVisible,
          DashboardActive,
          DashboardFormVisible,
          WordprocessorActive,
          WordprocessorFormVisible : Boolean;

          // SetBarItemVisible( ActualizacionButton, True );

          TodayDate,
          Today30DaysAgoDate,
          FirstDayOfYearDate,
          LastDayOfYearDate  : TDateTime;

          WorkDays : Integer;
          WorkStart,
          WorkFinish : TTime;

          {}

          ActiveModules : TIntegerArray;            // Módulos activos

          RegRootKey : String;

          Ejercicio,
          EjercicioProx,
          EjercicioPrev,

          NroMesInicial,
          NroMesFinal : Word;

          CabeceraEmpresa : String;

          Usuario_Nombre : String;

          Empresa_Nombre,
          Empresa_Domicilio,
          Empresa_Localidad : String;
          Empresa_CP : String;
          Empresa_Provincia : String;
          Empresa_NIF : String;
          Empresa_Telefono,
          Empresa_Fax : String;
          Empresa_CriterioCaja : Boolean;

          ActiveReportFileName : String;

          // Estas son variables de configuración globales

          LogRecordDataChanges : Boolean;
          SimTabWithKeyPad : Boolean;        // Indica si debe simularse la tecla Tab con el pad numérico.
          ExtendedSelections : Boolean;      // Si deben crearse los controles de selección extendidos (o no)
          ReportUnderline : Boolean;         // Si deben subrayarse las lineas de los listados
          ReportTitleBarColor : TColorRef;
          AnnotationFont : String;           // Fuente por defecto para las anotaciones (bx_not)
          AnnotationFontSize : SmallInt;     // Tamaño de la fuente por defecto para las anotaciones
          AlertasPermanentes : Boolean;
          PosicionAlertas : Byte;

          PDFCompressed,
          PDFEmbeddedFonts,                  // Los documentos PDF generados incluyen las definiciones de las fuentes utilizadas
          PDFBackground,
          PDFPrintOptimized : Boolean;
          PDFCompressionLevel : SmallInt;

          CustomLookAndFeel : Boolean;
          LookAndFeelKind : TcxLookAndFeelKind;

          AppUseSkins : Boolean;
          AppSkinName,
          AppSkinPalette,
          LoadedSkinName,
          LoadedSkinPalette : String;
          AppSkinPainter : TcxCustomLookAndFeelPainter; // TcxCustomLookAndFeelPainterClass;
          RenderMode : TdxRenderMode;

          DontAskForBackup,
          PosQueryFormsAtLeft,
          ShowNumericKeyboard  : Boolean;
          AppTouchMode : Boolean;
          NumOfInternalCopies : Integer;
          TouchModeSize : Integer;

          //

          CambioDeEmpresa,                       // En este momento se está cambiando de empresa activa (b_uee)

          FUserCanModifyReports,
          FUserCanEditReports,

          FRecordButtonPressed,
          FRecordButtonsEnabled,

          IsMenuBarActive : Boolean;

          MainTopBar,
          MainStatusBar : TdxBar;
          MainInfoPanel : TdxBarControlContainerItem;

          CurrentClosingForm : TForm;
          ApplicationFormCloseQuery : Boolean;    // Debe fijarlo el Form principal cuando se llama a su procedimiento CloseQuery

          SessionID : TGuid;                      // Identificador de la sesión activa

          FUpdatingError : Boolean;

          constructor Create( AOwner : TComponent ); override;
          destructor  Destroy; override;

          function  SaveWindowState( AForm : TForm; ParamList : TStringList; saveLayout : Boolean = False ) : Boolean;
          function  ReadWindowState( AForm : TForm; ParamList : TStringList ) : Boolean;
          function  DeleteWindowState( AForm : TForm; ConfigRegType : TConfigRegType = ctParametrosVentana ) : Boolean;
          function  ReadFieldContent( AForm : TForm; EditControl : TcxCustomEdit; ParamList : TStringList ) : Boolean;
          function  SaveFieldContent( AForm : TForm; EditControl : TcxCustomEdit; ParamList : TStringList ) : Boolean;

          function  SaveQueryConfig( QueryPanel : TcxGroupBox ) : Boolean;
          function  ReadQueryConfig( QueryPanel : TcxGroupBox ) : Boolean;

          procedure ShowAboutForm( Modal : Boolean );
          procedure HideAboutForm;
          procedure ShowApplicationLicense;
          procedure DisableApplication;
          procedure ApplyTDI;

          procedure RegisterProgram( AppForm : TForm = nil );

          procedure LoadAppModules;
          procedure UnloadAppModules;
          procedure InitializeAppModules( AppNumber : Word; MainSectionsArray : array of Integer );
          function  ExistsModuleName( Name : String ) : Boolean;
          function  ExistsOptionalModuleName( Name : String ) : Boolean;
          function  IsModuleActive( ModuleID : array of Integer ) : Boolean;

          // procedure ExecuteMenuItem( Sender : TObject );
          procedure ShowMainFormCaption( Caption : String );
          procedure ShowWebForm( Page : String = ''; Title : String = '' );
          procedure ShowMailForm;
          procedure ShowUpgradeForm;
          procedure SetupScheduler;
          procedure SetupDashboard;
          // procedure SetupMail;
          procedure SetupNumericKeyboard;
          procedure ExchangeSchedulerForm;
          procedure ExchangeDashboardForm;
          procedure ExchangeWordProcessorForm;
          procedure SetupCheckUpgrade;
          procedure UpdateDatabase( CodigoEmpresa : String; Detected : Boolean );
          procedure InitializeDatabase( OnlyVerifyIfExists : Boolean );

          procedure StartProgression( AMaxRecordCount : Integer = 100; Cancelable : Boolean = True;Doc : TComponent = nil );
          procedure ShowProgression( ProgMessage : String = ''; Percent : Integer = -1 );
          procedure EndProgression( Cancel : Boolean = False );

          procedure AlertWindowsVisible( ShowWindows : Boolean );

          procedure CloseAllReports;
          procedure CloseReport( AReport : TComponent );
          function  TryToCloseAll( CloseDataModules : Boolean = True; ShowMessage : Boolean = True ) : TModalResult;
          function  CanCloseAllForms( ShowMessage : Boolean = True ) : TModalResult;

          procedure AddAppSection( AnAppSection : TgAppSection );
          procedure PopupAppSectionsMenu( Sender : TObject );
          procedure InitializeAppSections;
          procedure UpdateAppSections( LockSectionsAccess : Boolean = False; UpdateMenus : Boolean = True );
          procedure SelectAppSection( AppSection : TgAppSection );
          function  SectionExists( ID : SmallInt ) : Boolean;

		  {$IFDEF APPSECTIONSPANEL}
          procedure AddAppSectionPanelItem( AppSection : TgAppSection );
          {$ELSE}
          procedure AddAppSectionPopupItem( AppSection : TgAppSection );
		  {$ENDIF}
          procedure AppSectionsMenuClick( Sender : TObject );
          procedure AddFormReference( AFormClass : TFormClass; AFormType : TFormType; AccessPoint : TProcedure );
          function GetContentStyleTextColor( ContentType : TContentType ) : TColor;
          function GetContentStyleBackgroundColor( ContentType : TContentType ) : TColor;
          function GetDefaultContentColor : TColor;
          function GetPainterColor( CurrentColor : TColor ) : TColor;
          function GetProgressBarTextColor( AIsFilledArea: Boolean ) : TColor;
          procedure HideHintPanel;
          procedure SetHintPanelCaption( HintControl : TControl; Value : String );
          procedure ShowAlert( ACaption, AText : String; ATag : SmallInt; AImageIndex : TcxImageIndex = -1 );
          procedure HideAlerts( Tags : TAlertWindowsTags = [] );

          // function  GetMainPanelsHeight( OnlyTopPanels : Boolean = False ) : Word;
          procedure EnableRecordButtons( Value : Boolean; FilterEnabled : Boolean = False; DatasetFiltered : Boolean = False );
          procedure DisableAllToolbarButtons;
          procedure LockClientWindowUpdate;
          procedure UnlockClientWindowUpdate;

          procedure ProcessLog( Caption, Msg : String; Tipo : TTipoRegistroDiarioProcesos = trdGenerico; ValorOpcion : SmallInt = 0 );
          procedure ProcessRecordChangesLog( Dataset : TnxIndexDataSet; OptionValue : SmallInt = 0; ReferenceTable : TnxTable = nil );

          procedure DoOnStart;
          procedure DoOnBegin;
          procedure DoOnEnd;

          procedure DoOnSetupMainForm;

          {
          procedure DoOnActivateForm( Form : TgxForm; ShowMDIFormButton : Boolean );
          procedure DoOnDeactivateEditForm( HideMDIFormButton : Boolean );
          }
          // procedure DoOnSetHintCaption( HintControl : TControl; Value : String );
          procedure DoOnBackupDatabase;
          procedure DoOnUpdateLookAndFeel;
          procedure DoOnExternalReport;
          procedure DoOnEdicionUsuarios;

          property TDI : Boolean read FTDI write FTDI;
          property CurrentMDILayout : TMDILayout read FCurrentMDILayout write SetCurrentMDILayout default mdiNone;
          property MaximizeEditForms : Boolean read FMaximizeEditForms write FMaximizeEditForms;
          property DontCloseWindowsWithEsc : Boolean read FDontCloseWindowsWithEsc write FDontCloseWindowsWithEsc;
          property ShowScheduler : Boolean read FShowScheduler write FShowScheduler;
          property ShowDashboard : Boolean read FShowDashboard write FShowDashboard default True;
          property DeactivateNotifications : Boolean read FDeactivateNotifications write FDeactivateNotifications;
          property ShowMail : Boolean read FShowMail write FShowMail;
          property UserCanModifyReports : Boolean read FUserCanModifyReports write FUserCanModifyReports;
          property UserCanEditReports : Boolean read FUserCanEditReports write FUserCanEditReports;

          {
          property MajorVersion : Word read VersionInfo.MajorVersion;
          property MinorVersion : Word read VersionInfo.MinorVersion;
          property Release : Word read VersionInfo.Release;
          property Build : Word read VersionInfo.Build;
          }

          procedure LogMessage(Msg: String);

          property UpdatingError : Boolean read FUpdatingError write FUpdatingError;
          property TryingToCloseAllForms : Boolean read FTryingToCloseAllForms;

          property ModuleNamesList : TStringList read FModuleNamesList;
          property OptionalModuleNamesList : TStringList read FOptionalModuleNamesList;
          property AppSectionList : TList  read FAppSectionList;
          property EditFormList : TFormList  read GetEditFormList;
          property ReportList : TList  read GetReportList;

          property CurrentSection : TgAppSection read FCurrentSection;
          property UpdatingAppSections : Boolean  read FUpdatingAppSections;
          property RecordButtonPressed : Boolean  read FRecordButtonPressed write FRecordButtonPressed;
          property RecordButtonsEnabled : Boolean  read FRecordButtonsEnabled;

          property EditButton : TdxBarLargeButton read FEditButton write FEditButton;
          property QueryGridButton : TdxBarLargeButton read FQueryGridButton write FQueryGridButton;
          property RelationsButton : TdxBarLargeButton read FRelationsButton write FRelationsButton;
          property QueryButton : TdxBarLargeButton read FQueryButton write FQueryButton;
          property NoteButton : TdxBarLargeButton read FNoteButton write FNoteButton;
          property ReportButton : TdxBarLargeButton read FReportButton write FReportButton;
          property FormReportButton : TdxBarLargeButton read FFormReportButton write FFormReportButton;
          property LabelButton : TdxBarLargeButton read FLabelButton write FLabelButton;
          property GraphicButton : TdxBarLargeButton read FGraphicButton write FGraphicButton;
          property SectionsButton : TdxBarLargeButton read FSectionsButton write FSectionsButton;
          property TabbedMDIManager : TdxTabbedMDIManager read FTabbedMDIManager write FTabbedMDIManager;
          property AppSectionsPopupMenu : TdxBarPopupMenu read FAppSectionsPopupMenu write FAppSectionsPopupMenu;
		        {$IFDEF APPSECTIONSPANEL}
		        property AppSectionsPanel : TdxPanel read FAppSectionsPanel write FAppSectionsPanel;
          property AppSectionsContentPanel : TcxScrollBox read FAppSectionsContentPanel write FAppSectionsContentPanel;
          property AppSectionPanelOffset : Integer read FAppSectionPanelOffset;
		        {$ENDIF}
          property FirstRecButton : TdxBarLargeButton read FFirstRecButton write FFirstRecButton;
          property PreviousRecButton : TdxBarLargeButton read FPreviousRecButton write FPreviousRecButton;
          property RefreshRecButton : TdxBarLargeButton read FRefreshRecButton write FRefreshRecButton;
          property ReloadRecButton : TdxBarLargeButton read FReloadRecButton write FReloadRecButton;
          property NextRecButton : TdxBarLargeButton read FNextRecButton write FNextRecButton;
          property LastRecButton : TdxBarLargeButton read FLastRecButton write FLastRecButton;
          property InsertRecButton : TdxBarLargeButton read FInsertRecButton write FInsertRecButton;
          property CopyRecButton : TdxBarLargeButton read FCopyRecButton write FCopyRecButton;
          property SearchRecButton : TdxBarLargeButton read FSearchRecButton write FSearchRecButton;
          property CancelSrchRecButton : TdxBarLargeButton read FCancelSrchRecButton write FCancelSrchRecButton;
          property SchedulerButton : TdxBarLargeButton read FSchedulerButton write FSchedulerButton;
          property DashboardButton : TdxBarLargeButton read FDashboardButton write FDashboardButton;
          property WordprocessorButton : TdxBarLargeButton read FWordprocessorButton write FWordprocessorButton;
          property MailButton : TdxBarLargeButton read FMailButton write FMailButton;
          property NumericKeyboardButton : TdxBarLargeButton read FNumericKeyboardButton write FNumericKeyboardButton;
          property UpgradeButton : TdxBarLargeButton read FUpgradeButton write FUpgradeButton;

          // Touch

          property DataPanel : TcxGroupBox read FDataPanel write FDataPanel;
          property QueryPanel : TcxGroupBox read FQueryPanel write FQueryPanel;
          property BottomPanel : TcxGroupBox read FBottomPanel write FBottomPanel;

          // Estandar

          property MainBarManager : TdxBarManager read FMainBarManager write FMainBarManager;
          property CurrentMainMenuBar : TdxBar read FCurrentMainMenuBar write FCurrentMainMenuBar;
          property PadMenuBar : TdxBar read FPadMenuBar write FPadMenuBar;
          property SectionBarStatic : TdxBarStatic read FSectionBarStatic write FSectionBarStatic;
          property SectionBarButton : TdxBarLargeButton read FSectionBarButton write FSectionBarButton;
          // property DefaultMenu : TMainMenu read FDefaultMenu write FDefaultMenu;
          property SaveParamsButton : TdxBarLargeButton read FSaveParamsButton write FSaveParamsButton;
          property SessionsBarStatic : TdxBarStatic read FSessionsBarStatic write FSessionsBarStatic;
          property HintPanel : TcxGroupBox  read FHintPanel write FHintPanel;
          property HintLabel : TcxLabel read FHintLabel write FHintLabel;
          property CurrentHintPanelControl : TControl read FCurrentHintPanelControl;
          property OnUpdateMDILayoutButtonsState : TUpdateMDILayoutButtonsStateEvent read FOnUpdateMDILayoutButtonsState write FOnUpdateMDILayoutButtonsState;

          property OnSetHintCaption : TSetHintCaptionEvent read FOnSetHintCaption write FOnSetHintCaption;
          property OnSetupAboutForm : TProcedure read FOnSetupAboutForm write FOnSetupAboutForm;
          property OnSetupMainForm : TSimpleEvent read FOnSetupMainForm write FOnSetupMainForm;
          property OnInitAppModules : TProcedure read FOnInitAppModules write FOnInitAppModules;
          property OnSaveWindowState : TSaveParamsEvent read FOnSaveWindowState write FOnSaveWindowState;
          property OnReadWindowState : TReadParamsEvent read FOnReadWindowState write FOnReadWindowState;
          property OnSaveFieldContent : TFieldContentEvent read FOnSaveFieldContent write FOnSaveFieldContent;
          property OnReadFieldContent : TFieldContentEvent read FOnReadFieldContent write FOnReadFieldContent;
          property OnDeleteWindowState : TDeleteWindowStateEvent read FOnDeleteWindowState write FOnDeleteWindowState;
          property OnSaveQueryConfig : TQueryParamsEvent read FOnSaveQueryConfig write FOnSaveQueryConfig;
          property OnReadQueryConfig : TQueryParamsEvent read FOnReadQueryConfig write FOnReadQueryConfig;

          property OnStartProgression : TStartProgressionEvent read FOnStartProgression write FOnStartProgression;
          property OnShowProgression : TShowProgressionEvent read FOnShowProgression write FOnShowProgression;
          property OnEndProgression : TEndProgressionEvent read FOnEndProgression write FOnEndProgression;

          property OnProcessLog : TProcessLogEvent read FOnProcessLog write FOnProcessLog;

          property OnStart : TProcedure read FOnStart write FOnStart;
          property OnBegin : TProcedure read FOnBegin write FOnBegin;
          property OnEnd : TProcedure read FOnEnd write FOnEnd;

          property OnExchangeSchedulerForm : TProcedure read FOnExchangeSchedulerForm  write FOnExchangeSchedulerForm;
          property OnExchangeDashboardForm : TProcedure read FOnExchangeDashboardForm  write FOnExchangeDashboardForm;
          property OnExchangeWordprocessorForm : TProcedure read FOnExchangeWordprocessorForm  write FOnExchangeWordprocessorForm;

          property OnSetupScheduler : TSimpleEvent read FOnSetupScheduler write FOnSetupScheduler;
          property OnSetupDashboard : TSimpleEvent read FOnSetupDashboard write FOnSetupDashboard;

          property OnShowWebForm : TShowWebProcedure read FOnShowWebForm write FOnShowWebForm;
          property OnShowMailForm : TSimpleEvent read FOnShowMailForm write FOnShowMailForm;
          property OnShowUpgradeForm : TSimpleEvent read FOnShowUpgradeForm write FOnShowUpgradeForm;

          property OnUpdateDatabase : TUpdateDatabaseProcedure read FOnUpdateDatabase write FOnUpdateDatabase;
          property OnInitializeDatabase : TInitializeDatabaseProcedure read FOnInitializeDatabase write FOnInitializeDatabase;
          property OnBackupdatabase : TProcedure read FOnBackupDatabase write FOnBackupDatabase;
          property OnUpdateLookAndFeel : TSimpleEvent read FOnUpdateLookAndFeel write FOnUpdateLookAndFeel;
          property OnExternalReport : TNotifyEvent read FOnExternalReport write FOnExternalReport;

          // Funciones genéricas de otros módulos

          property OnEdicionUsuarios : TProcedure read FOnEdicionUsuarios write FOnEdicionUsuarios;
          end;

       // ---------------------------------------------------------------------

        TgBitBtn = class( TcxButton )
          private

            FGlyphBitmap : TGlyphBitmap;
            FClicked : Boolean;

            procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
            procedure SetGlyphBitmap( const Value : TGlyphBitmap );
          protected
            procedure SetEnabled( Value : Boolean ); override;
            function GetEnabled : Boolean; override;
          public
            constructor Create( AOwner : TComponent ); override;
            procedure Click; override;
            property Clicked : Boolean read FClicked write FClicked;
          published
            property Glyph stored False;
            property GlyphBitmap : TGlyphBitmap read FGlyphBitmap write SetGlyphBitmap default gmNone;
            property Enabled : Boolean read GetEnabled write SetEnabled;
          end;

var     ModulesPrefix : String     = 'gd';   // En Gestwin táctil -por ejemplo- es 'gt'

const   MaxChar               : Char = 'Z';
        MaxDoubleError        : Double = 0.0000001;

        HighestChar           : Char = 'Z';
        ZeroStrCode           : AnsiString = '0000000000000000000000000';
        HighStrCode           : AnsiString = 'ZZZZZZZZZZZZZZZZZZZZZZZZZ';

        St_Punto              = '.';
        St_Suspensivos        = '...';
        St_DosPuntos          = ':';

        KeyMask               = $8000;
        BoolCheckChar         = #149;

        CM_STARTPROCESS        = CM_BASE + 102;
        CM_ERRORNOTIFICATION   = CM_BASE + 103;
        CM_UPDATE              = CM_BASE + 104;

        RoundSize              = 10;

        clBackgroundDefault    = clBtnFace;
        clPanelDefault         = cl3DLight;

        // Menu tags

        mtBarHeight          = 95;
        mtImagenSeccion      = 96;
        mtInformesExternos   = 97;
        mtVentana            = 98;
        mtAyuda              = 99;

        hlpIndex             = 10;

        // Tipos de acceso

        acSinAcceso          = 0;
        acConAcceso          = 1;
        acSoloLectura        = 2;

        FixedSerialNumber    = 13091962;

        OrdZero              = Ord( '0' );

var     LowestDateTime,
        HighestDateTime : TDateTime;

resourceString

        RsGestwin  = 'Gestwin';

        RsgMsg101  = 'Nº de serie : %d-%d-%d';

        RsgMsg104  = 'Procedo a abandonar el programa.';
        RsgMsg105  = 'Está a punto de abandonar la aplicación';
        RsgMsg106  = 'Recuerde : Haga [Color=Maroon][B]COPIAS DE SEGURIDAD[/B][/Color] de sus datos.'#13'Sólo así podrá recuperar la información (y el trabajo realizado) en caso de fallo del equipo.';
        RsgMsg107  = 'INICIO DE SESION';
        RsgMsg108  = 'FIN DE SESION';
        RsgMsg109  = 'Es conveniente que realice una [Color=Maroon][B]COPIA DE SEGURIDAD[/B][/Color] de sus datos.'#13'[B]¿Desea realizar la copia ahora?[/B]';
        RsgMsg110  = 'Su suscripción ha CADUCADO.';
        RsgMsg111  = 'Debe renovarla lo antes posible en [URL=http://www.gestwin.com]nuestra Web[/URL] o directamente a través del teléfono [Color=Gray][B]964460646[/B][/Color].'#13 +
                     'Durante el periodo de caducidad puede seguir utilizando la aplicación normalmente. Una vez expire éste, la aplicación pasará al modo EVALUACIÓN.';

        RsgMsg114  = 'No se ha podido cargar la piel selecionada : %s.';
        RsgMsg115  = 'Revise la configuración de la apariencia en el mantenimiento de usuarios.';

        RsgMsg116  = '¿Esta seguro de que desea abandonar la aplicación?';
        RsgMsg118  = 'Hay un proceso de selección de registros en curso.';
        RsgMsg119  = 'Espere a que finalice (o cancélelo) y reintente la operación.';
        RsgMsg120  = 'Se ha interrumpido el proceso.'#13'Debido al uso de transacciones no deberían haber datos inconsistentes.'#13'Repítalo cuando lo considere oportuno.';
        RsgMsg123  = 'Se ha producido una excepción. El sistema ha devuelto el siguiente mensaje.';
        RsgMsg169  = 'Pulse [Esc] para detener la búsqueda.';
        RsgMsg170  = 'Estructura de fichero de datos no definida.';

        RsgMsg171  = 'Dato necesario. Debe introducir algún valor.';
        RsgMsg172  = 'La información contenida en este campo es indispensable.';

        RsgMsg175  = 'No consigo inicializar el diccionario de datos.';
        RsgMsg176  = ''#13'Tenga en cuenta que también se [B]SUPRIMIRAN TODAS LAS LINEAS[/B] asociadas al registro.';
        RsgMsg178  = '¿Confirma que desea suprimir este registro?';
        RsgMsg179  = '¿Confirma que desea suprimir la línea seleccionada?';
        RsgMsg180  = 'No he conseguido cerrar todas las ventanas.';
        RsgMsg181  = 'Cierre la/s ventanas que originan el problema y reintente la operación.';
        RsgMsg182  = '¿Confirma que desea suprimir TODAS las líneas seleccionadas?';

        RsgMsg200  = '<Desconocido>';

        RsgMsg308  = 'Ha ocurrido un error al intentar actualizar y/o recuperar el registro de cabecera.';
        RsgMsg309  = 'Formato de fecha incorrecto.';

        RsgMsg311  = 'Código inexistente.';
        RsgMsg312  = 'Utilice la opción de consulta [B][F4][/B] para obtener una lista de los códigos disponibles.';
        RsgMsg313  = 'Número de periodo incorrecto.';
        RsgMsg314  = 'Los números de periodo están comprendidos entre 0 (Apertura) y 14 (Cierre).';

        RsgMsg316  = 'Ningun registro seleccionado.';
        RsgMsg317  = 'Ningún registro encontrado.';
        RsgMsg318  = 'Ningún registro cumple las condiciones impuestas o, simplemente, el fichero está vacío.';
        RsgMsg319  = ' en ';

        RsgMsg330  = 'Pulse [B][Esc][/B] para detener el proceso.';
        RsgMsg332  = 'La fecha no pertenece al ejercicio en curso.';
        RsgMsg333  = 'Puede cambiar de ejercicio activo para introducir registros de ejercicios anteriores o posteriores.';
        RsgMsg334  = '¿Desea suprimir todos los datos pertenecientes a esta Empresa?';
        RsgMsg335  = 'No he conseguido crear un directorio para esta Empresa.';
        RsgMsg336  = 'Puede que su disco esté lleno o no tenga acceso al mismo. Se cancela el proceso de creación de la nueva Empresa.';
        RsgMsg337  = 'Solo el super-usuario puede realizar este tipo de operaciones.';
        RsgMsg338  = 'Póngase en contacto con su soporte técnico para obtener más información.';

        RsgMsg341  = 'El texto contiene caracteres no validos.';
        RsgMsg342  = 'Los caracteres permitidos son "A..Z", "0..9","-","_","(" y ")".';

        RsgMsg352  = 'Este registro no pertenece al ejercicio en curso.';
        RsgMsg353  = 'Si desea editarlo cambie de ejercicio activo.';
        RsgMsg354  = 'Valor no válido.';
        RsgMsg355  = 'Seleccione una de las opciones mostradas.';
        RsgMsg356  = 'El valor introducido no es válido.';

        RsgMsg361  = 'Se cancela el proceso.';

        RsgMsg370  = 'El fichero pertenece (probablemente) a una versión anterior.'#13'Se va ha activar el [B]CONTROL AUTOMATICO DE VERSIONES[/B].';
        RsgMsg371  = 'El fichero [B]%s[/B] no existe en el diccionario de la última versión reconocida.';
        RsgMsg372  = 'Formato de hora incorrecto.';
        RsgMsg373  = 'El formato correcto es [B]HH:MM:SS[/B]. Por ejemplo 12:30:06 equivale a 12 horas, 30 minutos y 6 segundos.';

        RsgMsg381  = 'No existe ningún registro que tenga la clave especificada.';

        RsgMsg394  = 'Directorio no válido.';
        RsgMsg395  = 'Seleccione un directorio válido pulsando el botón [Examinar ...].';
        RsgMsg396  = 'Falta completar los datos de la ficha.';
        RsgMsg397  = 'Falta completar los datos de la clave.';
        RsgMsg398  = 'Para poder editar o crear una ficha nueva debe completar todos los datos solicitados en el área de clave.';
        RsgMsg399  = 'Palabra de paso incorrecta.';
        RsgMsg400  = 'Acceso denegado.';
        RsgMsg401  = '¿Está seguro de que quiere interrumpir el proceso?';
        RsgMsg402  = 'Ficheros globales de la aplicación';
        RsgMsg403  = 'Los ficheros han sido correctamente actualizados.';
        RsgMsg404  = 'Vuelva a acceder de nuevo al programa para proseguir con su sesión de trabajo.';
        RsgMsg405  = 'Ficheros maestros e inter-anuales';

        RsgMsg408  = 'Error irrecuperable de inicialización.';
        RsgMsg409  = 'Proceso interrumpido.';
        RsgMsg410  = 'Este código está siendo utilizado por otro usuario.';
        RsgMsg411  = 'Utilice un código alternativo o libere el bloqueo.';
        RsgMsg412  = 'No se ha podido crear un nuevo registro automático.';
        RsgMsg413  = 'Esta aplicación o módulo no puede actualizar el diccionario.';
        RsgMsg414  = 'Se procede a abandonar la aplicación.'#13'[Color=Maroon]Notifique a su proveedor este extremo.[/Color]';

        RsgMsg427  = '¿Esta seguro de que desea crear una copia del registro actual?';
        RsgMsg428  = 'Se ha producido un error durante la copia de el/los registro/s.';

        RsgMsg430  = 'No consigo recuperar el registro a copiar.';
        RsgMsg431  = 'No tiene el acceso permitido a esta sección de la aplicación.';

        RsgMsg435  = 'El proceso se ha realizado correctamente.';
        RsgMsg436  = 'Se ha interrupido el proceso debido a un error.';
        RsgMsg437  = 'Puesto que en todos los procesos de la aplicación se utilizan transacciones [B]no debería haber ningún tipo de información inconsistente[/B].'#13'Reintente el proceso cuando lo considere oportuno.';

        RsgMsg444  = 'No se puede modificar este registro.';
        RsgMsg445  = 'No le esté permitido realizar inserciones (altas).';
        RsgMsg446  = 'Compruebe que todos los campos del área de clave son correctos.';
        RsgMsg447  = 'La versión de la librería principal no coincide con la esperada.';
        RsgMsg448  = 'La reinstalación de la aplicación puede solucionar el problema.';
        RsgMsg449  = 'La versión de un módulo de la aplicación no coincide con la esperada.';
        RsgMsg450  = 'Se procederá a la actualización en línea (desde Internet) de dichos módulos.';

        RsgMsg500  = 'Solo se pueden situar los FormManagers en TgForms.';
        RsgMsg501  = 'Solo puede existir un FormManager en un Form.';

        RsgMsg521  = 'No ha sido asignado previamente el conjunto de datos (Dataset).';

        RsgMsg534  = 'La clave activa de la tabla [B]%s[/B] tiene un número diferente de segmentos';

        RsgMsg1015 = 'Si';
        RsgMsg1016 = 'No';

        RsgMsgTodos= '<Todos>';
        RsgMsgTodas= '<Todas>';
        RsgNinguno = '<Ninguno>';
        RsgNinguna = '<Ninguna>';
        RsgCualquiera = '<Cualquiera>';
        RsInexistente = '<Inexistente>';
        RsRegistroInexistente = '< Registro inexistente >';
        RsEmptyQuotes = '''''';
        RsMeses = '"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"';

        // RsSupportPage = 'http://www.gestwin.net/index.php?option=com_content&task=view&id=27&Itemid=55';

        _RsCopyRight = 'Copyright © 1989-%d WinStation, S.L.';

        DefaultSkinName = 'Gestwin';
        DefaultSkinPaletteName = 'Plastic Space';

const   StPeriodo         : array[ 0..14 ] of String = ( '<Apertura>',
                                                         'Enero',
                                                         'Febrero',
                                                         'Marzo',
                                                         'Abril',
                                                         'Mayo',
                                                         'Junio',
                                                         'Julio',
                                                         'Agosto',
                                                         'Septiembre',
                                                         'Octubre',
                                                         'Noviembre',
                                                         'Diciembre',
                                                         '<Regularización>',
                                                         '<Cierre>' );

var      RsCopyRight : String;

         ProcessInformation : TProcessInformation;  // Información sobre el último proceso iniciado con ProcessExecute

function StrMonth( NroPeriodo : Byte; Short : Boolean = False ) : String;
function StrToDate( St : String; var Date : TDateTime; DateFormat : TDateFormat = dfDefault2 ) : Boolean; overload;

function IsValidDate( Day, Month, Year : Word; CurrentYear : Boolean; var InvalidYear : Boolean ) : Boolean; overload;
function IsValidYear( Day, Month, Year : Word; ReferenceYear : Word = 0 ) : Boolean; overload;
function IsValidYear( ADate : TDateTime; ReferenceYear : Word = 0 ) : Boolean; overload;

procedure PrgRestart;
procedure FatalError ( Msg : String );
procedure CompruebaAccesoLocal;    // Comprueba si la aplicación y la Empresa activa acceden a los datos de forma local

function EjercicioActual( Date : TDateTime ) : Boolean;
procedure CompruebaEjercicio( Date : TDateTime );
function FechaPrimerDiaEjercicio( Ejercicio : SmallInt = 0 ) : TDateTime;
function FechaUltimoDiaEjercicio( Ejercicio : SmallInt = 0 ) : TDateTime;
function EjercicioFecha( ADate : TDateTime) : SmallInt;

function ObtenDC( Codigo : String ) : Char;
function CheckAccessLevel( IArray : array of LongInt ) : LongInt;

procedure ShowHelp;
procedure ShowHelpForm( HelpFileName, Topic : String; IsAMenuEvent : Boolean = False );

procedure KeyEvent( Key : Word; Shift : TShiftState = [] );

function  CalculaPorcentaje( Valor1, Valor2 : Double; RangoAjustado : Boolean = False ) : SmallInt;
// function  FloatDisplayFormat( DecimalPlaces : ShortInt ) : String;

function IsBarItemVisible( BarItem : TdxBarItem ) : Boolean;
procedure SetBarItemVisible( BarItem : TdxBarItem; Value : Boolean );
procedure SetBarItemsVisible( BarItems : array of TdxBarItem; Value : Boolean = True);
function  FindMenuItemByTag( MainMenuBar : TdxBar; MenuTag : LongInt ) : TdxBarItem;

procedure SetMDIChildFormsIcon( BorderIcons : TBorderIcons );

function  ApplicationContainer : TApplicationContainer;

implementation

{$R *.dfm}

Uses    CommCtrl,
        Consts,
        Math,
        IniFiles,
        TypInfo,
        Variants,
        Registry,
        ShellAPI,
        ShellAnimations,
        ClipBrd,

        dxRichEdit.Rtf,

        MsgFrame,

        Files,
        StrUtils,
        DateUtils,
        TextConvert,

        ShlObj,
        WebBrowser,

        PrintPreviewWindow,
        dxBevel,
        dxSkinsStrs,
        dxCalendarUtils,

        b_abo,
        b_msg,
        b_win,
        b_tcn;

var     FContainer : TApplicationContainer = nil;

resourceString
        RsMsg1  = 'El número de aplicación no coincide con el esperado.';
        RsMsg2  = 'La reinstalación de GESTWIN puede solucionar el problema.'#13'Si éste persiste, contacte con su distribuidor.';
        RsMsg3  = 'Menú de secciones de la aplicación';
        RsMsg4  = 'Este componente debe colocarse en un MDI Form.';
        RsMsg5  = 'No se puede convertir este valor (VarRec a Variant).';
        RsMsg6  = 'No puede realizar este proceso desde una localización remota';
        RsMsg7  = 'Este tipo de procesos deben realizarse desde el equipo principal para poder tener acceso directo a los datos.';
        RsMsg8  = '¿Está seguro de que desea cerrar todas las ventanas existentes?';
        RsMsg9  = 'La opción que acaba de seleccionar requiere cerrar todas las ventanas y procesos.'#13'Si hay algún registro pendiente de validación se cancelará el cierre automático.';
        RsMsg10 = '¿Está seguro de que desea cerrar la aplicación y comprobar si existe alguna actualización?';
        RsMsg11 = 'Asegúrese de que ningún otro usuario está utilizando GESTWIN para evitar conflictos durante el proceso de actualización.';
        RsMsg12 = 'La base de datos necesita ser actualizada o no es compatible con la aplicación.';
        RsMsg13 = 'Actualice o ajuste la base de datos para que puede ser utilizada por esta aplicación.';
        RsMsg14 = 'No existe una nueva versión.';
        RsMsg15 = 'Tiene la última versión disponible y no es necesario realizar ninguna actualización.';
        RsMsg16 = 'No se ha podido realizar la comprobación.';
        RsMsg17 = 'Puede que el servidor esté demasiado ocupado o que su conexión a Internet no esté activa.'#13'El sistema de comprobación de actualizaciones utiliza el mismo puerto que el Navegador de Internet para comunicarse con el servidor.';
        RsMsg18 = 'La aplicación ha sido desactivada por un error grave.<br/n>Abandone la aplicación, solucione el problema, y reintente la ejecución.';


function ApplicationContainer : TApplicationContainer;
begin
     If   not Assigned( FContainer )
     then FContainer := TApplicationContainer.Create( nil );
     Result := FContainer;
end;

// EMsgBoxException

constructor EMsgBoxException.Create( NotificationType: TNotificationType; Msg, Description: String );
begin
     inherited Create( Msg );
     FNotificationType := NotificationType;
     FDescription := Description;
end;

procedure SetBarItemVisible( BarItem : TdxBarItem;
                             Value   : Boolean );
begin
     If   Assigned( BarItem )
     then With BarItem do
            If   Value
            then Visible := ivAlways
            else Visible := ivNever;
end;

procedure SetBarItemsVisible( BarItems : array of TdxBarItem;
                              Value    : Boolean = True );

var  I : SmallInt;

begin
     For I := 0 to High( BarItems ) do
       If   Assigned( BarItems[ I ] )
       then With BarItems[ I ] do
              If   Value
              then Visible := ivAlways
              else Visible := ivNever;
end;

function IsBarItemVisible( BarItem : TdxBarItem ) : Boolean;
begin
     Result := BarItem.Visible = ivAlways;
end;

procedure SetMDIChildFormsIcon( BorderIcons : TBorderIcons );

var  I : SmallInt;

begin
     If   Assigned( Application.MainForm ) and not ApplicationContainer.TDI
     then If   Application.MainForm.FormStyle=fsMDIForm
          then For I := 0 to Application.MainForm.MDIChildCount - 1 do
                 If   Application.MainForm.MDIChildren[ I ].BorderIcons<>[ biSystemMenu ] // Si tiene solo el SystemMenu es porque es una venatana de listado o proceso
                 then Application.MainForm.MDIChildren[ I ].BorderIcons := BorderIcons;
end;

// TApplicationContainer ----------------------------------------------------------

constructor TApplicationContainer.Create( AOwner : TComponent );
begin

     inherited Create( AOwner );

     FContainer := Self;

     If   not IsDesignTime
     then begin

          CreateDirPath( ApplicationDataDirectory );

          TodayDate := Date;
          Today30DaysAgoDate := SysUtils.IncMonth( TodayDate, -1 );

          Ejercicio := YearOf( TodayDate );

          LowestDateTime := EncodeDate( 1, 1, 1 );
          HighestDateTime := EncodeDate( 3000, 12, 31 );

          FModuleNamesList := TStringList.Create;
          FOptionalModuleNamesList := TStringList.Create;
          FModuleList := TList.Create;
          FAppSectionList := TList.Create;
          FAppSectionCount := 0;
          FReportList := TList.Create;
          FEditFormList := TFormList.Create;
          FCurrentSection := nil;
          FShowDashboard := True;

          IsMenuBarActive := True;
          // CabeceraEmpresa := UpperCase( RsGestwin ) + '  ';
          RsCopyRight := Format( _RsCopyRight, [ YearOf( Now ) ] );

          RegRootKey := 'Software\Gestwin\' + Application.Title;
          SimTabWithKeyPad := False;
          ExtendedSelections := False;
          ReportUnderline := False;
          ReportTitleBarColor := clGray;

          CustomLookAndFeel := False;
          LookAndFeelKind := cxDefaultLookAndFeelKind;

          AppUseSkins := False;
          AppSkinName := '';
          AppSkinPalette := '';
          LoadedSkinName := '';
          LoadedSkinPalette := '';

          // Esto evita que no se atenúen las imágenes desactivadas cuando se usan pieles (ver bug report de DevExpress)

          TdxVisualRefinements.UseDisabledSkinPaletteForSVG := False;

          FCurrentMDILayout := mdiNone;

          {$IFDEF APPSECTIONSPANEL}
          FAppSectionPanelOffset := 1;
          {$ENDIF}
          end;
end;

procedure TApplicationContainer.HandleException(Sender: TObject);
begin

end;

destructor TApplicationContainer.Destroy;
begin
     If   not IsDesignTime
     then try
            FreeAndNil( FAppSectionList );
            FreeAndNil( FReportList );
            FreeAndNil( FEditFormList );
            FreeAndNil( FModuleList );
            FreeAndNil( FModuleNamesList );
            FreeAndNil( FOptionalModuleNamesList );
          except on E : Exception do ShowException( E, nil );
            end;

     inherited Destroy;
end;

procedure TApplicationContainer.StartProgression( AMaxRecordCount : Integer = 100;
                                                  Cancelable      : Boolean = True;
                                                  Doc             : TComponent = nil );
begin
     if   Assigned( FOnStartProgression )
     then FOnStartProgression( AMaxRecordCount, Cancelable, Doc );
end;

procedure TApplicationContainer.ShowProgression( ProgMessage : String = '' ;
                                                 Percent     : Integer = -1 );
begin
     If   Assigned( FOnShowProgression )
     then FOnShowProgression( ProgMessage, Percent );
end;

procedure TApplicationContainer.EndProgression( Cancel : Boolean = False );
begin
     If   Assigned( FOnEndProgression )
     then FOnEndProgression( Cancel );
end;

procedure TApplicationContainer.AlertWindowManagerButtonClick(Sender: TObject; AAlertWindow: TdxAlertWindow; AButtonIndex: Integer);
begin
     If   AButtonIndex=0
     then ClipBoard.AsText := TextConverter.ToPlaintext( AAlertWindow.MessageList[ AAlertWindow.CurrentMessageIndex ].Text );
end;

procedure TApplicationContainer.AlertWindowsVisible( ShowWindows : Boolean );

var  I : SmallInt;

begin
     For I := 0 to ApplicationContainer.AlertWindowManager.Count - 1 do
       ApplicationContainer.AlertWindowManager.Items[ I ].Visible := ShowWindows;
end;

procedure TApplicationContainer.ProcessLog( Caption,
                                            Msg         : String;
                                            Tipo        : TTipoRegistroDiarioProcesos = trdGenerico;
                                            ValorOpcion : SmallInt = 0 );
begin
     If   Assigned( FOnProcessLog)
     then FOnProcessLog( Caption, Msg, Tipo, ValorOpcion );
end;

function TApplicationContainer.TryToCloseAll( CloseDataModules : Boolean = True;
                                              ShowMessage      : Boolean = True ) : TModalResult;
begin
     Result := CanCloseAllForms( ShowMessage );
     If   Result=mrOk
     then try
            CloseAllReports;
            If   CloseDataModules
            then CloseAllDataModules;
          except
            Result := mrAbort;
            end;
end;

function  TApplicationContainer.CanCloseAllForms( ShowMessage : Boolean = True ) : TModalResult;

var   I,
      MinChildCount : SmallInt;
      MDIForm : TForm;
      St : String;

begin
     Result := mrOk;
     try

       FTryingToCloseAllForms := True;

       try

       If   RunningProcess and not DatabaseUpdateRequested
       then ShowNotification( ntStop, RsgMsg118, RsgMsg119 )
       else If   Assigned( Application.MainForm )
            then With Application.MainForm do
                   If   MDIChildCount>0
                   then begin

                        MinChildCount := 1;

                        If   ApplicationContainer.SchedulerActive
                        then Inc( MinChildCount );

                        If   ApplicationContainer.DashboardActive
                        then Inc( MinChildCount );

                        If   ApplicationContainer.WordprocessorActive
                        then Inc( MinChildCount );

                        If   ShowMessage and ( MDIChildCount>MinChildCount ) // Si hay más de una ventana abierta, se muestra un aviso
                        then If   ShowNotification( ntQuestionWarning, RsMsg8, RsMsg9 )<>mrYes
                             then begin
                                  Result := mrCancel;
                                  Exit;
                                  end;

                        // Primero cierro los previews y ventanas vinculadas con otras

                        For I := MDIChildCount - 1 downto 0 do
                           begin
                           If   Assigned( MDIChildren[ I ] )
                           then begin
                                MDIForm := TForm( MDIChildren[ I ] );
                                With MDIForm do
                                  If   not ( csDestroying in ComponentState ) and ( MDIForm<>CurrentClosingForm )
                                  then If   MDIForm is TPrintPreview
                                       then begin
                                            Close;
                                            Free;
                                            end;
                                end;
                           end;

                        // Y luego el resto

                        For I := MDIChildCount - 1 downto 0 do
                           begin
                           If   Assigned( MDIChildren[ I ] )
                           then begin
                                MDIForm := TForm( MDIChildren[ I ] );
                                With MDIForm do
                                  If   not ( csDestroying in ComponentState ) and ( MDIForm<>CurrentClosingForm )
                                  then If   CloseQuery
                                       then begin
                                            Close;
                                            Free;  // Necesito que sea inmediato, por eso no utilizo Release
                                            end
                                       else begin
                                            Result := mrAbort;
                                            Exit;
                                            end;
                                end;
                           end;

                        CloseAllReports;
                        end;

       except
         Result := mrAbort;
         end;

     finally
      FTryingToCloseAllForms := False;
     end;
end;

procedure TApplicationContainer.CheckUpgradeTimerTimer(Sender: TObject);
begin

     // Solo permanece visible durante un minuto. Luego oculto el botón para que no moleste.

     SetBarItemVisible( FUpgradeButton, False );
     CheckUpgradeTimer.Enabled := False;

end;

procedure TApplicationContainer.CloseAllReports;

var   I : SmallInt;

begin
     If   Assigned( ReportList )
     then With ReportList do
            begin
            Pack;
            I := Count - 1;
            while I>=0 do
              begin
              With TComponent( Items[ I ] ) do
                If   not ( csDestroying in ComponentState )
                then Free;
              Dec( I );
              end;
            Clear;
            end;
end;

procedure TApplicationContainer.CloseReport( AReport : TComponent );

var   I : SmallInt;

begin
     try
       If   Assigned( ReportList )
       then With ReportList do
              For I := 0 to Count - 1 do
                If   Items[ I ]=AReport
                then begin
                     AReport.Free;
                     Pack;
                     Break;
                     end;
     except
       end;
end;

function TApplicationContainer.SaveWindowState( AForm      : TForm;
                                                ParamList  : TStringList;
                                                SaveLayout : Boolean = False ) : Boolean;
begin
     If   Assigned( FOnSaveWindowState )
     then Result := FOnSaveWindowState( AForm, ParamList, SaveLayout )
     else Result := False;
end;

function  TApplicationContainer.ReadFieldContent( AForm       : TForm;
                                                  EditControl : TcxCustomEdit;
                                                  ParamList   : TStringList ) : Boolean;
begin
     If   Assigned( FOnReadFieldContent )
     then Result := FOnReadFieldContent( AForm, EditControl, ParamList )
     else Result := False;
end;

function  TApplicationContainer.SaveFieldContent( AForm       : TForm;
                                                  EditControl : TcxCustomEdit;
                                                  ParamList   : TStringList ) : Boolean;
begin
     If   Assigned( FOnSaveFieldContent )
     then Result := FOnSaveFieldContent( AForm, EditControl, ParamList )
     else Result := False;
end;

function TApplicationContainer.ReadWindowState( AForm     : TForm;
                                                ParamList : TStringList ) : Boolean;
begin
     If   Assigned( FOnReadWindowState )
     then Result := FOnReadWindowState( AForm, ParamList )
     else Result := False;
end;

function TApplicationContainer.DeleteWindowState( AForm         : TForm;
                                                  ConfigRegType : TConfigRegType = ctParametrosVentana ) : Boolean;
begin
     If   Assigned( FOnDeleteWindowState )
     then Result := FOnDeleteWindowState( AForm, ConfigRegType )
     else Result := False;
end;

function TApplicationContainer.SaveQueryConfig( QueryPanel : TcxGroupBox ) : Boolean;
begin
     If   Assigned( FOnSaveQueryConfig )
     then Result := FOnSaveQueryConfig( QueryPanel )
     else Result := False;
end;

function TApplicationContainer.ReadQueryConfig( QueryPanel : TcxGroupBox ) : Boolean;
begin
     If   Assigned( FOnReadQueryConfig )
     then Result := FOnReadQueryConfig( QueryPanel )
     else Result := False;
end;

function TApplicationContainer.GetReportList : TList;
begin
     Result := FReportList;
end;

function TApplicationContainer.GetEditFormList : TFormList;
begin
     Result := FEditFormList;
end;

procedure TApplicationContainer.ApplyTDI;
begin
     If   Assigned( FTabbedMDIManager )
     then FTabbedMDIManager.Active := FTDI;
end;

procedure TApplicationContainer.LockClientWindowUpdate;
begin
     If   fLockClientWindowUpdateCount=0
     then SendMessage( Application.MainForm.ClientHandle, WM_SETREDRAW, 0, 0 );
     Inc( FLockClientWindowUpdateCount ) ;
 end;

 procedure TApplicationContainer.UnlockClientWindowUpdate;
 begin
      Dec( FLockClientWindowUpdateCount );
      If   fLockClientWindowUpdateCount=0
      then begin
           SendMessage( Application.MainForm.ClientHandle, WM_SETREDRAW, 1, 0 );
           RedrawWindow( Application.MainForm.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_NOINTERNALPAINT );
           end
 end;

procedure TApplicationContainer.LoadAppModules;

var   ProcessInformation : TProcessInformation;
      ModuleName : String;
      I : SmallInt;

begin
       // Primero cargo los módulos principales ...

       If   AppShortName<>''
       then try

              ExtractStrings( [ ',' ], [], PChar( DefaultModules ), FModuleNamesList );

              // Es responsabilidad de cada módulo añadirse a la lista de procedimientos de inicialización

              For I := 0 to FModuleNamesList.Count - 1 do
                begin
                ModuleName := ModulesPrefix + 'm' + FModuleNamesList.Strings[ I ] + '.bpl';
                AddModule( LoadPackage( ApplicationPath + ModuleName ) );
                end;

              If   ( VersionInfo.MajorVersion<>ProgramVersion ) or
                   ( VersionInfo.MinorVersion<>ProgramRelease )
              then begin
                   ShowNotification( ntStop, RsgMsg447, RsgMsg448 );
                   PrgExit( False, True );
                   Abort;
                   end;

              // Y luego las opciones ... lo mismo

              ExtractStringList( OptionalModules, FOptionalModuleNamesList );

              For I := 0 to FOptionalModuleNamesList.Count - 1 do
                begin
                var ModuleNumberStr := FOptionalModuleNamesList.Strings[ I ];
                If   not ExistsModuleName( ModuleNumberStr ) and  // No está duplicado
                     ( ModuleNumberStr<>'206' )                   // Ya no existe, pero puede estar incluído en el fichero de configuración
                then begin
                     ModuleName := ApplicationPath + ModulesPrefix + 'm' + ModuleNumberStr + '.bpl';
                     If   FileExists( ModuleName )
                     then AddModule( LoadPackage( ModuleName ) );
                     end;
                end;

            except on E : Exception do
              begin
              ShowNotification( ntStop, RsgMsg449, 'Mensaje de Error : ' + E.Message + ''#13''#13'' + RsgMsg450  );
              ProcessExecute( ProcessInformation, ApplicationPath + 'GdUpd.exe ' + AppShortName );
              InitializationError := True;
              Application.Terminate;
              Abort;
              end;
            end;
end;

procedure TApplicationContainer.RegisterProgram( AppForm : TForm = nil );

var  MainWndHandle  : HWnd;

begin
     If   AppShortName<>''
     then begin
          If   not Assigned( AppForm )
          then AppForm := Application.MainForm;
          ReadIniFile;
          Application.Title := RsGestwin + AppShortName;
          ShowMainFormCaption( Application.Title );
          If   not Restarting
          then CheckInstance( AppForm, AllowMultipleInstances );
          LogMessage( RsgMsg107 );
          end;
end;

procedure TApplicationContainer.LogMessage( Msg : String );
begin
     AppManager.LogMessage( CodigoEmpresaActual + ' - ' + CodigoUsuarioActual + ' : ' + CleanStr( Msg ) );
end;

procedure TApplicationContainer.DisableApplication;
begin
     ShowNotification( ntExceptionError, RsMsg18 );
     If   Assigned( Application.MainForm )
     then Application.MainForm.Enabled := False;
end;

procedure TApplicationContainer.ShowAboutForm( Modal : Boolean );
begin
     FStartTimeDelay := Time;
     AboutForm := TAboutForm.Create( Application.MainForm, { Interactive } Modal );
     If   Assigned( AboutForm )
     then With AboutForm do
            begin

            If   Assigned( FOnSetupAboutForm )
            then FOnSetupAboutForm;

            If   Modal
            then begin
                 try
                   ShowApplicationLicense;
                   ShowModal;
                 finally
                   Free;
                   end;
                 end
            else begin
                 Show;
                 Application.ProcessMessages;
                 end;

          end;
end;

procedure TApplicationContainer.HideAboutForm;

var   CurrentTime : TDateTime;

begin
     If   Assigned( AboutForm )
     then begin

          // Dejemos que se vea la ventana de presentación un ratito más

          If   not ( fsModal in AboutForm.FormState )
          then repeat
                 CurrentTime := Time;
                 Application.ProcessMessages;
               until CurrentTime - FStartTimeDelay>0.00002;

          AboutForm.Release;
          AboutForm := nil;
          end;
end;

procedure TApplicationContainer.HideHintPanel;
begin
     If   Assigned( MainInfoPanel ) and Assigned( FHintPanel )
     then FHintPanel.Visible := False;
end;

procedure TApplicationContainer.HintStyleControllerShowHint(     Sender   : TObject;
                                                             var HintStr  : String;
                                                             var CanShow  : Boolean;
                                                             var HintInfo : THintInfo );
begin
     HintStr := StringReplace( HintStr, '\n', #13, [ rfReplaceAll, rfIgnoreCase ] )
end;

procedure TApplicationContainer.SetCurrentMDILayout( const Value : TMDILayout );

var  BorderIcons : TBorderIcons;

begin
     If   FCurrentMDILayout<>Value
     then begin
          BorderIcons := [ biMaximize, biSystemMenu ];
          If   Value=mdiNone
          then BorderIcons := BorderIcons + [ biMinimize ];
          SetMDIChildFormsIcon( BorderIcons );
          If   Assigned( FOnUpdateMDILayoutButtonsState )
          then FOnUpdateMDILayoutButtonsState( Value );
          end;
     FCurrentMDILayout := Value;
end;

procedure TApplicationContainer.SetHintPanelCaption( HintControl : TControl;
                                                     Value       : String );
begin
     If   not ReleasingApplication
     then begin

          Value := StringReplace( Value, '\n', ' ' { #13 }, [ rfReplaceAll ] );
          If   Value<>HintLabel.Caption
          then begin
               FCurrentHintPanelControl := HintControl;
               HintLabel.Caption := Value;
               end;

          If   Assigned( MainInfoPanel ) and Assigned( FHintPanel )
          then begin
               FHintPanel.Invalidate;
               FHintPanel.Visible := True;
               end;

          end;
end;

procedure TApplicationContainer.ShowAlert( ACaption,
                                           AText      : String;
                                           ATag       : SmallInt;
                                           AImageIndex: TcxImageIndex = -1 );

var   AlertWindow : TdxAlertWindow;
const ValorPosicionAlertas : Array[ 0..3 ] of TdxAlertWindowPosition = ( awpTopRight, awpBottomRight, awpBottomLeft, awpTopLeft );

begin

     // Si el último aviso era del mismo tipo evito acumularlos

     With AlertWindowManager do
       If   Count>0
       then begin
            AlertWindow := Items[ Count - 1 ];
            If   AlertWindow.Tag=ATag
            then Close( AlertWindow );
            end;

     If   PosicionAlertas in [ 0..3 ]
     then AlertWindowManager.WindowPosition := ValorPosicionAlertas[ PosicionAlertas ];

     AlertWindow := AlertWindowManager.Show( ACaption, AText, AImageIndex );
     AlertWindow.Tag := ATag;
     If   AlertasPermanentes
     then AlertWindow.Pinned := True;
     MessageBeep( mb_iconWarning );
end;

procedure TApplicationContainer.HideAlerts( Tags : TAlertWindowsTags = [] );

var  Index : SmallInt;
     AlertWindow : TdxAlertWindow;

begin
     With AlertWindowManager do
       begin
       Index := Count - 1;
       While Index>=0 do
         begin
         AlertWindow := Items[ Index ];
         If   ( Tags=[] ) or ( AlertWindow.Tag in Tags )
         then Close( AlertWindow );
         Dec( Index );
         end;
       end;
end;

procedure TApplicationContainer.ShowApplicationLicense;
begin
     If   Assigned( AboutForm )
     then AboutForm.ShowInfoMessage;
end;

procedure TApplicationContainer.AddModule( Handle : HMODULE );
begin
     FModuleList.Add( Pointer( Handle ) );
end;

procedure TApplicationContainer.UnLoadAppModules;

var   I : SmallInt;

begin
     With FModuleList do
       For I := Count - 1 downto 0 do
         UnloadPackage( THandle( Items[ I ] ) );
end;

function  TApplicationContainer.ExistsModuleName( Name : String ) : Boolean;
begin
     Result := FModuleNamesList.IndexOf( Name )<>-1;
end;

function  TApplicationContainer.ExistsOptionalModuleName( Name : String ) : Boolean;
begin
     Result := FOptionalModuleNamesList.IndexOf( Name )<>-1;
end;

procedure TApplicationContainer.InitializeAppModules( AppNumber         : Word;
                                                      MainSectionsArray : array of Integer );

var  I,
     SectionIndex,
     NumOfModules : SmallInt;
     SectionsIA,
     OptionalSectionsIA : TIntegerArray;
     ProcItem : TProcedureItem;

begin
     If   AppNumber=ProgramNumber
     then begin

          SectionsIA := ExecuteProcedures( imSectionModule, MainSectionsArray );
          OptionalSectionsIA := ExecuteProcedures( imOptionalSectionModule, [] );

          // ActiveModules contiene los IDs de los modulos principales y de todos los módulos opcionales.
          // Para añadir un módulo a la lista hay que llamar a la función 'AddProcedure(  imSectionModule | imOptionalSectionModule, <NroModulo>, SectionSetup );'

          ActiveModules := SectionsIA;
          SectionIndex := High( ActiveModules ) + 1;
          With ProcedureList do
            For I := 0 to Count - 1 do
              begin
              ProcItem := TProcedureItem( Items[ I ] );
              If   Assigned( ProcItem )
              then With ProcItem do
                     If   ItemType=imOptionalSectionModule
                     then begin
                          SetLength( ActiveModules, SectionIndex + 1 );
                          ActiveModules[ SectionIndex ] := ID;
                          Inc( SectionIndex );
                          end;
              end;

          end
     else begin
          ShowNotification( ntStop, RsMsg1, RsMsg2 );
          PrgExit( False, True );
          end;
end;


function TApplicationContainer.IsModuleActive( ModuleID : array of Integer ) : Boolean;

var  Index1,
     Index2  : SmallInt;

begin
     {$IFDEF DEBUGAPP}
     Result := True;
     {$ELSE}
     Result := False;
     For Index1 := 0 to High( ActiveModules ) do
       For Index2 := 0 to High( ModuleID ) do
         If   ActiveModules[ Index1 ]=ModuleID[ Index2 ]
         then begin
              Result := True;
              Break;
              end;
     {$ENDIF}
end;

procedure TApplicationContainer.AddAppSection( AnAppSection : TgAppSection );

var  I : SmallInt;

begin
     If   Assigned( FAppSectionList )
     then begin
          If   AnAppSection.SetupSection
          then FAppSectionList.Add( AnAppSection )
          else begin
               FAppSectionList.Insert( FAppSectionCount, AnAppSection );
               Inc( FAppSectionCount );
               end;
          end;
end;

procedure TApplicationContainer.InitializeAppSections;

var   I : SmallInt;
      AppSection : TgAppSection;
      SectionMenuBar : TdxBar;

begin

     If   Assigned( FAppSectionList ) and
          Assigned( FAppSectionsPopupMenu )
     then With FAppSectionList do
            begin

            For I := 0 to Count - 1 do
              begin
              AppSection := TgAppSection( Items[ I ] );
              If   Assigned( AppSection )
              then begin

                   If   Assigned( Application.MainForm ) and not AppSection.Hidden
                   then begin
                        {$IFDEF APPSECTIONSPANEL}
                        AddAppSectionPanelItem( AppSection );
                        {$ELSE}
                        AddAppSectionPopupItem( AppSection );
                        {$ENDIF}
                        end;

                   AppSection.DoOnInitialize;

                   If   Assigned( FMainBarManager ) and
                        Assigned( AppSection.MainMenuBar )
                   then begin

                        AppSection.MainMenuBar.Visible := False;

                        SectionMenuBar := FMainBarManager.AddToolBar( True );

                        SectionMenuBar.Assign( AppSection.MainMenuBar );
                        SectionMenuBar.Row := 1;
                        SectionMenuBar.IsMainMenu := False;
                        SectionMenuBar.UseRestSpace := True;
                        SectionMenuBar.Multiline := False;
                        SectionMenuBar.OneOnRow := False;
                        SectionMenuBar.WholeRow := False;
                        SectionMenuBar.Visible := False;

                        AppSection.MainMenuBar := SectionMenuBar;

                        end
                   end;
              end;

            end;
end;

function TApplicationContainer.SectionExists( ID : SmallInt ) : Boolean;

var   I : SmallInt;
      AppSection : TgAppSection;

begin
     Result := False;
     If   Assigned( FAppSectionList )
     then With FAppSectionList do
            For I := 0 to Count - 1 do
              If   TComponent( Items[ I ] ).Tag=ID
              then begin
                   Result := True;
                   Exit;
                   end;
end;

procedure TApplicationContainer.UpdateAppSections( LockSectionsAccess : Boolean = False;
                                                   UpdateMenus        : Boolean = True );

var   I : SmallInt;
      AppSection : TgAppSection;
      SectionSelected : Boolean;

begin

     If   not FUpdatingAppSections
     then begin

          FUpdatingAppSections := True;

          try

            SectionsButton.Enabled  := True;

            With FAppSectionList do
              begin
              SectionSelected := False;
              For I := Count - 1 downto 0 do
                 If   Assigned( Items[ I ] )
                 then begin
                      AppSection := TgAppSection( Items[ I ] );
                      If   Assigned( AppSection.SectionsMenuItem )
                      then With AppSection do
                             begin

                             // Primero pregunto si este usuario tiene alguna restricción o,
                             // si estoy bloqueando el acceso a las opciones de usuario, las
                             // deshabilito directamente

                             If   LockSectionsAccess
                             then SectionsMenuItem.Enabled := False
                             else If   Assigned( OnSetAccess )
                                  then begin
                                       Enabled := OnSetAccess;
                                       SectionsMenuItem.Enabled := Enabled;
                                       If   Enabled
                                       then If   Assigned( OnSetUSerOption )
                                            then If   OnSetUSerOption
                                                 then begin
                                                      SelectAppSection( AppSection );
                                                      SectionSelected := True;
                                                      end;
                                       end;

                             If   SectionsMenuItem.Enabled and UpdateMenus
                             then UpdateMainMenu;

                             end;

                      end;

              If   not LockSectionsAccess and not SectionSelected
              then For I := 0 to Count - 1 do
                     If   Assigned( Items[ I ] )
                     then begin
                          AppSection := TgAppSection( Items[ I ] );
                          If   AppSection.Enabled
                          then begin
                               SelectAppSection( AppSection );
                               Break;
                               end;
                          end;
              end;

          Finally
            FUpdatingAppSections := False;
            end;

          end;

end;

procedure TApplicationContainer.ShowMainFormCaption( Caption : String );
begin
     If   Assigned( FSectionBarStatic ) and
          ( WebApp or ( TabletApp and VirtualUIApp ) )
     then begin
          FSectionBarStatic.Caption := Caption;
          FSectionBarStatic.Hint := Caption;
          end
     else Application.MainForm.Caption := Caption;
end;

procedure TApplicationContainer.ShowMainMenuBar( AppSection : TgAppSection );

var  MaxWidth : SmallInt;

begin

     try

       FMainBarManager.BeginUpdate;

       FCurrentMainMenuBar := AppSection.MainMenuBar;

       If   Assigned( FCurrentMainMenuBar )
       then FCurrentMainMenuBar.OneOnRow := False;

       If   Assigned( FSectionBarButton )
       then begin
            FSectionBarButton.Caption := AppSection.Caption + ' ';
            If   AppSection.Glyph.Empty
            then FSectionBarButton.LargeGlyph := AppSection.SmartGlyph
            else FSectionBarButton.LargeGlyph.SetBitmap( AppSection.Glyph );
            PadMenuBar.DockedLeft := Application.MainForm.Width;
            end;

       FPadMenuBar.Row := 0;
       If   Assigned( FCurrentMainMenuBar )
       then  begin
             FCurrentMainMenuBar.Row := 0;
             If   SystemScaled and not AppSection.MainMenuBarFontFixed
             then begin
                  FCurrentMainMenuBar.Font.Size := GetSystemScaledMenuFontSize;
                  AppSection.MainMenuBarFontFixed := True;
                  end;
             FCurrentMainMenuBar.Visible := True;
             end;

     finally
       FMainBarManager.EndUpdate( { ACheckBarChanges } False );
       end;

end;

procedure TApplicationContainer.SelectAppSection( AppSection : TgAppSection );
begin
     {$IFDEF APPSECTIONSPANEL}

     If   Assigned( FAppSectionsPanel )
     then FAppSectionsPanel.Visible := False;

	    {$ENDIF}

     If   FCurrentSection<>AppSection
     then begin
          FCurrentSection := AppSection;
          If   Assigned( AppSection )
          then begin

               AppSection.DoOnSelected;

               try
                 FMainBarManager.BeginUpdate;

                 If   Assigned( FCurrentMainMenuBar )
                 then FCurrentMainMenuBar.Visible := False;

                 ShowMainMenuBar( AppSection );

               finally
                 FMainBarManager.EndUpdate;
                 end;

               {$IFDEF APPSECTIONSPANEL}

               // Desactivo el botón de la sección actual

               var SectionIndex := AppSectionList.IndexOf( AppSection );

               For var Index := 0 to FAppSectionsPanel.ComponentCount - 1 do
                 If   FAppSectionsPanel.Components[ Index ] is TcxButton
                 then begin
                      var Button := FAppSectionsPanel.Components[ Index ] as TcxButton;
                      Button.Enabled := Button.Tag<>SectionIndex;
                      end;

               {$ENDIF}

               end;
          end;
end;

procedure TApplicationContainer.PopupAppSectionsMenu( Sender : TObject );

var  P : TPoint;

begin
     If   Assigned( AppSectionsPopupMenu )
     then With AppSectionsPopupMenu do
            If   Sender is TdxBarButton   // el botón del menú activo
            then begin
                 P.X := 4;
                 P.Y := 26;
                 P := Application.MainForm.ClientToScreen( P );
                 Popup( P.X, P.Y );
                 end
            else PopupFromCursorPos;
end;

procedure TApplicationContainer.AppSectionsMenuClick( Sender : TObject );

var  Section : SmallInt;
     AppSection : TgAppSection;

begin
     If   Sender is TComponent
     then begin
          Section := TComponent( Sender ).Tag;
          AppSection := TgAppSection( AppSectionList.Items[ Section ] );
          SelectAppSection( AppSection );
          end;
end;

{$IFDEF APPSECTIONSPANEL}

procedure TApplicationContainer.AddAppSectionPanelItem( AppSection : TgAppSection );

var   NavBarButton : TcxButton;
      Bevel : TdxBevel;

begin

     If   Assigned( FAppSectionsPanel ) and
          Assigned( FAppSectionsContentPanel )
     then begin

          var SectionIndex := AppSectionList.IndexOf( AppSection );

          If   AppSection.SetupSection
          then begin
               var ConfiguracionButton := FAppSectionsPanel.FindChildControl( 'ConfiguracionButton' );
               If   Assigned( ConfiguracionButton ) and ( ConfiguracionButton is TcxButton )
               then begin
                    NavBarButton := TcxButton( ConfiguracionButton );
                    NavBarButton.OnClick := AppSectionsMenuClick;
                    NavBarButton.Tag := SectionIndex;
                    end;
               end
          else begin

               If   AppSection.NewGroup
               then begin
                    Bevel := TdxBevel.Create( FAppSectionsPanel );
                    If   Assigned( Bevel )
                    then begin
                         Bevel.Parent := FAppSectionsContentPanel;
                         Bevel.Width := FAppSectionsContentPanel.Width - 1;
                         Bevel.Top := FAppSectionPanelOffset + 2;
                         Bevel.Height := 1;
                         Bevel.Shape := dxbsLineTop;
                         Bevel.LookAndFeel.NativeStyle := False;
                         Inc( FAppSectionPanelOffset, 4 );
                         end;
                    end;

               NavBarButton := TcxButton.Create( FAppSectionsPanel );
               If   Assigned( NavBarButton )
               then begin

                    NavBarButton.Parent := FAppSectionsContentPanel;
                    NavBarButton.Left := 1;
                    NavBarButton.Top := FAppSectionPanelOffset + 1;
                    NavBarButton.Width := FAppSectionsContentPanel.Width - 2;
                    NavBarButton.Height := 28;
                    NavBarButton.Caption := AppSection.Caption;
                    NavBarButton.OnClick := AppSectionsMenuClick;
                    NavBarButton.Tag := SectionIndex;
                    NavBarButton.Fade := False;
                    {
                    NavBarButton.Colors.NormalText := clHighlightText;
                    NavBarButton.Colors.HotText := clBtnText;
                    }
                    NavBarButton.OptionsImage.Glyph.Assign( AppSection.SmartGlyph );
                    NavBarButton.OptionsImage.Glyph.SourceHeight := 20;
                    NavBarButton.OptionsImage.Glyph.SourceWidth := 20;
                    NavBarButton.OptionsImage.Margin := 6;
                    NavBarButton.OptionsImage.Spacing := 6;
                    NavBarButton.SpeedButtonOptions.CanBeFocused := True;
                    NavBarButton.SpeedButtonOptions.Transparent := True;
                    NavBarButton.SpeedButtonOptions.Flat := True;

                    Inc( FAppSectionPanelOffset, 29 );
                    end;

               FAppSectionsContentPanel.VertScrollBar.Range := FAppSectionPanelOffset;
               end;

          AppSection.SectionsMenuItem := NavBarButton;

          Inc( FAppSectionIndex );
          end;

end;

{$ELSE}

procedure TApplicationContainer.AddAppSectionPopupItem( AppSection : TgAppSection );

var   Link : TdxBarItemLink;
      BarButton,
      ImageBarButton : TdxBarButton;
      LinkIndex : SmallInt;

begin

     If   Assigned( AppSectionsPopupMenu )
     then begin

          LinkIndex := FAppSectionIndex;

          If   AppSection.SetupSection
          then begin  // Añado un espacio para separar las secciones de configuración del resto
               BarButton := AppSectionsPopupMenu.BarManager.AddButton;
               If   Assigned( BarButton )
               then begin
                     BarButton.Caption := '';
                     BarButton.Enabled := False;
                     Link := AppSectionsPopupMenu.ItemLinks.Insert( LinkIndex );
                     Link.Item := BarButton;
                     // Link.BeginGroup := True;
                     Inc( LinkIndex );
                    end;
               end;

          BarButton := AppSectionsPopupMenu.BarManager.AddButton;
          If   Assigned( BarButton )
          then begin

               BarButton.Caption := AppSection.Caption;
               BarButton.OnClick := AppSectionsMenuClick;
               BarButton.Tag := AppSectionList.IndexOf( AppSection );

               Link := AppSectionsPopupMenu.ItemLinks.Insert( LinkIndex );
               Link.Item := BarButton;
               Link.BeginGroup := AppSection.NewGroup;

               If   not AppSection.Glyph.Empty
               then BarButton.Glyph.Assign( AppSection.Glyph )
               else If   not AppSection.SmartGlyph.Empty
                    then BarButton.Glyph.Assign( AppSection.SmartGlyph );

               BarButton.LargeGlyph.SourceWidth := 20;
               BarButton.LargeGlyph.SourceHeight := 20;

               If   AppSection.SetupSection
               then Link.BeginGroup := True;

               end;

          AppSection.SectionsMenuItem := BarButton;

          Inc( FAppSectionIndex );
          end;

end;

{$ENDIF}

procedure TApplicationContainer.AddFormReference( AFormClass  : TFormClass;
                                                  AFormType   : TFormType;
                                                  AccessPoint : TProcedure );

var  EditFormItem : TFormItem;

begin
     EditFormItem := TFormItem.Create( AFormClass, AFormType, AccessPoint );
     FEditFormList.Add( EditFormItem );
end;

procedure TApplicationContainer.DoOnStart;
begin
     If   Assigned( FOnStart )
     then FOnStart;
end;

procedure TApplicationContainer.DoOnBegin;
begin
     If   Assigned( FOnBegin )
     then FOnBegin;
end;

procedure TApplicationContainer.DoOnEnd;
begin
     If   Assigned( FOnEnd )
     then FOnEnd;
end;

procedure TApplicationContainer.DoOnSetupMainForm;
begin
     If   Assigned( FOnSetupMainForm )
     then FOnSetupMainForm;
end;

procedure TApplicationContainer.DoOnEdicionUsuarios;
begin
     If   Assigned( FOnEdicionUsuarios )
     then FOnEdicionUsuarios;
end;

procedure TApplicationContainer.UpdateDatabase( CodigoEmpresa  : String;
                                                Detected       : Boolean );
begin
     InitializationError := True;
     DatabaseUpdateRequested := True;
     If   Assigned( FOnUpdateDatabase )
     then FOnUpdateDatabase( CodigoEmpresa, Detected )
     else begin
          ShowNotification( ntExceptionError, RsMsg12, RsMsg13 );
          PrgExit( False, True );
          end;
end;

procedure TApplicationContainer.InitializeDatabase( OnlyVerifyIfExists : Boolean );
begin
     If   Assigned( FOnInitializeDatabase )
     then FOnInitializeDatabase( OnlyVerifyIfExists )
     else PrgExit( False, True );
end;

procedure TApplicationContainer.ShowWebForm( Page  : String = '';
                                             Title : String = '' );
begin
     If   Assigned( FOnShowWebForm )
     then FOnShowWebForm( Page, Title );
end;

procedure TApplicationContainer.SkinControllerSkinForm(Sender: TObject; AForm: TCustomForm; var ASkinName: string; var UseSkin: Boolean);
begin
     If   ( AForm.Name='frxPrintDialog' ) or
          ( Copy( AForm.Name, 1, 14 ) ='frxPreviewForm' )  // Si hay más de una se le añade un sufijo
     then UseSkin := True;
end;

procedure TApplicationContainer.SetupCheckUpgrade;
begin
     SetBarItemVisible( FUpgradeButton, ComprobarActualizaciones and ( CodigoUsuarioActual='00' ) and not VirtualUIApp );
     CheckUpgradeTimer.Enabled := True;
end;

procedure TApplicationContainer.SetupScheduler;
begin
     If   Assigned( FOnSetupScheduler )
     then FOnSetupScheduler;
end;

procedure TApplicationContainer.SetupDashboard;
begin
     If   Assigned( FOnSetupDashboard )
     then FOnSetupDashboard;
end;

procedure TApplicationContainer.ShowMailForm;
begin
     If   Assigned( FOnShowMailForm )
     then FOnShowMailForm;
end;

procedure TApplicationContainer.SetupNumericKeyboard;
begin
     If   Assigned( FNumericKeyboardButton )
     then SetBarItemVisible( FNumericKeyboardButton, ShowNumericKeyboard );
     If  not ShowNumericKeyboard and Assigned( TecladoFrame )
     then TecladoFrame.Visible := False;
end;

procedure TApplicationContainer.ExchangeSchedulerForm;
begin
     If   Assigned( FOnExchangeSchedulerForm )
     then FOnExchangeSchedulerForm;
end;

procedure TApplicationContainer.ExchangeDashboardForm;
begin
     If   Assigned( FOnExchangeDashboardForm )
     then FOnExchangeDashboardForm;
end;

procedure TApplicationContainer.ExchangeWordProcessorForm;
begin
     If   Assigned( FOnExchangeWordprocessorForm )
     then FOnExchangeWordprocessorForm;
end;

procedure TApplicationContainer.EnableRecordButtons( Value           : Boolean;
                                                     FilterEnabled   : Boolean = False;
                                                     DatasetFiltered : Boolean = False );
begin
     If   not IsDesignTime and
          Assigned( Application.MainForm ) and
          Assigned( FirstRecButton )
     then begin

          FirstRecButton.Enabled := Value;
          PreviousRecButton.Enabled := Value;
          RefreshRecButton.Enabled := Value;
          NextRecButton.Enabled := Value;
          LastRecButton.Enabled := Value;

          //* 02.11.2003  Los botones InsertRec y CopyRec no se deben activar por defecto

          If   not Value
          then begin
               InsertRecButton.Enabled := False;
               CopyRecButton.Enabled := False;
               end;

          SearchRecButton.Enabled := FilterEnabled;
          CancelSrchRecButton.Enabled := FilterEnabled and DatasetFiltered;

          FRecordButtonsEnabled := Value;

          end;
end;

procedure TApplicationContainer.DisableAllToolbarButtons;
begin
     If   not IsDesignTime and
          Assigned( Application.MainForm ) and
          not ( csDestroying in Application.MainForm.ComponentState ) and
          Assigned( EditButton )
     then begin

          EditButton.Enabled := False;
          QueryGridButton.Enabled := False;
          QueryButton.Enabled := False;
          NoteButton.Enabled := False;
          RelationsButton.Enabled := False;

          ReportButton.Enabled := False;
          FormReportButton.Enabled := False;
          LabelButton.Enabled := False;
          GraphicButton.Enabled := False;

          SaveParamsButton.Enabled := False;

          EnableRecordButtons( False );

          end;
end;

function  TApplicationContainer.GetProgressBarTextColor( AIsFilledArea: Boolean ) : TColor;
begin
     If   AppUseSkins and Assigned( AppSkinPainter )
     then Result := AppSkinPainter.ProgressBarTextColor
     else Result := clWindowText;
end;

function  TApplicationContainer.GetPainterColor( CurrentColor : TColor ) : TColor;
begin
     Result := CurrentColor;
     If   AppUseSkins and Assigned( AppSkinPainter )
     then With AppSkinPainter do
            case CurrentColor of
              clInfoBk            : Result := DefaultGroupColor;
              clActiveCaption     : Result := DefaultHeaderColor;
              clCaptionText       : Result := DefaultHeaderTextColor;
              clPanelDefault      : Result := DefaultContentColor;
              clBackgroundDefault : Result := DefaultControlColor;
              end;
end;

function  TApplicationContainer.GetDefaultContentColor : TColor;
begin
     If   AppUseSkins and Assigned( AppSkinPainter )
     then Result := AppSkinPainter.DefaultContentColor // DefaultContentEvenColor
     else Result := clBackgroundDefault;
end;

function TApplicationContainer.GetContentStyleBackgroundColor( ContentType : TContentType ) : TColor;

var  SkinPainter : Boolean;

begin
     Result := clDefault;
     If   Assigned( AppSkinPainter )
     then case ContentType of
            cntQuerySourceColumn :
              Result := AppSkinPainter.DefaultVGridContentEvenColor;
            cntEditFixedColumn :
              Result := AppSkinPainter.DefaultHeaderColor;
            cntContentEven :
              Result := AppSkinPainter.DefaultVGridContentEvenColor;
            cntMenuNote :
              Result := AppSkinPainter.DefaultControlColor;
            cntMenuHeader :
              Result := AppSkinPainter.DefaultControlColor;
            end;
end;

function TApplicationContainer.GetContentStyleTextColor( ContentType : TContentType ) : TColor;

var  SkinPainter : Boolean;

begin
     Result := clDefault;
     If   Assigned( AppSkinPainter )
     then case ContentType of
            cntQuerySourceColumn :
              Result := AppSkinPainter.DefaultVGridContentTextColor;
            cntEditFixedColumn :
              Result := AppSkinPainter.DefaultHeaderTextColor;
            cntContentEven :
              Result := AppSkinPainter.DefaultVGridContentTextColor;
            cntMenuNote :
              Result := AppSkinPainter.DefaultPreviewTextColor;
            cntMenuHeader :
              Result := AppSkinPainter.DefaultHeaderBackgroundTextColor;
            end;
end;

procedure TApplicationContainer.DoOnbackupDatabase;
begin
     If   Assigned( FOnBackupDatabase )
     then FOnBackupDatabase;
end;

procedure TApplicationContainer.DoOnUpdatelookAndFeel;
begin
     UpdateSkinController;
     If   Assigned( FOnUpdatelookAndFeel )
     then FOnUpdatelookAndFeel;
end;

procedure TApplicationContainer.DoOnExternalReport;
begin
     If   Assigned( FOnExternalReport )
     then FOnExternalReport( Self );
end;

procedure TApplicationContainer.UpdateSkinController;

var Painter : TcxCustomLookAndFeelPainter;
    LookAndFeelStyle : TcxLookAndFeelStyle;

procedure UpdateStyleColors;
begin

     EditFixedColumnStyle.TextColor := GetContentStyleTextColor( cntEditFixedColumn );
     EditFixedColumnStyle.Color := GetContentStyleBackgroundColor( cntEditFixedColumn );

     QueryContentEvenStyle.TextColor := GetContentStyleTextColor( cntContentEven );
     QueryContentEvenStyle.Color := GetContentStyleBackgroundColor( cntContentEven );

     QueryContentSourceColumnStyle.TextColor := GetContentStyleTextColor( cntQuerySourceColumn );
     QueryContentSourceColumnStyle.Color := GetContentStyleBackgroundColor( cntQuerySourceColumn );

     MenuNoteStyle.TextColor := GetContentStyleTextColor( cntMenuNote );
     MenuNoteStyle.Color := GetContentStyleBackgroundColor( cntMenuNote );

     MenuHeaderStyle.TextColor := GetContentStyleTextColor( cntMenuHeader );
     MenuHeaderStyle.Color := GetContentStyleBackgroundColor( cntMenuHeader );

end;

begin

     SkinController.TouchMode := AppTouchMode;
     If   AppTouchMode
     then dxAdjustToTouchableSize( TouchModeSize );

     SkinController.RenderMode := RenderMode;

     If   AppUseSkins
     then try
            If   ( SkinController.UseSkins=AppUseSkins ) and
                 ( LoadedSkinName=AppSkinName ) and
                 ( LoadedSkinPalette=AppSkinPalette )
            then Exit
            else try

                   SkinController.BeginUpdate;

                   SkinController.UseSkins := True;
                   SkinController.NativeStyle := False;

                   If   not cxLookAndFeelPaintersManager.GetPainter( AppSkinName, Painter )
                   then begin  // Una opción por defecto
                        AppSkinName := DefaultSkinName;
                        AppSkinPalette := DefaultSkinPaletteName;
                        end;

                   SkinController.SkinName := AppSkinName;
                   If   AppSkinName=DefaultSkinName
                   then SkinController.SkinPaletteName := AppSkinPalette
                   else SkinController.SkinPaletteName := '';

                   SkinController.TouchMode := AppTouchMode;

                   If   cxLookAndFeelPaintersManager.GetPainter( AppSkinName, Painter )
                   then begin
                        AppSkinPainter := Painter;
                        LoadedSkinName := AppSkinName;
                        LoadedSkinPalette := AppSkinPalette;
                        UpdateStyleColors;
                        Exit;
                        end;

                 finally
                   SkinController.EndUpdate;
                   end
          except
            ShowNotification( ntWarning, Format( RsgMsg114, [ AppSkinName ] ), RsgMsg115 );
            end;

     // Si no consigo cargar el painter también se desactiva el Skin

     AppUseSkins := False;
     AppSkinPainter := nil;

     With SkinController do
       begin
       If   CustomLookAndFeel
       then Kind := LookAndFeelKind
       else Kind := cxDefaultLookAndFeelKind;
       UseSkins := False;
       SkinName := '';
       NativeStyle := not CustomLookAndFeel;
       If   NativeStyle
       then LookAndFeelStyle := lfsNative
       else LookAndFeelStyle := TcxLookAndFeelStyle( LookAndFeelKind );
       AppSkinPainter := cxLookAndFeelPaintersManager.GetPainter( LookAndFeelStyle );
       end;

     UpdateStyleColors;
end;

procedure TApplicationContainer.ShowUpgradeForm;

var  ProcessInformation : TProcessInformation;

begin
     If   Assigned( FOnShowUpgradeForm )
     then FOnShowUpgradeForm
     else begin

          {$IFDEF DEBUG}
          ApplicationName := 'gd.exe';   // Por que si no, sería gdd.exe
          {$ENDIF}

          FUpgradeChecked := True;
          If   not ReleasingApplication and not DatabaseUpdateRequested
          then If   ShowNotification( ntQuestionWarning, RsMsg10, RsMsg11 )=mrYes
               then begin
                    ProcessExecute( ProcessInformation, 'GdUpd.exe ' + AppShortName, ApplicationPath, SW_SHOWNORMAL, True );
                    PrgExit( False, True, True );
                    Abort;
                    end;

               {
               With Rpc, VersionInfo do
                 try
                   try

                     Connect;

                     Setup( ptUpdate, nil, nil, False );

                     If   Rpc.GetFileVersion( AddPathDelim( RemoteDir + VersionDir ) + ApplicationName, True )>GetComparableVersionNumber( MajorVersion, MinorVersion, Release, Build )
                     then begin
                          UpgradeAvailable := True;
                          If   ShowNotification( ntQuestionWarning, RsMsg10, RsMsg11 )=mrYes
                          then If   PrgExit( False, False )
                               then begin
                                    ProcessExecute( ProcessInformation, ApplicationPath + 'GdUpd.exe ' + AppShortName );
                                    Abort;
                                    end;
                          end
                     else ShowNotification( ntInformation, RsMsg14, RsMsg15 );

                     SetBarItemVisible( FUpgradeButton, False );
                     CheckUpgradeTimer.Enabled := False;

                   except
                     ShowNotification( ntInformation, RsMsg16, RsMsg17 );
                     end;

                 finally
                   Disconnect;
                   end;
               }

          end;
end;

procedure TApplicationContainer.ProcessRecordChangesLog( Dataset        : TnxIndexDataSet;
                                                         OptionValue    : SmallInt = 0;
                                                         ReferenceTable : TnxTable = nil );

var  LogCaption : String;

function GetFieldValueAsString( Field      : TField;
                                OldValue   : Boolean = False;
                                TextoNulo  : String = '<nulo>';
                                TextoVacio : String = '<vacío>' ) : String;

var  Value : Variant;
     StrValue : String;

begin
     If   OldValue
     then Value := Field.OldValue
     else Value := Field.Value;

     If   VarIsNull( Value )
     then Result := TextoNulo
     else If   Field.DataType in [ ftMemo, ftWideMemo ]
          then begin
               Result := Field.AsAnsiString;
               If   Result<>''
               then Result:= TextConverter.ToPlainText( Result );
               end
          else begin
               StrValue := VarToStr( Value );
               If   StrValue=''
               then Result := TextoVacio
               else Result := StrValue;
               end;
end;

function GetRecordChangesLog : String;

var  Field : TField;
     Caption : String;

begin
     Result := '';
     try
       For Field in Dataset.Fields do
         If   not ( Field.DataType in [ ftBytes, ftGraphic ] )
         then If   ( Field.Value<>Field.OldValue ) and ( Field.FieldKind=fkData )
              then begin
                   If   Result<>''
                   then StrAdd( Result, #13 );
                   If   ( Assigned( ReferenceTable ) and ( ReferenceTable.State=dsInsert ) ) or ( Dataset.State=dsInsert )
                   then StrAdd( Result, Field.FieldName + ' : ' + GetFieldValueAsString( Field ) )
                   else StrAdd( Result, Field.FieldName + ' : ' + GetFieldValueAsString( Field, { OldValue } True ) + ' -> ' + GetFieldValueAsString( Field ) );
                   end;
     except on E : Exception do
       ShowNotification( ntExceptionError, E.Message );
       end;
end;

function GetRecordIndexValues( IndexDataset : TnxIndexDataset ) : String;

var  I : SmallInt;
     Field : TField;

begin
     Result := '';
     try
       For I := 0 to IndexDataset.IndexFieldCount - 1 do
         begin
         Field := IndexDataset.IndexFields[ I ];
         If   not ( Field.DataType in [ ftBytes, ftGraphic ] )
         then begin
              If   Result<>''
              then StrAdd( Result, ' . ' );
              StrAdd( Result, GetFieldValueAsString( Field, False, '', '' ) );
              end;
         end;
     except on E : Exception do
       ShowNotification( ntExceptionError, E.Message );
       end;
end;

begin
     If   LogRecordDataChanges
     then begin

          // La tabla de referencia se pasa cuando el dataset es, por ejemplo, un TnxCachedDataset, que se utiliza como
          // intermediario en los procesos de edición

          If   Assigned( ReferenceTable )
          then LogCaption := ReferenceTable.TableName + ' ' + GetRecordIndexValues( ReferenceTable )
          else LogCaption := Dataset.TableDescriptor.btdFullName + ' ' + GetRecordIndexValues( Dataset );
          ProcessLog( LogCaption, GetRecordChangesLog, TTipoRegistroDiarioProcesos.trdRegistroCambios, OptionValue );
          end;
end;

// TgBitBtn -----------------------------------------------------------------

constructor TgBitBtn.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     FGlyphBitmap := gmNone;
     Kind := cxbkStandard;

     ModalResult := mrNone;
     OptionsImage.Images := ApplicationContainer.ButtonImageList;
     NumGlyphs := 1;
end;

procedure TgBitBtn.Click;
begin

     // Curiosamente sí que se puede llamar a la función si el botón está desactivado : con las AccelKeys

     If   Enabled
     then try
            FClicked := True;
            If   CanBeFocused
            then SetFocus;
            inherited Click;
          finally
            FClicked := False;
            end;
end;

function TgBitBtn.GetEnabled : Boolean;
begin
     Result := inherited GetEnabled;
end;

procedure TgBitBtn.SetEnabled( Value : Boolean );
begin
     If   not Focused
     then inherited SetEnabled( Value );
end;

procedure TgBitBtn.SetGlyphBitmap( const Value : TGlyphBitmap );

var    GlyphName : String;

const  ButtonCaption : array[ gmNone..gmWarning ] of String = ( '',
                                                               'A&yuda',
                                                               'N&o',
                                                               '&Aceptar',
                                                               'S&i',
                                                               '&Insertar',
                                                               '&Suprimir',
                                                               'Ca&ncelar',
                                                               '&Cerrar',
                                                               'A&viso' );
begin
     If   Value<>FGlyphBitmap
     then begin

          FGlyphBitmap := Value;
          OptionsImage.ImageIndex := Ord( FGlyphBitmap ) - 1;

          If   FGlyphBitmap<>gmNone
          then begin

               If   ModalResult=mrNone
               then Case FGlyphBitmap of
                     gmNo       : ModalResult := mrNo;
                     gmOk       : ModalResult := mrOk;
                     gmYes      : ModalResult := mrYes;
                     gmCancel   : ModalResult := mrCancel;
                     gmWarning  : ModalResult := mrIgnore;
                     gmClose    : ModalResult := mrCancel;  // bkClose no tiene modalResult
                     gmDelete   : ModalResult := mrAbort;
                     else         ModalResult := mrNone;
                     end;

               If   ModalResult=mrCancel
               then Cancel := True;

               end;

          // De esta forma solo se reajusta durante la edición del componente Y puedo
          // crear botones con parámetros distintos sin que se rejusten al crearse
          // en modo ejecución

          If   IsDesignTime and
               not ( csLoading   in ComponentState ) and
               not ( csWriting   in ComponentState )
          then begin

               Margin := 4;
               Spacing := 5;
               Height := 28;
               Width := 85;

               If   FGlyphBitmap in [ gmNone..gmWarning ]
               then Caption := ButtonCaption[ FGlyphBitmap ];
               end;

          end;
end;

procedure TgBitBtn.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
     inherited;
     With Message do
       begin

       If   GetKeyState( VK_CONTROL )>=0
       then Result := Result or DLGC_WANTTAB;

       If   ModalResult=mrNone
       then Result := Result or DLGC_WANTALLKEYS;   // Simplemente evito que VK_RETURN provoque el Click

       end;
end;

{ Otros procedimientos comunes ---------------------------------------------- }

procedure FatalError( Msg : String );
begin
     ShowNotification( ntStop, Msg, RsgMsg104 );
     PrgExit( False );
end;

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
               If   ApplicationContainer.CanCloseAllForms( False )<>mrOk
               then Exit;
               If   ( CodigoUsuarioActual='00' ) and not ApplicationContainer.DontAskForBackup
               then If   ShowNotification( ntQuestionWarning, RsgMsg105, RsgMsg109 )=mrYes
                    then ApplicationContainer.DoOnBackupDatabase;
               end
          else Exit;
          end
     else begin
          If   not Force
          then If   ApplicationContainer.CanCloseAllForms( False )<>mrOk
               then Exit;
          If   not SilentMode
          then ShowNotification( ntInformation, RsgMsg105, RsgMsg106 );
          end;

     ReleasingApplication := True;

     CloseAllDataModules( {IncludingPersistentOnes } True );

     LogMessage( RsgMsg108 );

     Result := True;

     Application.Terminate;
end;

procedure CompruebaAccesoLocal;
begin

     //* Puedo considerar una aplication TS como local a todos los efectos

     If   DataAccessMode=dmRemote
     then begin
          ShowNotification( ntError, RsMsg6, RsMsg7 );
          Abort;
          end;
end;

procedure PrgRestart;

var AppShortName,
    Parameters : String;

begin

     AppShortName := ParamStr( 0 );
     Parameters := ParamStr( 1 );

     // Añadiendo el parámetro '-E' restart

     If   ParamCount>1
     then Parameters := Parameters + ' ' + ParamStr( 2 ) + 'E ' + ParamStr( 3 ) + ' ' + ParamStr( 4 );

     ShellExecute( Application.MainForm.Handle, 'open', PChar( AppShortName ), PChar( Parameters ), nil, SW_SHOWNORMAL );
     Application.Terminate;
end;

function StrMonth( NroPeriodo : Byte;
                   Short      : Boolean = False ) : String;
begin
     Result := '';
     If   NroPeriodo in [ 0..14 ]
     then If   Short
          then begin
               case NroPeriodo of
                 0, 13, 14 : Result := '<' + Copy( StPeriodo[ NroPeriodo ], 2, 1 ) + '>';
                 else        Result := Copy( StPeriodo[ NroPeriodo ], 1, 3 );
                 end;
               end
          else Result := StPeriodo[ NroPeriodo ];
end;

function StrToDate(     St         : String;
                    var Date       : TDateTime;
                        DateFormat : TDateFormat = dfDefault2 ) : Boolean;

var   Code    : LongInt;
      Dummy   : Boolean;
      Day,
      Month,
      Year    : Integer;

begin

     { de momento solo acepta dfDefault, dfInput Y dfSQL }

     case DateFormat of
       dfDefault :
         St := StrRemoveChars( St, [ FormatSettings.DateSeparator ] );
       dfSQL :
         begin
         St := StrRemoveChars( St, [ '-' ] );
         St := Copy( St, 7, 2 ) + Copy( St, 5, 2 ) + Copy( St, 1, 4 );
         end;
       end;

     Val( Copy( St, 1, 2 ), Day,   Code );
     If   Code<>0
     then Day := 0;
     Val( Copy( St, 3, 2 ), Month, Code );
     If   Code<>0
     then Month := 0;
     If   Length( St )=4
     then Year := YearOf( ApplicationContainer.TodayDate )
     else If   Length( St )=6
          then begin
               Val( Copy( St, 5, 2 ), Year, Code );
               If   Code=0
               then begin
                    If   Year>50
                    then Inc( Year, 1900 )
                    else Inc( Year, 2000 );
                    end
               else Year := 0;
               end
          else If   Length( St )=8
               then Val( Copy( St, 5, 4 ), Year, Code )
               else begin
                    Result := False;
                    Exit;
                    end;

     If   Month=0
     then Month := MonthOf( ApplicationContainer.TodayDate );
     If   Year=0
     then Year := YearOf( ApplicationContainer.TodayDate );

     Result := IsValidDate( Day, Month, Year, False, Dummy );
     If   Result
     then Date := EncodeDate( Year, Month, Day );

end;

//* 13.03.2000 Esta función devuelve el ejercicio al que pertenece la fecha en cuestión
//             (teniendo en cuenta que puede tratarse de una Empresa de ejercicio partido)

function EjercicioFecha( ADate : TDateTime ) : SmallInt;
begin
     Result := LibUtils.AccountingYear( ADate, ApplicationContainer.NroMesInicial );
end;

{
function  ChangeYear( ADate : TDateTime; NewYear : SmallInt ) : TDateTime;

var   Day,
      Month,
      Year : Word;

begin
     DecodeDate( ADate, Year, Month, Day );
     Result := EncodeDate( NewYear, Month, Day );
end;
}

function IsValidYear( ADate         : TDateTime;
                      ReferenceYear : Word = 0 ) : Boolean;
var   Day,
      Month,
      Year    : Word;

begin
     If   ValueIsEmpty( ADate )
     then Result := False
     else begin
          DecodeDate( ADate, Year, Month, Day );
          Result := IsValidYear( Day, Month, Year, ReferenceYear );
          end;
end;

function IsValidYear( Day,
                      Month,
                      Year          : Word;
                      ReferenceYear : Word = 0 ) : Boolean;
begin

     //* 14.03.2000 Varias ajustes para su uso en el Ejercicio partido

     If   ReferenceYear=0
     then ReferenceYear := ApplicationContainer.Ejercicio;

     If   ApplicationContainer.NroMesInicial=1
     then Result := Year=ReferenceYear
     else Result := ( ( Year=ReferenceYear ) and ( Month>=ApplicationContainer.NroMesInicial ) ) or
                    ( ( Year=ReferenceYear + 1 ) and ( Month<ApplicationContainer.NroMesInicial ) );

end;

function IsValidDate(     Day,
                          Month,
                          Year    : Word;
                          CurrentYear : Boolean;
                      var InvalidYear : Boolean ) : Boolean;

begin
     InvalidYear  := False;
     Result       := False;

     If   ( Day   in [ 1..31 ] ) and
          ( Month in [ 1..12 ] )
     then begin
          If   Month=2
          then begin
               If   IsLeapYear( Year )
               then Result := Day<=29
               else Result := Day<=28;
               end
          else Result := not( ( Month in [ 4, 6, 9, 11 ] ) and ( Day>30 ) );
          end;

     If   Result and CurrentYear
     then If   ApplicationContainer.NroMesInicial=1
          then begin
               If   Year<>ApplicationContainer.Ejercicio
               then begin
                    Result := False;
                    InvalidYear := True;
                    end;
               end
          else If   not IsValidYear( Day, Month, Year, ApplicationContainer.Ejercicio )
               then begin
                    Result := False;
                    InvalidYear := True;
                    end;
end;


(*
procedure CompruebaSuscripcion( EstadoSuscripcionBox : TgBox = nil );

var Resultado : Integer;
    NroUsuarios : Integer;
    ClaveActivacion : Int64;

begin
     With ApplicationContainer. do
       begin

       ApplicationContainer.SpEvaluation := True;

       try

         If   Assigned( EstadoSuscripcionBox )
         then begin
              EstadoSuscripcionBox.Font.Color := rgb_mediumBlue;
              EstadoSuscripcionBox.Text:= 'Comprobando...';
              Application.ProcessMessages;
              end;

         try
           Resultado := (RORemoteService as IGdService).CompruebaLicencia( ProtectionRec.UserCode,
                                                                           ProtectionRec.UserName,
                                                                           ProtectionRec.RegNumber,

                                                                           ProtectionRec.ProgramNumber,
                                                                           ProtectionRec.ProgramVersion,
                                                                           ProtectionRec.ProgramRelease,

                                                                           ProtectionRec.SerialNumber,
                                                                           ProtectionRec.ServerConnections,

                                                                           ProtectionRec.ActivationKey );

           If   Assigned( EstadoSuscripcionBox )
           then begin
                EstadoSuscripcionBox.Text:= 'Conexión realizada.';
                Application.ProcessMessages;
                end;

         except

           If   Assigned( EstadoSuscripcionBox )
           then begin
                EstadoSuscripcionBox.Text:= 'No se ha podido realizar la conexión.';
                EstadoSuscripcionBox.Font.Color := rgb_orange;
                Application.ProcessMessages;
                end;

           Resultado := -1;
           end;

       finally
         UpdateSuscriptionData( Resultado );
         end;

       ApplicationContainer.SpEvaluation := not ( Resultado in [ CCL_CORRECTA, CCL_CADUCADA ] );

       If   Resultado=CCL_CORRECTA
       then begin
            ApplicationContainer.SpUserCode := ProtectionRec.UserCode;
            ApplicationContainer.SpUserName := ProtectionRec.UserName;
            ApplicationContainer.SpRegNumber := ProtectionRec.RegNumber;
            ApplicationContainer.SpSerialNumber := ProtectionRec.SerialNumber;
            end;

       MuestraEstadoSuscripcion( EstadoSuscripcionBox );

       end;

end;

procedure MuestraEstadoSuscripcion( EstadoSuscripcionBox : TgBox = nil );
begin
     With ApplicationContainer. do
       If   SuscriptionRec.LastState=CCL_CORRECTA
       then begin

            If  Assigned( EstadoSuscripcionBox )
            then begin
                 EstadoSuscripcionBox.Font.Color := clNavy;
                 EstadoSuscripcionBox.Text := TextoEstadoSuscripcion[ CCL_CORRECTA ] + #13 +
                                              TextoAplicacion[ ProgramNumber ] + ', Versión ' +
                                              IntToStr( ProgramVersion )  + '.' + IntToStr( ProgramRelease ) + '.';
                 end;

            end
       else begin

            If  Assigned( EstadoSuscripcionBox )
            then begin
                 EstadoSuscripcionBox.Font.Color := rgb_orange;
                 If   SuscriptionRec.LastState in [ CCL_ERROR, CCL_CADUCADA..CCL_ERRORINTERNO ]
                 then EstadoSuscripcionBox.Text := TextoEstadoSuscripcion[ SuscriptionRec.LastState ]
                 else EstadoSuscripcionBox.Text := RsErrorComprobacion;
                 end;

            end;
       Application.ProcessMessages;
end;

*)

function GetComparableVersionNumber( AMajorVersion,
                                     AMinorVersion,
                                     ARelease       : SmallInt;
                                     ABuild         : SmallInt = -1 ) : LongWord;
var  VersionStr : String;

begin
     VersionStr := StrIntPadded( AMajorVersion, 2 ) + StrIntPadded( AMinorVersion, 2 ) + StrIntPadded( ARelease, 2 );
     If   ABuild<>-1
     then StrAdd( VersionStr, StrIntPadded( ABuild, 2 ) );
     Result := StrToInt( VersionStr );
end;

function EjercicioActual( Date : TDateTime ) : Boolean;
begin
     Result := IsValidYear( Date, ApplicationContainer.Ejercicio );
end;

procedure CompruebaEjercicio( Date : TDateTime );
begin
     If   not IsValidYear( Date, ApplicationContainer.Ejercicio )
     then begin
          ShowNotification( ntStop, RsgMsg352, RsgMsg353 );
          Abort;
          end;
end;

function  FechaPrimerDiaEjercicio( Ejercicio : SmallInt = 0 ) : TDateTime;
begin
     If   Ejercicio=0
     then Ejercicio := ApplicationContainer.Ejercicio;
     Result := EncodeDate( Ejercicio, ApplicationContainer.NroMesInicial, 1 );
end;

function  FechaUltimoDiaEjercicio( Ejercicio : SmallInt = 0 ) : TDateTime;
begin
     If   Ejercicio=0
     then Ejercicio := ApplicationContainer.Ejercicio;
     If   ApplicationContainer.NroMesInicial>1
     then Result := EncodeDate( Ejercicio + 1, ApplicationContainer.NroMesFinal, 31 )
     else Result := EncodeDate( Ejercicio, ApplicationContainer.NroMesFinal, 31 );
end;

function ObtenDC( Codigo : String ) : Char;

const  Peso : array[ 1..10 ] of Byte = ( 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 );

Var    I,
       Posicion : SmallInt;
       Suma : Integer;
       Digito,
       PrimerDigito,
       SegundoDigito : SmallInt;

begin
     Result   := '*';

     try

       Suma := 0;
       Posicion := 1;
       For I := Length( Codigo ) downto 1 do
         If   CharInSet( Codigo[ I ], [ '0'..'9' ] )
         then begin
              Digito := Ord( Codigo[ I ] ) - OrdZero;
              Inc( Suma, Digito * Peso[ Posicion ] );
              Inc( Posicion );
              end
         else Abort;

       Suma := 11 - ( Suma mod 11 );
       If   Suma=10
       then Suma := 1
       else If   Suma=11
            then Suma := 0;
       Result := Char( Suma + OrdZero );

     except
       end;

end;

function GetStrDef( Value   : String;
                    Default : String ) : String;
begin
     If   Value=''
     then Result := Default
     else Result := Value;
end;

procedure SetStrIfNull( var Dest   : String;
                        var Source : String   );
begin
     If   Dest=''
     then Dest := Source;
end;

procedure setIntIfNull( var Dest   : SmallInt;
                        var Source : SmallInt );
begin
     If   Dest=0
     then Dest := Source;
end;

procedure keyEvent( Key : Word; Shift : TShiftState = [] );
begin

     try
       If   ssShift in Shift
       then keybd_event( vk_shift, 0, 0, 0 );
       If   ssAlt in Shift   // Es <AltGr> no <Alt>
       then keybd_event( vk_RMenu, 0, 0, 0 );
       keybd_event( Key, 0, 0, 0 );
     Finally
       keybd_event( Key, 0, KEYEVENTF_KEYUP, 0 );
       If   ssAlt in Shift
       then keybd_event( vk_rMenu, 0, KEYEVENTF_KEYUP, 0 );
       If   ssShift in Shift
       then keybd_event( vk_shift, 0, KEYEVENTF_KEYUP, 0 );
       end;
end;


function  CheckAccessLevel( IArray : array of LongInt ) : LongInt;

var   I : SmallInt;

begin
     Result := 0;
     For I := 0 to High( IArray ) do
       If   IArray[ I ]=0
       then begin
            Result := 0;
            Exit;
            end
       else If   IArray[ I ]>Result
            then Result := IArray[ I ];
end;

function CalculaPorcentaje( Valor1,
                            Valor2        : Double;
                            RangoAjustado : Boolean = False ) : SmallInt;
begin
     If   Valor1=0.0
     then begin
          If   Valor2=0.0
          then Result := 0
          else Result := -100;
          end
     else If   Valor2=0.0
          then begin
               If   Valor1=0.0
               then Result := 0
               else Result := 100;
               end
          else begin
               If   Valor2>Valor1
               then Result := -Round( ( ( Valor2 - Valor1 ) * 100.0 ) / Valor2 )
               else Result := Round( ( ( Valor1 - Valor2 ) * 100.0 ) / Valor1 );
               If   RangoAjustado
               then begin
                    If   Result>100
                    then Result := 100
                    else If   Result<-100
                         then Result := -100;
                    end
               end;
end;

// TQuickSort ---------------------------------------------------------------

procedure SortIntegerArray( var A   : array of Integer;
                                Top : SmallInt );

procedure QuickSort( var A    : array of Integer;
                         ILo,
                         IHi  : Integer);
var  Lo,
     Hi,
     Mid,
     T : Integer;

begin
     Lo := ILo;
     Hi := IHi;
     Mid := A[ ( Lo + Hi ) div 2 ];
     repeat
       while A[ Lo ]<Mid do
         Inc( Lo );
       while A[ Hi ]>Mid do
         Dec( Hi );

       If   Lo<=Hi
       then begin
            T := A[ Lo ];
            A[ Lo ] := A[ Hi ];
            A[ Hi ] := T;
            Inc( Lo );
            Dec( Hi );
            end;
     until Lo>Hi;

    If   Hi>ILo
    then QuickSort( A, ILo, Hi );
    If   Lo<IHi
    then QuickSort( A, Lo, IHi );
end;

begin
     try
       If   Top>High( A )
       then Top := High( A );
       If   Top>0
       then QuickSort( A, low( A ), Top );
     except on E : Exception do ShowException( E, nil );
       end;
end;

procedure ShowHelp;
begin
     var ActiveForm := Screen.ActiveForm;
     If   Assigned( ActiveForm ) and ( ActiveForm.Enabled )
     then begin
            If   ActiveForm<>HelpForm
            then ShowHelpForm( ActiveForm.HelpFile, ActiveForm.HelpKeyword );
            end
       else If   Assigned( ApplicationContainer.CurrentSection )
            then With ApplicationContainer.CurrentSection do
                   ShowHelpForm( Copy( HelpFile, 1, 4 ), 'contenido' + Copy( HelpFile, 5, 2 ) );
end;

procedure ShowHelpForm( HelpFileName,
                        Topic        : String;
                        IsAMenuEvent : Boolean = False );
begin

     If   IsAMenuEvent and IsKeyPressed( VK_F1 ) and Assigned( Application.MainForm.ActiveMDIChild )
     then Exit;

     If   HelpFileName=''
     then Abort   // Evito que se muestre una excepción ?
     else begin
          If   Topic=''
          then Topic := 'contenido';
          ShowHelpPage( 'file:///' + ApplicationPath + 'Ayuda\' + HelpFileName + '\index.html?' + Topic + '.html' );
          end;
end;

{--------}

procedure ExtractHelper( const Pfn      : String;
                         var   DotPos   : Integer;
                         var   SlashPos : Integer);
var I : Integer;

begin
     DotPos := 0;
     SlashPos := 0;
     I := Length( Pfn );
     While ( I>0 ) and ( ( DotPos=0 ) or ( SlashPos=0 ) ) do
       begin
       If   ( Pfn[ I ]='.' )
       then begin
            If   ( DotPos=0 )
            then DotPos := I;
            end
       else If   ( Pfn[ I ]='\' )
            then begin
            SlashPos := I;
            If   ( DotPos=0 )
            then DotPos := Succ( Length( Pfn ) );
            end;
       Dec( I );
       end;
     If   ( DotPos=0 )
     then DotPos := Succ( Length( Pfn ) );
end;

{
function ValidFileNameHelper( const S      : String;
                                    MaxLen : Integer ) : Boolean;

const UnacceptableChars : set of Char = ['"', '*', '.', '/', ':', '<', '>', '?', '\', '|' ];

var   I, LenS : Integer;

begin
     Result := False;
     LenS := Length( S );
     If   ( 0<lenS )       and
          ( lenS<=MaxLen )
     then begin
          For I := 1 to lenS do
            If   CharInSet( S[ I ], UnacceptableChars )
            then Exit;
          Result := True;
          end;
end;
}

function FindMenuItemByTag( MainMenuBar : TdxBar;
                            MenuTag     : LongInt ) : TdxBarItem;

var   I : SmallInt;
      MenuItem : TdxBarItem;

begin
     Result := nil;
     If   Assigned( MainMenuBar ) and ( MenuTag<>0 )
     then With MainMenuBar do
            For I := 0 to ItemLinks.Count - 1 do
              If   ItemLinks[ I ].Item is TdxBarItem
              then begin
                   MenuItem := TdxBarItem( ItemLinks[ I ].Item );
                   If   MenuItem.Tag=MenuTag
                   then begin
                        Result := MenuItem;
                        Exit;
                        end;
                   end;
end;

// Un interceptador de la función SmartTextToDateFunc definida en cxDateutils

function SmartTextToDateTime( const AText : String;
                              var   ADate : TDateTime ) : Boolean;

var  Tl : SmallInt;
     Day,
     Month,
     Year : Word;

begin
     // Formato : 01 01 2009
     Result := False;
     try
       Tl := Length( AText );
       DecodeDate( ApplicationContainer.TodayDate, Year, Month, Day );
       If   Tl>1
       then Day := StrToIntDef( Copy( AText, 1, 2 ), 1 );
       If   Tl>4
       then Month := StrToIntDef( Copy( AText, 4, 2 ), 1 );
       If   Tl>7
       then begin
            Year := StrToIntDef( Copy( AText, 7, 4 ), 1 );
            If   Year<50
            then Year := 2000 + Year
            else If   Year<100
                 then Year := 1900 + Year;
            end;
       var Dim := DaysInAMonth( Year, Month );
       If   Day>Dim
       then Day := Dim;
       ADate := EncodeDate( Year, Month, Day );
       Result := True;
     except
       end;

end;



{ TEditFormItem }

constructor TFormItem.Create( FormClass  : TFormClass;
                              FormType   : TFormType;
                              EntryPoint : TProcedure);
begin
     inherited Create;
     Self.FormClass := FormClass;
     Self.FormType := FormType;
     Self.EntryPoint := EntryPoint;
end;

{ TEditFormList }

procedure TFormList.Clear;

var  I : Integer;

begin
     For I := 0 to Count - 1 do
       TFormItem( Items[ I ] ).Free;
     inherited;
end;

function TFormList.FindByFormClass(AFormClass: TFormClass): TFormItem;

var  I : Integer;
     FormItem : TFormItem;

begin
     Result := nil;
     For I := 0 to Count - 1 do
       begin
       FormItem := TFormItem( Items[ I ] );
       If   Assigned( FormItem )
       then If   FormItem.FormClass=AFormClass
            then begin
                 Result := FormItem;
                 Break;
                 end;
       end;
end;

initialization

     NullStrictConvert := False;
     SmartTextToDateFunc := SmartTextToDateTime;
     OnPrgExitNotification := PrgExit;

     RegisterClasses( [ TApplicationContainer,

                        TgBitBtn ] );


finalization

     SmartTextToDateFunc := nil;
     FreeAndNil( FContainer );

end.



