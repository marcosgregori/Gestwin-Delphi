program GdUpd;

uses
  Forms,
  main in 'main.pas' {MainForm},
  InfoInstall in '..\InfoInstall.pas' {InfoModule: TDataModule},
  RPCInstall in '..\RPCInstall.pas' {RpcInstallModule: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
