program GwExport;

uses
  Forms,
  Files,
  Main in 'Main.pas' {MainForm},
  Gim00Fields in '..\..\..\Interface\Gim00\Gim00Fields.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
