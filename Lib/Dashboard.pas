unit Dashboard;

interface

uses
  Types, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StdCtrls,
  Dialogs, Generics.Collections, System.ImageList, Vcl.ImgList, Vcl.Menus,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxClasses, dxSkinsForm, dxSkinsDefaultPainters,
  cxContainer, cxEdit, cxGroupBox, dxForms, dxCalloutPopup, ExtCtrls, cxTextEdit, cxMaskEdit, cxButtonEdit, dxCore,
  cxImageList, dxBarBuiltInMenu, cxPC, cxButtons, dxBar, dxBarExtItems,

  Spring,

  AppForms,
  AppManager,
  AppContainer,

  DashBoardSection, dxSkinsCore;

type

  TChangeDescriptionsVisibilityEvent = procedure( Visible : Boolean ) of object;

  { TDashboardForm }

  TDashboardForm = class(TgxForm)
    PageControl: TcxPageControl;
    ImageList: TcxImageList;
    BarManager: TdxBarManager;
    ButtonsBar: TdxBar;
    CancelButton: TdxBarLargeButton;
    OcultarDescripcionesButton: TdxBarLargeButton;
    RefrescarButton: TdxBarLargeButton;
    GestionContableButton: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarLargeButton4: TdxBarLargeButton;
    MessageBarStatic: TdxBarStatic;
    MesAnteriorButton: TdxBarLargeButton;
    MesSiguienteButton: TdxBarLargeButton;
    FormManager: TgxFormManager;
    procedure CancelButtonClick(Sender: TObject);
    procedure PageControlPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure RefrescarButtonClick(Sender: TObject);
    procedure OcultarDescripcionesButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MesAnteriorButtonClick(Sender: TObject);
    procedure MesSiguienteButtonClick(Sender: TObject);
    function FormManagerSaveWindowParams(
      Option: TSaveWndParamsOption): Boolean;
    procedure FormManagerReadWindowParams;
    procedure FormManagerShowForm;
  private

    FDashBoardSectionFrameList : TList<TDashBoardSectionFrame>;
    FCurrentDashboardSection : TDashBoardSectionFrame;

    // FOnChangeDescriptionsVisibility : Event<TChangeDescriptionsVisibilityEvent>;

  protected

  public

    class procedure DoSetupDashboard;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Setup;
    procedure AddDashboardSectionFrame( DashboardSectionFrame : TDashBoardSectionFrame );
    procedure RemoveDashboardSectionFrame( DashboardSectionFrame : TDashBoardSectionFrame );

    procedure ShowWidgetsHints( Value : Boolean );

    // property OnChangeDescriptionsVisibility : Event<TChangeDescriptionsVisibilityEvent> read FOnChangeDescriptionsVisibility write FOnChangeDescriptionsVisibility;

    property CurrentDashboardSection : TDashBoardSectionFrame read FCurrentDashboardSection;

  end;

var  DashboardForm: TDashboardForm = nil;

function CreateDashboard( OnSetup : TProcedure = nil ): TDashboardForm;
procedure ExchangeDashboard;
procedure SetDashboardVisible( Value : Boolean );
procedure ReleaseDashboard;

implementation

{$R *.dfm}

uses
  cxGeometry, dxCoreGraphics;

const  ParamOcultarDescripciones = 'OcultarDescripciones';

function CreateDashboard( OnSetup : TProcedure = nil ) : TDashboardForm;
begin
     If   not Assigned( DashboardForm )
     then begin

          DashboardForm := TDashboardForm.Create( Application.MainForm );
          SetDashboardVisible( False );

          If   Assigned( OnSetup )
          then OnSetup
          else begin
               DashboardForm.ID := idDashboard;
               DashboardForm.Setup;
               end;

          end;
     Result := DashboardForm;
end;

procedure ExchangeDashboard;
begin
     CreateDashboard;
     SetDashboardVisible( not ApplicationContainer.DashboardFormVisible );
end;

procedure SetDashboardVisible( Value : Boolean );
begin
     With ApplicationContainer, DashboardForm do
       begin
       Enabled := Value;
       DashboardFormVisible := Value;
       Visible := Value;
       {
       If   Value
       then begin
            If   ApplicationContainer.TDI
            then PlaceForm
            else MaximizeForm;
            BringToFront;
            end;
       }
       BringToFront;
       end;
end;

procedure ReleaseDashboard;
begin
     SetBarItemVisible( ApplicationContainer.DashboardButton, False );
     If   Assigned( DashboardForm )
     then DashboardForm.Release;
end;

{ TDashboardForm }

constructor TDashboardForm.Create(AOwner: TComponent);
begin
     FDashBoardSectionFrameList := TList<TDashBoardSectionFrame>.Create;

     inherited;

     FormType := fmBackground;

     ApplicationContainer.DashboardActive := True;
end;

