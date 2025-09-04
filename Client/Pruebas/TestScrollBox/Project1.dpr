program Project1;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Unit1 in 'Unit1.pas' {Form1},
  gdm00Frm in '..\..\Gdm00\gdm00Frm.pas' {Gds00Frm: TFrame},
  gdm10Frm in '..\..\Gdm10\gdm10Frm.pas' {Gds10Frm: TFrame},
  gdm30Frm in '..\..\Gdm30\gdm30Frm.pas' {Gds30Frm: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TForm1, Form1);
  {
  Application.CreateForm(TGds00Frm, Gds00Frm);
  Application.CreateForm(TGds10Frm, Gds10Frm);
  Application.CreateForm(TGds30Frm, Gds30Frm);
  }
  Application.Run;
end.
