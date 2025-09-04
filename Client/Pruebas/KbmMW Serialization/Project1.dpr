program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MyObject in 'MyObject.pas',
  HTTPServiceModule in 'HTTPServiceModule.pas' {kbmMWEventHTTPService2: TkbmMWEventHTTPService};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
