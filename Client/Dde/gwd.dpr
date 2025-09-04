
program gwd;

uses
  AppContainer,
  Forms,
  main in 'main.pas' {MainForm},
  topic in 'topic.pas' {DDEForm},
  f_app in 'f_app.pas' {ApplicationFrame: TFrame},
  DataAccess in '..\Lib\DataAccess.pas' {MainDataModule: TDataModule},
  EnterpriseDataAccess in '..\Lib\EnterpriseDataAccess.pas' {EnterpriseDataModule: TDataModule},
  ApplicationStore in '..\Lib\ApplicationStore.pas',
  b_msg in '..\Lib\b_msg.pas' {MsgBoxForm: TgxForm};

{$R *.RES}

begin
     Application.Initialize;
     Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
