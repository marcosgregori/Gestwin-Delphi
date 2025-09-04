
{******************************************}
{                                          }
{             FastReport VCL               }
{            Designer options              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditOptions;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, frxBaseForm
  {$IFDEF FPC}
  , LCLType
  {$ELSE}
  , frxCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxButtons,
  cxGroupBox, cxLabel, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxTextEdit,
  dxUIAClasses
  {$ENDIF}
{$IFDEF Delphi6}
, Variants
{$ENDIF};
  

type
  TfrxOptionsEditor = class(TfrxBaseForm)
    ColorDialog: TColorDialog;
    GridPanel: TcxGroupBox;
    CMRB: TRadioButton;
    InchesRB: TRadioButton;
    PixelsRB: TRadioButton;
    FontsPanel: TcxGroupBox;
    ColorsPanel: TcxGroupBox;
    WorkspacePB: TPaintBox;
    ToolPB: TPaintBox;
    OtherPanel: TcxGroupBox;
    CodePanel: TcxGroupBox;
    ButtonsGroupBox: TcxGroupBox;
    CancelB: TcxButton;
    OkB: TcxButton;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label12: TcxLabel;
    Label17: TcxLabel;
    LGuidAcc: TcxLabel;
    Label20: TcxLabel;
    Label18: TcxLabel;
    RightPanel: TcxGroupBox;
    LeftPanel: TcxGroupBox;
    ShowGridCB: TcxCheckBox;
    AlignGridCB: TcxCheckBox;
    GuidesStickCB: TcxCheckBox;
    GuidesAsAnchorCB: TcxCheckBox;
    ObjectFontCB: TcxCheckBox;
    LCDCB: TcxCheckBox;
    ShowScriptVARCB: TcxCheckBox;
    ShowADDVARCB: TcxCheckBox;
    ShowRttiVARCB: TcxCheckBox;
    MultiBCB: TcxCheckBox;
    EditAfterInsCB: TcxCheckBox;
    FreeBandsCB: TcxCheckBox;
    BandsCaptionsCB: TcxCheckBox;
    CME: TcxTextEdit;
    InchesE: TcxTextEdit;
    PixelsE: TcxTextEdit;
    DialogFormE: TcxTextEdit;
    TBE: TcxTextEdit;
    GapE: TcxTextEdit;
    EGuidAcc: TcxTextEdit;
    CodeWindowFontCB: TcxComboBox;
    CodeWindowSizeCB: TcxComboBox;
    MemoEditorFontCB: TcxComboBox;
    MemoEditorSizeCB: TcxComboBox;
    RestoreDefaultsB: TcxButton;
    WorkspaceB: TcxButton;
    ToolB: TcxButton;
	IntersectionsPB: TPaintBox;
    IntersectionsB: TButton;
    EnableCodeWindowHint: TcxCheckBox;
    EnableWorkspaceHints: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure WorkspacePBPaint(Sender: TObject);
    procedure ToolPBPaint(Sender: TObject);
    procedure IntersectionsPBPaint(Sender: TObject);
    procedure WorkspaceBClick(Sender: TObject);
    procedure ToolBClick(Sender: TObject);
    procedure IntersectionsBClick(Sender: TObject);
    procedure RestoreDefaultsBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FWColor: TColor;
    FTColor: TColor;
    FIColor: TColor;
    FPBHeight: integer;
    FPBWidth: integer;
  public
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    procedure UpdateResouces; override;
    { Public declarations }
  end;


implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxClass, frxDesgn, frxDesgnWorkspace, frxSynMemo, frxUtils, frxRes, frxDPIAwareInt;


{ TfrxPreferencesEditor }

procedure TfrxOptionsEditor.FormShow(Sender: TObject);

  procedure SetEnabledEx(cAr: Array of TControl; Enabled: Boolean);
  var
    i: Integer;
  begin
    for i := 0 to High(cAr) do
      cAr[i].Enabled := Enabled;
  end;

begin
  ColorDialog.CustomColors.Add('ColorA=' + IntToHex(ColorToRGB(clBtnFace), 6));

  with TfrxDesignerForm(Owner) do
  begin
    CodeWindowFontCB.Properties.Items.Assign(Screen.Fonts);
    MemoEditorFontCB.Properties.Items.Assign(Screen.Fonts);

    SetEnabledEx([CMRB, InchesRB, PixelsRB, CME, InchesE, PixelsE],
      (Workspace.GridType <> gtDialog) and (Workspace.GridType <> gtChar));

    CMRB.Checked := Units = duCM;
    InchesRB.Checked := Units = duInches;
    PixelsRB.Checked := Units = duPixels;

    CME.Text := FloatToStr(GridSize1);
    InchesE.Text := FloatToStr(GridSize2);
    PixelsE.Text := FloatToStr(GridSize3);
    DialogFormE.Text := FloatToStr(GridSize4);

    ShowGridCB.Checked := ShowGrid;
    AlignGridCB.Checked := GridAlign;
    EditAfterInsCB.Checked := EditAfterInsert;
    BandsCaptionsCB.Checked := Workspace.ShowBandCaptions;
    //.. StartupCB.Checked := ShowStartup;
    //.. StartupCB.Visible := ConnectionsMI.ActuallyVisible;
    EnableWorkspaceHints.Checked := Workspace.EnableHint;
    FreeBandsCB.Checked := Workspace.FreeBandsPlacement;
    GapE.Text := IntToStr(Workspace.GapBetweenBands);
    EGuidAcc.Text := FloatToStr(StickAccuracy);

    CodeWindowFontCB.Text := CodeWindow.Font.Name;
    CodeWindowSizeCB.Text := IntToStr(CodeWindow.Font.Size);
    MultiBCB.Checked := CodeWindow.MultiByteLang;
    MemoEditorFontCB.Text := MemoFontName;
    MemoEditorSizeCB.Text := IntToStr(MemoFontSize);
    ObjectFontCB.Checked := UseObjectFont;
    GuidesStickCB.Checked := StickToGuides;
    GuidesAsAnchorCB.Checked := GuidesAsAnchor;

    ShowScriptVARCB.Checked := (cltScript in CodeWindow.ShowInCodeComplition);
    ShowADDVARCB.Checked := (cltAddon in CodeWindow.ShowInCodeComplition);
    ShowRttiVARCB.Checked := (cltRtti in CodeWindow.ShowInCodeComplition);
    EnableCodeWindowHint.Checked := CodeWindow.EnableHint;
    TBE.Text := IntToStr(CodeWindow.TabStops);
    FWColor := WorkspaceColor;
    FTColor := ToolsColor;
    FIColor := IntersectionsColor;
    LCDCB.Checked := Workspace.GridLCD;
  end;
end;

procedure TfrxOptionsEditor.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
    with TfrxDesignerForm(Owner) do
    begin
      GridSize4 := frxStrToFloat(DialogFormE.Text);

      if CMRB.Enabled then
      begin
        GridSize1 := frxStrToFloat(CME.Text);
        GridSize2 := frxStrToFloat(InchesE.Text);
        GridSize3 := frxStrToFloat(PixelsE.Text);

        if CMRB.Checked then
          Units := duCM
        else if InchesRB.Checked then
          Units := duInches else
          Units := duPixels;
      end;

      ShowGrid := ShowGridCB.Checked;
      GridAlign := AlignGridCB.Checked;
      EditAfterInsert := EditAfterInsCB.Checked;
      Workspace.ShowBandCaptions := BandsCaptionsCB.Checked;
      //.. ShowStartup := StartupCB.Checked;
      Workspace.EnableHint := EnableWorkspaceHints.Checked;
      Workspace.FreeBandsPlacement := FreeBandsCB.Checked;
      Workspace.GapBetweenBands := StrToInt(GapE.Text);
      StickAccuracy := StrToFloat(EGuidAcc.Text);

      CodeWindow.Font.Name := CodeWindowFontCB.Text;
      CodeWindow.Font.Size := StrToInt(CodeWindowSizeCB.Text);
      CodeWindow.MultiByteLang := MultiBCB.Checked;
      MemoFontName := MemoEditorFontCB.Text;
      MemoFontSize := StrToInt(MemoEditorSizeCB.Text);
      UseObjectFont := ObjectFontCB.Checked;
      StickToGuides := GuidesStickCB.Checked;
      GuidesAsAnchor := GuidesAsAnchorCB.Checked;
      CodeWindow.ShowInCodeComplition := [];
      if ShowScriptVARCB.Checked then
        CodeWindow.ShowInCodeComplition := CodeWindow.ShowInCodeComplition + [cltScript];
      if ShowADDVARCB.Checked then
        CodeWindow.ShowInCodeComplition := CodeWindow.ShowInCodeComplition + [cltAddon];
      if ShowRttiVARCB.Checked then
        CodeWindow.ShowInCodeComplition := CodeWindow.ShowInCodeComplition + [cltRtti];
      CodeWindow.EnableHint := EnableCodeWindowHint.Checked;
      CodeWindow.TabStops := StrToInt(TBE.Text);
     
      WorkspaceColor := FWColor;
      ToolsColor := FTColor;
      IntersectionsColor := FIColor;
      Workspace.GridLCD := LCDCB.Checked;
    end;
end;

procedure TfrxOptionsEditor.WorkspacePBPaint(Sender: TObject);
begin
  with WorkspacePB.Canvas do
  begin
    Pen.Color := clGray;
    Brush.Color := FWColor;
    Rectangle(0, 0, FPBWidth, FPBHeight);
  end;
end;

procedure TfrxOptionsEditor.ToolPBPaint(Sender: TObject);
begin
  with ToolPB.Canvas do
  begin
    Pen.Color := clGray;
    Brush.Color := FTColor;
    Rectangle(0, 0, FPBWidth, FPBHeight);
  end;
end;

procedure TfrxOptionsEditor.IntersectionsPBPaint(Sender: TObject);
begin
  with IntersectionsPB.Canvas do
  begin
    Pen.Color := clGray;
    Brush.Color := FIColor;
    Rectangle(0, 0, FPBWidth, FPBHeight);
  end;
end;

procedure TfrxOptionsEditor.UpdateResouces;
begin
  inherited;
  Caption := frxGet(3000);
  GridPanel.Caption := frxGet(3001);
  Label2.Caption := frxGet(3002);
  Label3.Caption := frxGet(3003);
  Label4.Caption := frxGet(3004);
  OtherPanel.Caption := frxGet(3005);
  FontsPanel.Caption := frxGet(3006);
  Label7.Caption := frxGet(3007);
  Label8.Caption := frxGet(3008);
  Label9.Caption := frxGet(3009);
  Label10.Caption := frxGet(3010);
  ColorsPanel.Caption := frxGet(3011);
  Label12.Caption := frxGet(3012);
  Label13.Caption := frxGet(3013);
  Label14.Caption := frxGet(3014);
  Label15.Caption := frxGet(3015);
  Label16.Caption := frxGet(3016);
  Label17.Caption := frxGet(3017);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  CMRB.Caption := frxGet(3018);
  InchesRB.Caption := frxGet(3019);
  PixelsRB.Caption := frxGet(3020);
  ShowGridCB.Caption := frxGet(3021);
  AlignGridCB.Caption := frxGet(3022);
  EditAfterInsCB.Caption := frxGet(3023);
  ObjectFontCB.Caption := frxGet(3024);
  WorkspaceB.Caption := frxGet(3025);
  ToolB.Caption := frxGet(3026);
  IntersectionsB.Caption := frxGet(3107);
  LCDCB.Caption := frxGet(3027);
  FreeBandsCB.Caption := frxGet(3028);
  //.. StartupCB.Caption := frxGet(3030);
  EnableWorkspaceHints.Caption := frxGet(6610);
  RestoreDefaultsB.Caption := frxGet(3031);
  BandsCaptionsCB.Caption := frxGet(3032);

  CodePanel.Caption := frxGet(6593);
  ShowScriptVARCB.Caption := frxGet(6594);
  ShowADDVARCB.Caption := frxGet(6595);
  ShowRttiVARCB.Caption := frxGet(6596);
  EnableCodeWindowHint.Caption := frxGet(6609);
  Label18.Caption := frxGet(6597);
  GuidesStickCB.Caption := frxGet(6598);
  GuidesAsAnchorCB.Caption := frxGet(6599);
  LGuidAcc.Caption := frxGet(6710)
end;

procedure TfrxOptionsEditor.WorkspaceBClick(Sender: TObject);
var
  ctx: FRX_DPI_AWARENESS_CONTEXT;
begin
  ColorDialog.Color := FWColor;
  { awoid common Dialogs bug with HiDPi Per monitor v2 }
  ctx := frxGetThreadDpiAwarenessContext;
  frxSetThreadDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED);
  try
    if ColorDialog.Execute then
      FWColor := ColorDialog.Color;
  finally
    frxSetThreadDpiAwarenessContext(ctx);
  end;
  WorkspacePB.Repaint;
