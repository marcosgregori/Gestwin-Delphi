unit MyPanel;

(*** **** **** **** **** **** ****  **** **** **** **** **** **** **** **** ****
                    MYPANEL.PAS

The following are components intended to overcome weaknesses/shortcommings in the
DevExpress VCL releases.

TYPE MYPANEL
      This component are deliberately written as a add-in with a requirement for only
      2 lines (declaration and create) to be added to the application code for each
      component to be enhanced.  All other references within the application code
      should be to the original (base) components.  This is so that if/when
      DevExpress generate 'official'/proper component the changes to implement this in
      an application will be minimal.

      This is a temp method of creating a panel with the same look and feel as
      pagecontrols, tabsheets, etc. supplied by DevExpress.

      It is based on a sample provided by DevExpress support.
      It has been enhanced to
         a) automatically re-parent all controls from the original panel
            to the new one.
         b) transfer the Caption of the base Tpanel the the new panel to
            minimise the changes required in an application to

      To use

      For each TPanel you want to undate declare a TMyPanel in the 'Private'
      section of the form containing the TPanel you want to upgrade. e.g.
         Panel3a: TMyPanel;

      In Form.Create for each TPanel you want to upgrade add
         Panel3a := TMyPanel.Create(Panel3);
               where Panel3 is the original TPanel
      Reminder : If changing the color of the Caption make sure the ParentFont
      and ParentColor of all child components are FALSE, unless you want them
      all to change.

      Note the new panel name will be the parent panel name with an 'a' added


Created 23/01/2007
      Simple upgrade of a DevExpress Panel example showing how to produce a panel
      with the look/feel of the office11 components.
      a) automates re-parenting of any number of child controls, and
      b) puts the original panel caption on the new panel
Updated 06/02/2007
      c) TMyPanel now gets changes to the base panel caption (text and color)
         and transfers them to the new panel
Updated 30/08/2007
      d) MyInputQuery and MyInputBox added.  These are updates of Delphi's
         InputQuery and InputBox but with additional parameters to enable
         their position to be defined
Updated 13/09/2007
      e) MyMessageDlg, etc. added in order to make it compatible with DevExpress
         skins - the TLabel was changed to a TcxLabel (not essential) and its
         Transparent property set to TRUE (essential)

Developed by Dr John M Porteous for Chemigraphic Ltd
Dr Porteous is an independant consultant working with Chemigraphic Ltd (UK)
for whom this was developed.
Any problems/suggestions may be emailed to dr.john@chemigraphic.co.uk

The software is provided 'as-is', without any express or implied warranty.
In no event will the author or Chemigraphic Ltd be held liable for any damages
arising from the use of the software.

Permission is granted to anyone to use this software for any purpose, including
commercial applications, and to alter it and redistribute it freely,
subject to the following restrictions:

1. The origin of this software must not be misrepresented, you must not claim
   that you wrote the original software. If you use this software in a product,
   an acknowledgment in the product documentation would be appreciated but is
   not required.

2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

3. This notice may not be removed or altered from any source distribution.

**** **** **** **** **** **** ****  **** **** **** **** **** **** **** **** ***)

interface

uses
   ExtCtrls,Classes, Graphics, Controls,dxOffice11, StdCtrls, cxButtons,
   cxLookAndFeelPainters, messages;

type
  TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore,
    mbAll, mbNoToAll, mbYesToAll, mbHelp);
  TMsgDlgButtons = set of TMsgDlgBtn;

const
  mbYesNo = [mbYes, mbNo];
  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  mbYesAllNoAllCancel = [mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel];
  mbOKCancel = [mbOK, mbCancel];
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];
  mbAbortIgnore = [mbAbort, mbIgnore];
