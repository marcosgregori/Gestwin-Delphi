program gdPub;

uses
  Forms,
  main in 'main.pas' {MainForm},
  InfoInstall in '..\InfoInstall.pas' {InfoModule: TDataModule},
  RPCInstall in '..\RPCInstall.pas' {RpcInstallModule: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'GESTWIN Publicación de aplicaciones';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
