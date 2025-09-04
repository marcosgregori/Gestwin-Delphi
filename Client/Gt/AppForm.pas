
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
     Vcl.AppEvnts, System.ImageList, cxImageList, dxTabbedMDI,

     SBUtils,

     AppManager, 
     AppContainer,
     AppForms,
     DataManager, dxAlertWindow, cxSplitter;

type

  TApplicationForm = class(TgxForm)
    DataPanel: TcxGroupBox;
    QueryPanel: TcxGroupBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift : TShiftState; X, Y : Integer);
    procedure FormDestroy(Sender: TObject);

  private

    FDocument : TComponent;

    FProgressionIndex : Integer;
    FProgressionCancelled : Boolean;
    FCurrentHintControl : TObject;
    ProgressionHits : LongInt;

    procedure Initialize;
    function DoOnHelp( Command : Word; Data : NativeInt; var CallHelp : Boolean ) : Boolean;
    procedure DoSetupMainForm;

  protected

    procedure CreateParams( var params : TCreateParams ); override;

    procedure CMUpdateDatabase( var Msg : TMessage ); message CM_UPDATEDATABASE;
    procedure CMStartProcess( var Msg : TMessage ); message CM_STARTPROCESS;
    procedure CMServerNotification( var Msg : TMessage ); message CM_SERVERNOTIFICATION;
    procedure CMInitializeDatabase( var Msg : TMessage ); message CM_INITIALIZEDATABASE;
    
    procedure WMDisplayChange( var Message : TWMDisplayChange ); message WM_DISPLAYCHANGE;
    procedure WMActivateApp( var Message : TWMActivateApp ); message WM_ACTIVATEAPP;
    
    procedure SetEnabled( Value : Boolean ); override;

  public

    destructor Destroy; override;

    function  CloseQuery: Boolean; override;
    procedure Initiate;
    procedure BeforeDestruction; override;
    procedure RegApplication;
    procedure UpdateLookAndFeel;

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

{

var    OldClientHandle : THandle = 0;
       OldClientProcPtr : Pointer = nil;
       
function ClientWindowProc( Wnd : HWND; Msg : Cardinal; WParam : WPARAM;  LParam : LPARAM ) : Integer; stdcall;
begin
     case Msg of
       WM_WINDOWPOSCHANGING : ShowScrollBar( ApplicationForm.ClientHandle, SB_BOTH, False );
       WM_NCCALCSIZE        : If   ( GetWindowLong( Wnd, GWL_STYLE ) and ( WS_HSCROLL or WS_VSCROLL ) )<>0
                              then SetWindowLong( Wnd, GWL_STYLE, GetWindowLong( Wnd, GWL_STYLE) and not ( WS_HSCROLL or WS_VSCROLL ) );
       end;
     Result := CallWindowProc( OldClientProcPtr, Wnd, Msg, WParam, LParam );
end;
}

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
     If   TabletApp or VirtualUIApp
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

{
procedure TApplicationForm.CambioEmpresaItemClick(Sender: TObject);
begin
     ApplicationContainer.DoOnStart;
end;
}

procedure TApplicationForm.SetEnabled(Value: Boolean);
begin
     inherited;
end;

procedure TApplicationForm.BeforeDestruction;
begin
     ApplicationContainer.DestroyingMainForm := True;
     inherited;
end;

procedure TApplicationForm.Initiate;
begin
end;

procedure TApplicationForm.Initialize;
begin

     If   ( csDesigning in ComponentState ) or InitializationError or ApplicationInitialized
     then Exit;

     ApplicationForms;

     With ApplicationContainer do
       begin

       try

         ApplicationContainer.RegisterProgram;

         Caption := Application.Title;

         {$IFDEF DEBUGAPP}
         ExecuteProcedures( imSectionModule, [] );
         ExecuteProcedures( imOptionalSectionModule, [] );
         {$ELSE}
         LoadAppModules;
         {$ENDIF}

         OnUpdateLookAndFeel := UpdateLookAndFeel;

         {$IFNDEF DEBUGAPP}
         ShowAboutForm( False );
         {$ENDIF}

         If   Assigned( AboutForm )
         then AboutForm.ShowInfoMessage( RsMsg2 );

         {$IFNDEF DEBUGAPP}

         If   Assigned( OnInitAppModules )
         then OnInitAppModules;

         {$ENDIF}

         {
         If   not UnProtectedApp
         then CheckProtection( True, DataAccessMode=dmRemote );
         }

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

              InitializeAppSections;

              Initiate;

              ShowApplicationLicense;

              If   DataAccessTransport=dtWinsock
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
begin

     With Application do
       begin
       OnException := ApplicationManager.DoOnException;
       HintHidePause := 60000;  // Por defecto son 2500 ms
       end;

     ApplicationContainer.DataPanel := DataPanel;
     ApplicationContainer.QueryPanel := QueryPanel;

     ApplicationContainer.OnSetupMainForm := DoSetupMainForm;

     OnHelp := DoOnHelp;
     Application.OnHelp := DoOnHelp;

     If   VirtualUIApp
     then SetMinMaxAnimation( False )
     else Position := poScreenCenter;

end;

procedure TApplicationForm.DoSetupMainForm;
begin
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
     then ; //
end;

procedure TApplicationForm.UpdateLookAndFeel;
begin

     // Quitando efectos visuales molestos en modo TS

     If   VirtualUIApp
     then TcxHintStyle( ApplicationContainer.HintStyleController.HintStyle ).Animate := cxhaNone;

     Refresh;
end;

{
procedure TApplicationForm.AyudaButtonClick(Sender: TObject);
begin
     ShowHelp;
end;
}

function TApplicationForm.DoOnHelp (     Command  : Word;
                                         Data     : NativeInt;
                                     var CallHelp : Boolean ) : Boolean;
begin
     ShowHelp;
     CallHelp := False;
     Result := True;
end;

procedure TApplicationForm.FormShow(Sender: TObject);
begin
     Initialize;
end;

initialization
   RegisterClasses( [ TApplicationForm ] );

end.