type

  TMyPanel = class(TPanel)
  private
    FColor1: TColor;
    FColor2: TColor;
    ParPanel : TPanel;
    procedure SetColor1(AValue: TColor);
    procedure SetColor2(AValue: TColor);
  protected
    FPrevControlWndProc: TWndMethod;
    procedure Paint; override;
    procedure PResize(Sender: TObject);
    procedure NewWndProc(var Message: TMessage); virtual;
  public
    Constructor Create( MyParent : TPanel );
    property Color1: TColor read FColor1 write SetColor1;
    property Color2: TColor read FColor1 write SetColor2;
  end;

  TPanelPosition = (ppCursor, ppLeft, ppRight);
  function MyInputQuery(const ACaption, APrompt: string;
     var Value: string; pos : TPanelPosition): Boolean; overload;
  function MyInputBox(const ACaption, APrompt, ADefault: string): string;
  function MyMessageDlg(const Msg: string; DlgType: TMsgDlgType;
     Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
  function MyMessageDlg(const Msg: string; DlgType: TMsgDlgType;
     Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;
  function MyMessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
     Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload;
  function MyMessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
     Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
     DefaultButton: TMsgDlgBtn): Integer; overload;



implementation

uses
   Windows,cxLookAndFeels, Forms, IBUtils, cxlabel, cxTextEdit, consts, sysutils;


Constructor TMyPanel.Create( MyParent : TPanel );
var
   i : integer;
begin
   inherited Create( MyParent );
   SetColor1(dxOffice11ToolbarsColor1);
   SetColor2(dxOffice11ToolbarsColor2);
   Parent      := MyParent;
   ParPanel    := MyParent;
   Align       := alClient;
   Caption     := MyParent.Caption;
   Name        := MyParent.Name + 'a';

   for i := MyParent.ControlCount - 1 downto 0 do
      if (MyParent.Controls[i].name  <> name) and
         (MyParent.Controls[i].Parent = MyParent) then
             MyParent.Controls[i].Parent := Self;

   MyParent.OnResize    := PResize;
   Paint;
   FPrevControlWndProc := myparent.WindowProc;
   myparent.WindowProc := NewWndProc;
end;

procedure TMyPanel.NewWndProc(var Message: TMessage);
var
   i : integer;
begin
  FPrevControlWndProc(Message);
  if Message.Msg in [WM_PAINT, WM_NCPAINT] then
  begin
      Paint;
      for i := ControlCount - 1 downto 0 do
      try
         if (Controls[i].ClassName = 'TLabel') or (Controls[i].ClassName = 'TcxLabel') then
             Controls[i].refresh;
      except
      end;
  end;
end;

procedure TMyPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  VerticalAlignments: array[TVerticalAlignment] of Longint = (DT_TOP, DT_BOTTOM, DT_VCENTER);
var
  Rect: TRect;
  Flags: Longint;
begin
  FillTubeGradientRect(Canvas.Handle, BoundsRect, FColor1, FColor2, False);
  with Canvas do
  begin
    Rect := GetClientRect;
    Brush.Style := bsClear;
    Color := PArPanel.Color;
    Font  := ParPanel.Font;
    Flags := DT_EXPANDTABS or DT_SINGLELINE or
      VerticalAlignments[VerticalAlignment] or Alignments[Alignment];
    Flags := Parent.DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(ParPanel.Caption), -1, Rect, Flags);
  end;
end;

procedure TMyPanel.PResize(Sender: TObject);
begin
   Paint;
end;

procedure TMyPanel.SetColor1(AValue: TColor);
begin
  FColor1 := AValue;
  Invalidate;
end;

procedure TMyPanel.SetColor2(AValue: TColor);
begin
  FColor2 := AValue;
  Invalidate;
end;



function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;


function MyInputQuery(const ACaption, APrompt: string;
  var Value: string; pos : TPanelPosition): Boolean; overload;
const  
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Cancel';
var
  Form: TForm;
  Prompt: TcxLabel;
  Edit: TcxTextEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  pt : TPoint;
begin
  Result := False;
  Form   := TForm.Create(Application);
  with Form do
    try
      Canvas.Font  := Font;
      DialogUnits  := GetAveCharSize(Canvas);
      BorderStyle  := bsDialog;
      Caption      := ACaption;
      ClientWidth  := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(63, DialogUnits.Y, 8);

      getcursorpos(pt);
      case pos of
      ppLeft:  Form.Left := 20;
      ppRight: Form.Left := Screen.Width - form.Width - 20
      else                                   // ppCursor
         if pt.X > (screen.Width div 2) then
            Form.Left := pt.X - form.Width - 20
         else
            Form.Left := pt.X + 20;
      end;


      case pos of
      ppLeft,
      ppRight: begin
                  Form.Top := pt.Y - (form.Height div 2);
                  if Form.Top < 20 then
                     Form.Top := 20
                  else
                  if (Form.Top + Form.Height) > screen.Height then
                     Form.Top := screen.Height - Form.Height - 20;
               end;
      else                                   // ppCursor
         if pt.Y > (screen.height div 2) then
            Form.Top := pt.Y - form.Height - 20
         else
            Form.Top := pt.Y + 20;
      end;

      Prompt := TcxLabel.Create(Form);
      with Prompt do
      begin
        Parent   := Form;
        AutoSize := True;
        Left     := MulDiv(8, DialogUnits.X, 4);
        Top      := MulDiv(8, DialogUnits.Y, 8);
        Caption  := APrompt;
        BorderIcons := [];
        Transparent := TRUE;
      end;
      Edit := TcxTextEdit.Create(Form);
      with Edit do
      begin
        Parent    := Form;
        Left      := Prompt.Left;
        Top       := MulDiv(19, DialogUnits.Y, 8);
        Width     := MulDiv(164, DialogUnits.X, 4);
        Properties.MaxLength := 255;
        Text      := Value;
        SelectAll;
      end;
      ButtonTop    := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth  := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TcxButton.Create(Form) do
      begin
        Parent      := Form;
        Caption     := SMsgDlgOK;
        ModalResult := mrOk;
        default     := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TcxButton.Create(Form) do
      begin
        Parent      := Form;
        Caption     := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel      := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;


      if ShowModal = mrOk then
      begin
        Value  := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function MyInputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  MyInputQuery(ACaption, APrompt, Result, ppCursor);
