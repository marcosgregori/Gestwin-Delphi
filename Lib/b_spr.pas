
unit b_spr;

interface

uses Controls, StdCtrls, Buttons, ExtCtrls, Classes, Forms, Messages, windows,

     AppContainer, Graphics, AppForms, Menus, cxLookAndFeelPainters, cxButtons,
  cxGraphics, cxControls, cxLookAndFeels, cxContainer, cxEdit, dxSkinsCore,
  cxGroupBox, dxGDIPlusClasses, cxImage, dxSkinsDefaultPainters, cxLabel,
  cxGeometry, dxFramedControl, dxPanel;

type
  TSubProcessForm = class(TgxForm)
    Image1: TcxImage;
    cxGroupBox1: TdxPanel;
    ProcessLabel: TLabel;
    Bevel1: TShape;
    HeaderLabel: TcxLabel;
  private
  public
  end;

var  SubProcessForm : TSubProcessForm = nil;

procedure CreateSubProcessForm;
procedure DestroySubProcessForm;

implementation

{$R *.dfm}

uses   b_msg;

procedure CreateSubProcessForm;
begin
     SubProcessForm := TSubProcessForm.Create( Application.MainForm );
     If   Assigned( SubProcessForm )
     then SubProcessForm.Show;
end;

procedure DestroySubProcessForm;
begin
     If   Assigned( SubProcessForm )
     then SubProcessForm.Release;
end;

end.

