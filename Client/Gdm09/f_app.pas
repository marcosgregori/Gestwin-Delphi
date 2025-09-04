unit f_app;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxImage, dxGDIPlusClasses;

type
  TApplicationFrame = class(TFrame)
    Image: TcxImage;
  private
  public
  end;

implementation

{$R *.dfm}

uses  AppContainer,
      AppManager,

      b_abo;

procedure SetupAboutForm;

var  AppFrame : TApplicationFrame;

begin
     If   Assigned( AboutForm )
     then try
            AppFrame := TApplicationFrame.Create( nil );
            If   Assigned( AppFrame )
            then With AppFrame do
                 AboutForm.AppImage.Picture.Assign( Image.Picture );
          finally
            FreeAndNil( AppFrame );
            end;
end;

procedure InitAppModules;
begin
     ApplicationContainer.InitializeAppModules( 9, [ 0, 90 ] );
end;

initialization

     With ApplicationContainer do
       begin
       UnProtectedApp := True;
       SpEvaluation := False;
       Sp64BitsServer := True;
       OnSetupAboutForm := SetupAboutForm;
       OnInitAppModules := InitAppModules;
       end;

end.
