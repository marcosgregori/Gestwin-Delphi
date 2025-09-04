unit Gantt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, Generics.Collections,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxClasses,
  cxControls, Menus, Buttons, ExtCtrls, AppForms,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, cxLookAndFeels,
  dxSkinsdxBarPainter, cxBarEditItem, dxBar, cxExport,
  cxNavigator, dxCore, dxCoreClasses, dxHashUtils, cxFontNameComboBox,
  cxDropDownEdit, cxColorComboBox, System.Actions,
  Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList, cxImageList,
  dxGanttControl, dxGanttControlCustomSheet, dxGanttControlViewChart,
  dxGanttControlViewResourceSheet, dxGanttControlViewTimeline,
  dxGanttControlTasks, dxGanttControlAssignments, dxGanttControlResources,
  dxGanttControlCustomClasses;



type TGanttForm = class(TgxForm)

       GanttControl: TdxGanttControl;
    BarManager: TdxBarManager;
    ButtonsBar: TdxBar;
    CancelButton: TdxBarLargeButton;
    HorasButton: TdxBarLargeButton;
    MediosDiasButton: TdxBarLargeButton;
    DiasButton: TdxBarLargeButton;
    PageSettingsButton: TdxBarLargeButton;
    PreviewButton: TdxBarLargeButton;
    PrintButton: TdxBarLargeButton;
    FormatPageButton: TdxBarLargeButton;
    CronologiaButton: TdxBarLargeButton;

       procedure FormCreate(Sender: TObject);
       procedure FormClose(Sender: TObject; var Action: TCloseAction);
       procedure FormDestroy(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure HorasButtonClick(Sender: TObject);
    procedure DiasButtonClick(Sender: TObject);
    procedure MediosDiasButtonClick(Sender: TObject);
    procedure CronologiaButtonClick(Sender: TObject);

    private

    public

      destructor Destroy; override;

    published

    end;

var  CurrenTGanttForm : TGanttForm = nil;

procedure DiagramaGantt;

implementation

uses  LibUtils,

      AppManager,
      EnterpriseDataAccess,

      b_msg;

{$R *.dfm}

resourceString
      RsMsg1  = '';

{ TGanttForm }

procedure DiagramaGantt;
begin
     LastGanttFormReference := nil;
     CreateForm( fmBackground, TGanttForm, LastGanttFormReference, [], False );
     CurrenTGanttForm := TGanttForm( LastGanttFormReference );
end;

procedure TGanttForm.FormDestroy(Sender: TObject);
begin
     CurrenTGanttForm := nil;
end;

procedure TGanttForm.DiasButtonClick(Sender: TObject);
begin
     GanttControl.ViewChart.TimescaleUnit := TdxGanttControlChartViewTimescaleUnit.Days;
end;

procedure TGanttForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
end;

procedure TGanttForm.FormCreate(Sender: TObject);
begin
     //.
end;

procedure TGanttForm.CancelButtonClick(Sender: TObject);
begin
     Close;
end;

procedure TGanttForm.CronologiaButtonClick(Sender: TObject);
begin
     If   CronologiaButton.Down
     then GanttControl.ViewChart.Active := True
     else GanttControl.ViewTimeLine.Active := True;
end;

destructor TGanttForm.Destroy;
begin
     inherited;
end;

procedure TGanttForm.HorasButtonClick(Sender: TObject);
begin
     GanttControl.ViewChart.TimescaleUnit := TdxGanttControlChartViewTimescaleUnit.Hours;
end;

procedure TGanttForm.MediosDiasButtonClick(Sender: TObject);
begin
     GanttControl.ViewChart.TimescaleUnit := TdxGanttControlChartViewTimescaleUnit.QuarterDays;
end;

end.
