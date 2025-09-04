{******************************************}
{                                          }
{             FastReport VCL               }
{           Base export dialog             }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxExportBaseDialog;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  SysUtils, Graphics, Controls, Classes, Forms, Dialogs,
  StdCtrls, ExtCtrls, {ComObj,} frxClass, frxBaseForm,
  ComCtrls, Variants, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPC, cxContainer, cxEdit,
  Vcl.Menus, cxButtons, cxGroupBox, cxRadioGroup, cxTextEdit, cxLabel,
  cxMaskEdit, cxDropDownEdit, cxCheckBox,
  AppForms, dxUIAClasses;

type
  TfrxBaseExportDialog = class;

  TfrxBaseExportDialogClass = class of TfrxBaseExportDialog;

  TfrxBaseDialogExportFilter = class(TfrxCustomExportFilter)
  protected
    procedure AfterFinish; override;
  public
    function ShowModal: TModalResult; override;
    class function ExportDialogClass: TfrxBaseExportDialogClass; virtual;
  end;

  TfrxBaseExportDialog = class(TfrxBaseForm)
    PageControl1: TcxPageControl;
    ExportPage: TcxTabSheet;
    OpenCB: TcxCheckBox;
    GroupPageRange: TcxGroupBox;
    DescrL: TcxLabel;
    SaveToGroupBox: TcxGroupBox;
    GroupQuality: TcxGroupBox;
    OkB: TcxButton;
    CancelB: TcxButton;
    AllRB: TcxRadioButton;
    CurPageRB: TcxRadioButton;
    PageNumbersRB: TcxRadioButton;
    PageNumbersE: TcxTextEdit;
    FiltersNameCB: TcxComboBox;
    ButtonsGroupBox: TcxGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OkBClick(Sender: TObject);
  protected
    procedure InitDialog; virtual;
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); virtual;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); virtual;
  end;

implementation

uses
  frxRes, frxIOTransportIntf, frxUtils, AppManager //..
{$IFNDEF FPC}
  ,ShellAPI
{$ENDIF};

{$R *.dfm}

{ TfrxPDFExportDialog }

procedure TfrxBaseExportDialog.FormCreate(Sender: TObject);
begin
  InitDialog;
  rePadding(Self);
end;

procedure TfrxBaseExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxBaseExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxBaseExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxBaseExportDialog.InitControlsFromFilter( ExportFilter: TfrxBaseDialogExportFilter);

var ItemIndex: Integer;

begin
      OpenCB.Visible := not ExportFilter.SlaveExport;

      if ExportFilter.SlaveExport then
      begin
        OpenCB.Enabled := False;
        OpenCB.State := cbsGrayed;
        ExportFilter.OpenAfterExport := False;
        //OpenCB.Checked := ExportFilter.OpenAfterExport;
      end;
      OpenCB.Checked := ExportFilter.OpenAfterExport;
      FiltersNameCB.Enabled := not ExportFilter.SlaveExport;
      FiltersNameCB.Visible := (FiltersNameCB.Properties.Items.Count > 1);
      SaveToGroupBox.Visible := FiltersNameCB.Visible;
      If   not SaveToGroupBox.Visible
      then Height := Height - ScaledToCurrent( SaveToGroupBox.Height );
      //else
      //  SaveDialog1.FileName := FileName;

      if ExportFilter.PageNumbers <> '' then
      begin
        PageNumbersE.Text := ExportFilter.PageNumbers;
        PageNumbersRB.Checked := True;
      end;

      FiltersNameCB.ItemIndex := 0;
      ItemIndex := FiltersNameCB.ItemIndex;
      if ExportFilter.IOTransport <> nil then
        ItemIndex := FiltersNameCB.Properties.Items.IndexOfObject(ExportFilter.IOTransport);

      //if ItemIndex = -1 then
      //  ItemIndex := FiltersNameCB.Items.AddObject(IOTransport.GetDescription, IOTransport);
      if (ItemIndex <> -1) and not ExportFilter.SlaveExport then
        ExportFilter.DefaultIOTransport := TfrxCustomIOTransport(FiltersNameCB.Properties.Items.Objects[ItemIndex]).CreateFilterClone(fvExport);
      ExportFilter.DefaultIOTransport.InitFromExport(ExportFilter);
      if (ExportFilter.FileName = '') and (not ExportFilter.SlaveExport) then
      begin
        ExportFilter.FileName := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(ExportFilter.Report.FileName)), ExportFilter.DefaultIOTransport.DefaultExt);
        //SaveDialog1.FileName := s;
      end;

end;

procedure TfrxBaseExportDialog.InitDialog;
var
  Control: TControl;
begin
  TranslateControlsByTag(Self);
  ExportPage.Caption := frxGet(107);
  FillItemsList(FiltersNameCB.Properties.Items, fvExport);

  if PageControl1.PageCount = 1 then
    PageControl1.Properties.HideTabs := True;

  if UseRightToLeftAlignment then
    FlipChildren(True);

end;

procedure TfrxBaseExportDialog.InitFilterFromDialog(
  ExportFilter: TfrxBaseDialogExportFilter);
var
  ItemIndex: Integer;
begin
  //FiltersNameCB.ItemIndex := 0;
  ItemIndex := FiltersNameCB.ItemIndex;
  if ExportFilter.IOTransport <> nil then
    ItemIndex := FiltersNameCB.Properties.Items.IndexOfObject(ExportFilter.IOTransport);
  if (ItemIndex <> -1) and not ExportFilter.SlaveExport then
    ExportFilter.DefaultIOTransport :=
      TfrxCustomIOTransport(FiltersNameCB.Properties.Items.Objects[FiltersNameCB.ItemIndex])
      .CreateFilterClone(fvExport);

  ExportFilter.PageNumbers := '';
  ExportFilter.CurPage := False;
  if CurPageRB.Checked then
    ExportFilter.CurPage := True
  else if PageNumbersRB.Checked then
    ExportFilter.PageNumbers := PageNumbersE.Text;

  ExportFilter.OpenAfterExport := OpenCB.Checked;
end;

procedure TfrxBaseExportDialog.OkBClick(Sender: TObject);
begin

end;

{ TfrxBaseDialogExportFilter }

procedure TfrxBaseDialogExportFilter.AfterFinish;
begin
  if OpenAfterExport and (not Assigned(Stream)) then
{$IFNDEF FPC}
  if not FileExists(FileName) then
    ShellExecute(GetDesktopWindow, 'open', PChar(ExtractFilePath(FileName) + ChangeFileExt(ExtractFileName(FileName), '') +
                                           '.1' + ExtractFileExt(FileName)), nil, nil, SW_SHOW)
  else
    ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
{$ELSE}
  OpenDocument(FileName);
{$ENDIF}
end;

class function TfrxBaseDialogExportFilter.ExportDialogClass: TfrxBaseExportDialogClass;
begin
  Result := TfrxBaseExportDialog;
end;

function TfrxBaseDialogExportFilter.ShowModal: TModalResult;
var
  eDialog: TfrxBaseExportDialog;
begin
  if not Assigned(Stream) then
  begin
    eDialog := TfrxBaseExportDialog(ExportDialogClass.NewInstance);
    eDialog.Create(nil);
    eDialog.InitControlsFromFilter(Self);

      Result := eDialog.ShowModal;
      if Result = mrOk then
        eDialog.InitFilterFromDialog(Self);
     eDialog.Free;
  end
  else
    Result := mrOk;
end;



end.