end;



//************************************************************************
type
  TMessageForm = class(TForm)
  private
    Message: TcxLabel;
    procedure HelpButtonClick(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WriteToClipBoard(Text: String);
    function GetFormText: String;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

var
  ButtonWidths : array[TMsgDlgBtn] of integer;  // initialized to zero
  Captions: array[TMsgDlgType] of Pointer = (@SMsgDlgWarning, @SMsgDlgError,
    @SMsgDlgInformation, @SMsgDlgConfirm, nil);
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help');
  ButtonCaptions: array[TMsgDlgBtn] of Pointer = (
    @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort,
    @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll, @SMsgDlgYesToAll,
    @SMsgDlgHelp);
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0);

constructor TMessageForm.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
end;

procedure TMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TMessageForm.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    WriteToClipBoard(GetFormText);
  end;
end;

procedure TMessageForm.WriteToClipBoard(Text: String);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if OpenClipBoard(0) then
  begin
    try
      Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Length(Text) + 1);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(PChar(Text)^, DataPtr^, Length(Text) + 1);
          EmptyClipBoard;
          SetClipboardData(CF_TEXT, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipBoard;
    end;
  end
  else
    raise Exception.CreateRes(@SCannotOpenClipboard);
end;

function TMessageForm.GetFormText: String;
var
  DividerLine, ButtonCaptions: string;
  I: integer;
begin
  DividerLine := StringOfChar('-', 27) + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TButton then
      ButtonCaptions := ButtonCaptions + TButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions,'&','', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, Message.Caption, sLineBreak, DividerLine, ButtonCaptions,
    sLineBreak, DividerLine]);
end;

function DoMessageDlgPosHelp(MessageDialog: TForm; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  with MessageDialog do
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): TForm; overload;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, ALeft: Integer;
  B, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  TextRect: TRect;
  LButton: TButton;
begin
  Result := TMessageForm.CreateNew(Application);
  with Result do
  begin
    BiDiMode := Application.BiDiMode;
    BorderStyle := bsDialog;
    Canvas.Font := Font;
    KeyPreview := True;
    Position := poDesigned;
    OnKeyDown := TMessageForm(Result).CustomKeyDown;
    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        if ButtonWidths[B] = 0 then
        begin
          TextRect := Rect(0,0,0,0);
          Windows.DrawText( canvas.handle,
            PChar(LoadResString(ButtonCaptions[B])), -1,
            TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
            DrawTextBiDiModeFlagsReadingOnly);
          with TextRect do ButtonWidths[B] := Right - Left + 8;
        end;
        if ButtonWidths[B] > ButtonWidth then
          ButtonWidth := ButtonWidths[B];
      end;
    end;
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
    DrawText(Canvas.Handle, PChar(Msg), Length(Msg)+1, TextRect,
      DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
      DrawTextBiDiModeFlagsReadingOnly);
    IconID := IconIDs[DlgType];
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;
    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
    if DlgType <> mtCustom then
      Caption := LoadResString(Captions[DlgType]) else
      Caption := Application.Title;
    if IconID <> nil then
      with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;
    TMessageForm(Result).Message := TcxLabel.Create(Result);
    with TMessageForm(Result).Message do
    begin
      Name := 'Message';
      Parent := Result;
      Properties.WordWrap := True;
      TRansparent := TRUE;
      Caption := Msg;
      BoundsRect := TextRect;
      BiDiMode := Result.BiDiMode;
      ALeft := IconTextWidth - TextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin,
        TextRect.Right, TextRect.Bottom);
    end;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
      begin
        LButton := TButton.Create(Result);
        with LButton do
        begin
          Name := ButtonNames[B];
          Parent := Result;
          Caption := LoadResString(ButtonCaptions[B]);
          ModalResult := ModalResults[B];
          if B = DefaultButton then
          begin
            Default := True;
            ActiveControl := LButton;
          end;
          if B = CancelButton then
            Cancel := True;
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
            ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := TMessageForm(Result).HelpButtonClick;
        end;
      end;
  end;
end;

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TForm; overload;
var
  DefaultButton: TMsgDlgBtn;
begin
  if mbOk in Buttons then DefaultButton := mbOk else
    if mbYes in Buttons then DefaultButton := mbYes else
      DefaultButton := mbRetry;
  Result := CreateMessageDialog(Msg, DlgType, Buttons, DefaultButton);
end;


function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer; overload;
begin
  Result := DoMessageDlgPosHelp(CreateMessageDialog(Msg, DlgType, Buttons),
    HelpCtx, X, Y, HelpFileName);
end;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := DoMessageDlgPosHelp(CreateMessageDialog(Msg, DlgType, Buttons, DefaultButton),
    HelpCtx, X, Y, HelpFileName);
end;

function MyMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;

function MyMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '', DefaultButton);
end;

function MyMessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;

function MyMessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '', DefaultButton);
end;


end.