end;

procedure TfrxOptionsEditor.ToolBClick(Sender: TObject);
begin
  ColorDialog.Color := FTColor;
  if ColorDialog.Execute then
    FTColor := ColorDialog.Color;
  ToolPB.Repaint;
end;

procedure TfrxOptionsEditor.IntersectionsBClick(Sender: TObject);
begin
  ColorDialog.Color := FIColor;
  if ColorDialog.Execute then
    FIColor := ColorDialog.Color;
  IntersectionsPB.Repaint;
end;

procedure TfrxOptionsEditor.RestoreDefaultsBClick(Sender: TObject);
begin
     If   frxConfirmMsg( frxResources.Get('eoConfirmRestoreDefaults'), mb_YesNoCancel)=mrYes //..
     then begin
          TfrxDesignerForm(Owner).RestoreState(True);
          FTColor := TfrxDesignerForm(Owner).ToolsColor;
          FWColor := TfrxDesignerForm(Owner).WorkspaceColor;
          FIColor := TfrxDesignerForm(Owner).IntersectionsColor;
          ModalResult := mrCancel;
          end;
end;

procedure TfrxOptionsEditor.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxOptionsEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxOptionsEditor.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  FPBHeight := Round(21 * aNewPPI / frx_DefaultPPI);
  FPBWidth := Round(161 * aNewPPI / frx_DefaultPPI);
end;

end.
