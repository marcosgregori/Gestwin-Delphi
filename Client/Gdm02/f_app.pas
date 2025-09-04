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
                 end;
          finally
            FreeAndNil( AppFrame );
            end;
end;

procedure InitAppModules;
begin
     ApplicationContainer.InitializeAppModules( 2, [ 0, 30 ] );

     // El m�dulo 20 se carga como opci�n. Los m�dulos que se definen como opcionales para que
     // se puedan cargar desde otras aplicaciones, no deben ser inicializados como m�dulos principales.

end;

initialization

     With ApplicationContainer do
       begin
       OnSetupAboutForm := SetupAboutForm;
       OnInitAppModules := InitAppModules;
       end;

end.
