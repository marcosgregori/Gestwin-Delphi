unit f_app;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxImage;

type
  TApplicationFrame = class(TFrame)
    Image: TcxImage;
  private
  public
  end;

implementation

{$R *.dfm}

uses  AppManager,
      AppContainer,

      b_abo;

procedure SetupAboutForm;

var  AppFrame : TApplicationFrame;

begin
     If  Assigned( AboutForm )
     then try
            AppFrame := TApplicationFrame.Create( nil );
            If   Assigned( AppFrame )
            then With AppFrame do
                 begin
                 AboutForm.AppImage.Picture.Assign( Image.Picture );
                 AboutForm.AppNameLabel.Caption := 'Enlace DDE';
                 AboutForm.InfoLabel.Caption := GetAppVersionString( 'gw.exe' );
                 end;
          finally
            FreeAndNil( AppFrame );
            end;
end;

initialization
     With ApplicationContainer do
       begin
       OnSetupAboutForm := SetupAboutForm;
       SpEvaluation := False;
       end;

end.
