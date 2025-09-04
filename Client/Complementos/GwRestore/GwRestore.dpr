program GwRestore;

uses
  Forms,
  Files,
  Main in 'Main.pas' {MainForm},
  Gim00Fields in '..\..\..\Interface\Gim00\Gim00Fields.pas',
  MessageBox in '..\..\..\Lib\MessageBox.pas' {MsgBoxForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