destructor TDashboardForm.Destroy;
begin
     inherited;

     FreeAndNil( FDashBoardSectionFrameList );
     DashboardForm := nil;
   	 ApplicationContainer.DashboardActive := False;
end;

procedure TDashboardForm.ShowWidgetsHints( Value : Boolean );
begin
     For var DashboardSection in FDashBoardSectionFrameList do
       DashboardSection.ShowHints( Value );
end;

procedure TDashboardForm.AddDashboardSectionFrame( DashboardSectionFrame : TDashBoardSectionFrame );

var  TabSheet : TcxTabSheet;

begin
     FDashBoardSectionFrameList.Add( DashboardSectionFrame );
     TabSheet := TcxTabSheet.Create( Self );
     TabSheet.PageControl := PageControl;
     DashboardSectionFrame.Parent := TabSheet;
     If   not Assigned( FCurrentDashboardSection )
     then FCurrentDashboardSection := DashboardSectionFrame;
end;

procedure TDashboardForm.RemoveDashboardSectionFrame( DashboardSectionFrame : TDashBoardSectionFrame );
begin
     If   Assigned( FDashBoardSectionFrameList )
     then FDashBoardSectionFrameList.Remove( DashboardSectionFrame );
end;

procedure TDashboardForm.CancelButtonClick(Sender: TObject);
begin
     ExchangeDashboard;
end;

class procedure TDashboardForm.DoSetupDashboard;
begin
     If   ApplicationContainer.ShowDashboard
     then CreateDashboard.Setup
     else ReleaseDashboard;
end;

procedure TDashboardForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     If   not ApplicationContainer.TryingToCloseAllForms
     then begin
          ExchangeDashboard;
          Action := caNone;
          end;
end;

procedure TDashboardForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   Enabled and ( Key=vk_escape )
     then Close;
end;

procedure TDashboardForm.FormManagerReadWindowParams;
begin
     With FormManager do
       begin

       OcultarDescripcionesButton.Down := GetValueFromList( ParamOcultarDescripciones, False );
       OcultarDescripcionesButton.OnClick( Self );
       end;

     For var DashboardSection in FDashBoardSectionFrameList do
       DashboardSection.DoOnReadWindowParams;
end;

function TDashboardForm.FormManagerSaveWindowParams( Option: TSaveWndParamsOption ): Boolean;

var ValueList : TStringList;

begin
     If   Option=wpDelete
     then Result := ApplicationContainer.DeleteWindowState( Self )
     else begin
          ValueList := TStringList.Create;
          try

            ValueList.AddPair( ParamOcultarDescripciones, BoolToStr( OcultarDescripcionesButton.Down ) );

            For var DashboardSection in FDashBoardSectionFrameList do
              DashboardSection.DoOnSaveWindowParams( ValueList );

            Result := ApplicationContainer.SaveWindowState( Self, ValueList );

           finally
             ValueList.Free;
             end;
           end;
end;

procedure TDashboardForm.FormManagerShowForm;
begin
      If   Assigned( FCurrentDashboardSection )
      then begin
           CurrentDashboardSection.DoOnActivate;
           CurrentDashboardSection.UpdateButtonsState;
           end;
end;

procedure TDashboardForm.MesAnteriorButtonClick(Sender: TObject);
begin
     With CurrentDashboardSection do
       begin
       PreviousMonth;
       UpdateButtonsState;
       end;
end;

procedure TDashboardForm.MesSiguienteButtonClick(Sender: TObject);
begin
     With CurrentDashboardSection do
       begin
       NextMonth;
       UpdateButtonsState;
       end;
end;

procedure TDashboardForm.OcultarDescripcionesButtonClick(Sender: TObject);
begin
     ShowWidgetsHints( not OcultarDescripcionesButton.Down );
end;

procedure TDashboardForm.PageControlPageChanging( Sender: TObject; NewPage : TcxTabSheet; var AllowChange : Boolean );
begin
     var AP := PageControl.ActivePage;
     If   Assigned( AP )
     then begin
          FCurrentDashboardSection := FindComponentByClass( Ap, TDashBoardSectionFrame ) as TDashBoardSectionFrame;
          If   Assigned( FCurrentDashboardSection )
          then FCurrentDashboardSection.DoOnActivate;
          end;
end;

procedure TDashboardForm.RefrescarButtonClick(Sender: TObject);
begin
     For var DashboardSection in FDashBoardSectionFrameList do
       DashboardSection.UpdateData;
end;

procedure TDashboardForm.Setup;
begin
     ExecComponentProcedures( idDashboard, imOnCreateComponent );
end;

procedure Initialize;
begin
     If   Assigned( Application.MainForm )
     then With ApplicationContainer do
            begin
            OnExchangeDashboardForm := ExchangeDashboard;
            If   Assigned( DashboardButton )
            then OnSetupDashboard := TDashboardForm.DoSetupDashboard;
            end;
end;

initialization
  AddProcedure( imInitialize, 0, Initialize );

end.
