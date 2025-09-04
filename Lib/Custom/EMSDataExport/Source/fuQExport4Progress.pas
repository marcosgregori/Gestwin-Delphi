unit fuQExport4Progress;
{$I QExport4VerCtrl.inc}
interface

uses
  {$IFDEF VCL16}
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Classes,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
  {$ELSE}
    Windows,
    Classes,
    Messages,
    SysUtils,
    Controls,
    Forms,
    StdCtrls,
    ExtCtrls,
  {$ENDIF}
  QExport4, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxGroupBox, Vcl.Menus, cxButtons, Comun, cxLabel;

const
  WM_QEXPORT_PROGRESS = WM_USER + 1;

  QEP_START = 1;
  QEP_FETCHED = 2;
  QEP_SKIPPED = 3;
  QEP_EXPORTED = 4;
  QEP_PAUSE = 5;
  QEP_CONTINUE = 6;
  QEP_ABORT = 7;
  QEP_FINISH = 8;
  QEP_DONE = 9;

type
  TQExportStatus = (estBegin, estSkipping, estFetching, estExporting, estPause,
    estContinue, estAbort, estEnd);

  TfmQExport4Progress = class(TForm)
    paButtons: TcxGroupBox;
    bButton: TgBitBtn;
    paInfo: TcxGroupBox;
    laStatusValue: TcxLabel;
    laStatus: TcxLabel;
    laExported: TcxLabel;
    laExportedValue: TcxLabel;
    laTime: TcxLabel;
    laTimeValue: TcxLabel;
    tmTimer: TTimer;
    laSpeed: TcxLabel;
    laSpeedValue: TcxLabel;
    procedure tmTimerTimer(Sender: TObject);
    procedure bButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FExportedRows: integer;
    FFetchedRows: integer;
    FStatus: TQExportStatus;
    FTime: TDateTime;
    FQExport: TQExport4;
    FSkippedRows: integer;

    procedure SetSkippedRows(const Value: integer);
    procedure SetExportedRows(Value: integer);
    procedure SetFetchedRows(const Value: integer);

    procedure SetStatus(const Value: TQExportStatus);
  protected
    procedure CreateParams( var Params: TCreateParams ); override;
    procedure ExportProgress(var Msg: TMessage); message WM_QEXPORT_PROGRESS;
  public
    constructor CreateProgress(AOwner: TComponent; AQExport: TQExport4);
    procedure ShowTime;

    property SkippedRows: integer read FSkippedRows write SetSkippedRows;
    property ExportedRows: integer read FExportedRows write SetExportedRows;
    property FetchedRows: integer read FFetchedRows write SetFetchedRows;
    property Status: TQExportStatus read FStatus write SetStatus;
  end;


implementation

uses QExport4StrIDs;

{$R *.DFM}

{ TQExportDialogProgressF }

constructor TfmQExport4Progress.CreateProgress(AOwner: TComponent;
  AQExport: TQExport4);
begin
  inherited Create(AOwner);
  FQExport := AQExport;
  FSkippedRows := 0;
  FExportedRows := 0;
  FTime := 0;
  ShowTime;
end;

procedure TfmQExport4Progress.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Assigned(Owner) and (Owner is TForm) then
    with Params do
    begin
      Style := Style or ws_Overlapped;
      WndParent := (Owner as TForm).Handle;
    end;
end;

