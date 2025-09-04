unit f_app;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, dxGDIPlusClasses;

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
                 AboutForm.AppImage.Picture.Assign( Image.Picture );
          finally
            FreeAndNil( AppFrame );
            end;
end;

procedure InitAppModules;
begin
     ApplicationContainer.InitializeAppModules( 3, [ 0, 10, 30 ] );
end;

initialization

     With ApplicationContainer do
       begin
       OnSetupAboutForm := SetupAboutForm;
       OnInitAppModules := InitAppModules;
       end;

end.
