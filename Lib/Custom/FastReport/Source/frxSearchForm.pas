unit frxSearchForm;

{$I frx.inc}

interface

uses
  {$IFDEF FPC}
  LCLIntf, LCLType, LMessages,
  {$ENDIF}
  {$IFNDEF FPC}
  Windows,
  {$ENDIF}
   Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, frxBaseForm, frxRes, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxCheckBox, cxGroupBox, cxRadioGroup, cxButtons, cxTextEdit,
  cxTreeView;

type

  { TfrxSearchForm }

{$IFNDEF FPC}
  TTView = class(TTreeView)
    procedure WM_MouseWheel(var Msg: TWMMouseWheel); message WM_MouseWheel; //TWMMouseWheel
  end;
{$ENDIF}

  TfrxSearchForm = class(TfrxBaseForm)
    pnlSearch: TcxGroupBox;
    edtFind: TcxTextEdit;
    lblFind: TLabel;
    btnFind: TcxButton;
    gbSearch: TcxGroupBox;
    chkBeg: TcxCheckBox;
    chkCase: TcxCheckBox;
    chkFindAll: TcxCheckBox;
    Label1: TLabel;
    trvFind: TcxTreeView;
{$IFDEF  FPC}
    procedure chkFindAllChange(Sender: TObject);
{$ELSE}
    procedure chkFindAllClick(Sender: TObject);
{$ENDIF}
    procedure edtFindKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private

  public
    destructor Destroy; override;
    procedure UpdateResouces; override;
    procedure CleartrvFind;
  end;

const
  EventScrollFind = High(SmallInt);

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}
uses frxPreview;

{$IFNDEF FPC}
procedure TTView.WM_MouseWheel(var Msg: TWMMouseWheel);
begin
  Msg.XPos := EventScrollFind;
  Msg.YPos := EventScrollFind;
  Inherited;
end;
{$ENDIF}

{$IFDEF FPC}
procedure TfrxSearchForm.chkFindAllChange(Sender: TObject);
{$ELSE}
procedure TfrxSearchForm.chkFindAllClick(Sender: TObject);
{$ENDIF}
begin
     trvFind.Visible := chkFindAll.Checked;
end;


procedure TfrxSearchForm.UpdateResouces;
begin
    inherited;
end;

procedure TfrxSearchForm.edtFindKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_RETURN
     then btnFind.OnClick(nil);
end;

procedure TfrxSearchForm.FormCreate(Sender: TObject);
begin
     // FIsFrxBaseForm := False;
end;

destructor TfrxSearchForm.Destroy;
begin
     inherited;
end;

procedure TfrxSearchForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then
    begin
      if Self.Parent.Parent is TfrxPreviewForm then
        begin
          TfrxPreviewForm(Self.Parent.Parent).CopyCmd.ShortCut := 0;
          TfrxPreviewForm(Self.Parent.Parent).PasteCmd.ShortCut := 0;
        end;
      if Key = Ord('F') then
        begin
           if Self.Parent.Parent is TfrxPreviewForm then
             TfrxPreviewForm(Self.Parent.Parent).FindButton.Down := False;  //..
           TfrxPreview(Self.Parent).FindFmVisible := False;
           Hide;
           TfrxPreview(Self.Parent).SetFocus;
        end;
    end;
end;

procedure TfrxSearchForm.FormShow(Sender: TObject);
begin
  edtFind.SetFocus;
  edtFind.SelectAll;
end;

procedure TfrxSearchForm.CleartrvFind();
var
  i: Integer;
  data: PfrxTrvData;
begin
  for i := 0 to trvFind.Items.Count - 1 do
  begin
    data := trvFind.Items[i].Data;
    if data <> nil then
      Dispose(data);
  end;
  trvFind.Items.Clear();
end;

end.
