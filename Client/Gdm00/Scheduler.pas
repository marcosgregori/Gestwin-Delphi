
{$IMPORTEDDATA ON}

unit Scheduler;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, Buttons, ToolWin, ComCtrls, StdCtrls, ExtCtrls, AppForms,
  Menus, cxStyles, cxGraphics, cxEdit, cxScheduler, cxSchedulerStorage,
  cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerDateNavigator, cxSchedulerTimeGridView,
  cxSchedulerUtils, cxSchedulerWeekView, cxSchedulerYearView,
  cxSchedulerDBStorage, cxControls, DB, nxdb, DataManager,
  cxSchedulerHolidays, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxSchedulerPainter, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinscxPCPainter, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd,
  dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxPScxPageControlProducer, dxSkinsdxBarPainter, cxBarEditItem, dxBar,
  cxClasses, dxPSCore, dxPScxCommon, dxPScxSchedulerLnk, cxSchedulerRecurrence,
  cxSchedulerRibbonStyleEventEditor, cxSchedulerTreeListBrowser, cxSchedulerAgendaView,
  dxBarBuiltInMenu, cxSchedulerGanttView;

type
  TSchedulerForm = class(TgxForm)
    CxScheduler: TcxScheduler;
    BarManager: TdxBarManager;
    ButtonsBar: TdxBar;
    CancelButton: TdxBarLargeButton;
    DiarioButton: TdxBarLargeButton;
    LaboralButton: TdxBarLargeButton;
    SemanalButton: TdxBarLargeButton;
    MensualButton: TdxBarLargeButton;
    RejillaButton: TdxBarLargeButton;
    AnualButton: TdxBarLargeButton;
    PageSettingsButton: TdxBarLargeButton;
    PreviewButton: TdxBarLargeButton;
    PrintButton: TdxBarLargeButton;
    FormatPageButton: TdxBarLargeButton;
    AgendaButton: TdxBarLargeButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ViewButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PageSettingsButtonClick(Sender: TObject);
    procedure PreviewButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormatPageButtonClick(Sender: TObject);
  private
    AnchorDate : TdateTime;
    FSchedulerReportLink : TcxSchedulerReportLink;
    FPreviewBtnClicked,
    FPrintBtnClicked : Boolean;

  protected

  public
    class procedure DoSetupScheduler;
    procedure Setup;

  end;

var FSchedulerForm: TSchedulerForm = nil;

function CreateScheduler : TSchedulerForm;
procedure ExchangeScheduler;
procedure SetSchedulerVisible( Value : Boolean );
procedure ReleaseScheduler;

implementation

{$R *.dfm}

uses   Math,
       Registry,
       ComObj,
       AppContainer,
       DataAccess,
       PrintSystem,
       PrintPreviewWindow,
       cxDateUtils,
       dxPrnDlg,

       AppManager,

       Gdm00Dm,

       b_msg,

       dm_pga;

resourceString
       RsMsg1   = 'Planificador. %s - %s.';

function CreateScheduler : TSchedulerForm;
begin
     If   not Assigned( FSchedulerForm )
     then begin
          FSchedulerForm := TSchedulerForm.Create( Application.MainForm );
          SetSchedulerVisible( False );
          FSchedulerForm.Setup;
          end;
     Result := FSchedulerForm;
end;

procedure ExchangeScheduler;
begin
     CreateScheduler;
     SetSchedulerVisible( not ApplicationContainer.SchedulerFormVisible );
end;

procedure SetSchedulerVisible( Value : Boolean );
begin
     With ApplicationContainer, FSchedulerForm do
       begin
       Enabled := Value;
       SchedulerFormVisible := Value;
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

procedure ReleaseScheduler;
begin
     SetBarItemVisible( ApplicationContainer.SchedulerButton, False );
     If   Assigned( FSchedulerForm )
     then FSchedulerForm.Release;
end;

procedure TSchedulerForm.ViewButtonClick(Sender: TObject);

