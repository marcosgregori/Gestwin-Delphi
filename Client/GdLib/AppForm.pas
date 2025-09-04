
{$IMPORTEDDATA ON}

unit AppForm;

interface

uses Windows,
     SysUtils,
     Classes,
     Graphics,
     Forms,
     Menus,
     Messages,
     StdCtrls,
     Dialogs,
     Buttons,
     Controls,
     ExtCtrls,
     ComCtrls,
     ImgList,
     HelpIntfs,
     ToolWin,
     Math,

     cxStyles,
     cxClasses,
     cxGridTableView,
     cxLookAndFeels,
     dxSkinsForm,
     dxSkinsDefaultPainters,
     cxLookAndFeelPainters,
     dxGDIPlusClasses,
     dxSkinsCore,

     dxSkinsdxBarPainter,
     cxGraphics,
     dxBar,
     dxBarExtItems, cxControls, cxContainer, cxEdit, cxProgressBar,
     dxSkinsdxStatusBarPainter, dxStatusBar, cxLabel, cxGroupBox, cxCalendar,
     cxBarEditItem, cxPCdxBarPopupMenu, dxScreenTip, dxCustomHint, cxDropDownEdit,
     cxTextEdit, cxMaskEdit, cxButtons, dxSkinscxPCPainter, cxPC, cxTrackBar, cxImage, cxHint,
     dxBarBuiltInMenu, cxDBLookupComboBox, cxButtonEdit,
     System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
     Vcl.AppEvnts, System.ImageList, cxImageList, dxTabbedMDI, dxAlertWindow, cxScrollBox, dxNavBar, dxUIAClasses,

     AppManager,
     AppContainer,
     AppForms,
     DataManager, cxGeometry, dxFramedControl, dxPanel;

