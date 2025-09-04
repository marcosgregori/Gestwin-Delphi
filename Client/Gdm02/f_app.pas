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

     // El módulo 20 se carga como opción. Los módulos que se definen como opcionales para que
     // se puedan cargar desde otras aplicaciones, no deben ser inicializados como módulos principales.

end;

initialization

     With ApplicationContainer do
       begin
       OnSetupAboutForm := SetupAboutForm;
       OnInitAppModules := InitAppModules;
       end;

end.
