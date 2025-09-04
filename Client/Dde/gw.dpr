
program gw;

uses
  AppContainer,
  Forms,
  main in 'main.pas' {MainForm},
  topic in 'topic.pas' {DDEForm},
  f_app in 'f_app.pas' {ApplicationFrame: TFrame},
  Gim10Fields in '..\..\Interface\Gim10\Gim10Fields.pas',
  Gim00Fields in '..\..\Interface\Gim00\Gim00Fields.pas',
  EnterpriseDataAccess in '..\..\Lib\EnterpriseDataAccess.pas' {EnterpriseDataModule: TDataModule};

{$R *.RES}

begin
     Application.Initialize;
     Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
