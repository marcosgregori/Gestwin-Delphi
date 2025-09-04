program GwCopy;

uses
  Forms,
  Files,
  InfoInstall in '..\InfoInstall.pas' {InfoModule: TDataModule},
  RPCInstall in '..\RPCInstall.pas' {RpcInstallModule: TDataModule},
  InstallerClass in '..\InstallerClass.pas',
  b_cop in 'b_cop.pas' {InstallForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TInstallForm, InstallForm);
  Application.Run;
end.
