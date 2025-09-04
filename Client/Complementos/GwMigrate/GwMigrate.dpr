program GwMigrate;

uses
  Forms,
  Files,
  Main in 'Main.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  Gim00Fields in '..\..\..\Interface\Gim00\Gim00Fields.pas',
  Gim10Fields in '..\..\..\Interface\Gim10\Gim10Fields.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
