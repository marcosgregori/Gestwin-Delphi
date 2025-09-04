unit f_app;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TApplicationFrame = class(TFrame)
    Image: TImage;
  private
  public
  end;

implementation

{$R *.dfm}

uses  AppContainer,

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
                 AboutForm.AppNameBox.Text := 'Enlace DDE';
                 AboutForm.InfoLabel.Caption := ApplicationContainer.GetAppVersionString( 'gw.exe' );
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