type

  TApplicationForm = class(TgxForm)
    MainBarManager: TdxBarManager;
    GuardarContenidoItem: TdxBarLargeButton;
    GuardarCampoActivoItem: TdxBarLargeButton;
    GuardarEstadoItem: TdxBarLargeButton;
    GuardarTodoItem: TdxBarLargeButton;
    BorrarTodoItem: TdxBarLargeButton;
    SeleccionEmpresaItem: TdxBarLargeButton;
    SalirItem: TdxBarLargeButton;
    WindowLayoutPopupMenu: TdxBarPopupMenu;
    MDIChildPopupMenu: TdxBarPopupMenu;
    AppSectionsPopupMenu: TdxBarPopupMenu;
    TopBar: TdxBar;
    EditarButton: TdxBarLargeButton;
    RelacionesButton: TdxBarLargeButton;
    ConsultaButton: TdxBarLargeButton;
    AnotacionButton: TdxBarLargeButton;
    ListadoButton: TdxBarLargeButton;
    ImpresoButton: TdxBarLargeButton;
    EtiquetasButton: TdxBarLargeButton;
    GraficoButton: TdxBarLargeButton;
    AyudaButton: TdxBarLargeButton;
    SoporteButton: TdxBarLargeButton;
    FirstRecButton: TdxBarLargeButton;
    PrevRecButton: TdxBarLargeButton;
    LastRecButton: TdxBarLargeButton;
    NextRecButton: TdxBarLargeButton;
    InsertRecButton: TdxBarLargeButton;
    CopyRecButton: TdxBarLargeButton;
    SearchRecButton: TdxBarLargeButton;
    CancelSrchRecButton: TdxBarLargeButton;
    TecladoNumericoButton: TdxBarLargeButton;
    SchedulerButton: TdxBarLargeButton;
    DashboardButton: TdxBarLargeButton;
    MDIFormBarControlContainerItem: TdxBarControlContainerItem;
    StatusBar: TdxBar;
    InfoPanel: TcxGroupBox;
    ProgressPanel: TcxGroupBox;
    ProgressLabel: TcxLabel;
    ProgressBar: TcxProgressBar;
    WindowListButton: TdxBarLargeButton;
    PrevWindowButton: TdxBarLargeButton;
    NextWindowButton: TdxBarLargeButton;
    SaveParamsButton: TdxBarLargeButton;
    InfoPanelBarControlContainerItem: TdxBarControlContainerItem;
    CloseMDIFormButton: TdxBarLargeButton;
    dxBarInPlaceSubItem1: TdxBarInPlaceSubItem;
    GuardarButton: TdxBarButton;
    CancelProcessButton: TcxButton;
    CorreoButton: TdxBarLargeButton;
    WebSoporteButton: TdxBarButton;
    GuardarBarStatic: TdxBarStatic;
    SessionsBarStatic: TdxBarStatic;
    HintPanel: TcxGroupBox;
    HintLabel: TcxLabel;
    SeccionesButton: TdxBarLargeButton;
    AyudaItem: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    ContenidoAyudaItem: TdxBarButton;
    AcercaDeItem: TdxBarButton;
    LeftRestLayoutButton: TdxBarLargeButton;
    TileHortizontalLayoutButton: TdxBarLargeButton;
    TopRestLayoutButton: TdxBarLargeButton;
    TileVerticalLayoutButton: TdxBarLargeButton;
    NoneLayoutButton: TdxBarLargeButton;
    PadMenuBar: TdxBar;
    CaptionBar: TdxBarStatic;
    StyleRepository: TcxStyleRepository;
    CaptionBarStyle: TcxStyle;
    FormClientShape: TShape;
    ApplicationEvents: TApplicationEvents;
    SectionBarButton: TdxBarLargeButton;
    ImageList: TcxImageList;
    SectionBarStatic: TdxBarStatic;
    RefreshRecButton: TdxBarLargeButton;
    TabbedMDIManager: TdxTabbedMDIManager;
    CloseAllWindowsButton: TdxBarLargeButton;
    dxBarLargeButton1: TdxBarLargeButton;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    HintImage: TcxImage;
    WordprocessorButton: TdxBarLargeButton;
    RejillaConsultaButton: TdxBarLargeButton;
    procedure CancelSrchRecButtonClick(Sender: TObject);
    procedure CloseMDIFormButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
        
    procedure CancelProcessButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift : TShiftState; X, Y : Integer);
    procedure ConsultaButtonClick(Sender: TObject);
    procedure EditarButtonClick(Sender: TObject);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure ListadoButtonClick(Sender: TObject);
    procedure ImpresoButtonClick(Sender: TObject);
    procedure EtiquetasButtonClick(Sender: TObject);
    procedure GraficoButtonClick(Sender: TObject);
    procedure CopyRecButtonClick(Sender: TObject);
    procedure SearchRecButtonClick(Sender: TObject);
    procedure RecordButtonClick(Sender: TObject);
    procedure RelacionesButtonClick(Sender: TObject);
    procedure WindowListButtonClick(Sender: TObject);
    procedure AyudaButtonClick(Sender: TObject);
    procedure PrevWindowButtonClick(Sender: TObject);
    procedure NextWindowButtonClick(Sender: TObject);
    procedure SaveParamsButtonClick(Sender: TObject);
    procedure InsertRecButtonClick(Sender: TObject);
    procedure GuardarEstadoVentanaItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GuardarCampoActivoItemClick(Sender: TObject);
    procedure SchedulerButtonClick(Sender: TObject);
    procedure TecladoNumericoButtonClick(Sender: TObject);
    procedure CambioEmpresaItemClick(Sender: TObject);
    procedure SalirItemClick(Sender: TObject);
    procedure CorreoButtonClick(Sender: TObject);
    procedure HintStyleControllerShowHintEx(Sender: TObject; var Caption,HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    procedure FormDestroy(Sender: TObject);
    procedure ContenidoAyudaItemClick(Sender: TObject);
    procedure AcercaDeItemClick(Sender: TObject);
    procedure LeftRestLayoutButtonClick(Sender: TObject);
    procedure TopRestLayoutButtonClick(Sender: TObject);
    procedure TileHortizontalLayoutButtonClick(Sender: TObject);
    procedure TileVerticalLayoutButtonClick(Sender: TObject);
    procedure NoneLayoutButtonClick(Sender: TObject);
    procedure SoporteButtonClick(Sender: TObject);
    procedure SeccionesButtonClick(Sender: TObject);
    procedure ApplicationEventsShortCut(var Msg: TWMKey;var Handled: Boolean);
    procedure SectionBarButtonClick(Sender: TObject);
    procedure CloseAllWindowsButtonClick(Sender: TObject);
    procedure WordprocessorButtonClick(Sender: TObject);
    procedure RejillaConsultaButtonClick(Sender: TObject);
    procedure DashboardButtonClick(Sender: TObject);

  private

    FDocument : TComponent;

    FProgressionIndex : Integer;
    FProgressionCancelled : Boolean;
    FCurrentHintControl : TObject;
    FSavedApplicationOnMessage : TMessageEvent;
    ProgressionHits : LongInt;

    procedure Initialize;
    procedure StartProgression( AMaxRecordCount : Integer; Cancelable : Boolean = True; Doc : TComponent = nil );
    procedure ShowProgression( ProgMessage : String = ''; Percent : Integer = -1 );
    procedure EndProgression( Cancel : Boolean = False );
    function DoOnHelp( Command : Word; Data : NativeInt; var CallHelp : Boolean ) : Boolean;
    procedure DoSetupMainForm;
    procedure DoUpdateMDILayoutButtonsState( const Value : TMDILayout );
    procedure AjustaVentana;

  protected

    procedure CreateParams( var params : TCreateParams ); override;

    procedure CMUpdateDatabase( var Msg : TMessage ); message CM_UPDATEDATABASE;
    procedure CMStartProcess( var Msg : TMessage ); message CM_STARTPROCESS;
    procedure CMServerNotification( var Msg : TMessage ); message CM_SERVERNOTIFICATION;
    procedure CMInitializeDatabase( var Msg : TMessage ); message CM_INITIALIZEDATABASE;

    procedure WMDisplayChange( var Message : TWMDisplayChange ); message WM_DISPLAYCHANGE;
    procedure WMActivateApp( var Message : TWMActivateApp ); message WM_ACTIVATEAPP;

    function  GetReportActive : Boolean;
    procedure SetEnabled( Value : Boolean ); override;
    procedure ShowSectionsPopup( X, Y : Integer );
    procedure ShowWindowList;
    procedure WindowListClick(Sender : TObject);

  public

    destructor Destroy; override;

    procedure AdjustScale; override;
    function  CloseQuery: Boolean; override;
    procedure Initiate;
    procedure BeforeDestruction; override;
    procedure RegApplication;
    procedure SpeedButton( aSpeedBtn : TSpeedBtnTag );
    procedure UpdateLookAndFeel;
	   procedure ShowSectionsMenu;


    {$IFNDEF NOREPORTS}
    procedure InformeExterno( Sender : TObject );
    {$ENDIF}

    property  ReportActive : Boolean read GetReportActive;

  end;

var ApplicationForm   : TApplicationForm = nil;

implementation

{$R *.dfm}

uses   Generics.Collections,
       CommCtrl,
       NxdbBase,
       NxllException,
       DB,

       LibUtils,
       NexusRpcData,
       DataAccess,

       dxDPIAwareUtils,

       frxClass,
       frxPreview,

       ReportManager,
       QueryForm,

       dxPSCore,

       b_abo,
       b_msg,
       b_tcn;

resourceString
       RsMsg1  = '¿Esta seguro de que desea interrumpir el proceso en curso?';
       RsMsg2  = 'Cargando los módulos de la aplicación';
       RsMsg3  = 'Inicializando la aplicación';
       RsMsg4  = 'Información  ';  // Los espacios son ex profeso
       RsMsg5  = 'No he podido cargar el gestor de base de datos.';
       RsMsg7  = 'El valor introducido no es válido.';

       RsMsg8  = 'Web de soporte de GESTWIN';
       RsMsg9  = 'Foro de GESTWIN';

       RsMsg17 = 'Registro anterior.\nTeclas ';
       RsMsg18 = 'Próximo registro.\nTeclas ';
       RsMsg19 = '[Ctrl]+[RePag]';
       RsMsg20 = '[Ctrl]+[Cursor arriba]';
       RsMsg21 = '[Ctrl]+[AvPag]';
       RsMsg22 = '[Ctrl]+[Cursor abajo]';

const  AnchuraVentaDefecto = 1480;
       AlturaVentaDefecto = 900;

var    OldClientHandle : THandle = 0;
       OldClientProcPtr : Pointer = nil;

function ClientWindowProc( Wnd : HWND; Msg : Cardinal; WParam : WPARAM;  LParam : LPARAM ) : Integer; stdcall;
begin
     case Msg of
       // WM_WINDOWPOSCHANGING : ShowScrollBar( ApplicationForm.ClientHandle, SB_BOTH, False );
       WM_NCCALCSIZE        : If   ( GetWindowLong( Wnd, GWL_STYLE ) and ( WS_HSCROLL or WS_VSCROLL ) )<>0
                              then SetWindowLong( Wnd, GWL_STYLE, GetWindowLong( Wnd, GWL_STYLE) and not ( WS_HSCROLL or WS_VSCROLL ) );
       end;
     Result := CallWindowProc( OldClientProcPtr, Wnd, Msg, WParam, LParam );
end;

procedure TApplicationForm.CreateParams( var Params : TCreateParams );
begin
     inherited CreateParams( Params );
     RegApplication;
     StrCopy( Params.WinClassName, PChar( GetMFClassName ) );
end;

procedure TApplicationForm.WMActivateApp(var Message: TWMActivateApp);
begin
     ApplicationContainer.AlertWindowsVisible( Message.Active );
end;

procedure TApplicationForm.WMDisplayChange(var Message: TWMDisplayChange);
begin
     If   WebApp
     then begin

          // No utilizo WorkAreaWidth y WorkAreaHeight porque en ambos casos quiero que se ocupe toda la pantalla

          Width := Screen.Width;
          Height := Screen.Height;
          end;
end;

procedure TApplicationForm.RegApplication;
begin
end;

procedure TApplicationForm.CMStartProcess( var Msg : TMessage );
begin
     With ApplicationContainer do
       begin
       HideAboutForm;
       DoOnStart;
       end;
end;

procedure TApplicationForm.CMUpdateDatabase( var Msg : TMessage );

var  ForceCompactation : Boolean;

begin
     ForceCompactation := Msg.WParam<>0;
     ApplicationContainer.UpdateDatabase( CodigoEmpresaActual, True );
end;

procedure TApplicationForm.CMServerNotification( var Msg : TMessage );

var  Header : array[ 0..128 ] of WideChar;
     Description : array[ 0..256 ] of WideChar;

begin
     GetAtomName( Msg.LParamLo, Header, 128 );
     DeleteAtom( Msg.LParamLo );
     If   Msg.LParamHi=0
     then Description := ''
     else begin
          GetAtomName( Msg.LParamHi, Description, 256 );
          DeleteAtom( Msg.LParamHi );
          end;
     ShowNotification( TNotificationType( Msg.WParam ), String( Header ), String( Description ) );
end;

procedure TApplicationForm.CMInitializeDatabase( var Msg : TMessage );
begin
     ApplicationContainer.InitializeDatabase( True );
end;

procedure TApplicationForm.CambioEmpresaItemClick(Sender: TObject);
begin
     ApplicationContainer.DoOnStart;
end;

procedure TApplicationForm.CancelProcessButtonClick(Sender: TObject);
begin
     EndProgression( True );
end;

procedure TApplicationForm.SetEnabled(Value: Boolean);
begin
     inherited;
end;

function TApplicationForm.GetReportActive : Boolean;
begin
     Result := ProgressBar.Visible;
end;

procedure TApplicationForm.BeforeDestruction;
begin
     ApplicationContainer.DestroyingMainForm := True;
     inherited;
end;

procedure TApplicationForm.TecladoNumericoButtonClick(Sender: TObject);
begin
     MuestraTecladoNumerico;
end;

procedure TApplicationForm.TileHortizontalLayoutButtonClick(Sender: TObject);
begin
     UpdateMDILayout( mdiHorizontalTile );
end;

procedure TApplicationForm.TileVerticalLayoutButtonClick(Sender: TObject);
begin
     UpdateMDILayout( mdiVerticalTile );
end;

procedure TApplicationForm.TopRestLayoutButtonClick(Sender: TObject);
begin
     UpdateMDILayout( mdiTopRest );
end;

procedure TApplicationForm.StartProgression( AMaxRecordCount : Integer;
                                             Cancelable      : Boolean = True;
                                             Doc             : TComponent = nil  );
begin

     //** 14.04.2009  Cuando se producen progresiones anidadas, oculto el porcentaje porque ya no es relevante

     If   RunningProcess
     then begin
          Inc( FProgressionIndex );
          ProgressBar.Properties.ShowText := False;
          end
     else begin

          FProgressionIndex := 0;
          ProgressionHits := 0;

          MainMenuActive( False, True );
          With ProgressBar do
            begin
            Properties.Marquee := False;
            Position := 0;
            With Properties do
              begin
              Max := AMaxRecordCount;
              ShowText := True;
              end;
            end;

          CancelProcessButton.Enabled := Cancelable;
          InfoPanelBarControlContainerItem.Visible := ivAlways;
          ProgressPanel.Visible := True;
          RunningProcess := True;
          FDocument := Doc;
          Application.ProcessMessages;
          end;

     FProgressionCancelled := False;
end;

procedure TApplicationForm.ShowProgression( ProgMessage : String = '' ;
                                            Percent     : Integer = -1 );
begin
     If   FProgressionCancelled
     then Abort;

     If   RunningProcess
     then begin

          With ProgressBar do
            begin
            If   Percent=-1
            then Position := Position + 1
            else Position := Percent;
            If   Position=Properties.Max
            then Properties.Marquee := True;
            end;

          Inc( ProgressionHits );

          If   ProgMessage=''
          then ProgMessage := FormatFloat( '#', ProgressionHits );
          ProgressLabel.Caption := ProgMessage;

          Application.ProcessMessages;
          end;

end;

procedure TApplicationForm.EndProgression( Cancel : Boolean = False );
begin

     If   ( csDesigning  in ComponentState ) or ( csDestroying in ComponentState ) or not RunningProcess
     then Exit;

     If   Cancel
     then begin
          If   not CancelProcessButton.Enabled or  // No es cancelable
               ( ShowNotification( ntQuestionWarning, RsMsg1 )<>mrYes )
          then Exit;
          end;

     If   FProgressionIndex>1
     then Dec( FProgressionIndex )
     else try
            With ProgressBar do
              Position := Properties.Max;
            ProgressPanel.Visible := False;
            // InfoPanelBarControlContainerItem.Visible := ivNever;
            RunningProcess := False;
            {$IFNDEF NOREPORTS}
            If   Assigned( FDocument ) and ( FDocument is TfrxReport )
            then TfrxReport( FDocument ).Terminated := True;
            {$ENDIF}
          finally
            MainMenuActive( True, True );
            end;

     Application.ProcessMessages;

     If   Cancel
     then begin
          FProgressionCancelled := True;
          Abort;
          end;

end;


procedure TApplicationForm.Initiate;
begin
end;

procedure TApplicationForm.AjustaVentana;
begin

     If   WebApp or ( TabletApp and VirtualUIApp )
     then begin
          SectionBarStatic.Visible := ivAlways;
          BorderStyle := bsNone;
          BorderIcons := [];
          PrevRecButton.Hint := RsMsg17 + RsMsg20;
          NextRecButton.Hint := RsMsg18 + RsMsg22;
          WindowState := wsMaximized;
          end
     else begin

          PrevRecButton.Hint := RsMsg17 + RsMsg19;
          NextRecButton.Hint := RsMsg18 + RsMsg21;

          If   ( AlturaVentana<>0 ) or
               ( AnchuraVentana<>0 )
          then begin

               AnchuraVentana := MulDiv( AnchuraVentana, SystemScaleDPI, USER_DEFAULT_SCREEN_DPI );
               AlturaVentana := MulDiv( AlturaVentana, SystemScaleDPI, USER_DEFAULT_SCREEN_DPI );

               If   AnchuraVentana<>0
               then Width := Min( AnchuraVentana, Screen.WorkAreaWidth );
               If   AlturaVentana<>0
               then Height := Min( AlturaVentana, Screen.WorkAreaHeight );
               end
          else begin


               // WindowState := wsMaximized;

               // Si está activa la opción de Windows de acoplamiento de ventanas se produce un redimensionado
               // de la ventana al moverla por primera vez. Creo que es mejor que la versión maximizada porque
               // tiende a salirse de la ventana al mostrarse por primera vez en monitores múltiples (mu feo)

               SetBounds( 0, 0, Screen.WorkAreaWidth, Screen.WorkAreaHeight );

               end;
               
          end;

end;

procedure TApplicationForm.AdjustScale;
begin
     inherited;
     AjustaVentana;
end;

procedure TApplicationForm.Initialize;
begin

     If   ( csDesigning in ComponentState ) or InitializationError or ApplicationInitialized
     then Exit;

     ApplicationForms;

     dxBarMakeInactiveImagesDingy := False;

     With ApplicationContainer do
       begin

       // WindowListButton.Enabled := False;

       MainTopBar := TopBar;
       MainInfoPanel := InfoPanelBarControlContainerItem;
       MainStatusBar := StatusBar;

       try

         ApplicationContainer.RegisterProgram;

         // Caption := Application.Title;

         {$IFDEF DEBUGAPP}
         ExecuteProcedures( imSectionModule, [] );
         ExecuteProcedures( imOptionalSectionModule, [] );
         {$ELSE}
         LoadAppModules;
         {$ENDIF}

         OnUpdateLookAndFeel := UpdateLookAndFeel;

         {.$IFNDEF DEBUGAPP}
         ShowAboutForm( False );
         {.$ENDIF}

         If   Assigned( AboutForm )
         then AboutForm.ShowInfoMessage( RsMsg2 );

         {$IFNDEF DEBUGAPP}

         If   Assigned( OnInitAppModules )
         then OnInitAppModules;

         {$ENDIF}

         If   not UnProtectedApp
         then CheckProtection( True, DataAccessMode=dmRemote );

         ApplicationInitialized := True;

         ExecuteProcedures( imInitialize, [] );

         NexusRpc;   // Esto arranca el servidor

         If   not InitializationError and
              not DatabaseUpdateRequested
         then begin

              DataAccessModule;   // Arrancando la base de datos global

              ExecuteProcedures( imStartUp, [] );  // Iniciando, entre otras cosas, las bases de datos de cada módulo

              If   Assigned( AboutForm )
              then AboutForm.ShowInfoMessage( RsMsg3 );

              {$IFNDEF NOREPORTS}
              OnExternalReport := InformeExterno;
              {$ENDIF}
              InitializeAppSections;

              Initiate;

              ShowApplicationLicense;

              If   WebApp
              then SessionsBarStatic.ImageIndex := 2
              else If   VirtualUIApp
                   then SessionsBarStatic.ImageIndex := 1;

              end
         else Abort;

       except on e : exception do
         begin
         // Si ya se ha gestionado el error no hace falta mostrar más mensajes
         If   not InitializationError and
              not DatabaseUpdateRequested
         then begin
              ShowNotification( ntWarning, RsgMsg408, E.Message );
              PrgExit( False );
              InitializationError := True;
              end;
         If   DatabaseUpdateRequested
         then WindowState := wsMinimized;
         Exit;
         end;
       end;

       end;

     If   not InitializationError
     then PostMessage( Handle, CM_STARTPROCESS, 0, 0 );

end;

procedure TApplicationForm.FormCreate(Sender: TObject);

var CurClientProcPtr : Pointer;
        
begin

     MainBarManager.BeginUpdate;
     
     With Application do
       begin
       OnException := ApplicationManager.DoOnException;
       HintHidePause := 60000;  // Por defecto son 2500 ms
       end;

     ClientShape := FormClientShape;   // Muy importante para poder determinar el tamaño del área de cliente o desktop

     ApplicationContainer.MainBarManager := MainBarManager;
     ApplicationContainer.SectionBarStatic := SectionBarStatic;
     ApplicationContainer.PadMenuBar := PadMenuBar;
     ApplicationContainer.SectionBarButton := SectionBarButton;
     ApplicationContainer.AppSectionsPopupMenu := AppSectionsPopupMenu;
     ApplicationContainer.TabbedMDIManager := TabbedMDIManager;
     ApplicationContainer.SessionsBarStatic := SessionsBarStatic;
     ApplicationContainer.HintPanel := HintPanel;
     ApplicationContainer.HintLabel := HintLabel;

     ApplicationContainer.EditButton := EditarButton;
     ApplicationContainer.QueryGridButton := RejillaConsultaButton;
     ApplicationContainer.RelationsButton := RelacionesButton;
     ApplicationContainer.QueryButton := ConsultaButton;
     ApplicationContainer.NoteButton := AnotacionButton;
     ApplicationContainer.ReportButton := ListadoButton;
     ApplicationContainer.FormReportButton := ImpresoButton;
     ApplicationContainer.LabelButton := EtiquetasButton;
     ApplicationContainer.GraphicButton := GraficoButton;
     ApplicationContainer.SectionsButton := SeccionesButton;

     ApplicationContainer.FirstRecButton := FirstRecButton;
     ApplicationContainer.PreviousRecButton := PrevRecButton;
     ApplicationContainer.RefreshRecButton := RefreshRecButton;
     ApplicationContainer.NextRecButton := NextRecButton;
     ApplicationContainer.LastRecButton := LastRecButton;
     ApplicationContainer.InsertRecButton := InsertRecButton;
     ApplicationContainer.CopyRecButton := CopyRecButton;
     ApplicationContainer.SearchRecButton := SearchRecButton;
     ApplicationContainer.CancelSrchRecButton := CancelSrchRecButton;
     ApplicationContainer.SchedulerButton := SchedulerButton;
     ApplicationContainer.DashboardButton := DashboardButton;
     ApplicationContainer.WordprocessorButton := WordprocessorButton;
     ApplicationContainer.SaveParamsButton := SaveParamsButton;
     ApplicationContainer.NumericKeyboardButton := TecladoNumericoButton;
     ApplicationContainer.MailButton := CorreoButton;
     // ApplicationContainer.UpgradeButton := ActualizarButton;

     ApplicationContainer.OnUpdateMDILayoutButtonsState := DoUpdateMDILayoutButtonsState;
     ApplicationContainer.OnSetupMainForm := DoSetupMainForm;
     ApplicationContainer.OnStartProgression := StartProgression;
     ApplicationContainer.OnShowProgression := ShowProgression;
     ApplicationContainer.OnEndProgression := EndProgression;

     OnHelp := DoOnHelp;
     Application.OnHelp := DoOnHelp;

     ApplicationContainer.CurrentMDILayout := mdiNone;

     If   VirtualUIApp
     then SetMinMaxAnimation( False );

     If   not WebApp
     then Position := poScreenCenter;

     With MainBarmanager.LookAndFeel do
       begin
       SkinName := '';
       AssignedValues := [];   // Si se queda asignado por error la piel del BarManager no cambia
       end;

end;

procedure TApplicationForm.DoSetupMainForm;
begin
     
     MainBarManager.BeginUpdate;
     try
       SetBarItemsVisible( [ NoneLayoutButton, LeftRestLayoutButton, TopRestLayoutButton ], not ApplicationContainer.TDI );
     finally
       MainBarManager.EndUpdate;
       end;
end;

procedure TApplicationForm.DoUpdateMDILayoutButtonsState( const Value : TMDILayout );
begin

     // A pesar de que se llama también tras pulsar el usuario sobre el botón, no produce ningun proceso circular (el Down := True no provoca un Click)

     case Value of
       mdiNone     : NoneLayoutButton.Down := True;
       mdiLeftRest : LeftRestLayoutButton.Down := True;
       mdiTopRest  : TopRestLayoutButton.Down := True;
       end;

end;

procedure TApplicationForm.RejillaConsultaButtonClick(Sender: TObject);
begin
     SpeedButton( sbnQueryGrid );
end;

procedure TApplicationForm.WordprocessorButtonClick(Sender: TObject);
begin
     ApplicationContainer.ExchangeWordProcessorForm;
end;

procedure TApplicationForm.CloseAllWindowsButtonClick(Sender: TObject);
begin
     ApplicationContainer.CanCloseAllForms;
end;

procedure TApplicationForm.FormDestroy(Sender: TObject);
begin
     //..
end;

destructor TApplicationForm.Destroy;
begin

     inherited;

     // Debe producirse tras la destrucción total del form principal
     
     {$IFNDEF DEBUGAPP}
     ApplicationContainer.UnloadAppModules;
     {$ENDIF}
end;

function TApplicationForm.CloseQuery: Boolean;

var   I : Integer;

begin

     // He interceptado esta función porque se puede producir el cierre de algunas ventanas durante la comprobación, sobre todo
     // al desactivarse ventanas de consulta o temporales cuando se muestra una ventana modal de confirmación.

     Result := False;

     try

       // Un caso especial : cuando en TS-Plus se cierra el navegador directamente, ésta parece ser la única forma de
       // interceptar a tiempo el cierre (el proceso se mata a lo bruto y no da tiempo a más)

       If   WebApp
       then begin
            NexusRpc.FreeSessionService;
            // NexusRpc.SessionService.CloseSession;  // Sustituido por NexusRpc.FreeSessionService para intentar destruir la sesión desde el cliente y no directamente en el servidor
            Result := True;
            end;

       ApplicationContainer.ApplicationFormCloseQuery := True;

       try
         For I := 0 to MDIChildCount - 1 do
           If   Assigned( MDIChildren[ I ] ) and not MDIChildren[ I ].CloseQuery
           then Exit;
       except
         Exit;
         end;

       Result := True;

     finally
       ApplicationContainer.ApplicationFormCloseQuery := False;
       end;
end;

procedure TApplicationForm.FormClose(     Sender : TObject;
                                      var Action : TCloseAction);
begin
     If   not ReleasingApplication
     then If   PrgExit( True )
          then Action := caFree
          else Action := caNone;
end;

procedure TApplicationForm.FormMouseDown( Sender : TObject;
                                          Button : TMouseButton;
                                          Shift  : TShiftState;
                                          X,
                                          Y      : Integer);
begin
     If   Button=mbRight
     then ShowSectionsPopup( X, Y );
end;

procedure TApplicationForm.ShowSectionsPopup( X, Y : Integer );

var   P : TPoint;

begin
     If   Assigned( ApplicationContainer.CurrentSection ) and
          ( ApplicationContainer.IsMenuBarActive ) and
          ( SeccionesButton.Enabled )
     then begin
          P.X := X;
          P.Y := Y;
          P := ClientToScreen( P );
          ApplicationContainer.AppSectionsPopupMenu.Popup( P.X, P.Y );
          end;
end;

procedure TApplicationForm.ShowSectionsMenu;

var  ItemLink : TdxBarItemLink;

begin
     { Cuidado con la posición del menú. Si está fuera del área de cliente la escala
      puede ser errónea. De ahí los 2 pixels de margen }

     ItemLink := GetItemLinkByBarItem( TopBar, SeccionesButton );
     If   Assigned( ItemLink )
     then ShowSectionsPopup( ItemLink.Control.ViewInfo.Bounds.Left + 2, GetDesktopTop + 2 );
end;

procedure TApplicationForm.UpdateLookAndFeel;
begin

     // Quitando efectos visuales molestos en modo TS

     If   VirtualUIApp
     then begin
          MainBarManager.MenuAnimations := maNone;
          TcxHintStyle( ApplicationContainer.HintStyleController.HintStyle ).Animate := cxhaNone;
          end;

     Refresh;

end;

procedure TApplicationForm.SpeedButton( ASpeedBtn : TSpeedBtnTag );
begin

     //** 14.06.2023 He añadido la posibilidad de imprimir informes directamente desde las rejillas de consulta

     If   ( ASpeedBtn in RecordSpeedBtns ) and Assigned( ActiveRecordButtonLink )
     then ActiveRecordButtonLink.RecordBtnPressed( aSpeedBtn )
     else If   ( ASpeedBtn=sbnFormReport ) and  Assigned( ActiveQueryPanel ) and ( ActiveQueryPanel.OwnerForm.Active )
          then ActiveQueryPanel.DoOnFormReport
          else If   Assigned( ActiveFormManager )
               then ActiveFormManager.SpeedBtnPressed( aSpeedBtn );
end;

procedure TApplicationForm.ConsultaButtonClick(Sender: TObject);
begin
     SpeedButton( sbnQuery );
end;

procedure TApplicationForm.EditarButtonClick(Sender: TObject);
begin
     SpeedButton( sbnEdit );
end;

procedure TApplicationForm.RelacionesButtonClick(Sender: TObject);
begin
     SpeedButton( sbnRelatedDocs );
end;

procedure TApplicationForm.AcercaDeItemClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

procedure TApplicationForm.AnotacionButtonClick(Sender: TObject);
begin
     SpeedButton( sbnNote );
end;

procedure TApplicationForm.ApplicationEventsShortCut( var Msg     : TWMKey;
                                                      var Handled : Boolean );
begin
     case Msg.CharCode of
       VK_F10 :
         begin
         If   Assigned( ApplicationContainer.CurrentMainMenuBar )
         then ApplicationContainer.CurrentMainMenuBar.Control.BarGetFocus( nil );
         Handled := True;
         end;
       end;
end;

procedure TApplicationForm.LeftRestLayoutButtonClick(Sender: TObject);
begin
     UpdateMDILayout( mdiLeftRest );
end;

procedure TApplicationForm.ListadoButtonClick(Sender: TObject);
begin
     SpeedButton( sbnReport );
end;

procedure TApplicationForm.CorreoButtonClick(Sender: TObject);
begin
     ApplicationContainer.ShowMailForm;
end;

procedure TApplicationForm.ImpresoButtonClick(Sender: TObject);
begin
     SpeedButton( sbnFormReport );
end;

procedure TApplicationForm.EtiquetasButtonClick(Sender: TObject);
begin
     SpeedButton( sbnLabels );
end;

procedure TApplicationForm.GraficoButtonClick(Sender: TObject);
begin
     SpeedButton( sbnGraphic );
end;

procedure TApplicationForm.CopyRecButtonClick(Sender: TObject);
begin
     SpeedButton( sbnCopyRec );
end;

procedure TApplicationForm.SearchRecButtonClick(Sender: TObject);
begin
     SpeedButton( sbnSearchRec );
end;

procedure TApplicationForm.SeccionesButtonClick(Sender: TObject);
begin
    ShowSectionsMenu;
end;

procedure TApplicationForm.SectionBarButtonClick(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

procedure TApplicationForm.CancelSrchRecButtonClick(Sender: TObject);
begin
     SpeedButton( sbnCancelSrchRec );
end;

procedure TApplicationForm.InsertRecButtonClick(Sender: TObject);
begin
     SpeedButton( sbnInsertRec );
end;

procedure TApplicationForm.SalirItemClick(Sender: TObject);
begin
     PrgExit( True );
end;

procedure TApplicationForm.SaveParamsButtonClick(Sender: TObject);

var  P : TPoint;
     ItemLink : TdxBarItemLink;

begin
     With WindowLayoutPopupMenu do
       begin
       SetBarItemVisible( GuardarContenidoItem, ( Assigned( ActiveFormManager ) and ( ActiveFormManager.Model in [ fmReportForm, fmInputForm, fmPersistentInputForm ] ) ) );
       SetBarItemVisible( GuardarCampoActivoItem, GuardarContenidoItem.ActuallyVisible or ( ( Assigned( ActiveFormManager ) ) and ( ActiveFormManager.Model=fmEditForm ) ) );
       SetBarItemVisible( GuardarTodoItem, GuardarContenidoItem.ActuallyVisible );
       ItemLink := GetItemLinkByBarItem( StatusBar, SaveParamsButton );
       If   Assigned( ItemLink )
       then begin
            P.X := ItemLink.Control.ViewInfo.Bounds.Left;
            P.Y := Self.ClientHeight - StatusBar.Control.Height - GetBarPopupMenuHeight( WindowLayoutPopupMenu ) - 4;
            P := ClientToScreen( P );
            Popup( P.X, P.Y );
            end;
       end;
end;

procedure TApplicationForm.SchedulerButtonClick(Sender: TObject);
begin
     ApplicationContainer.ExchangeSchedulerForm;
end;

procedure TApplicationForm.AyudaButtonClick(Sender: TObject);
begin
     ShowHelp;
end;

function TApplicationForm.DoOnHelp (     Command  : Word;
                                         Data     : NativeInt;
                                     var CallHelp : Boolean ) : Boolean;
begin
     ShowHelp;
     CallHelp := False;
     Result := True;
end;

procedure TApplicationForm.ContenidoAyudaItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure TApplicationForm.RecordButtonClick(Sender: TObject);
begin
     If   Assigned( ActiveRecordButtonLink )
     then ActiveRecordButtonLink.RecordBtnPressed( TComponent( Sender ).Tag );
end;

{$IFNDEF NOREPORTS}
procedure TApplicationForm.InformeExterno( Sender : TObject );

var   MenuOption : TdxBarButton;

begin
     If   Sender is TdxBarButton
     then begin
          MenuOption := TdxBarButton( Sender );
          With TgxReportManager.Create( Self ) do
            try
              try
                Title := MenuOption.Caption;
                FileName := MenuOption.Hint;
                Load;
                Start;
             except on E : Exception do Cancel( E );
               end;
            finally
              Free;
              end;
          end;
end;
{$ENDIF}

procedure TApplicationForm.ShowWindowList;

var   Index : SmallInt;
      ActiveWindowHandle : HWnd;
      P : TPoint;
      FirstReport,
      BeginGroup : Boolean;
      MDIForm : TForm;
      ItemLink : TdxBarItemLink;

procedure AddMenuItem( ACaption      : String;
                       AWindowHandle : hWnd;
                       BeginGroup    : Boolean = False );

var  BarButton : TdxBarButton;
     Link : TdxBarItemLink;

begin
     BarButton := MDIChildPopupMenu.BarManager.AddButton;
     If   Assigned( BarButton )
     then With BarButton do
            begin
            Caption := ACaption;
            Tag := AWindowHandle;
            ButtonStyle := bsChecked;
            Down := AWindowHandle=ActiveWindowHandle;
            If   AWindowHandle<>0
            then OnClick := WindowListClick;
            Link := MDIChildPopupMenu.ItemLinks.Add;
            Link.Item := BarButton;
            Link.BeginGroup := BeginGroup;
            end;
end;

begin

     MDIChildPopupMenu.ItemLinks.Clear;

     ActiveWindowHandle := SendMessage( ClientHandle, WM_MDIGETACTIVE, 0, 0 );

     {$IFNDEF NOREPORTS}

     // Primero añado las ventanas ordinarias

     try

       For Index := 0 to MDIChildCount - 1 do
         begin
         MDIForm := MDIChildren[ Index ];
         If   MDIForm is TgxForm and
              not ( MDIForm is TfrxPreviewForm )
         then With MDIForm as TgxForm do
                If   Enabled and Visible and ( FormType<>fmQuery )
                then AddMenuItem( Caption, Handle );
         end;

       // Y ahora los reports

       FirstReport := True;

       For Index := 0 to MDIChildCount - 1 do
         If   MDIChildren[ Index ] is TfrxPreviewForm
         then begin
              If   FirstReport
              then begin
                   BeginGroup := MDIChildPopupMenu.ItemLinks.Count>0;
                   FirstReport := False;
                   end
              else BeginGroup := False;

              With TfrxPreviewForm( MDIChildren[ Index ] ) do
                AddMenuItem( Caption, Handle, BeginGroup );
              end;

     except
       end;

     {$ENDIF}

     With MDIChildPopupMenu do
       If   ItemLinks.Count>0
       then begin
            ItemLink := GetItemLinkByBarItem( StatusBar, WindowListButton );
            If   Assigned( ItemLink )
            then begin
                 P.X := ItemLink.Control.ViewInfo.Bounds.Left;
                 P.Y := Self.ClientHeight - StatusBar.Control.Height - GetBarPopupMenuHeight( MDIChildPopupMenu ) - 4;
                 P := ClientToScreen( P );
                 Popup( P.X, P.Y );
                 end;
            end;

end;

procedure TApplicationForm.SoporteButtonClick(Sender: TObject);
begin
     ApplicationContainer.ShowWebForm( WebSoporte, RsMsg8 );
end;

procedure TApplicationForm.WindowListClick( Sender: TObject );

var  I : SmallInt;
     AForm : TForm;

begin
     If   Sender is TComponent
     then begin
          AForm := nil;
          For I := 0 to MDIChildCount - 1 do
            If   MDIChildren[ I ].Handle=TComponent( Sender ).Tag
            then begin
                 AForm := MDIChildren[ I ];
                 Break;
                 end;
          If   Assigned( AForm )
          then begin
               If   AForm.WindowState=wsMinimized
               then SendMessage( AForm.Handle, WM_SYSCOMMAND, SC_RESTORE, 0 );
               SendMessage( ClientHandle, WM_MDIACTIVATE, AForm.Handle, 0 );
               end;
          end;
end;

procedure TApplicationForm.WindowListButtonClick(Sender: TObject);
begin
     ShowWindowList;
end;

procedure TApplicationForm.DashboardButtonClick(Sender: TObject);
begin
     ApplicationContainer.ExchangeDashboardForm;
end;

procedure TApplicationForm.PrevWindowButtonClick(Sender: TObject);
begin
     Previous;
end;

procedure TApplicationForm.NextWindowButtonClick(Sender: TObject);
begin
     Next;
end;

procedure TApplicationForm.NoneLayoutButtonClick(Sender: TObject);
begin
     UpdateMDILayout( mdiNone );
end;

procedure TApplicationForm.GuardarCampoActivoItemClick(Sender: TObject);
begin
     If   Assigned( ActiveFormManager )
     then ActiveFormManager.DoSaveWindowParams( wpOneField );
end;

procedure TApplicationForm.GuardarEstadoVentanaItemClick( Sender : TObject );
begin
     var SaveWndParamsOption := TSaveWndParamsOption( TMenuItem( Sender ).Tag );
     If   Assigned( ActiveFormManager )
     then ActiveFormManager.DoSaveWindowParams( SaveWndParamsOption )
     else If   Assigned( ActiveQueryPanel )
          then If   SaveWndParamsOption=wpDelete
               then ActiveQueryPanel.DeleteQueryState
               else ActiveQueryPanel.SaveQueryState( { SaveLayout } True );
end;

procedure TApplicationForm.HintStyleControllerShowHintEx(     Sender   : TObject;
                                                          var Caption,
                                                              HintStr  : string;
                                                          var CanShow  : Boolean;
                                                          var HintInfo : THintInfo);
begin
     CanShow := not ( ( HintInfo.HintControl=ApplicationContainer.CurrentHintPanelControl ) and InfoPanelBarControlContainerItem.VisibleForUser );
     If   CanShow
     then begin
          FCurrentHintControl := HintInfo.HintControl;
          HintInfo.HintMaxWidth := 300;
          // La única secuencia de escape que utilizo es \n (new line)
          HintStr := StringReplace( HintStr, '\n', #13, [ rfReplaceAll, rfIgnoreCase ] );
          end;
end;

procedure TApplicationForm.FormShow(Sender: TObject);

var CurClientProcPtr : Pointer;

begin
     // Evitando que se vean los ScrollBars

     If   ClientHandle<>0
     then begin
          CurClientProcPtr := Pointer( GetWindowLong( ClientHandle, GWL_WNDPROC ) );
          If   CurClientProcPtr<>@ClientWindowProc
          then begin
               OldClientHandle := ClientHandle;
               OldClientProcPtr := CurClientProcPtr;
               SetWindowLong( ClientHandle, GWL_WNDPROC, Integer( @ClientWindowProc ) );
               end;
          end;
     Initialize;
     MainBarManager.EndUpdate;
end;

procedure TApplicationForm.FormResize(Sender: TObject);
begin

     If   Visible
     then begin

          PadMenuBar.DockedLeft := Width;

          UpdateMDILayout( ApplicationContainer.CurrentMDILayout );

          If   Assigned( TecladoFrame )
          then TecladoFrame.UpdatePos;

          end;

end;

procedure TApplicationForm.CloseMDIFormButtonClick(Sender: TObject);
begin
     If   Assigned( ActiveMDIChild )
     then ActiveMDIChild.Close;
end;

initialization
   RegisterClasses( [ TApplicationForm ] );

end.