procedure TfmQExport4Progress.ExportProgress(var Msg: TMessage);
begin
  if Msg.Msg = WM_QEXPORT_PROGRESS then
    case Msg.WParam of
      QEP_START: begin
         if not tmTimer.Enabled then tmTimer.Enabled := true;
         Status := estBegin;
      end;
      QEP_FETCHED: begin
        if not tmTimer.Enabled then tmTimer.Enabled := true;
        Status := estFetching;
        FetchedRows := FetchedRows + 1;
      end;
      QEP_SKIPPED: begin
        if not tmTimer.Enabled then tmTimer.Enabled := true;
        Status := estSkipping;
        SkippedRows := SkippedRows + 1;
      end;
      QEP_EXPORTED: begin
        if not tmTimer.Enabled then tmTimer.Enabled := true;
        Status := estExporting;
        ExportedRows := ExportedRows + 1;
      end;
      QEP_PAUSE: begin
        if tmTimer.Enabled then tmTimer.Enabled := false;
        Status := estPause;
      end;
      QEP_CONTINUE: begin
        if not tmTimer.Enabled then tmTimer.Enabled := true;
        Status := estContinue;
      end;
      QEP_ABORT: begin
        if tmTimer.Enabled then tmTimer.Enabled := false;
        Status := estAbort;
      end;
      QEP_FINISH: begin
        if tmTimer.Enabled then tmTimer.Enabled := false;
        Status := estEnd;
      end;
      QEP_DONE: Close;
    end;
end;

procedure TfmQExport4Progress.SetSkippedRows(const Value: integer);
begin
  FSkippedRows := Value;
  laExportedValue.Caption := IntToStr(FSkippedRows);
end;

procedure TfmQExport4Progress.SetExportedRows(Value: integer);
begin
  FExportedRows := Value;
  laExportedValue.Caption := IntToStr(FExportedRows);
end;

procedure TfmQExport4Progress.SetFetchedRows(const Value: integer);
begin
  FFetchedRows := Value;
  laExportedValue.Caption := IntToStr(FFetchedRows);
end;

procedure TfmQExport4Progress.SetStatus(const Value: TQExportStatus);
begin
{  if (FStatus = estFetching) and (Value = estExporting)
    then}
  FStatus := Value;
  case FStatus of
    estBegin: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Preparing);
      bButton.Caption := QExportLoadStr(QEDP_Cancel);
    end;
    estSkipping: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Skipping);
      laExported.Caption := QExportLoadStr(QEDP_Skipped);
    end;
    estExporting: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Exporting);
      laExported.Caption := QExportLoadStr(QEDP_Exported);
    end;
    estFetching: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Fetching);
      laExported.Caption := QExportLoadStr(QEDP_Fetched);
    end;
    estPause: laStatusValue.Caption := QExportLoadStr(QEDP_Pause);
    estContinue: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Exporting);
      bButton.Caption := QExportLoadStr(QEDP_Cancel);
    end;
    estAbort: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Aborted);
      bButton.Caption := QExportLoadStr(QEDP_OK);
    end;
    estEnd: begin
      laStatusValue.Caption := QExportLoadStr(QEDP_Finished);
      bButton.Caption := QExportLoadStr(QEDP_OK);
    end;
  end;
end;

procedure TfmQExport4Progress.tmTimerTimer(Sender: TObject);
var
  FSpeed: integer;
  Hour, Min, Sec, MSec: word;
begin
  FTime := FTime + 0.00001;
  ShowTime;
  DecodeTime(FTime, Hour, Min, Sec, MSec);

  if (Sec + Min * 60 + Hour * 3600) > 0
    then FSpeed := Trunc((FetchedRows + ExportedRows + SkippedRows) /
      (Sec + Min * 60 + Hour * 3600))
    else FSpeed := 0;
  laSpeedValue.Caption := Format(QExportLoadStr(QEDP_RowsPerSec), [FSpeed]);
end;

procedure TfmQExport4Progress.bButtonClick(Sender: TObject);
begin
  case Status of
    estBegin,
    estFetching,
    estExporting,
    estContinue: begin
      FQExport.Abort;
    end;
    else ModalResult := mrOk;
  end;
end;

procedure TfmQExport4Progress.ShowTime;
begin
  laTimeValue.Caption := FormatDateTime(QExportLoadStr(QEDP_TimeFormat), FTime);
end;

procedure TfmQExport4Progress.FormShow(Sender: TObject);
begin
  Caption := QExportLoadStr(QEDP_Caption);
  laStatus.Caption := QExportLoadStr(QEDP_Status);
  laTime.Caption := QExportLoadStr(QEDP_Time);
  laSpeed.Caption := QExportLoadStr(QEDP_Speed);
  laExported.Caption := QExportLoadStr(QEDP_Exported);
end;

end.
