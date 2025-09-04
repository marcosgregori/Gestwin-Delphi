unit ThumbFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TThumbWindowsForm = class(TForm)
    ThumbScroller: TScrollBox;
  private
    procedure GetMDIChildImages;
    function CreateTImage( const Form: TForm ) : TImage;
    procedure ImageClick(Sender: TObject) ;
  public
    class function Execute : TModalResult;
  end;

implementation

{$R *.dfm}

uses  AppForm;

class function TThumbWindowsForm.Execute : TModalResult;
begin
     With Self.Create( nil ) do
       try
         GetMDIChildImages;
         Result := ShowModal;
       finally
         Free;
         end;
end;

procedure TThumbWindowsForm.GetMDIChildImages;

var  Idx : Integer;
     Form : TForm;
     FormImage : TBitmap;

begin
     For Idx := 0 to ApplicationForm.MDIChildCount - 1 do
       begin
       Form := ApplicationForm.MDIChildren[ Idx ];
       If   Form=ApplicationForm.ActiveMDIChild
       then Continue;
       FormImage := Form.GetFormImage;
       try
         CreateTImage( Form ).Picture.Assign( FormImage );
       finally
         FormImage.Free;
         end;
       end;
end;

function TThumbWindowsForm.CreateTImage( const Form: TForm ) : TImage;
begin
     Result := TImage.Create( ThumbScroller ) ;
     With Result do
       begin
       Tag := Form.Handle; //used to activate upon "click"
       Parent := ThumbScroller;

       Cursor := crHandPoint;
       Margins.Left := 8;
       Margins.Right := 8;
       Margins.Top := 8;
       Margins.Bottom := 8;
       AlignWithMargins := True;
       Width := 4 * ThumbScroller.Height div 3;
       Align := alLeft;

       Stretch := True;
       Proportional := True;
       Center := True;

       OnClick := ImageClick;
       OnMouseEnter := MouseEnter;
       OnMouseLeave := MouseLeave;

       ShowHint := True;
       Hint := Format( 'Pulsa para activar "%s"', [ Form.Caption ] ) ;
     end;
end;

procedure TThumbWindowsForm.ImageClick(Sender: TObject) ;

var TheImage : TImage;
    MDIChildHandle : THandle;
    MDiChild : TForm;

begin
     TheImage := TImage( Sender ) ;
     MDIChildHandle := TheImage.Tag;
     MDiChild := FindControl(MDIChildHandle) as TForm;
     If   MDiChild<>nil
     then begin
          If   IsIconic( MDIChildHandle )
          then ShowWindow( MDIChildHandle, SW_RESTORE )
          else MDiChild.Show;
          ModalResult := mrOk;
          end;
end;

end.
