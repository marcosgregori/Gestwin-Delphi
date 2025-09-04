
program GwInst;

uses
  Forms,
  InfoInstall in '..\InfoInstall.pas' {InfoModule: TDataModule},
  RPCInstall in '..\RPCInstall.pas' {RpcInstallModule: TDataModule},
  main in 'main.pas' {InstallForm},
  InstallerClass in '..\InstallerClass.pas',
  UnInstall in '..\UnInstall.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Instalador de aplicaciones GESTWIN';
  Application.CreateForm(TInstallForm, InstallForm);
  Application.Run;
end.