var  BarButton : TdxBarLargeButton;
begin
     BarButton := TdxBarLargeButton( Sender );
     If   not CxScheduler.ViewWeek.Active
     then AnchorDate := CxScheduler.SelectedDays[ 0 ];
     CxScheduler.SelectDays( [ AnchorDate], BarButton.Tag in [ 0, 1 ] );
     case BarButton.Tag of
       0 : CxScheduler.ViewDay.Active := True;
       1 : CxScheduler.SelectWorkDays( Date );
       2 : CxScheduler.ViewWeek.Active := True;
       3 : CxScheduler.GoToDate( CxScheduler.SelectedDays[ 0 ], vmMonth );
       4 : CxScheduler.ViewTimeGrid.Active := True;
       5 : CxScheduler.ViewYear.Active := True;
       // 6 : CxScheduler.ViewGantt.Active := True;
       7 : CxScheduler.ViewAgenda.Active := True;
  end;
end;

procedure TSchedulerForm.PrintButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.Print( FSchedulerReportLink );
end;

class procedure TSchedulerForm.DoSetupScheduler;
begin
     If   ApplicationContainer.ShowScheduler
     then CreateScheduler
     else ReleaseScheduler;
end;

procedure TSchedulerForm.FormatPageButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.DesignReport( FSchedulerReportLink );
end;

procedure TSchedulerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     If   not ApplicationContainer.TryingToCloseAllForms
     then begin
          ExchangeScheduler;
          Action := caNone;
          end;
end;

procedure TSchedulerForm.FormCreate(Sender: TObject);
begin
     FormType := fmBackground;
     AnchorDate := Date;
     CxScheduler.SelectDays( [ Date - 1, Date, Date + 1 ], True );
     FSchedulerReportLink := TcxSchedulerReportLink.Create( Self );
     FSchedulerReportLink.Component := CxScheduler;
     FSchedulerReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;
     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;
     ApplicationContainer.SchedulerActive := True;
end;

procedure TSchedulerForm.FormDestroy(Sender: TObject);
begin
     DataModule00.SchedulerDBStorage.Reminders.Active := False;
     FSchedulerForm := nil;
     ApplicationContainer.SchedulerActive := False;
end;

procedure TSchedulerForm.CancelButtonClick(Sender: TObject);
begin
     ExchangeScheduler;
end;

procedure TSchedulerForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   Enabled and ( Key=vk_escape )
     then Close;
end;

procedure TSchedulerForm.PreviewButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FSchedulerReportLink );
end;

procedure TSchedulerForm.PageSettingsButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.PageSetupEx( 0, False, True, FPreviewBtnClicked, FPrintBtnClicked, FSchedulerReportLink );
end;

procedure TSchedulerForm.Setup;

function BitFieldToTDays( BitField : Integer ) : TDays;

var  I : Byte;

function GetDayFromByte( Value : Byte ) : TDay;
begin
     If   Value=6
     then Result := dSunday
     else Result := TDay( Value + 1 );
end;

begin
     Result := [];
     For I := 0 to 6 do
       If   ( ( BitField and Trunc( Power( 2, I ) ) )<>0 )
       then Result := Result + [ GetDayFromByte( I ) ];
end;

begin
     With DataModule00, SchedulerDBStorage do
       try

         Reminders.Active := False;

         BeginUpdate;

         With Resources.Items[ 0 ] do
           begin
           ResourceID := CodigoUsuarioActual;
           Name := ApplicationContainer.Usuario_Nombre;
           Caption := Format( RsMsg1, [ ResourceID, Name ] );
           WorkDays := BitFieldToTDays( ApplicationContainer.WorkDays );
           WorkStart := ApplicationContainer.WorkStart;
           WorkFinish := ApplicationContainer.WorkFinish;
           end;

         With CxScheduler.OptionsView do
           begin
           WorkDays := Resources.Items[ 0 ].WorkDays;
           WorkStart := ApplicationContainer.WorkStart;
           WorkFinish := ApplicationContainer.WorkFinish;
           end;

       finally
         EndUpdate;
         Reminders.Active := True;
       end;
end;

//

procedure Initialize;
begin
     If   Assigned( Application.MainForm )
     then With ApplicationContainer do
            begin
            OnExchangeSchedulerForm := ExchangeScheduler;
            If   Assigned( SchedulerButton )
            then OnSetupScheduler := TSchedulerForm.DoSetupScheduler;
            end;
end;

initialization
     AddProcedure( imInitialize, 0, Initialize );

end.

